vlib work
vlog -f vflist
vsim -c -novopt work.counter_updown_tb -do "run -all"

pause

