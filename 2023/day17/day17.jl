using DataStructures

input=parse.(Int,permutedims(reduce(hcat,collect.(readlines("input.txt")))))

function find_neighbours(cur_pos,cur_dir,times_moved_dir)
    res=[]
    if times_moved_dir<3
        push!(res,[[cur_pos+cur_dir] [cur_dir] times_moved_dir+1])
    end
    push!(res,[[cur_pos+(cur_dir*[[0 1];[1 0]])] [cur_dir*[[0 1];[1 0]]] 1])
    push!(res,[[cur_pos+(cur_dir*[[0 -1];[-1 0]])] [cur_dir*[[0 -1];[-1 0]]] 1])
end

function valid(input,pos)
    return (1<=pos[1]<=size(input,1) && 1<=pos[2]<=size(input,2))
end

function part1(input, start_pos, end_pos)
    q=PriorityQueue()
    seen=Set()
    cur_dir=[0 1]
    times_moved_dir=0
    g_score=0
    h_score=sum(abs.(end_pos-start_pos))    
    push!(q,[[start_pos] [cur_dir] times_moved_dir g_score]=>(g_score+h_score,h_score))
    push!(seen,[[start_pos] [cur_dir] times_moved_dir])
    
    cur_dir=[1 0]
    times_moved_dir=0
    g_score=0
    h_score=sum(abs.(end_pos-start_pos))
    push!(q,[[start_pos] [cur_dir] times_moved_dir g_score]=>(g_score+h_score,h_score))
    push!(seen,[[start_pos] [cur_dir] times_moved_dir])
    #i=2

    while !isempty(q)
        #i+=1
        #println("$i $(length(q)) $(first(q))")
        cur_pos,cur_dir,times_moved_dir,score=dequeue!(q)
        cur_pos==end_pos && return score
        neighbours=find_neighbours(cur_pos, cur_dir,times_moved_dir)
        for n in neighbours
            new_pos,new_dir,new_times_moved_dir=n
            if valid(input,new_pos) && !in([[new_pos] [new_dir] new_times_moved_dir],seen)
                new_score=score+input[new_pos...]
                h_score=sum(abs.(new_pos-end_pos))
                push!(q,[[new_pos] [new_dir] new_times_moved_dir new_score]=>(new_score+h_score,h_score))
                push!(seen,[[new_pos] [new_dir] new_times_moved_dir])
            end
        end
    end
end

@time p1=part1(input,[1 1], [141 141])
println("Part1: $p1")

function valid2(input,pos,cur_dir,times_moved_dir)
    times_moved_dir>4 && return valid(input,pos)
    valid(input,pos+cur_dir*(4-times_moved_dir))
end

function find_neighbours2(cur_pos,cur_dir,times_moved_dir)
    res=[]
    if times_moved_dir<10
        push!(res,[[cur_pos+cur_dir] [cur_dir] times_moved_dir+1])
    end
    if times_moved_dir>=4
        push!(res,[[cur_pos+(cur_dir*[[0 1];[1 0]])] [cur_dir*[[0 1];[1 0]]] 1])
        push!(res,[[cur_pos+(cur_dir*[[0 -1];[-1 0]])] [cur_dir*[[0 -1];[-1 0]]] 1])
    end
    return res
end

function part2(input, start_pos, end_pos)
    q=PriorityQueue()
    seen=Set()
    cur_dir=[0 1]
    times_moved_dir=0
    g_score=0
    h_score=sum(abs.(end_pos-start_pos))
    push!(q,[[start_pos] [cur_dir] times_moved_dir g_score]=>(g_score+h_score,h_score))
    push!(seen,[[start_pos] [cur_dir] times_moved_dir])
    
    cur_dir=[1 0]
    times_moved_dir=0
    g_score=0
    h_score=sum(abs.(end_pos-start_pos))
    push!(q,[[start_pos] [cur_dir] times_moved_dir g_score]=>(g_score+h_score,h_score))
    push!(seen,[[start_pos] [cur_dir] times_moved_dir])
    
    while !isempty(q)
        #println("$(length(q)) $(first(q))")
        cur_pos,cur_dir,times_moved_dir,score=dequeue!(q)
        cur_pos==end_pos && return score
        neighbours=find_neighbours2(cur_pos, cur_dir,times_moved_dir)
        for n in neighbours
            new_pos,new_dir,new_times_moved_dir=n
            if valid2(input,new_pos,new_dir,new_times_moved_dir) && !in([[new_pos] [new_dir] new_times_moved_dir],seen)
                new_score=score+input[new_pos...]
                h_score=sum(abs.(new_pos-end_pos))
                push!(q,[[new_pos] [new_dir] new_times_moved_dir new_score]=>(new_score+h_score,h_score))
                push!(seen,[[new_pos] [new_dir] new_times_moved_dir])
            end
        end
    end
end

@time p2=part2(input,[1 1],[141 141])
println("Part2: $p2")