input=readlines("input.txt")
input=[input;""] #add a line for the while loop in create_Ms

function create_Ms(input)
    Ms=[]
    while !isempty(input)
        M=[]
        line=popfirst!(input)
        while line!="" 
            push!(M,line)
            line=popfirst!(input)
        end
        M=permutedims(reduce(hcat,collect.(M)))
        push!(Ms,M)
    end
    return Ms
end

function symmetry(M) #returns a vector starting with zero as in part 2 there may be more than one symmetry
    res=[0]
    ncol=size(M,2)
    pot_col=findall([M[:,i]==M[:,i+1] for i in 1:ncol-1])
    for col in pot_col
        diffmax=min(col,ncol-col)
        if all([M[:,col+1-i]==M[:,col+i] for i in 1:diffmax])
            push!(res,col)
        end
    end
    return res
end

function part1(s)
    input=copy(s)
    Ms=create_Ms(input)
    s=0
    for M in Ms
        col=symmetry(M)[end]
        row=symmetry(permutedims(M))[end]
        s+=col+100*row
    end
    return s
end

@time p1=part1(input)
println("Part1: $p1")

function part2(s)
    input=copy(s)
    Ms=create_Ms(input)
    s=0
    for M in Ms
        col=symmetry(M)
        row=symmetry(permutedims(M))
        newcol=col
        newrow=row
        for i in eachindex(M)
            Mnew=copy(M)
            Mnew[i]=='.' ? Mnew[i]='#' : Mnew[i]='.'
            newcol=symmetry(Mnew)
            newrow=symmetry(permutedims(Mnew))
                if newcol!=col && newcol!=[0]
                    s+=setdiff(newcol,col)[1]
                    break
                end
                if newrow!=row && newrow!=[0]
                    s+=100*setdiff(newrow,row)[1]
                    break
                end
            
        end
    end
    return s
end

@time p2=part2(input)
println("Part2: $p2")