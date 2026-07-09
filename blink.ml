#use "topfind"

#require "hardcaml"

open Hardcaml
open Hardcaml.Signal

let clock = Hardcaml.Signal.input "clock" 1
(* let clear = Hardcaml.Signal.input "clear" 1 *)

let spec = Hardcaml.Signal.Reg_spec.create ~clock ~clear:gnd ()

let pdm_dat = Signal.input "pdm_dat" 1

(* 3MHz counter to drive PDM mic *)
let enable_counter =
  reg_fb
  (spec)
  ~enable:vdd
  ~width:4
  ~f:(mod_counter ~max:(9 - 1))

let read_flag = 
  mux2 (enable_counter ==:. 2) gnd vdd

let pdm_clk = Hardcaml.Signal.output "pdm_clk" (enable_counter <:. 4)

let centre_amp ~gain input = 
   gain *+ (input +: input -:. 1)

let lpf ~divisor_power input= 
  reg_fb
    (spec)
    ~enable:read_flag
    ~width:32
    ~f:(fun d -> d +: (Signal.sra (input -: d) divisor_power))

let rectify input = 
        input *+ input

let invert input = ~: (input)


let envelope = 
        pdm_dat 
        |> sresize ~width:2
        |> centre_amp ~gain:(of_signed_int ~width:8 (64))
        |> sresize ~width:32
        |> lpf ~divisor_power:4
        |> rectify
        |> sresize ~width:32
        |> lpf ~divisor_power:16
        |> sresize ~width:6
        |> invert 

(* Advance the LED pattern by one every time enable_flag is set *)
let display_counter = 
 reg_fb                               
   (spec) 
   ~enable:vdd
   ~width:24                           
   ~f:(mod_counter ~max:(27000000 / 2 - 1))

let display_flag = 
  mux2 (display_counter ==:. 1) gnd vdd


(* The hardware is designed such that LEDs light when set to 0. Therefore we must invert the signal*)
let invert_leds = ~: (envelope)


(* Define input and outputs. Pin mapping is handsled by the .cst file*)

let output_leds = Hardcaml.Signal.output "leds" (envelope)

let led_circuit = Hardcaml.Circuit.create_exn ~name:"led_counter" [output_leds; pdm_clk]

let print_circuit () = Hardcaml.Rtl.print Verilog led_circuit

let verilog_string = Hardcaml.Rtl.full_hierarchy (Hardcaml.Rtl.create Verilog [led_circuit]) |> Rope.to_string

let write_circuit () = Stdio.Out_channel.write_all "_build_fpga/led_test.v" ~data:verilog_string

let build_simulator() = 
        let (simulator : _ Cyclesim.t) = Cyclesim.create led_circuit in
        let pdm_dat_sim = Cyclesim.in_port simulator "pdm_dat" in
        let out = Cyclesim.out_port simulator "leds" in
        (simulator, pdm_dat_sim, out)

