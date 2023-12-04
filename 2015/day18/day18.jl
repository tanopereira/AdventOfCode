input=reduce(hcat,split.(readlines("input.txt"),""))

M=input.=="#"
M=M'
neighs=[[-1,-1],[-1,0],[-1,1],[0,-1],[0,1],[1,-1],[1,0],[1,1]]

function sum_neighs(M2,i,j)
    s=0
    for neigh in neighs
        if 0<neigh[1]+i<=size(M2,1) && 0<neigh[2]+j<=size(M2,2)
            s+=M2[neigh[1]+i,neigh[2]+j]
        end
    end
    return s
end

function newstate(M2,i,j)
    S=sum_neighs(M2,i,j)
    if M2[i,j]==1 
        if S==2 || S==3
            return 1
        else
            return 0
        end
    elseif M2[i,j]==0
        if S==3
            return 1
        else
            return 0
        end
    end
end

function next_step(M2)
    newM=copy(M2)
    for i in 1:size(M2,1)
        for j in 1:size(M2,2)
            newM[i,j]=newstate(M2,i,j)
        end
    end
    return newM
end

M2=copy(M)

for k in 1:100
    M2=next_step(M2)
end

p1=sum(M2)

M3=copy(M)
M3[1,1]=1
M3[1,100]=1
M3[100,1]=1
M3[100,100]=1

for k in 1:100
    M3=next_step(M3)
    M3[1,1]=1
    M3[1,100]=1
    M3[100,1]=1
    M3[100,100]=1
end

p2=sum(M3)