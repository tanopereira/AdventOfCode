using Memoize, LRUCache
input=permutedims(reduce(hcat,collect.(readlines("input.txt"))))

function part1(input)
    res=zeros(Int,size(input,1))
    for col in eachcol(input)
        startpos=1
        pos=1
        while pos<=length(col)
            if col[pos]=='O'
                res[startpos]+=1 
                startpos+=1
            end
            if col[pos]=='#'
                startpos=pos+1
            end
            pos+=1
        end
    end
    return collect(length(res):-1:1)'*res
end

function tiltN(M)
    Mnew=copy(M)
    for col in eachcol(Mnew)
        startpos=1
        pos=1
        while pos<=length(col)
            if col[pos]=='O'
                col[startpos]='O'
                if pos!=startpos
                    col[pos]='.'
                end 
                startpos+=1
            end
            if col[pos]=='#'
                startpos=pos+1
            end
            pos+=1
        end
    end
    return Mnew
end
    
function tiltW(M)
    Mnew=copy(M)
    for row in eachrow(Mnew)
        startpos=1
        pos=1
        while pos<=length(row)
            if row[pos]=='O'
                row[startpos]='O'
                if pos!=startpos
                    row[pos]='.'
                end 
                startpos+=1
            end
            if row[pos]=='#'
                startpos=pos+1
            end
            pos+=1
        end
    end
    return Mnew
end

function tiltS(M)
    Mnew=copy(M)
    Mnew=Mnew[end:-1:1,:]
    Mnew=tiltN(Mnew)
    Mnew=Mnew[end:-1:1,:]
    return Mnew
end

function tiltE(M)
    Mnew=copy(M)
    Mnew=Mnew[:,end:-1:1]
    Mnew=tiltW(Mnew)
    Mnew=Mnew[:,end:-1:1]
    return Mnew
end

@memoize function cycle(M)
    return tiltE(tiltS(tiltW(tiltN(M))))
end


@memoize function load(M)
    s=0
    for i in size(M,1):-1:1
        s+=i*sum(M[end-i+1,:].=='O')
    end
    return s
end

function part2(input)
    M=input
    for i in 1:1000
        M=cycle(M)
        println("$i, $(load(M))")
    end
end

#part2 has a cycle of 42, so rem(1e9,42)=34 so after a settling period you can choose any of the 42k+34 results, which gives 88680 as response

