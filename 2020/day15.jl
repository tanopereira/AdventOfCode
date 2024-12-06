input=readlines("data/input15.txt")

function part1(input,k)
    d=Dict()
    s=[parse(Int,x) for x in split(input[1],",")]
    for (i,x) in enumerate(s[1:end-1])
        d[x]=i
    end
    turn=length(s)
    num=last(s)
    while turn<k
        nextnum=(get!(d,num,0)==0) ? 0 : turn-d[num]
        d[num]=turn
        num=nextnum
        turn+=1
    end
    return num
end

@time p1=part1(input,2020)
@time p2=part1(input,30000000)
