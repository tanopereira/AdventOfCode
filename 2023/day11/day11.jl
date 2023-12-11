input=reduce(hcat,collect.(readlines("input.txt"))) |> permutedims

function mydist(x,y,empty_rows,empty_cols,value) #value is the number of rows added due to expansion
    rows=collect(min(x[1],y[1]):max(x[1],y[1]))
    cols=collect(min(x[2],y[2]):max(x[2],y[2]))
    return abs(x[1]-y[1])+abs(x[2]-y[2])+(length(intersect(rows,empty_rows))+length(intersect(cols,empty_cols)))*value
end
    
function part1(input,value)
    M=copy(input)
    galaxies=findall(isequal('#'),M)
    galaxies=[[galaxies[i][1],galaxies[i][2]] for i in eachindex(galaxies)]
    empty_rows=[]
    empty_cols=[]
    for i in 1:size(M,1)
        all(M[i,:].=='.') && push!(empty_rows,i)
        all(M[:,i].=='.') && push!(empty_cols,i)
    end
    s=0
    for i in 1:length(galaxies)-1
        for j in i+1:length(galaxies)
            s+=mydist(galaxies[i],galaxies[j],empty_rows,empty_cols,value)
        end
    end
    return s
end

@time p1=part1(input,1)
@time p2=part1(input,999999)
println("Part1: $p1")
println("Part2: $p2")