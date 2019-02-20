#!/usr/bin/julia

include("./ncurses.jl")
using .NCurses

init()
box()
add(0x6d, 1, 1)
add("eem")
add(UInt32('s') | A_BOLD)
add(Array{UInt8,1}([109, 101, 101, 109, 115]))
pair(1, COLOR_RED, COLOR_GREEN)
attron(A_STANDOUT | pair(1))
add("meems", 10, 1)
attrset(A_NORMAL)
add(string(lines()))
refresh()
getch()
deinit()
