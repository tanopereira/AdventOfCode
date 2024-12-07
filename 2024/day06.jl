using Revise, Distributed
function solve()
input=stack(readlines("data/input06.txt"))

function isvalid(pos,s1,s2)
    return 1<=pos[1]<=s1 && 1<=pos[2]<=s2
end

function part1(input)
    s1,s2=size(input)
    
    pos=findfirst(==('^'),input)
    dirs=[CartesianIndex(0,-1),CartesianIndex(1,0),CartesianIndex(0,1),CartesianIndex(-1,0)]
    visited=Set{CartesianIndex{2}}()
    while isvalid(pos,s1,s2)
        push!(visited,pos)
        pot_pos=pos+dirs[1]
        if isvalid(pot_pos,s1,s2) && input[pot_pos]=='#' 
            circshift!(dirs,-1)
        else
            pos=pot_pos
        end
    end
    
    return visited
end

@time p1=part1(input)
println("Part1:", length(p1))

function part2(M)
    
    pot_obstrs=[CartesianIndex(x) for x in setdiff(Tuple.(p1),[Tuple(findfirst(==('^'),M))])]
    s1,s2=size(M)
    count=0
    for pot_obstr in pot_obstrs
        pos=findfirst(==('^'),M)
        dirs=[CartesianIndex(0,-1),CartesianIndex(1,0),CartesianIndex(0,1),CartesianIndex(-1,0)]
        visited=Set()
        M[pot_obstr]='#'
        while isvalid(pos,s1,s2)
            if !in((pos,dirs[1]),visited)
                push!(visited, (pos,dirs[1]))
                pot_pos=pos+dirs[1]
                if isvalid(pot_pos,s1,s2) && M[pot_pos]=='#' 
                    circshift!(dirs,-1)
                else
                    pos=pot_pos
                end
            else
                count+=1
                break
            end
        end
        M[pot_obstr]='.'
    end
    
    return count
end

@time p2=part2(input)
println("Part2:", p2)
end

solve()