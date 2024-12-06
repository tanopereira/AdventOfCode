using Revise, Distributed

@time input=readlines("data/input03.txt")

function part1(input)
    s=0
    for line in input
        m=[m.match for m in eachmatch(r"mul\([0-9]{1,3},[0-9]{1,3}\)",line)]
        for mm in m
            m1,m2=parse.(Int,match(r"([0-9]+),([0-9]+)",mm).captures)
            s+=m1*m2
        end
    end
    return s
end

function part2(input)
    s=0
    enabled=1
    for line in input
        m=[m.match for m in eachmatch(r"mul\([0-9]{1,3},[0-9]{1,3}\)|do\(\)|don't\(\)",line)]
        for mm in m
            if mm=="do()"
                enabled=1
            elseif mm=="don't()"
                enabled=0
            else
                m1,m2=parse.(Int,match(r"([0-9]+),([0-9]+)",mm).captures)
                s+=enabled*m1*m2
            end
        end
    end
    return s
end

@time println("Part1:", part1(input))
@time println("Part2:", part2(input))