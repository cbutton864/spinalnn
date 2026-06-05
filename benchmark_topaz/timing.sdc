create_clock -name clk -period 6.667 [get_ports clk]
set_false_path -from [get_ports reset]
