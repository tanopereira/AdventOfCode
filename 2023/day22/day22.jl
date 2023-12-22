input=readlines("input.txt")

function create_bricks(input)
    q=[]
    for line in input
        x1,y1,z1,x2,y2,z2=[parse(Int,m.match) for m in eachmatch(r"\d+",line)]
        x2+=1
        y2+=1
        z2+=1
        push!(q,[x1,y1,z1,x2,y2,z2])
    end
    return q
end

function brick_overlap(brick_a,brick_b)
    x_intersect=intersect(brick_a[1]:brick_a[4],brick_b[1]:brick_b[4])
    y_intersect=intersect(brick_a[2]:brick_a[5],brick_b[2]:brick_b[5])
    return length(x_intersect)>1 && length(y_intersect)>1
end
    

function drop_brick(brick,other_bricks)
    new_brick=copy(brick)
    pots=filter(x->brick_overlap(brick,x),other_bricks)
    isempty(pots) ? zmin=0 : zmin=maximum([x[6] for x in pots])
    z_diff=brick[6]-brick[3]
    new_brick[3]=zmin
    new_brick[6]=zmin+z_diff
    return new_brick
end

function can_remove(brick,pile)
    pots=filter(x->x[3]==brick[6],pile)
    same_height=filter(x->x[6]==brick[6] && x!=brick,pile)
    isempty(pots) && return true
    for new_brick in pots
        bb=deepcopy(new_brick)
        bb=drop_brick(bb,same_height)
        bb!=new_brick && return false
    end
    return true
end

function tetris(q)
    sorted=[]
    moved=0
    for brick in q
        new_brick=drop_brick(brick,sorted)
        push!(sorted,new_brick)
        new_brick!=brick ? moved+=1 : nothing
    end
    return sorted,moved
end

function part1(input)
    q=create_bricks(input)
    q=sort(q,lt=(x,y)->x[3]<y[3])
    q=tetris(q)[1]
    count=0
    for brick in q
        can_remove(brick,q) ? count+=1 : nothing
    end
    return count
end

function part2(input)
    q=create_bricks(input)
    q=sort(q,lt=(x,y)->x[3]<y[3])
    q=tetris(q)[1]
    s=0
    for brick in q
        if can_remove(brick,q)
            nothing
        else
            new_q=filter(x->x!=brick,q)
            new_q,moved=tetris(new_q)
            s+=moved
        end
    end
    return s
end