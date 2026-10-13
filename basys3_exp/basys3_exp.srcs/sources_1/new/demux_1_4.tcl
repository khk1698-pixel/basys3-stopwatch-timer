restart

add_force D {0 0ns} {1 100ns} -repeat_every 200ns

add_force S[0] {0 0ns} {1 1000ns} -repeat_every 2000ns
add_force S[1] {0 0ns} {1 2000ns} -repeat_every 4000ns

run 10us