input=readlines("data/input05.txt")

function part1(input)
    m=-1
    for line in input
        l=reverse(line)
        col=evalpoly(2,'R' .== collect(l[1:3]))
        row=evalpoly(2,'B' .== collect(l[4:end]))
        id=row*8+col
        id>m ? m=id : nothing
    end
    return m
end

function part2(input)
    ids=[]
    for line in input
        l=reverse(line)
        col=evalpoly(2,'R' .== collect(l[1:3]))
        row=evalpoly(2,'B' .== collect(l[4:end]))
        id=row*8+col
        push!(ids,id)
    end
    ids=sort!(ids)
    old_id=popfirst!(ids)
    while !isempty(ids)
        new_id=popfirst!(ids)
        new_id-old_id==2 && return new_id-1
        old_id=new_id
    end
end