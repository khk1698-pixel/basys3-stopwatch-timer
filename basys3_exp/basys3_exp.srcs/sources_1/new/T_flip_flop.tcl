restart

add_force T {0 0ns} {1 1000ns} -repeat_every 2000ns
add_force clk {0 0ns} {1 215ns} -repeat_every 430ns
add_force reset_n {0 0ns} {1 10ns} -repeat_every 880ns
add_force preset_n {0 0ns} {1 10ns} -repeat_every 920ns

run 10 us