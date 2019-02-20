# ncurses bindings for julia
# Copyright (C) 2019  Andy Tockman <andy@tck.mn>
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

module NCurses
    using Libdl

    export Window, stdscr

    # load ncurses shared library
    const ncurses = try
        first(filter(!isempty, find_library.("libncurses" .* ["", "w"])))
    catch BoundsError
        error("ncurses library not found")
    end

    const Window = Ptr{Cvoid}
    const CharOrUInt = Union{Char, UInt8, UInt16, UInt32}
    const CharArray = Union{Array{Int8, 1}, Array{UInt8, 1}}
    stdscr = C_NULL  # can only be initialized after init()

    export A_NORMAL, A_ATTRIBUTES, A_CHARTEXT, A_COLOR, A_STANDOUT,
    A_UNDERLINE, A_REVERSE, A_BLINK, A_DIM, A_BOLD, A_ALTCHARSET, A_INVIS,
    A_PROTECT, A_HORIZONTAL, A_LEFT, A_LOW, A_RIGHT, A_TOP, A_VERTICAL,
    A_ITALIC

    const A_NORMAL     = UInt32(0)
    const A_ATTRIBUTES = ~UInt32(0) << 8
    const A_CHARTEXT   = UInt32(1 << 8 - 1)
    const A_COLOR      = UInt32(1 << 8 - 1) << 8
    const A_STANDOUT   = UInt32(1) << 16
    const A_UNDERLINE  = UInt32(1) << 17
    const A_REVERSE    = UInt32(1) << 18
    const A_BLINK      = UInt32(1) << 19
    const A_DIM        = UInt32(1) << 20
    const A_BOLD       = UInt32(1) << 21
    const A_ALTCHARSET = UInt32(1) << 22
    const A_INVIS      = UInt32(1) << 23
    const A_PROTECT    = UInt32(1) << 24
    const A_HORIZONTAL = UInt32(1) << 25
    const A_LEFT       = UInt32(1) << 26
    const A_LOW        = UInt32(1) << 27
    const A_RIGHT      = UInt32(1) << 28
    const A_TOP        = UInt32(1) << 29
    const A_VERTICAL   = UInt32(1) << 30
    const A_ITALIC     = UInt32(1) << 31

    export COLOR_BLACK, COLOR_RED, COLOR_GREEN, COLOR_YELLOW, COLOR_BLUE,
    COLOR_MAGENTA, COLOR_CYAN, COLOR_WHITE

    const COLOR_BLACK   = UInt16(0)
    const COLOR_RED     = UInt16(1)
    const COLOR_GREEN   = UInt16(2)
    const COLOR_YELLOW  = UInt16(3)
    const COLOR_BLUE    = UInt16(4)
    const COLOR_MAGENTA = UInt16(5)
    const COLOR_CYAN    = UInt16(6)
    const COLOR_WHITE   = UInt16(7)

    export KEY_DOWN, KEY_UP, KEY_LEFT, KEY_RIGHT, KEY_HOME, KEY_BACKSPACE,
    KEY_F0, KEY_F, KEY_DL, KEY_IL, KEY_DC, KEY_IC, KEY_EIC, KEY_CLEAR, KEY_EOS,
    KEY_EOL, KEY_SF, KEY_SR, KEY_NPAGE, KEY_PPAGE, KEY_STAB, KEY_CTAB,
    KEY_CATAB, KEY_ENTER, KEY_PRINT, KEY_LL, KEY_A1, KEY_A3, KEY_B2, KEY_C1,
    KEY_C3, KEY_BTAB, KEY_BEG, KEY_CANCEL, KEY_CLOSE, KEY_COMMAND, KEY_COPY,
    KEY_CREATE, KEY_END, KEY_EXIT, KEY_FIND, KEY_HELP, KEY_MARK, KEY_MESSAGE,
    KEY_MOVE, KEY_NEXT, KEY_OPEN, KEY_OPTIONS, KEY_PREVIOUS, KEY_REDO,
    KEY_REFERENCE, KEY_REFRESH, KEY_REPLACE, KEY_RESTART, KEY_RESUME, KEY_SAVE,
    KEY_SBEG, KEY_SCANCEL, KEY_SCOMMAND, KEY_SCOPY, KEY_SCREATE, KEY_SDC,
    KEY_SDL, KEY_SELECT, KEY_SEND, KEY_SEOL, KEY_SEXIT, KEY_SFIND, KEY_SHELP,
    KEY_SHOME, KEY_SIC, KEY_SLEFT, KEY_SMESSAGE, KEY_SMOVE, KEY_SNEXT,
    KEY_SOPTIONS, KEY_SPREVIOUS, KEY_SPRINT, KEY_SREDO, KEY_SREPLACE,
    KEY_SRIGHT, KEY_SRSUME, KEY_SSAVE, KEY_SSUSPEND, KEY_SUNDO, KEY_SUSPEND,
    KEY_UNDO, KEY_MOUSE, KEY_RESIZE, KEY_EVENT

    const KEY_DOWN      = 0o402
    const KEY_UP        = 0o403
    const KEY_LEFT      = 0o404
    const KEY_RIGHT     = 0o405
    const KEY_HOME      = 0o406
    const KEY_BACKSPACE = 0o407
    const KEY_F0        = 0o410
    KEY_F(n) = KEY_F0+n
    const KEY_DL        = 0o510
    const KEY_IL        = 0o511
    const KEY_DC        = 0o512
    const KEY_IC        = 0o513
    const KEY_EIC       = 0o514
    const KEY_CLEAR     = 0o515
    const KEY_EOS       = 0o516
    const KEY_EOL       = 0o517
    const KEY_SF        = 0o520
    const KEY_SR        = 0o521
    const KEY_NPAGE     = 0o522
    const KEY_PPAGE     = 0o523
    const KEY_STAB      = 0o524
    const KEY_CTAB      = 0o525
    const KEY_CATAB     = 0o526
    const KEY_ENTER     = 0o527
    const KEY_PRINT     = 0o532
    const KEY_LL        = 0o533
    const KEY_A1        = 0o534
    const KEY_A3        = 0o535
    const KEY_B2        = 0o536
    const KEY_C1        = 0o537
    const KEY_C3        = 0o540
    const KEY_BTAB      = 0o541
    const KEY_BEG       = 0o542
    const KEY_CANCEL    = 0o543
    const KEY_CLOSE     = 0o544
    const KEY_COMMAND   = 0o545
    const KEY_COPY      = 0o546
    const KEY_CREATE    = 0o547
    const KEY_END       = 0o550
    const KEY_EXIT      = 0o551
    const KEY_FIND      = 0o552
    const KEY_HELP      = 0o553
    const KEY_MARK      = 0o554
    const KEY_MESSAGE   = 0o555
    const KEY_MOVE      = 0o556
    const KEY_NEXT      = 0o557
    const KEY_OPEN      = 0o560
    const KEY_OPTIONS   = 0o561
    const KEY_PREVIOUS  = 0o562
    const KEY_REDO      = 0o563
    const KEY_REFERENCE = 0o564
    const KEY_REFRESH   = 0o565
    const KEY_REPLACE   = 0o566
    const KEY_RESTART   = 0o567
    const KEY_RESUME    = 0o570
    const KEY_SAVE      = 0o571
    const KEY_SBEG      = 0o572
    const KEY_SCANCEL   = 0o573
    const KEY_SCOMMAND  = 0o574
    const KEY_SCOPY     = 0o575
    const KEY_SCREATE   = 0o576
    const KEY_SDC       = 0o577
    const KEY_SDL       = 0o600
    const KEY_SELECT    = 0o601
    const KEY_SEND      = 0o602
    const KEY_SEOL      = 0o603
    const KEY_SEXIT     = 0o604
    const KEY_SFIND     = 0o605
    const KEY_SHELP     = 0o606
    const KEY_SHOME     = 0o607
    const KEY_SIC       = 0o610
    const KEY_SLEFT     = 0o611
    const KEY_SMESSAGE  = 0o612
    const KEY_SMOVE     = 0o613
    const KEY_SNEXT     = 0o614
    const KEY_SOPTIONS  = 0o615
    const KEY_SPREVIOUS = 0o616
    const KEY_SPRINT    = 0o617
    const KEY_SREDO     = 0o620
    const KEY_SREPLACE  = 0o621
    const KEY_SRIGHT    = 0o622
    const KEY_SRSUME    = 0o623
    const KEY_SSAVE     = 0o624
    const KEY_SSUSPEND  = 0o625
    const KEY_SUNDO     = 0o626
    const KEY_SUSPEND   = 0o627
    const KEY_UNDO      = 0o630
    const KEY_MOUSE     = 0o631
    const KEY_RESIZE    = 0o632
    const KEY_EVENT     = 0o633

    export init, deinit, add, move, clear, refresh,
        attron, attroff, attrset, attrget, color, pair, box,
        newwin, delwin, movewin, subwin, dupwin,
        getch, lines, cols

    function init(; raw::Bool=true, cbreak::Bool=true, echo::Bool=false,
                    keypad::Bool=true, color::Bool=true)
        n_initscr()
        global stdscr = unsafe_load(cglobal((:stdscr, ncurses), Ptr{Cvoid}))
        raw && n_raw()
        cbreak && n_cbreak()
        echo || n_noecho()
        keypad && n_keypad(stdscr, 1)
        color && n_has_colors() == 1 && n_start_color()
    end

    function deinit()
        n_endwin()
    end

    add(ch::CharOrUInt) = n_addch(ch)
    add(str::AbstractString) = n_addstr(str)
    add(arr::CharArray) = n_addnstr(pointer(arr), length(arr))
    add(ch::CharOrUInt, y::Integer, x::Integer) = n_mvaddch(y, x, ch)
    add(str::AbstractString, y::Integer, x::Integer) = n_mvaddstr(y, x, str)
    add(arr::CharArray, y::Integer, x::Integer) = n_mvaddnstr(y, x, pointer(arr), length(arr))
    add(win::Window, ch::CharOrUInt) = n_waddch(win, ch)
    add(win::Window, str::AbstractString) = n_waddstr(win, str)
    add(win::Window, arr::CharArray) = n_waddnstr(win, pointer(arr), length(arr))
    add(win::Window, ch::CharOrUInt, y::Integer, x::Integer) = n_mvwaddch(win, y, x, ch)
    add(win::Window, str::AbstractString, y::Integer, x::Integer) = n_waddstr(win, y, x, str)
    add(win::Window, arr::CharArray, y::Integer, x::Integer) = n_waddnstr(win, y, x, pointer(arr), length(arr))

    attron(attrs::UInt32) = n_attr_on(attrs, C_NULL)
    attroff(attrs::UInt32) = n_attr_off(attrs, C_NULL)
    attrset(attrs::UInt32; color::Integer=0) = n_attr_set(attrs, color, C_NULL)
    attrset(attrs::Nothing=nothing; color::Integer=0) = n_color_set(color, C_NULL)
    attrget() = (t1 = Ref{UInt32}(0); t2 = Ref{UInt16}(0); n_attr_get(t1, t2, C_NULL); (t1[], t2[]))
    attron(win::Window, attrs::UInt32) = n_wattr_on(win, attrs, C_NULL)
    attroff(win::Window, attrs::UInt32) = n_wattr_off(win, attrs, C_NULL)
    attrset(win::Window, attrs::UInt32; color::Integer=0) = n_wattr_set(win, attrs, color, C_NULL)
    attrset(win::Window, attrs::Nothing=nothing; color::Integer=0) = n_wcolor_set(win, color, C_NULL)
    attrget(win::Window) = (t1 = Ref{UInt32}(0); t2 = Ref{UInt16}(0); n_wattr_get(win, t1, t2, C_NULL); (t1[], t2[]))

    color(color::Integer, r::Integer, g::Integer, b::Integer) = n_init_color(color, r, g, b)
    pair(pair::Integer, f::Integer, b::Integer) = n_init_pair(pair, f, b)
    pair(pair::Integer) = (UInt32(pair) << 8) & A_COLOR

    box(; kw...) = n_border(
        get(kw, :ls, get(kw, :hor, 0)),
        get(kw, :rs, get(kw, :hor, 0)),
        get(kw, :ts, get(kw, :ver, 0)),
        get(kw, :bs, get(kw, :ver, 0)),
        get(kw, :tl, get(kw, :cor, 0)),
        get(kw, :tr, get(kw, :cor, 0)),
        get(kw, :bl, get(kw, :cor, 0)),
        get(kw, :br, get(kw, :cor, 0)))
    box(win::Window; kw...) = n_wborder(win,
        get(kw, :ls, get(kw, :hor, 0)),
        get(kw, :rs, get(kw, :hor, 0)),
        get(kw, :ts, get(kw, :ver, 0)),
        get(kw, :bs, get(kw, :ver, 0)),
        get(kw, :tl, get(kw, :cor, 0)),
        get(kw, :tr, get(kw, :cor, 0)),
        get(kw, :bl, get(kw, :cor, 0)),
        get(kw, :br, get(kw, :cor, 0)))

    move(y::Integer, x::Integer) = n_move(y, x)
    move(win::Window, y::Integer, x::Integer) = n_wmove(win, y, x)

    clear(clearok::Bool=false) = clearok ? n_clear() : n_erase()
    clrtobot() = n_clrtobot()
    clrtoeol() = n_clrtoeol()
    clear(win::Window, clearok::Bool=false) = clearok ? n_wclear(win) : n_werase(win)
    clrtobot(win::Window) = n_wclrtobot(win)
    clrtoeol(win::Window) = n_wclrtoeol(win)

    refresh() = n_refresh()
    refresh(win::Window) = n_wrefresh(win)

    newwin(h::Integer, w::Integer, y::Integer, x::Integer) = n_newwin(h, w, y, x)
    delwin(win::Window) = n_delwin(win)
    movewin(win::Window, y::Integer, x::Integer; derived=false) =
        derived ? n_mvderwin(win, y, x) : n_mvwin(win, y, x)
    subwin(win::Window, h::Integer, w::Integer, y::Integer, x::Integer; derived=false) =
        derived ? n_derwin(win, h, w, y, x) : n_subwin(win, h, w, y, x)
    dupwin(win::Window) = n_dupwin(win)

    getch() = Char(n_getch())
    getch(y::Integer, x::Integer) = Char(n_mvgetch(y, x))
    getch(win::Window) = Char(n_wgetch(win))
    getch(win::Window, y::Integer, x::Integer) = Char(n_mvwgetch(win, y, x))
    # TODO getstr

    lines() = unsafe_load(cglobal((:LINES, ncurses), Cint))
    cols() = unsafe_load(cglobal((:COLS, ncurses), Cint))

    # autogenerated code starts here
    n_addch(a) = ccall((:addch, ncurses), Cint, (UInt32,), a)
    n_addchnstr(a,b) = ccall((:addchnstr, ncurses), Cint, (Ptr{UInt32},Cint), a,b)
    n_addchstr(a) = ccall((:addchstr, ncurses), Cint, (Ptr{UInt32},), a)
    n_addnstr(a,b) = ccall((:addnstr, ncurses), Cint, (Cstring,Cint), a,b)
    n_addstr(a) = ccall((:addstr, ncurses), Cint, (Cstring,), a)
    n_attroff(a) = ccall((:attroff, ncurses), Cint, (Cint,), a)
    n_attron(a) = ccall((:attron, ncurses), Cint, (Cint,), a)
    n_attrset(a) = ccall((:attrset, ncurses), Cint, (Cint,), a)
    n_attr_get(a,b,c) = ccall((:attr_get, ncurses), Cint, (Ptr{UInt32},Ptr{Cshort},Ptr{Cvoid}), a,b,c)
    n_attr_off(a,b) = ccall((:attr_off, ncurses), Cint, (UInt32,Ptr{Cvoid}), a,b)
    n_attr_on(a,b) = ccall((:attr_on, ncurses), Cint, (UInt32,Ptr{Cvoid}), a,b)
    n_attr_set(a,b,c) = ccall((:attr_set, ncurses), Cint, (UInt32,Cshort,Ptr{Cvoid}), a,b,c)
    n_baudrate() = ccall((:baudrate, ncurses), Cint, ())
    n_beep() = ccall((:beep, ncurses), Cint, ())
    n_bkgd(a) = ccall((:bkgd, ncurses), Cint, (UInt32,), a)
    n_bkgdset(a) = ccall((:bkgdset, ncurses), Cvoid, (UInt32,), a)
    n_border(a,b,c,d,e,f,g,h) = ccall((:border, ncurses), Cint, (UInt32,UInt32,UInt32,UInt32,UInt32,UInt32,UInt32,UInt32), a,b,c,d,e,f,g,h)
    n_box(a,b,c) = ccall((:box, ncurses), Cint, (Window,UInt32,UInt32), a,b,c)
    n_can_change_color() = ccall((:can_change_color, ncurses), UInt8, ())
    n_cbreak() = ccall((:cbreak, ncurses), Cint, ())
    n_chgat(a,b,c,d) = ccall((:chgat, ncurses), Cint, (Cint,UInt32,Cshort,Ptr{Cvoid}), a,b,c,d)
    n_clear() = ccall((:clear, ncurses), Cint, ())
    n_clearok(a,b) = ccall((:clearok, ncurses), Cint, (Window,UInt8), a,b)
    n_clrtobot() = ccall((:clrtobot, ncurses), Cint, ())
    n_clrtoeol() = ccall((:clrtoeol, ncurses), Cint, ())
    n_color_content(a,b,c,d) = ccall((:color_content, ncurses), Cint, (Cshort,Ptr{Cshort},Ptr{Cshort},Ptr{Cshort}), a,b,c,d)
    n_color_set(a,b) = ccall((:color_set, ncurses), Cint, (Cshort,Ptr{Cvoid}), a,b)
    n_COLOR_PAIR(a) = ccall((:COLOR_PAIR, ncurses), Cint, (Cint,), a)
    n_copywin(a,b,c,d,e,f,g,h,i) = ccall((:copywin, ncurses), Cint, (Window,Window,Cint,Cint,Cint,Cint,Cint,Cint,Cint), a,b,c,d,e,f,g,h,i)
    n_curs_set(a) = ccall((:curs_set, ncurses), Cint, (Cint,), a)
    n_def_prog_mode() = ccall((:def_prog_mode, ncurses), Cint, ())
    n_def_shell_mode() = ccall((:def_shell_mode, ncurses), Cint, ())
    n_delay_output(a) = ccall((:delay_output, ncurses), Cint, (Cint,), a)
    n_delch() = ccall((:delch, ncurses), Cint, ())
    n_delwin(a) = ccall((:delwin, ncurses), Cint, (Window,), a)
    n_deleteln() = ccall((:deleteln, ncurses), Cint, ())
    n_derwin(a,b,c,d,e) = ccall((:derwin, ncurses), Window, (Window,Cint,Cint,Cint,Cint), a,b,c,d,e)
    n_doupdate() = ccall((:doupdate, ncurses), Cint, ())
    n_dupwin(a) = ccall((:dupwin, ncurses), Window, (Window,), a)
    n_echo() = ccall((:echo, ncurses), Cint, ())
    n_echochar(a) = ccall((:echochar, ncurses), Cint, (UInt32,), a)
    n_erase() = ccall((:erase, ncurses), Cint, ())
    n_endwin() = ccall((:endwin, ncurses), Cint, ())
    n_erasechar() = ccall((:erasechar, ncurses), Cchar, ())
    n_filter() = ccall((:filter, ncurses), Cvoid, ())
    n_flash() = ccall((:flash, ncurses), Cint, ())
    n_flushinp() = ccall((:flushinp, ncurses), Cint, ())
    n_getbkgd(a) = ccall((:getbkgd, ncurses), UInt32, (Window,), a)
    n_getch() = ccall((:getch, ncurses), Cint, ())
    n_getnstr(a,b) = ccall((:getnstr, ncurses), Cint, (Cstring,Cint), a,b)
    n_getstr(a) = ccall((:getstr, ncurses), Cint, (Cstring,), a)
    n_halfdelay(a) = ccall((:halfdelay, ncurses), Cint, (Cint,), a)
    n_has_colors() = ccall((:has_colors, ncurses), UInt8, ())
    n_has_ic() = ccall((:has_ic, ncurses), UInt8, ())
    n_has_il() = ccall((:has_il, ncurses), UInt8, ())
    n_hline(a,b) = ccall((:hline, ncurses), Cint, (UInt32,Cint), a,b)
    n_idcok(a,b) = ccall((:idcok, ncurses), Cvoid, (Window,UInt8), a,b)
    n_idlok(a,b) = ccall((:idlok, ncurses), Cint, (Window,UInt8), a,b)
    n_immedok(a,b) = ccall((:immedok, ncurses), Cvoid, (Window,UInt8), a,b)
    n_inch() = ccall((:inch, ncurses), UInt32, ())
    n_inchnstr(a,b) = ccall((:inchnstr, ncurses), Cint, (Ptr{UInt32},Cint), a,b)
    n_inchstr(a) = ccall((:inchstr, ncurses), Cint, (Ptr{UInt32},), a)
    n_initscr() = ccall((:initscr, ncurses), Window, ())
    n_init_color(a,b,c,d) = ccall((:init_color, ncurses), Cint, (Cshort,Cshort,Cshort,Cshort), a,b,c,d)
    n_init_pair(a,b,c) = ccall((:init_pair, ncurses), Cint, (Cshort,Cshort,Cshort), a,b,c)
    n_innstr(a,b) = ccall((:innstr, ncurses), Cint, (Cstring,Cint), a,b)
    n_insch(a) = ccall((:insch, ncurses), Cint, (UInt32,), a)
    n_insdelln(a) = ccall((:insdelln, ncurses), Cint, (Cint,), a)
    n_insertln() = ccall((:insertln, ncurses), Cint, ())
    n_insnstr(a,b) = ccall((:insnstr, ncurses), Cint, (Cstring,Cint), a,b)
    n_insstr(a) = ccall((:insstr, ncurses), Cint, (Cstring,), a)
    n_instr(a) = ccall((:instr, ncurses), Cint, (Cstring,), a)
    n_intrflush(a,b) = ccall((:intrflush, ncurses), Cint, (Window,UInt8), a,b)
    n_isendwin() = ccall((:isendwin, ncurses), UInt8, ())
    n_is_linetouched(a,b) = ccall((:is_linetouched, ncurses), UInt8, (Window,Cint), a,b)
    n_is_wintouched(a) = ccall((:is_wintouched, ncurses), UInt8, (Window,), a)
    n_keyname(a) = ccall((:keyname, ncurses), Cstring, (Cint,), a)
    n_keypad(a,b) = ccall((:keypad, ncurses), Cint, (Window,UInt8), a,b)
    n_killchar() = ccall((:killchar, ncurses), Cchar, ())
    n_leaveok(a,b) = ccall((:leaveok, ncurses), Cint, (Window,UInt8), a,b)
    n_longname() = ccall((:longname, ncurses), Cstring, ())
    n_meta(a,b) = ccall((:meta, ncurses), Cint, (Window,UInt8), a,b)
    n_move(a,b) = ccall((:move, ncurses), Cint, (Cint,Cint), a,b)
    n_mvaddch(a,b,c) = ccall((:mvaddch, ncurses), Cint, (Cint,Cint,UInt32), a,b,c)
    n_mvaddchnstr(a,b,c,d) = ccall((:mvaddchnstr, ncurses), Cint, (Cint,Cint,Ptr{UInt32},Cint), a,b,c,d)
    n_mvaddchstr(a,b,c) = ccall((:mvaddchstr, ncurses), Cint, (Cint,Cint,Ptr{UInt32}), a,b,c)
    n_mvaddnstr(a,b,c,d) = ccall((:mvaddnstr, ncurses), Cint, (Cint,Cint,Cstring,Cint), a,b,c,d)
    n_mvaddstr(a,b,c) = ccall((:mvaddstr, ncurses), Cint, (Cint,Cint,Cstring), a,b,c)
    n_mvchgat(a,b,c,d,e,f) = ccall((:mvchgat, ncurses), Cint, (Cint,Cint,Cint,UInt32,Cshort,Ptr{Cvoid}), a,b,c,d,e,f)
    n_mvcur(a,b,c,d) = ccall((:mvcur, ncurses), Cint, (Cint,Cint,Cint,Cint), a,b,c,d)
    n_mvdelch(a,b) = ccall((:mvdelch, ncurses), Cint, (Cint,Cint), a,b)
    n_mvderwin(a,b,c) = ccall((:mvderwin, ncurses), Cint, (Window,Cint,Cint), a,b,c)
    n_mvgetch(a,b) = ccall((:mvgetch, ncurses), Cint, (Cint,Cint), a,b)
    n_mvgetnstr(a,b,c,d) = ccall((:mvgetnstr, ncurses), Cint, (Cint,Cint,Cstring,Cint), a,b,c,d)
    n_mvgetstr(a,b,c) = ccall((:mvgetstr, ncurses), Cint, (Cint,Cint,Cstring), a,b,c)
    n_mvhline(a,b,c,d) = ccall((:mvhline, ncurses), Cint, (Cint,Cint,UInt32,Cint), a,b,c,d)
    n_mvinch(a,b) = ccall((:mvinch, ncurses), UInt32, (Cint,Cint), a,b)
    n_mvinchnstr(a,b,c,d) = ccall((:mvinchnstr, ncurses), Cint, (Cint,Cint,Ptr{UInt32},Cint), a,b,c,d)
    n_mvinchstr(a,b,c) = ccall((:mvinchstr, ncurses), Cint, (Cint,Cint,Ptr{UInt32}), a,b,c)
    n_mvinnstr(a,b,c,d) = ccall((:mvinnstr, ncurses), Cint, (Cint,Cint,Cstring,Cint), a,b,c,d)
    n_mvinsch(a,b,c) = ccall((:mvinsch, ncurses), Cint, (Cint,Cint,UInt32), a,b,c)
    n_mvinsnstr(a,b,c,d) = ccall((:mvinsnstr, ncurses), Cint, (Cint,Cint,Cstring,Cint), a,b,c,d)
    n_mvinsstr(a,b,c) = ccall((:mvinsstr, ncurses), Cint, (Cint,Cint,Cstring), a,b,c)
    n_mvinstr(a,b,c) = ccall((:mvinstr, ncurses), Cint, (Cint,Cint,Cstring), a,b,c)
    n_mvvline(a,b,c,d) = ccall((:mvvline, ncurses), Cint, (Cint,Cint,UInt32,Cint), a,b,c,d)
    n_mvwaddch(a,b,c,d) = ccall((:mvwaddch, ncurses), Cint, (Window,Cint,Cint,UInt32), a,b,c,d)
    n_mvwaddchstr(a,b,c,d) = ccall((:mvwaddchstr, ncurses), Cint, (Window,Cint,Cint,Ptr{UInt32}), a,b,c,d)
    n_mvwaddnstr(a,b,c,d,e) = ccall((:mvwaddnstr, ncurses), Cint, (Window,Cint,Cint,Cstring,Cint), a,b,c,d,e)
    n_mvwaddstr(a,b,c,d) = ccall((:mvwaddstr, ncurses), Cint, (Window,Cint,Cint,Cstring), a,b,c,d)
    n_mvwdelch(a,b,c) = ccall((:mvwdelch, ncurses), Cint, (Window,Cint,Cint), a,b,c)
    n_mvwgetch(a,b,c) = ccall((:mvwgetch, ncurses), Cint, (Window,Cint,Cint), a,b,c)
    n_mvwgetnstr(a,b,c,d,e) = ccall((:mvwgetnstr, ncurses), Cint, (Window,Cint,Cint,Cstring,Cint), a,b,c,d,e)
    n_mvwgetstr(a,b,c,d) = ccall((:mvwgetstr, ncurses), Cint, (Window,Cint,Cint,Cstring), a,b,c,d)
    n_mvwhline(a,b,c,d,e) = ccall((:mvwhline, ncurses), Cint, (Window,Cint,Cint,UInt32,Cint), a,b,c,d,e)
    n_mvwin(a,b,c) = ccall((:mvwin, ncurses), Cint, (Window,Cint,Cint), a,b,c)
    n_mvwinch(a,b,c) = ccall((:mvwinch, ncurses), UInt32, (Window,Cint,Cint), a,b,c)
    n_mvwinchnstr(a,b,c,d,e) = ccall((:mvwinchnstr, ncurses), Cint, (Window,Cint,Cint,Ptr{UInt32},Cint), a,b,c,d,e)
    n_mvwinchstr(a,b,c,d) = ccall((:mvwinchstr, ncurses), Cint, (Window,Cint,Cint,Ptr{UInt32}), a,b,c,d)
    n_mvwinnstr(a,b,c,d,e) = ccall((:mvwinnstr, ncurses), Cint, (Window,Cint,Cint,Cstring,Cint), a,b,c,d,e)
    n_mvwinsch(a,b,c,d) = ccall((:mvwinsch, ncurses), Cint, (Window,Cint,Cint,UInt32), a,b,c,d)
    n_mvwinsnstr(a,b,c,d,e) = ccall((:mvwinsnstr, ncurses), Cint, (Window,Cint,Cint,Cstring,Cint), a,b,c,d,e)
    n_mvwinsstr(a,b,c,d) = ccall((:mvwinsstr, ncurses), Cint, (Window,Cint,Cint,Cstring), a,b,c,d)
    n_mvwinstr(a,b,c,d) = ccall((:mvwinstr, ncurses), Cint, (Window,Cint,Cint,Cstring), a,b,c,d)
    n_mvwvline(a,b,c,d,e) = ccall((:mvwvline, ncurses), Cint, (Window,Cint,Cint,UInt32,Cint), a,b,c,d,e)
    n_napms(a) = ccall((:napms, ncurses), Cint, (Cint,), a)
    n_newpad(a,b) = ccall((:newpad, ncurses), Window, (Cint,Cint), a,b)
    n_newwin(a,b,c,d) = ccall((:newwin, ncurses), Window, (Cint,Cint,Cint,Cint), a,b,c,d)
    n_nl() = ccall((:nl, ncurses), Cint, ())
    n_nocbreak() = ccall((:nocbreak, ncurses), Cint, ())
    n_nodelay(a,b) = ccall((:nodelay, ncurses), Cint, (Window,UInt8), a,b)
    n_noecho() = ccall((:noecho, ncurses), Cint, ())
    n_nonl() = ccall((:nonl, ncurses), Cint, ())
    n_noqiflush() = ccall((:noqiflush, ncurses), Cvoid, ())
    n_noraw() = ccall((:noraw, ncurses), Cint, ())
    n_notimeout(a,b) = ccall((:notimeout, ncurses), Cint, (Window,UInt8), a,b)
    n_overlay(a,b) = ccall((:overlay, ncurses), Cint, (Window,Window), a,b)
    n_overwrite(a,b) = ccall((:overwrite, ncurses), Cint, (Window,Window), a,b)
    n_pair_content(a,b,c) = ccall((:pair_content, ncurses), Cint, (Cshort,Ptr{Cshort},Ptr{Cshort}), a,b,c)
    n_PAIR_NUMBER(a) = ccall((:PAIR_NUMBER, ncurses), Cint, (Cint,), a)
    n_pechochar(a,b) = ccall((:pechochar, ncurses), Cint, (Window,UInt32), a,b)
    n_prefresh(a,b,c,d,e,f,g) = ccall((:prefresh, ncurses), Cint, (Window,Cint,Cint,Cint,Cint,Cint,Cint), a,b,c,d,e,f,g)
    n_qiflush() = ccall((:qiflush, ncurses), Cvoid, ())
    n_raw() = ccall((:raw, ncurses), Cint, ())
    n_redrawwin(a) = ccall((:redrawwin, ncurses), Cint, (Window,), a)
    n_refresh() = ccall((:refresh, ncurses), Cint, ())
    n_resetty() = ccall((:resetty, ncurses), Cint, ())
    n_reset_prog_mode() = ccall((:reset_prog_mode, ncurses), Cint, ())
    n_reset_shell_mode() = ccall((:reset_shell_mode, ncurses), Cint, ())
    n_savetty() = ccall((:savetty, ncurses), Cint, ())
    n_scr_dump(a) = ccall((:scr_dump, ncurses), Cint, (Cstring,), a)
    n_scr_init(a) = ccall((:scr_init, ncurses), Cint, (Cstring,), a)
    n_scrl(a) = ccall((:scrl, ncurses), Cint, (Cint,), a)
    n_scroll(a) = ccall((:scroll, ncurses), Cint, (Window,), a)
    n_scrollok(a,b) = ccall((:scrollok, ncurses), Cint, (Window,UInt8), a,b)
    n_scr_restore(a) = ccall((:scr_restore, ncurses), Cint, (Cstring,), a)
    n_scr_set(a) = ccall((:scr_set, ncurses), Cint, (Cstring,), a)
    n_setscrreg(a,b) = ccall((:setscrreg, ncurses), Cint, (Cint,Cint), a,b)
    n_slk_attroff(a) = ccall((:slk_attroff, ncurses), Cint, (UInt32,), a)
    n_slk_attr_off(a,b) = ccall((:slk_attr_off, ncurses), Cint, (UInt32,Ptr{Cvoid}), a,b)
    n_slk_attron(a) = ccall((:slk_attron, ncurses), Cint, (UInt32,), a)
    n_slk_attr_on(a,b) = ccall((:slk_attr_on, ncurses), Cint, (UInt32,Ptr{Cvoid}), a,b)
    n_slk_attrset(a) = ccall((:slk_attrset, ncurses), Cint, (UInt32,), a)
    n_slk_attr() = ccall((:slk_attr, ncurses), UInt32, ())
    n_slk_attr_set(a,b,c) = ccall((:slk_attr_set, ncurses), Cint, (UInt32,Cshort,Ptr{Cvoid}), a,b,c)
    n_slk_clear() = ccall((:slk_clear, ncurses), Cint, ())
    n_slk_color(a) = ccall((:slk_color, ncurses), Cint, (Cshort,), a)
    n_slk_init(a) = ccall((:slk_init, ncurses), Cint, (Cint,), a)
    n_slk_label(a) = ccall((:slk_label, ncurses), Cstring, (Cint,), a)
    n_slk_noutrefresh() = ccall((:slk_noutrefresh, ncurses), Cint, ())
    n_slk_refresh() = ccall((:slk_refresh, ncurses), Cint, ())
    n_slk_restore() = ccall((:slk_restore, ncurses), Cint, ())
    n_slk_set(a,b,c) = ccall((:slk_set, ncurses), Cint, (Cint,Cstring,Cint), a,b,c)
    n_slk_touch() = ccall((:slk_touch, ncurses), Cint, ())
    n_standout() = ccall((:standout, ncurses), Cint, ())
    n_standend() = ccall((:standend, ncurses), Cint, ())
    n_start_color() = ccall((:start_color, ncurses), Cint, ())
    n_subpad(a,b,c,d,e) = ccall((:subpad, ncurses), Window, (Window,Cint,Cint,Cint,Cint), a,b,c,d,e)
    n_subwin(a,b,c,d,e) = ccall((:subwin, ncurses), Window, (Window,Cint,Cint,Cint,Cint), a,b,c,d,e)
    n_syncok(a,b) = ccall((:syncok, ncurses), Cint, (Window,UInt8), a,b)
    n_termattrs() = ccall((:termattrs, ncurses), UInt32, ())
    n_termname() = ccall((:termname, ncurses), Cstring, ())
    n_timeout(a) = ccall((:timeout, ncurses), Cvoid, (Cint,), a)
    n_touchline(a,b,c) = ccall((:touchline, ncurses), Cint, (Window,Cint,Cint), a,b,c)
    n_touchwin(a) = ccall((:touchwin, ncurses), Cint, (Window,), a)
    n_typeahead(a) = ccall((:typeahead, ncurses), Cint, (Cint,), a)
    n_ungetch(a) = ccall((:ungetch, ncurses), Cint, (Cint,), a)
    n_untouchwin(a) = ccall((:untouchwin, ncurses), Cint, (Window,), a)
    n_use_env(a) = ccall((:use_env, ncurses), Cvoid, (UInt8,), a)
    n_use_tioctl(a) = ccall((:use_tioctl, ncurses), Cvoid, (UInt8,), a)
    n_vidattr(a) = ccall((:vidattr, ncurses), Cint, (UInt32,), a)
    n_vline(a,b) = ccall((:vline, ncurses), Cint, (UInt32,Cint), a,b)
    n_waddch(a,b) = ccall((:waddch, ncurses), Cint, (Window,UInt32), a,b)
    n_waddchnstr(a,b,c) = ccall((:waddchnstr, ncurses), Cint, (Window,Ptr{UInt32},Cint), a,b,c)
    n_waddchstr(a,b) = ccall((:waddchstr, ncurses), Cint, (Window,Ptr{UInt32}), a,b)
    n_waddnstr(a,b,c) = ccall((:waddnstr, ncurses), Cint, (Window,Cstring,Cint), a,b,c)
    n_waddstr(a,b) = ccall((:waddstr, ncurses), Cint, (Window,Cstring), a,b)
    n_wattron(a,b) = ccall((:wattron, ncurses), Cint, (Window,Cint), a,b)
    n_wattroff(a,b) = ccall((:wattroff, ncurses), Cint, (Window,Cint), a,b)
    n_wattrset(a,b) = ccall((:wattrset, ncurses), Cint, (Window,Cint), a,b)
    n_wattr_get(a,b,c,d) = ccall((:wattr_get, ncurses), Cint, (Window,Ptr{UInt32},Ptr{Cshort},Ptr{Cvoid}), a,b,c,d)
    n_wattr_on(a,b,c) = ccall((:wattr_on, ncurses), Cint, (Window,UInt32,Ptr{Cvoid}), a,b,c)
    n_wattr_off(a,b,c) = ccall((:wattr_off, ncurses), Cint, (Window,UInt32,Ptr{Cvoid}), a,b,c)
    n_wattr_set(a,b,c,d) = ccall((:wattr_set, ncurses), Cint, (Window,UInt32,Cshort,Ptr{Cvoid}), a,b,c,d)
    n_wbkgd(a,b) = ccall((:wbkgd, ncurses), Cint, (Window,UInt32), a,b)
    n_wbkgdset(a,b) = ccall((:wbkgdset, ncurses), Cvoid, (Window,UInt32), a,b)
    n_wborder(a,b,c,d,e,f,g,h,i) = ccall((:wborder, ncurses), Cint, (Window,UInt32,UInt32,UInt32,UInt32,UInt32,UInt32,UInt32,UInt32), a,b,c,d,e,f,g,h,i)
    n_wclear(a) = ccall((:wclear, ncurses), Cint, (Window,), a)
    n_wclrtobot(a) = ccall((:wclrtobot, ncurses), Cint, (Window,), a)
    n_wclrtoeol(a) = ccall((:wclrtoeol, ncurses), Cint, (Window,), a)
    n_wcolor_set(a,b,c) = ccall((:wcolor_set, ncurses), Cint, (Window,Cshort,Ptr{Cvoid}), a,b,c)
    n_wcursyncup(a) = ccall((:wcursyncup, ncurses), Cvoid, (Window,), a)
    n_wdelch(a) = ccall((:wdelch, ncurses), Cint, (Window,), a)
    n_wdeleteln(a) = ccall((:wdeleteln, ncurses), Cint, (Window,), a)
    n_wechochar(a,b) = ccall((:wechochar, ncurses), Cint, (Window,UInt32), a,b)
    n_werase(a) = ccall((:werase, ncurses), Cint, (Window,), a)
    n_wgetch(a) = ccall((:wgetch, ncurses), Cint, (Window,), a)
    n_wgetnstr(a,b,c) = ccall((:wgetnstr, ncurses), Cint, (Window,Cstring,Cint), a,b,c)
    n_wgetstr(a,b) = ccall((:wgetstr, ncurses), Cint, (Window,Cstring), a,b)
    n_whline(a,b,c) = ccall((:whline, ncurses), Cint, (Window,UInt32,Cint), a,b,c)
    n_winch(a) = ccall((:winch, ncurses), UInt32, (Window,), a)
    n_winchnstr(a,b,c) = ccall((:winchnstr, ncurses), Cint, (Window,Ptr{UInt32},Cint), a,b,c)
    n_winchstr(a,b) = ccall((:winchstr, ncurses), Cint, (Window,Ptr{UInt32}), a,b)
    n_winnstr(a,b,c) = ccall((:winnstr, ncurses), Cint, (Window,Cstring,Cint), a,b,c)
    n_winsch(a,b) = ccall((:winsch, ncurses), Cint, (Window,UInt32), a,b)
    n_winsdelln(a,b) = ccall((:winsdelln, ncurses), Cint, (Window,Cint), a,b)
    n_winsertln(a) = ccall((:winsertln, ncurses), Cint, (Window,), a)
    n_winsnstr(a,b,c) = ccall((:winsnstr, ncurses), Cint, (Window,Cstring,Cint), a,b,c)
    n_winsstr(a,b) = ccall((:winsstr, ncurses), Cint, (Window,Cstring), a,b)
    n_winstr(a,b) = ccall((:winstr, ncurses), Cint, (Window,Cstring), a,b)
    n_wmove(a,b,c) = ccall((:wmove, ncurses), Cint, (Window,Cint,Cint), a,b,c)
    n_wnoutrefresh(a) = ccall((:wnoutrefresh, ncurses), Cint, (Window,), a)
    n_wredrawln(a,b,c) = ccall((:wredrawln, ncurses), Cint, (Window,Cint,Cint), a,b,c)
    n_wrefresh(a) = ccall((:wrefresh, ncurses), Cint, (Window,), a)
    n_wscrl(a,b) = ccall((:wscrl, ncurses), Cint, (Window,Cint), a,b)
    n_wsetscrreg(a,b,c) = ccall((:wsetscrreg, ncurses), Cint, (Window,Cint,Cint), a,b,c)
    n_wstandout(a) = ccall((:wstandout, ncurses), Cint, (Window,), a)
    n_wstandend(a) = ccall((:wstandend, ncurses), Cint, (Window,), a)
    n_wsyncdown(a) = ccall((:wsyncdown, ncurses), Cvoid, (Window,), a)
    n_wsyncup(a) = ccall((:wsyncup, ncurses), Cvoid, (Window,), a)
    n_wtimeout(a,b) = ccall((:wtimeout, ncurses), Cvoid, (Window,Cint), a,b)
    n_wtouchln(a,b,c,d) = ccall((:wtouchln, ncurses), Cint, (Window,Cint,Cint,Cint), a,b,c,d)
    n_wvline(a,b,c) = ccall((:wvline, ncurses), Cint, (Window,UInt32,Cint), a,b,c)
    export n_addch,n_addchnstr,n_addchstr,n_addnstr,n_addstr,n_attroff,n_attron,n_attrset,n_attr_get,n_attr_off,n_attr_on,n_attr_set,n_baudrate,n_beep,n_bkgd,n_bkgdset,n_border,n_box,n_can_change_color,n_cbreak,n_chgat,n_clear,n_clearok,n_clrtobot,n_clrtoeol,n_color_content,n_color_set,n_COLOR_PAIR,n_copywin,n_curs_set,n_def_prog_mode,n_def_shell_mode,n_delay_output,n_delch,n_delwin,n_deleteln,n_derwin,n_doupdate,n_dupwin,n_echo,n_echochar,n_erase,n_endwin,n_erasechar,n_filter,n_flash,n_flushinp,n_getbkgd,n_getch,n_getnstr,n_getstr,n_halfdelay,n_has_colors,n_has_ic,n_has_il,n_hline,n_idcok,n_idlok,n_immedok,n_inch,n_inchnstr,n_inchstr,n_initscr,n_init_color,n_init_pair,n_innstr,n_insch,n_insdelln,n_insertln,n_insnstr,n_insstr,n_instr,n_intrflush,n_isendwin,n_is_linetouched,n_is_wintouched,n_keyname,n_keypad,n_killchar,n_leaveok,n_longname,n_meta,n_move,n_mvaddch,n_mvaddchnstr,n_mvaddchstr,n_mvaddnstr,n_mvaddstr,n_mvchgat,n_mvcur,n_mvdelch,n_mvderwin,n_mvgetch,n_mvgetnstr,n_mvgetstr,n_mvhline,n_mvinch,n_mvinchnstr,n_mvinchstr,n_mvinnstr,n_mvinsch,n_mvinsnstr,n_mvinsstr,n_mvinstr,n_mvvline,n_mvwaddch,n_mvwaddchstr,n_mvwaddnstr,n_mvwaddstr,n_mvwdelch,n_mvwgetch,n_mvwgetnstr,n_mvwgetstr,n_mvwhline,n_mvwin,n_mvwinch,n_mvwinchnstr,n_mvwinchstr,n_mvwinnstr,n_mvwinsch,n_mvwinsnstr,n_mvwinsstr,n_mvwinstr,n_mvwvline,n_napms,n_newpad,n_newwin,n_nl,n_nocbreak,n_nodelay,n_noecho,n_nonl,n_noqiflush,n_noraw,n_notimeout,n_overlay,n_overwrite,n_pair_content,n_PAIR_NUMBER,n_pechochar,n_prefresh,n_qiflush,n_raw,n_redrawwin,n_refresh,n_resetty,n_reset_prog_mode,n_reset_shell_mode,n_savetty,n_scr_dump,n_scr_init,n_scrl,n_scroll,n_scrollok,n_scr_restore,n_scr_set,n_setscrreg,n_slk_attroff,n_slk_attr_off,n_slk_attron,n_slk_attr_on,n_slk_attrset,n_slk_attr,n_slk_attr_set,n_slk_clear,n_slk_color,n_slk_init,n_slk_label,n_slk_noutrefresh,n_slk_refresh,n_slk_restore,n_slk_set,n_slk_touch,n_standout,n_standend,n_start_color,n_subpad,n_subwin,n_syncok,n_termattrs,n_termname,n_timeout,n_touchline,n_touchwin,n_typeahead,n_ungetch,n_untouchwin,n_use_env,n_use_tioctl,n_vidattr,n_vline,n_waddch,n_waddchnstr,n_waddchstr,n_waddnstr,n_waddstr,n_wattron,n_wattroff,n_wattrset,n_wattr_get,n_wattr_on,n_wattr_off,n_wattr_set,n_wbkgd,n_wbkgdset,n_wborder,n_wclear,n_wclrtobot,n_wclrtoeol,n_wcolor_set,n_wcursyncup,n_wdelch,n_wdeleteln,n_wechochar,n_werase,n_wgetch,n_wgetnstr,n_wgetstr,n_whline,n_winch,n_winchnstr,n_winchstr,n_winnstr,n_winsch,n_winsdelln,n_winsertln,n_winsnstr,n_winsstr,n_winstr,n_wmove,n_wnoutrefresh,n_wredrawln,n_wrefresh,n_wscrl,n_wsetscrreg,n_wstandout,n_wstandend,n_wsyncdown,n_wsyncup,n_wtimeout,n_wtouchln,n_wvline
    # autogenerated code ends here

end
