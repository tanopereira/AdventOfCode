using Revise, Distributed

function solve()
    input=readlines("data/input05.txt")
    rules=Dict()
    updates=[]
    blankline=false
    for line in input
        if line==""
            blankline=true
            continue
        end
        if blankline
            push!(updates,parse.(Int,split(line,",")))
        else
            k,v=parse.(Int,split(line,"|"))
            !haskey(rules,k) ? rules[k]=[v] : push!(rules[k],v)
        end
    end
    function isvalid(update,rules)
        valid=true
        breaking_pages=[]
        for i in 2:length(update)
            if haskey(rules, update[i])
                breaking_pages=intersect(update[1:i-1],rules[update[i]])
                if length(breaking_pages)>0
                    valid=false
                    return valid, breaking_pages, update[i]
                end
            end
        end
        return valid, [], []
    end    
    function makevalid(update,rules)
        valid, br, r = isvalid(update,rules)
        while !valid
            idx_b=findfirst(==(br[1]),update)
            idx_r=findfirst(==(r),update)
            insert!(deleteat!(update,idx_r),idx_b,r)
            #println(update)
            valid, br, r = isvalid(update,rules)
        end
        return update
    end
    svalid=0
    sinvalid=0
    for update in updates
        if isvalid(update,rules)[1]
            svalid+=update[div(length(update),2)+1]
        else
            update=makevalid(update,rules)
            sinvalid+=update[div(length(update),2)+1]
        end
    end
    return svalid,sinvalid
end

@time p1,p2=solve()
println("Part1: $p1")
println("Part2: $p2")