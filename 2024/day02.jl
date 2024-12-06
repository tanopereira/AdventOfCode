using Revise, Distributed
@time input=readlines("data/input02.txt")

function is_safe(b)
    p=b[1]
    rule1=all(sign(p).==sign.(b[2:end]))
    rule2=all(1 .<= (abs.(b)) .<= 3)
    return rule1 && rule2
end

function part1(input)
    s=0
    for line in input
        a=parse.(Int,split(line))
        b=diff(a)
        is_safe(b) ? s+=1 : nothing
    end
    return s
end

function part2(input)
    s=0
    for line in input
        a=parse.(Int,split(line))
        b=diff(a)
        if is_safe(b)
            s+=1
        else
            for i in eachindex(a)
                b=diff(deleteat!(copy(a),i))
                if is_safe(b)
                    s+=1
                    break
                end
            end
        end
    end
    return s
end

@time println("Part1: ", part1(input))
@time println("Part1 alt:", sum(is_safe.(map(x->diff(x),map(x->parse.(Int,x),split.(input))))))
@time println("Part2: ", part2(input))