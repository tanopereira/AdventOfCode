s=readline("input.txt")

function floor(s)
    ss=0
    tots=[]
    for c in s
        if c=='('
            ss+=1
        else
            ss-=1
        end
        push!(tots,ss)
    end
    return ss,tots
end

p=floor(s)
p1=p[1]
p2=findfirst(isequal(-1),p[2])

function new_floor(s)
    ss=0
    first_minus_one=-1
    i=0
    for c in s
        i+=1
        c=='(' ? ss+=1 : ss-=1
        ss==-1 && first_minus_one<0 ? first_minus_one=i : nothing 
    end
    return ss,first_minus_one
end

@time println(floor(s)[1])

