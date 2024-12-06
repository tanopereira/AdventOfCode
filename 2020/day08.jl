input=readlines("data/input08.txt")

function parse_inst(s,i,acc)
    if startswith(s, "nop")
        return (i+1,acc)
    elseif startswith(s, "acc")
        return (i+1, acc + parse(Int,s[5:end]))
    else
        return (i+parse(Int,s[5:end]),acc)
    end
end

function part1(input)
    i=1
    acc=0
    visited=Set()
    while !in(i,visited)
        visited = push!(visited,i)
        #println((i,acc))
        i<=length(input) ? (i,acc)=parse_inst(input[i],i,acc) : return (i,acc)
    end
    return (i,acc)
end

function part2(input)
    for j in 1:length(input)
        input2=copy(input)
        if startswith(input2[j],"nop")
            input2[j]="jmp $(input2[j][5:end])"
        elseif startswith(input2[j],"jmp")
            input2[j]="nop $(input2[j][5:end])"
        else 
            continue
        end
        #println(input2)
        (i,acc) = part1(input2)
        if i>length(input)
            return (j,acc)
        end
    end
end
