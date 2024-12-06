using DataStructures

input=readlines("input.txt")

transformations=input[1:end-2]
molecule=input[end]

function part1(transformations,molecule)
    res=Set()
    for t in transformations
        #println(t)
        t1,t2=split(t," => ")
        fs=findall(t1,molecule)
        if !isempty(fs)
            for f in fs
                F=collect(f)
                if length(F)==1
                    n1=n2=F[1]
                else 
                    n1,n2=F[1],F[end]
                end
                push!(res,molecule[1:n1-1] * t2 * molecule[n2+1:end])
            end
        end
    end
    return res
end

@time p1=length(part1(transformations,molecule))

function part2_1(transformations,molecule) #reverse transform
    res=Set()
    for t in transformations
        #println(t)
        t2,t1=split(t," => ")
        fs=findall(t1,molecule)
        if !isempty(fs)
            for f in fs
                F=collect(f)
                if length(F)==1
                    n1=n2=F[1]
                else 
                    n1,n2=F[1],F[end]
                end
                s=molecule[1:n1-1] * t2 * molecule[n2+1:end]
                push!(res,s)
            end
        end
    end
    return res
end
    
function part2_2(transformations,start_mol,end_mol)
    i=0
    res=Set()
    while !any(res.==end_mol)
        i+=1
        res2=PriorityQueue()
        isempty(res) ? push!(res,start_mol) : nothing
        while !isempty(res)
            el=pop!(res)
            res3=part2_1(transformations,el)
            for newel in res3
                push!(res2, newel => length(newel))
            end
        end
        #res=Set()
        for i in 1:min(length(res2),16)  #keep the first 16 only (works!)
            push!(res,dequeue!(res2))
        end
        #println(i, " ", length(res))
    end
    return i,res
end

@time p2=part2_2(transformations,molecule,"e")[1]

