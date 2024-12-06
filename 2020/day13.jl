input=readlines("data/input13.txt")

function part1(input)
    N=parse(Int,input[1])
    busids = parse.(Int,[m.match for m in eachmatch(r"[0-9]+",input[2])])
    m=Inf
    busid=0
    for bus in busids
        res=bus*cld(N,bus)
        println(res)
        if res<m
            m=res
            busid=bus
        end
    end
    return busid*(m-N)
end

function chineseremainder(n::Array, a::Array)
    Π = prod(n)
    mod(sum(ai * invmod(Π ÷ ni, ni) * (Π ÷ ni) for (ni, ai) in zip(n, a)), Π)
end

function part2(input)
    busids=split(input[2],',')
    nums=[]
    rems=[]
    for (i,bus) in enumerate(busids)
        if bus!="x"
            bus=parse(Int,bus)
            push!(nums,bus)
            push!(rems,bus-i+1)
        end
    end
    return chineseremainder(nums,rems)
end
