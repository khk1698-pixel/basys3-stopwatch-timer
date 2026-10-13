restart

add_force D0 -radix hex 3
add_force D1 -radix hex 6
add_force D2 -radix hex 9
add_force D3 -radix hex 12
add_force D4 -radix hex 15
add_force D5 -radix hex 18
add_force D6 -radix hex 21
add_force D7 -radix hex 24

add_force S[0] {0 0ns} {1 2560ns} -repeat_every 5120ns
add_force S[1] {0 0ns} {1 5120ns} -repeat_every 10240ns
add_force S[2] {0 0ns} {1 10240ns} -repeat_every 20480ns

run 50us