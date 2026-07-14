#use "topfind"
#use "circuit.ml"
#require "hardcaml"

open Hardcaml

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


