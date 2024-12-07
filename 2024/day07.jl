input=readlines("data/input07.txt")

function part1(input)
    count=0
    for line in input
        r,s=split(line,": ")
        r=parse(Int,r)
        numbers=parse.(Int,split(s," "))
        results=[popfirst!(numbers)]
        for n in numbers
            pot_res=[]
            for res in results
                res_next=[res+n,res*n]
                for rr in res_next
                    if rr<=r
                        push!(pot_res,rr)
                    end
                end
            end
            results=pot_res
        end
        if in(r,results)
            count+=r
        end
    end
    return count
end

@time p1=part1(input)
println("Part1: $p1")

function part2(input)
    count=0
    for line in input
        r,s=split(line,": ")
        r=parse(Int,r)
        numbers=parse.(Int,split(s," "))
        results=[popfirst!(numbers)]
        for n in numbers
            pot_res=[]
            for res in results
                res_next=[res+n,res*n,parse(Int,"$res$n")]
                for rr in res_next
                    if rr<=r
                        push!(pot_res,rr)
                    end
                end
            end
            results=pot_res
        end
        if in(r,results)
            count+=r
        end
    end
    return count
end

@time p2=part2(input)
println("Part2: $p2")