using Revise, Distributed
@time input=stack(readlines("data/input04.txt"),dims=1)

function isvalid(pos,M)
   s=size(M)
   return 0<pos[1]<=s[1] && 0<pos[2]<=s[2]
end 

function part1(M)
    directions=[CartesianIndex(-1,-1),CartesianIndex(-1,0),CartesianIndex(-1,1),CartesianIndex(0,-1),CartesianIndex(0,1),CartesianIndex(1,-1),CartesianIndex(1,0),CartesianIndex(1,1)]
    s=0
    idxs=findall(x->x=='X',M)
    for idx in idxs
        for dir in directions
            Mpot=idx+dir
            Apot=idx+2*dir
            Spot=idx+3*dir
            if isvalid(Mpot,M) && isvalid(Apot,M) && isvalid(Spot,M) && M[Mpot]=='M' && M[Apot]=='A' && M[Spot]=='S'
                s+=1
            end 
        end 
    end 
    return s
end 

function part2(M)
    s=0
    idxs=findall(x->x=='A',M)
    dirpairs=[[CartesianIndex(-1,-1), CartesianIndex(1,-1)],[CartesianIndex(1,-1),CartesianIndex(1,1)],[CartesianIndex(1,1),CartesianIndex(-1,1)],[CartesianIndex(-1,1),CartesianIndex(-1,-1)]]
    for idx in idxs
        for dirpair in dirpairs
            Mpot1=idx+dirpair[1]
            Spot1=idx-dirpair[1]
            Mpot2=idx+dirpair[2]
            Spot2=idx-dirpair[2]
            if isvalid(Mpot1,M) && isvalid(Mpot2,M) && isvalid(Spot1,M) && isvalid(Spot2,M) && M[Mpot1]=='M' && M[Mpot2]=='M' && M[Spot1]=='S' && M[Spot2]=='S'
                s+=1
            end
        end
    end 
    return s
end

@time p1=part1(input)
println("Part1: ", p1)
@time p2=part2(input)
println("Part2: ", p2)