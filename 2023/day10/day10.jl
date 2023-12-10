input=permutedims(reduce(hcat,collect.(readlines("input.txt"))))

function change_direction(direction, c)
    if direction=='N'
        c=='7' && return 'W'
        c=='F' && return 'E'
        c=='|' && return 'N'
    elseif direction=='S'
        c=='L' && return 'E'
        c=='J' && return 'W'
        c=='|' && return 'S'
    elseif direction=='E'
        c=='7' && return 'S'
        c=='J' && return 'N'
        c=='-' && return 'E'
    elseif direction=='W'
        c=='L' && return 'N'
        c=='F' && return 'S'
        c=='-' && return 'W'
    end
end



function loop(input,start_pos,direction)
    directions=Dict('N'=>[-1,0],'S'=>[1,0],'E'=>[0,1],'W'=>[0,-1])
    d=Dict(start_pos=>[0])
    cur_pos=start_pos.+directions[direction]
    i=0
    while cur_pos!=start_pos
        i+=1
        push!(d,cur_pos=>[i])
        c=input[cur_pos...]
        direction=change_direction(direction,c)
        cur_pos=cur_pos.+directions[direction]       
    end
    return d
end
@time begin
d1=loop(input,[23,115],'N')
p1=div(length(d1),2)
end
println("Part1: $p1")

function part2(input,d)
    m=copy(input)
    m[23,115]='|' #brute force to input
    k=keys(d)
    count=0
    for i in 1:140
        for j in 1:140
            !in([i,j],k) ? m[i,j]='.' : nothing
        end
    end
    for row in 1:140
        inside=false
        for col in 1:140
            if in(m[row,col],['L','|','J'])  #check for parity, have you crossed an odd number of walls walking from left to right, same result with '7' and 'F'
                inside=!inside
            elseif m[row,col]=='.' && inside
                count+=1
            end
        end
    end
    return count
end

@time p2=part2(input,d1)
println("Part2: $p2")