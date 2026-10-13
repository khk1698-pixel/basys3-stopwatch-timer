restart

add_force D  {0 0ns} {1 50ns} -repeat_every 100ns
add_force E {0 0ns} {1 511500ps} -repeat_every 1023000ps

run 10 us