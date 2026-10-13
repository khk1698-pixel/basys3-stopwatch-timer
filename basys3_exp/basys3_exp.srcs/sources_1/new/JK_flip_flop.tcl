restart

add_force J {0 0ns} {1 50ns} -repeat_every 100ns
add_force K {0 0ns} {1 100ns} -repeat_every 200ns
add_force clk {0 0ns} {1 215ns} -repeat_every 430ns
add_force reset_n {0 0ns} {1 10ns} -repeat_every 880ns
add_force preset_n {0 0ns} {1 10ns} -repeat_every 920ns

run 10 us