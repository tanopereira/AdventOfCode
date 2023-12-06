input=readlines("input.txt")

function part1(input)
    ts=parse.(Int,[m.match for m in eachmatch(r"\d+",input[1])])
    ds=parse.(Int,[m.match for m in eachmatch(r"\d+",input[2])])
    p=[]
    for (t,d) in zip(ts,ds)
        res=0
        for i in 0:t
            i*(t-i)>=d ? res+=1 : continue
        end
        push!(p,res)
    end
    return prod(p)
end

@time p1=part1(input)

function part2(input)
    ts=parse(Int,reduce(*,[m.match for m in eachmatch(r"\d+",input[1])]))
    ds=parse(Int,reduce(*,[m.match for m in eachmatch(r"\d+",input[2])]))
    p=[]
    @inbounds for (t,d) in zip(ts,ds)
        res=0
        @inbounds for i in 0:t
            i*(t-i)>=d ? res+=1 : continue
        end
        push!(p,res)
    end
    return prod(p)
end

@time p2=part2(input)