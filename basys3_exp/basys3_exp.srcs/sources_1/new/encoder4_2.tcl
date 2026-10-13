restart

add_force A[0] {0 0ns} {1 100ns} -repeat_every 200ns
add_force A[1] {0 0ns} {1 200ns} -repeat_every 400ns
add_force A[2] {0 0ns} {1 400ns} -repeat_every 800ns
add_force A[3] {0 0ns} {1 800ns} -repeat_every 1600ns
add_force B[0] {0 0ns} {1 800ns} -repeat_every 1600ns
add_force B[1] {0 0ns} {1 400ns} -repeat_every 800ns
add_force B[2] {0 0ns} {1 200ns} -repeat_every 400ns
add_force B[3] {0 0ns} {1 100ns} -repeat_every 200ns
add_force Cin {0 0ns} {1 1600ns} -repeat_every 3200ns

run 10us