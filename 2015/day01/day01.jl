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