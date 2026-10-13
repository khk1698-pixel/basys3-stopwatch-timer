restart

add_force D[0] {0 0ns} {1 10ns} -repeat_every 20ns
add_force D[1] {0 0ns} {1 20ns} -repeat_every 40ns
add_force D[2] {0 0ns} {1 40ns} -repeat_every 80ns
add_force D[3] {0 0ns} {1 80ns} -repeat_every 160ns
add_force D[4] {0 0ns} {1 160ns} -repeat_every 320ns
add_force D[5] {0 0ns} {1 320ns} -repeat_every 640ns
add_force D[6] {0 0ns} {1 640ns} -repeat_every 1280ns
add_force D[7] {0 0ns} {1 1280ns} -repeat_every 2560ns

add_force S[0] {0 0ns} {1 2560ns} -repeat_every 5120ns
add_force S[1] {0 0ns} {1 5120ns} -repeat_every 10240ns
add_force S[2] {0 0ns} {1 10240ns} -repeat_every 20480ns

run 50us