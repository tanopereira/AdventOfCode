input=readlines("data/input06.txt")

function part1(input)
    s=0
    S=Set()
    for i in 1:length(input)
        line=input[i]
        cs=collect(line)
        if line != ""
            push!(S,cs...)
        end
        if line=="" || i==length(input)
            s+=length(S)
            S=Set()
        end
    end
    return s
end

function part2(input)
    s=0
    S=collect('a':'z')
    for i in 1:length(input)
        line=input[i]
        cs=collect(line)
        if line!=""
            S=intersect(S,cs)
        end
        if line=="" || i==length(input)
            s+=length(S)
            S=collect('a':'z')
        end
    end
    return s
end

