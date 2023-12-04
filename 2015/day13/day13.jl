using Combinatorics

input=readlines("input.txt")

M=zeros(9,9)

for i in 1:8
    for j in 1:8
        if i==j
            M[i,j]=0
            continue
        end
        l=popfirst!(input)
        v=parse(Int,match(r"[0-9]+",l).match)
        occursin("lose",l) ? M[i,j]=-v : M[i,j]=v
    end
end

M=M+M'


function happiness(M,v)
    sum(M[i,j] for (i,j) in zip(v[1:end-1],v[2:end]))
end

function maximum_happiness(M)
    P=permutations(1:size(M,1))
    maxh=0
    for v in P
        append!(v,first(v))
        h=happiness(M,v)
        if h>maxh
            maxh=h
        end
    end
    return maxh
end

p1=maximum_happiness(M[1:8,1:8])
p2=maximum_happiness(M)