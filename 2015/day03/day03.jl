input=readline("input.txt");

function houses(input)
    s=Set()
    pos=[0,0]
    push!(s,pos)
    for c in input
        if c=='^'
            pos=pos+[0,1]
        elseif c=='>'
            pos=pos+[1,0]
        elseif c=='<'
            pos=pos-[1,0]
        else
            pos=pos-[0,1]
        end
        push!(s,pos)
    end
    return s
end

@time p1=length(houses(input))
@time p2=length(union(houses(input[1:2:end]),houses(input[2:2:end])))
