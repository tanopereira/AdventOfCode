input=parse.(Int,readlines("data/input09.txt"))

function find_pair(ns,s)
    for i in 1:length(ns)-1
        pot=s-ns[i]
        if pot in ns[i+1:end]
            return true
        end
    end
    return false
end

function part1(input,preamble_length)
    for i in preamble_length+1:length(input)
        if !find_pair(input[i-preamble_length:i-1],input[i])
            return input[i]
        end
    end
    return nothing
end

function part2(input,target)
    for i in 2:length(input)
        for j in 1:length(input)-i+1
            sum(input[j:j+i-1])==target && return sum(extrema(input[j:j+i-1]))
        end
    end
end            
            
p1=part1(input,25)
p2=part2(input,p1)