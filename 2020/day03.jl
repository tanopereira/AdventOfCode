input=permutedims(stack(readlines("data/input03.txt")))

function part1(input,(slope1,slope2))
    x,y=1,1
    s=0
    while y<size(input,1)
        x+=slope1
        y+=slope2
        x=mod1(x,size(input,2))
        if input[y,x] == '#'
            s+=1
        end
    end
    return s
end

function part2(input)
    slopes=[(1,1),(3,1),(5,1),(7,1),(1,2)]
    p=1
    for slope in slopes
        p*=part1(input,slope)
    end
    return p
end

@time println(part1(input,(3,1)))
@time println(part2(input))