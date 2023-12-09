input=readlines("input.txt");

function nextvalue(s)
    res=[]
    ns=parse.(Int,split(s," "))
    while any(ns.!=0)
        push!(res,ns)
        ns=ns[2:end]-ns[1:end-1]
    end
    return sum([last(x) for x in res])
end

function part1(input)
    return sum(nextvalue.(input))    
end

@time p1=part1(input)
println("Part1: $p1")

function previous_value(s)
    res=[]
    ns=reverse(parse.(Int,split(s," ")))
    while any(ns.!=0)
        push!(res,ns)
        ns=ns[2:end]-ns[1:end-1]
    end
    return sum([last(x) for x in res])
end

function part2(input)
    return sum(previous_value.(input))
end

@time p2=part2(input)
println("Part2: $p2")