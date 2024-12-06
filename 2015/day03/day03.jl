input=readline("input.txt");

function houses(input::String)
    visited = Set{CartesianIndex{2}}()
    pos = CartesianIndex(0, 0)  
    push!(visited, pos)
    for c in input
        if c == '^'
            pos = pos + CartesianIndex(0, 1)
        elseif c == '>'
            pos = pos + CartesianIndex(1, 0)
        elseif c == '<'
            pos = pos + CartesianIndex(-1, 0)
        else 
            pos = pos + CartesianIndex(0, -1)
        end
        push!(visited, pos)
    end
    return visited
end

@time p1=length(houses(input))
@time p2=length(union(houses(input[1:2:end]),houses(input[2:2:end])))

const up=CartesianIndex(0,1)
const down=CartesianIndex(0,-1)
const left=CartesianIndex(-1,0)
const right=CartesianIndex(1,0)

function housesCart(input::String)
    s=Set{CartesianIndex{2}}()
    pos=CartesianIndex(0,0)
    push!(s,pos)
    for c in input
        if c=='^'
            pos+=up
        elseif c=='<'
            pos+=left
        elseif c=='>'
            pos+=right
        else
            pos+=down
        end
        push!(s,pos)
    end
    return s
end

@time p1cart=length(housesCart(input))
@time p2cart=length(union(housesCart(input[1:2:end]),housesCart(input[2:2:end])))