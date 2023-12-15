input=readlines("input.txt")

function hash(s)
    res=0
    for c in s
        res+=Int(c)
        res*=17
        res=res % 256
    end
    return res
end

@time p1=sum(hash.(split(input[1],",")))
println("Part1: $p1")

function part2(input)
    instructions=split(input[1],",")
    d=Dict([i => [] for i in 0:255])
    s=0
    for inst in instructions
        if occursin('-',inst)
            label=inst[1:end-1]
            box=hash(label)
            d[box]=[x for x in d[box] if x[1]!=label]
        else
            label,focal=split(inst,"=")
            focal=parse(Int,focal)
            box=hash(label)
            present_labels=[l[1] for l in d[box]]
            f=findfirst(isequal(label),present_labels)
            if isnothing(f)
                push!(d[box],[label,focal])
            else
                deleteat!(d[box],f)
                insert!(d[box],f,[label,focal])
            end

        end
    end
    for i in 0:255
        l=length(d[i])
        l>0 ? s+=(i+1)*(collect(1:l)'*[x[2] for x in d[i]]) : nothing
    end
    return s
end
             
@time p2=part2(input)
println("Part2: $p2")