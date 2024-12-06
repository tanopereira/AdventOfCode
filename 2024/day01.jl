using Revise, Distributed


input=readlines("data/input01.txt")


function parse_input(input)
    left=[]
    right=[]
    for line in input
        l,r=parse.(Int,split(line))
        push!(left,l)
        push!(right,r)
    end
    return left,right
end

@time left,right=parse_input(input)
    

function part1(left,right)
    sort!(left)
    sort!(right)
    return sum([abs(x-y) for (x,y) in zip(left,right)])
end

function part2(left,right)
    s=0
    counts=Dict()
    for elem in right
        counts[elem]=get(counts, elem, 0)+1
    end
    return sum(elem * get(counts,elem,0) for elem in left)
end

@time println("Part1:",part1(left,right))
@time println("Part2:",part2(left,right))