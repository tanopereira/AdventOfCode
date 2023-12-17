using Memoize, LRUCache

input=permutedims(reduce(hcat,collect.(readlines("input.txt"))))

function valid(input, pos)
    s1,s2=size(input)
    return (1<=pos[1]<=s1 && 1<=pos[2]<=s2)
end

function part1(input,start_pos,start_dir)
    directions=Dict('U'=>[-1,0],'D'=>[1,0],'L'=>[0,-1],'R'=>[0,1])
    beams=[]
    push!(beams,[[start_pos] start_dir])
    seen=Set()
    seen_with_direction=Set()
    while !isempty(beams)
        #println(beams)
        cur_pos,cur_dir=pop!(beams)
        push!(seen,cur_pos)
        push!(seen_with_direction,[[cur_pos] cur_dir])
        #println(length(seen))

        if input[cur_pos...]=='.'
            dir=cur_dir
            pot_pos=cur_pos+directions[dir]
            if valid(input,pot_pos)
                push!(beams,[[pot_pos] dir]) 
            end
        elseif input[cur_pos...]=='|'
            if cur_dir=='U' || cur_dir=='D'
                dir=cur_dir
                pot_pos=cur_pos+directions[dir]
                if valid(input,pot_pos)
                    !in([[pot_pos] dir],seen_with_direction) ? push!(beams,[[pot_pos] dir]) : nothing
                end
            else
                for dir in ['U','D']
                    pot_pos=cur_pos+directions[dir]
                    if valid(input,pot_pos)
                        !in([[pot_pos] dir],seen_with_direction) ? push!(beams,[[pot_pos] dir]) : nothing
                    end
                end
            end
        elseif input[cur_pos...]=='\\'
            if cur_dir=='U'
                dir='L'
            elseif cur_dir=='R'
                dir='D'
            elseif cur_dir=='L'
                dir='U'
            else
                dir='R'
            end
            pot_pos=cur_pos+directions[dir]
            if valid(input,pot_pos)
                !in([[pot_pos] dir],seen_with_direction) ? push!(beams,[[pot_pos] dir]) : nothing
            end
        elseif input[cur_pos...]=='-'
            if cur_dir=='L' || cur_dir=='R'
                dir=cur_dir
                pot_pos=cur_pos+directions[dir]
                if valid(input,pot_pos)
                    !in([[pot_pos] dir],seen_with_direction) ? push!(beams,[[pot_pos] dir]) : nothing
                end
            else
                for dir in ['L','R']
                    pot_pos=cur_pos+directions[dir]
                    if valid(input,pot_pos)
                        !in([[pot_pos] dir],seen_with_direction) ? push!(beams,[[pot_pos] dir]) : nothing
                    end
                end
            end    
        elseif input[cur_pos...]=='/'
            if cur_dir=='U'
                dir='R'
            elseif cur_dir=='R'
                dir='U'
            elseif cur_dir=='L'
                dir='D'
            else
                dir='L'
            end
            pot_pos=cur_pos+directions[dir]
            if valid(input,pot_pos)
                !in([[pot_pos] dir],seen_with_direction) ? push!(beams,[[pot_pos] dir]) : nothing
            end
        end
    end
    return length(seen)
end

function part2(input)
    res=0
    for i in 1:110
        pot=part1(input,[i,1],'R')
        pot>=res ? res=pot : nothing
        pot=part1(input,[1,i],'D')
        pot>=res ? res=pot : nothing
        pot=part1(input,[i,110],'L')
        pot>=res ? res=pot : nothing
        pot=part1(input,[110,i],'U')
        pot>=res ? res=pot : nothing
    end
    return res
end

@time p1=part1(input,[1,1],'R')
println("Part1: $p1")

@time p2=part2(input)
println("Part2: $p2")