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

let sample_hold input ~enable =
  reg
  (spec)
  ~enable:enable input


let read_flag = 
  mux2 (enable_counter ==:. 7) gnd vdd

let pdm_clk = Hardcaml.Signal.output "pdm_clk" (enable_counter <:. 4)

let centre_amp ~gain input = 
   gain *+ (input +: input -:. 1)

let lpf ~divisor_power input= 
  reg_fb
    (spec)
    ~enable:read_flag
    ~width:32
    (* don't really like how the round-to-negative-infinity biases the output *)
    ~f:(fun d -> d +: (Signal.sra (input -: d) divisor_power))

let rectify input = 
        input *+ input

let invert input = ~: (input)

let divide input ~divisor_power =
        sra input divisor_power

(* only display the coutner from time to time *)
 let display_counter = 
 reg_fb                               
   (spec) 
   ~enable:vdd
   ~width:24                           
   ~f:(mod_counter ~max:(270000 / 2 - 1))

let display_flag = 
  mux2 (display_counter ==:. 1) vdd gnd

(* let select_bits input high width step = 
    ((List.map (bit input))
    (List.map(( + ) high))
    (List.init width (( * ) step)))
    |> concat_msb
*)

let select_list input  =
        [bit input 18; bit input 20; bit input 22; bit input 24; bit input 26; bit input 28]
        |> concat_msb

let envelope = 
        pdm_dat 
        |> sresize ~width:2
        |> centre_amp ~gain:(of_signed_int ~width:18 (4096))
        |> sresize ~width:32
        |> lpf ~divisor_power:4
        |> rectify
        |> sresize ~width:32 
        |> lpf ~divisor_power:20
        |> select_list
(*        |> (.:+[]) (25, (Some 6))
        |> divide ~divisor_power:17 (* don't do this like this *)
        |> sresize ~width:6
*)
        |> invert 
        |> sample_hold ~enable:display_flag



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

let multi_cycle simulator n = 
        for x=1 to n do
                Cyclesim.cycle simulator
        done

let build () =
        (* Short-circuit AND means that subsequent commands do not get run if one fails*)
        Sys.command "yosys fpga/synth.ys" == 0
        &&
        Sys.command "yowasp-nextpnr-himbaechel-gowin --json _build_fpga/led_test.json --write _build_fpga/pnr_led_test.json --device $DEVICE --vopt family=GW2A-18C --vopt cst=fpga/mic_test.cst" == 0
        &&
        Sys.command "gowin_pack -d GW2A-18C -o _build_fpga/pack.fs _build_fpga/pnr_led_test.json" == 0
        

let flash() = Sys.command "openFPGALoader _build_fpga/pack.fs" == 0

let build_and_flash () = (build() && flash(), write_circuit())


