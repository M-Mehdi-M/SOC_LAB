transcript off
onbreak {quit -force}
onerror {quit -force}
transcript on

vlib work
vmap -link {D:/lab_1/project_4/project_4.cache/compile_simlib/riviera}
vlib riviera/xil_defaultlib

vlog -work xil_defaultlib  -incr -v2k5 -l xil_defaultlib \
"../../../bd/design_1/ip/design_1_iesire_0_0_1/sim/design_1_iesire_0_0.v" \
"../../../bd/design_1/ip/design_1_intrare_0_0_1/sim/design_1_intrare_0_0.v" \
"../../../bd/design_1/ip/design_1_sumator4b_0_0_1/sim/design_1_sumator4b_0_0.v" \
"../../../bd/design_1/ip/design_1_sumator4b_1_0_1/sim/design_1_sumator4b_1_0.v" \
"../../../bd/design_1/ip/design_1_sumator4b_2_0_1/sim/design_1_sumator4b_2_0.v" \
"../../../bd/design_1/ip/design_1_sumator4b_3_0_1/sim/design_1_sumator4b_3_0.v" \
"../../../bd/design_1/ip/design_1_uat_0_0_1/sim/design_1_uat_0_0.v" \
"../../../bd/design_1/sim/design_1.v" \


vlog -work xil_defaultlib \
"glbl.v"

