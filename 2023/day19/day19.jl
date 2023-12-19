input=readlines("input.txt")

function parse_input(s)
    input=copy(s)
    d=Dict()
    parts=[]
    line=input[1]
    while line!=""
        name, instruction = split(line[1:end-1],"{")
        push!(d,name=>instruction)
        line=popfirst!(input)
    end
    while !isempty(input)
        line=popfirst!(input)
        x,m,a,s=[parse(Int,m.match) for m in eachmatch(r"\d+",line)]
        push!(parts,Dict('x'=>x,'m'=>m,'a'=>a,'s'=>s))
    end
    return d,parts
end

function follow_instruction(d,name,part)
    #println(name)
    name=="A" && return part
    name=="R" && return nothing
    line=d[name]
    instructions=split(line,",")
    for inst in instructions
        if occursin(':',inst)
            cond,dest=split(inst,":")
            xmas=cond[1]
            lt=cond[2]
            value=parse(Int,cond[3:end])
            if lt=='<'
                part[xmas]<value && return follow_instruction(d,dest,part)
            else
                part[xmas]>value && return follow_instruction(d,dest,part)
            end
        else
            return follow_instruction(d,inst,part)
        end
    end
end

function part1(input)
    d,parts=parse_input(input)
    s=0
    for part in parts
        m=follow_instruction(d,"in",part)
        !isnothing(m) ? s+=sum([v for (k,v) in part]) : nothing
    end
    return s
end

@time p1=part1(input)
println("Part1: $p1")

function range_instructions(d,name,range_dict)
    q=[]
    res=[]
    push!(q,(name,range_dict))
    while !isempty(q)
        name,range_dict=popfirst!(q)
        #println("Name: $name, Length_queue:$(length(q))")
        if name=="A" 
            push!(res,BigInt(length(range_dict['x'])*length(range_dict['m'])*length(range_dict['a'])*length(range_dict['s'])))
            #println("Sum so far: $(sum(res))")
            continue
        end
        if name=="R" 
            continue
        end

        line=d[name]
        instructions=split(line,",")
        remain_dict=copy(range_dict)
        for inst in instructions
            filter_dict=copy(remain_dict)
            if occursin(':',inst)
                cond,dest=split(inst,":")
                xmas=cond[1]
                lt=cond[2]
                value=parse(Int,cond[3:end])
                if lt=='<'
                    filter_dict[xmas]=filter(x->x<value,remain_dict[xmas])
                    remain_dict[xmas]=filter(x->x>=value,remain_dict[xmas])
                else
                    filter_dict[xmas]=filter(x->x>value,remain_dict[xmas])
                    remain_dict[xmas]=filter(x->x<=value,remain_dict[xmas])
                end
                push!(q,(dest,filter_dict))
            else
                push!(q,(inst,remain_dict))
            end
        end
    end
    return sum(res)
end

function part2(input)
    d,_=parse_input(input)
    range_dict=Dict('x'=>collect(1:4000),'m'=>collect(1:4000),'a'=>collect(1:4000),'s'=>collect(1:4000))
    return range_instructions(d,"in",range_dict)
end

@time p2=part2(input)
println("Part2: $p2")
