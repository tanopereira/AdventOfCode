input=readlines("input.txt")

M=zeros(8,8)

for i in 1:7
    for j in (i+1):8
        l=popfirst!(input)
        _ , n = split(l," = ")
        M[i,j]=parse(Int,n)
    end
end

M=M+M'

function dfs(M, node, visited, path, curr_dist, dist,part)
    s=size(M,1)
    visited[node]=1
    push!(path, node)
    if length(path)==s
        if part==1
            if curr_dist<dist
                dist=curr_dist
            end
        else
            if curr_dist>dist
                dist=curr_dist
            end
        end
    else
        for neighbor in 1:s
            if visited[neighbor]==0
                new_dist = curr_dist + M[node, neighbor]
                dist=dfs(M,neighbor, visited,path,new_dist,dist,part) 
            end
        end
    end
    #println(path)
    pop!(path)
    visited[node]=false

    return dist
    
end

min_dfs(i)=dfs(M,i,zeros(8),[],0,9999999,1)
max_dfs(i)=dfs(M,i,zeros(8),[],0,0,2)

@time p1=minimum(min_dfs.(1:8))
@time p2=maximum(max_dfs.(1:8))