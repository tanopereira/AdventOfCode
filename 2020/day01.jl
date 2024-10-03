input=parse.(Int,readlines("data/input01.txt"))

function part1(input)
    seen=Set{Int}()
    for x in input
        comp=2020-x
        !in(comp,seen) ? push!(seen,x) : return(x*comp)
    end
end


function part2(input)
    for i in 1:length(input)-2
        for j in (i+1):length(input)-1
            s1=input[i]
            s2=input[j]
            p=2020-s1-s2
            in(p,input[(j+1):end]) && return(p*s1*s2)
        end
    end
end

function part2_search(input)
    sort!(input)
    for i in 1:length(input)-2
        left=1+1
        right=length(input)
        while left<right
            s=input[i]+input[left]+input[right]
            if s==2020
                return(input[i]*input[left]*input[right])
            elseif s<2020
                left+=1
            else
                right-=1
            end
        end
    end
end
