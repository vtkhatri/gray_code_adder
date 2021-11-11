lappend search_path [exec pwd]
set target_library [concat [exec pwd]/osu05_stdcells.db]
set link_library [concat "*" $target_library]
link
read_file -format sverilog ../hdl/gray_code_adder.sv
current_design gray_code_adder
compile -exact_map
report_cell
report_area
report_power
write -format Verilog -hierarchy -output gray_code_adder.netlist
link
quit
