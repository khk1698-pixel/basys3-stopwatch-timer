restart

add_force D[0] {0 0ns} {1 10ns} -repeat_every 20ns
add_force D[1] {0 0ns} {1 100ns} -repeat_every 200ns
add_force S {0 0ns} {1 1000ns} -repeat_every 2000ns

run 100us