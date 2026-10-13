restart

add_force A {0 0ns} {1 100ns} -repeat_every 200ns
add_force B {0 0ns} {1 200ns} -repeat_every 400ns

run 1us