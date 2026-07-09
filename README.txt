Testing the use of a PDM microphone with the Sipeed Tang Nano 20k and Hardcaml

Work in progress. I am new to Ocaml and FPGAs so there are probably things that could be done more idiomatically (e.g. using Dune). 

Requirements (may be incomplete): 
Hardware: Sipeed Tang Nano 20k, USB-C cable

Ocaml: Oxcaml (5.2.0+ox)
	Hardcaml
	Topfind
	Utop

FPGA: Yosys 
	Yowasp
	Nextpnr	


Running (all commands to be run from this directory): 

$ ocaml blink.ml

$ yosys fpga/synth.ys

$ yowasp-nextpnr-himbaechel-gowin --json _build_fpga/led_test.json --write _build_fpga/pnr_led_test.json --device $DEVICE --vopt family=GW2A-18C --vopt cst=fpga/mic_test.cst

$ gowin_pack -d GW2A-18C -o _build_fpga/pack.fs _build_fpga/pnr_led_test.json

$ openFPGALoader _build_fpga/pack.fs

