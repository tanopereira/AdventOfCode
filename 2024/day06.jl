using Revise, Distributed
function solve()
input=stack(readlines("data/input06.txt"))

function part1(input)
    s1,s2=size(input)
    function isvalid(pos)
        return 1<=pos[1]<=s1 && 1<=pos[2]<=s2
    end
    pos=findfirst(==('^'),input)
    dirs=[CartesianIndex(0,-1),CartesianIndex(1,0),CartesianIndex(0,1),CartesianIndex(-1,0)]
    visited=Set{CartesianIndex{2}}()
    while isvalid(pos)
        push!(visited,pos)
        pot_pos=pos+dirs[1]
        if isvalid(pot_pos) && input[pot_pos]=='#' 
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
    function isvalid(pos)
        return 1<=pos[1]<=s1 && 1<=pos[2]<=s2
    end
    count=0
    for pot_obstr in pot_obstrs
        pos=findfirst(==('^'),M)
        dirs=[CartesianIndex(0,-1),CartesianIndex(1,0),CartesianIndex(0,1),CartesianIndex(-1,0)]
        visited=Set()
        newM=copy(M)
        newM[pot_obstr]='#'
        while isvalid(pos)
            if !in([pos,dirs[1]],visited)
                push!(visited, [pos,dirs[1]])
                pot_pos=pos+dirs[1]
                if isvalid(pot_pos) && newM[pot_pos]=='#' 
                    circshift!(dirs,-1)
                else
                    pos=pot_pos
                end
            else
                count+=1
                break
            end
        end
    end
    
    return count
end

@time p2=part2(input)
println("Part2:", p2)
end

solve()