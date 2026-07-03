#use "topfind"

#require "hardcaml"

open Hardcaml
open Hardcaml.Signal

let clock = Hardcaml.Signal.input "clock" 1
let clear = Hardcaml.Signal.input "clear" 1

let spec = Hardcaml.Signal.Reg_spec.create ~clock ~clear ()

(* Counter that gets incremented at the default rate of 27Mhz, set to loop every 0.5s *)
let enable_counter ~clock ~clear =
  reg_fb
  (Reg_spec.create ~clock ~clear ())
  ~enable:vdd
  ~width:24
  ~f:(mod_counter ~max:(27000000/2 - 1))

(* Create a flag that is true for one clock cycle every 0.5s *)
let enable_flag ~clock ~clear = 
  mux2 (any_bit_set (enable_counter ~clock ~clear)) gnd vdd

(* Advance the LED pattern by one every time enable_flag is set *)
let led_counter ~clock ~clear = 
 reg_fb                               
   (Reg_spec.create ~clock ~clear ()) 
   ~enable:(enable_flag ~clock ~clear)
   ~width:6                           
   ~f:(fun d -> d +:. 1)              

(* The hardware is designed such that LEDs light when set to 0. Therefore we must invert the signal*)
let invert_leds ~clock ~clear = ~: (led_counter ~clock ~clear)

(* Define input and outputs. Pin mapping is handsled by the .cst file*)
let input_clock = Hardcaml.Signal.input "clock" 1

let output_leds = Hardcaml.Signal.output "leds" (invert_leds ~clock:input_clock ~clear:gnd)

let led_circuit = Hardcaml.Circuit.create_exn ~name:"led_counter" [output_leds]

let () = Hardcaml.Rtl.print Verilog led_circuit

let verilog_string = Hardcaml.Rtl.full_hierarchy (Hardcaml.Rtl.create Verilog [led_circuit]) |> Rope.to_string

let () = Stdio.Out_channel.write_all "_build_fpga/led_test.v" ~data:verilog_string

