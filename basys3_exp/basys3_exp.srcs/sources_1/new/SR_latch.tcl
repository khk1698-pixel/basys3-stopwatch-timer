restart

add_force R {0 0ns} {1 100ns} -repeat_every 200ns
add_force S {0 0ns} {1 200ns} -repeat_every 400ns

run 2us