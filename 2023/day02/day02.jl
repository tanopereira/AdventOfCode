input=readlines("input.txt")

function parse_line(line)
    s=split(line,": ")
    game_number=parse(Int,match(r"\d+",s[1]).match)
    ss=split(s[2],"; ")
    d=[]
    for el in ss
        dd=Dict("blue"=>0,"red"=>0,"green"=>0)
        els=split(el,", ")
        for els_el in els
            x1,x2=split(els_el," ")
            push!(dd,x2 => parse(Int, x1))
        end
        push!(d,dd)
    end
    return game_number,d
end

function possible(v, red=12,green=13,blue=14)
    for d in v
        if d["red"]<=red && d["green"]<=green && d["blue"]<=blue
            continue
        else
            return false
        end
    end
    return true
end

function part1(input)
    s=0
    for line in input
        i,v=parse_line(line)
        possible(v) ? s+=i : continue
    end
    return s
end

p1=part1(input)
println("Part1 : $p1")

function cube_power(v)
    p=1
    for k in ["blue","red","green"]
        p*=maximum([x[k] for x in v])
    end
    return p
end

function part2(input)
    s=0
    for line in input
        i,v=parse_line(line)
        s+=cube_power(v)
    end
    return s
end

p2=part2(input)
println("Part2: $p2")