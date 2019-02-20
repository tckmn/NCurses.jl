#!/usr/bin/ruby

def parse types
    # we could do proper parsing, but there's only one edge case,
    # so it's easier to just do an ugly hack around that
    types.sub('int (*)(WINDOW *, int)', 'fnptr').split(?,).map{|x|
        x = x.strip.sub('const ', '').sub('NCURSES_CONST ', '').sub(' *', '*')
        {
            'int' => 'Cint',
            'void' => 'Cvoid',
            'void*' => 'Ptr{Cvoid}',
            'char' => 'Cchar',
            'char*' => 'Cstring',

            # might be unsigned or might be uint32_t, so use UInt32
            'chtype' => 'UInt32',
            # attr_t is defined as chtype
            'attr_t' => 'UInt32',
            'chtype*' => 'Ptr{UInt32}',
            'attr_t*' => 'Ptr{UInt32}',

            'NCURSES_COLOR_T' => 'Cshort',
            'NCURSES_COLOR_T*' => 'Ptr{Cshort}',
            'NCURSES_PAIRS_T' => 'Cshort',
            'NCURSES_PAIRS_T*' => 'Ptr{Cshort}',
            'NCURSES_ATTR_T' => 'Cint',

            'WINDOW*' => 'Window',  # Ptr{Cvoid}

            # might be stdbool or might be unsigned char, so to be safe use UInt8
            'bool' => 'UInt8',
        }[x]
    }
end

going = false
names = []
out = File.open 'out.jl', 'w'
File.open('ncurses.h').each do |line|
    if line =~ /^
            extern\ NCURSES_EXPORT
            \s* \( ([^)]+) \)
            \s* (\w+)
            \s* \( (.*) \)
            ;? \t+ \/\* .* \*\/
        $/x
        ret, name, args = $1, $2, $3
        going = true if name == 'addch'
        if going
            ret, args = parse(ret)[0], parse(args)
            if ret == nil || args.include?(nil)
                puts "skipping #{name}"
                next
            end
            names.push 'n_'+name
            args = [] if args == ['Cvoid']  # no arguments
            ch = ?`
            vars = args.map{ch.next!.dup}*?,
            args.push '' if args.size == 1  # a 1-tuple is (x,)
            out.puts "n_#{name}(#{vars}) = ccall((:#{name}, ncurses), #{ret}, " +
                "(#{args*?,})#{vars.empty? ? '' : ', '}#{vars})"
            break if name == 'wvline'
        end
    end
end
out.puts "export #{names*?,}"
out.close

