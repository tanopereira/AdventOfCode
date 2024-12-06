input=readlines("data/input02.txt")

function part1(input)
    s=0
    for line in input
        lims,letter,pwd=split(line," ")
        min,max=parse.(Int,split(lims,"-"))
        c=letter[1]
        res=length(filter(isequal(c),pwd))
        if min<=res<=max
            s+=1
        end
    end
    return s
end

function part2(input)
    s=0
    for line in input
        lims,letter,pwd=split(line," ")
        min,max=parse.(Int,split(lims,"-"))
        c=letter[1]
        res=length(filter(isequal(c),"$(pwd[min])$(pwd[max])"))
        if res==1
            s+=1
        end
    end
    return s
end

@time println(part1(input))
@time println(part2(input))