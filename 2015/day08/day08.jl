input=readlines("input.txt")

function part1(input)
    tot=0
    for s in input
        tot+=length(s)-(length(unescape_string(s))-2) #-length()-2 as I need to remove the original begin and end quotes
    end
    return tot
end

@time p1=part1(input)

function part2(input)
    tot=0
    for s in input
        tot+=length(escape_string(s))+2-length(s) # +2 because I need to add begin and end quotes
    end
    return tot
end

@time p2=part2(input)