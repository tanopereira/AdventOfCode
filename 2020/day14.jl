input=readlines("data/input14.txt")

function part1(input)
    mem=Dict()
    mask=split(input[1]," ")[3]
    m1=replace(mask,'X'=>'0')
    m2=replace(mask,'X'=>'1')
    for line in input[2:end]
        if startswith(line,"mask")
            mask=split(line," ")[3]
            m1=replace(mask,'X'=>'0')
            m2=replace(mask,'X'=>'1')
        else
            s1,s2=[x.match for x in eachmatch(r"[0-9]+",line)]
            mem[s1]=(parse(Int,s2) | parse(Int,"0b$m1")) & parse(Int,"0b$m2")
        end
    end
    return mem,sum(values(mem))
end

function part2(input)
    mem=Dict()
    mask=split(input[1]," ")[3]
    m1=replace(mask,'X'=>'0')
    for line in input[2:end]
        if startswith(line,"mask")
            mask=split(line," ")[3]
            m1=replace(mask,'X'=>'0')
        else
            s1,s2=[x.match for x in eachmatch(r"[0-9]+",line)]
            s1=string(parse(Int,s1) | parse(Int,"0b$m1"),base=2,pad=36)
            s2=parse(Int,s2)
            xs=findall('X',mask)
            for i in 0:2^length(xs)-1
                s=s1
                n=string(i,base=2,pad=length(xs))
                for j in eachindex(xs)
                    s=s[1:xs[j]-1]*n[j]*s[xs[j]+1:end]
                end
                #println(s)
                mem[s]=s2
            end
        end
    end
    return sum(values(mem))
end
