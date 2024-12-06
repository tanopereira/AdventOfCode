input=parse.(Int,readlines("data/input10.txt"))

function part1(input)
    input2=copy(input)
    i=sort!(input2)
    pushfirst!(input2,0)
    push!(input2,input2[end]+3)
    d=countmap(diff(input2))
    println(d)
    return d[3]*d[1]
end

function part2(input)
   
    input2=copy(input)
    sort!(input2)
    pushfirst!(input2,0)
    push!(input2,input2[end]+3)
    n=length(input2)
    dp=zeros(Int,n)
    dp[1]=1
    for i in 2:n
        for j in max(i-3,1):i-1
            if input2[i]-input2[j]<=3
                dp[i]+=dp[j]
            end
        end
    end
    return dp[n]
end





