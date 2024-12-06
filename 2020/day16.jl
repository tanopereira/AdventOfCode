input=readlines("data/input16.txt")

function part1(input)
    S=[]
    x1,x2=findall(x->x=="",input)
    for i in 1:x1-1
        s1,s2,s3,s4=parse.(Int,[m.match for m in eachmatch(r"[0-9]+",input[i])])
        S=union(S,s1:s2,s3:s4)
    end
    ss=0
    for i in x2+2:length(input)
        line=parse.(Int,[m.match for m in eachmatch(r"[0-9]+",input[i])])
        sd=setdiff(line,S)
        !isempty(sd) ? ss+=sum(sd) : nothing
    end
    return ss
end

function part2(input)
    S=[]
    d=Dict()
    x1,x2=findall(x->x=="",input)
    for i in 1:x1-1
        s1,s2,s3,s4=parse.(Int,[m.match for m in eachmatch(r"[0-9]+",input[i])])
        name=split(input[i],":")[1]
        d[name]=union(s1:s2,s3:s4)
        S=union(S,s1:s2,s3:s4)
    end
    valid=[]
    for i in x2+2:length(input)
        line=parse.(Int,[m.match for m in eachmatch(r"[0-9]+",input[i])])
        sd=setdiff(line,S)
        isempty(sd) ? push!(valid,line) : nothing
    end
    pot_dict=Dict()
    for k in keys(d)
        push!(pot_dict,k=>[1:20...])
    end
    v=stack(valid)
    for i in 1:length(keys(pot_dict))
        for k in keys(pot_dict)
            sd=setdiff(v[i,:],d[k])
            !isempty(sd) ? pot_dict[k]=setdiff(pot_dict[k],i) : nothing
        end
    end
    established=filter(x->length(pot_dict[x])==1,keys(d))
    while length(established)<length(keys(d))
        for k in established
            for ne in setdiff(keys(d),established)
                pot_dict[ne]=setdiff(pot_dict[ne],pot_dict[k])
            end
        end
        established=filter(x->length(pot_dict[x])==1,keys(d))
    end
    my_ticket=parse.(Int,[m.match for m in eachmatch(r"[0-9]+",input[x1+2])])
    p=1
    for k in keys(pot_dict)
        occursin("departure",k) ? p*=my_ticket[pot_dict[k][1]] : nothing
    end
    return p
end

