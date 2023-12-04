input=readlines("input.txt")

function part1(input)
    s=0
    for line in input
        card,numbers=split(line,": ")
        winning,holding=split(numbers,"|")
        n1=parse.(Int,[m.match for m in eachmatch(r"\d+",winning)])
        n2=parse.(Int,[m.match for m in eachmatch(r"\d+",holding)])
        l=length(intersect(n1,n2))
        if l>0
            s+=2^(l-1)
        end
    end
    return s
end

@time p1=part1(input)
println("Part1: $p1")

function part2(input)
    v=repeat([1],length(input))
    for (i,line) in enumerate(input)
        card,numbers=split(line,": ")
        winning,holding=split(numbers,"|")
        n1=parse.(Int,[m.match for m in eachmatch(r"\d+",winning)])
        n2=parse.(Int,[m.match for m in eachmatch(r"\d+",holding)])
        l=length(intersect(n1,n2))
        if l>0
            v[i+1:i+l].+=v[i]
        end
    end
    return sum(v)
end

@time p2=part2(input)
println("Part2: $p2")

#Knowing how P1 and P2 need the same parsing
function solution(input)
    s=0
    v=repeat([1],length(input))
    for (i,line) in enumerate(input)
        card,numbers=split(line,": ")
        winning,holding=split(numbers,"|")
        n1=parse.(Int,[m.match for m in eachmatch(r"\d+",winning)])
        n2=parse.(Int,[m.match for m in eachmatch(r"\d+",holding)])
        l=length(intersect(n1,n2))
        if l>0
            s+=2^(l-1)
            v[i+1:i+l].+=v[i]
        end
    end
    return s,sum(v)
end

@time p3,p4=solution(input)