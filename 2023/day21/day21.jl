input=permutedims(reduce(hcat,collect.(readlines("input.txt"))))

const U=[-1 0]
const L=[0 -1]
const R=[0 1]
const D=[1 0]

dirs=[U,L,R,D]

function valid(pos,input)
    s1,s2=size(input)
    return 1<=pos[1]<=s1 && 1<=pos[2]<=s2 && input[pos...]!='#'
end


function part1(input,reps)
    
    start_pos=[div(size(input,1)+1,2) div(size(input,2)+1,2)]
    new=Set()
    push!(new,start_pos)
    seen=Set()
    for i in 1:reps
        #isempty(new) && return length(seen)
        pots=Set()
        while !isempty(new)
            pos=pop!(new)
            push!(seen,pos)
            for dir in dirs
                new_pos=pos+dir
                if valid(new_pos,input)
                    push!(pots,new_pos)
                end
            end
        end
        new=pots
        #println("$i $(length(new))")
    end
    return length(new)
end

@time p1=part1(input,64)
println("Part1: $p1")    
#For part 2 and in this particular case as the vert and horiz midlines are all garden plots 
#reps=26501365
#this is 202300*131+65
#this will be a quadratic result (in 131 steps you certainly fill the original input and reach the center of the ones to the sides)
#by observing steps reps=65, reps=131+65, reps=131*2+65, etc you can get the coefficients

function part2(input,reps=26501365)
    s=size(input,1)
    d,r=divrem(reps,s)
    r0=part1(input,r)
    r1=part1(repeat(input,3,3),s+r)
    r2=part1(repeat(input,5,5),s*2+r)

    a0=r0
    a1=r1-r0
    a2=(r2-r1)-a1

    v=repeat([a2],d-1) # I need to get to a length of 202301
    v2=cumsum([a1;v]) 
    v3=cumsum([a0;v2])
    return last(v3)
end

@time p2=part2(input)
println("Part2: $p2")