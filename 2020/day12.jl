input=readlines("data/input12.txt")

function part1(input)
    N=[0,1]
    E=[1,0]
    S=[0,-1]
    W=[-1,0]
    M=[[0 1];[-1 0]]
    cur_dir=E
    cur_pos=[0,0]
    for line in input
        q=parse(Int,line[2:end])
        if startswith(line,"F")
            cur_pos=cur_pos+q*cur_dir
        elseif startswith(line,"L")
            turns=div(q,90)
            cur_dir=((-M)^turns)*cur_dir
        elseif startswith(line,"R")
            turns=div(q,90)
            cur_dir=(M^turns)*cur_dir
        elseif startswith(line,"N")
            cur_pos=cur_pos+q*N
        elseif startswith(line,"E")
            cur_pos=cur_pos+q*E
        elseif startswith(line,"S")
            cur_pos=cur_pos+q*S
        elseif startswith(line,"W")
            cur_pos=cur_pos+q*W
        end
        println(cur_pos)
    end
    return abs(cur_pos[1])+abs(cur_pos[2])
end    

function part2(input)
    N=[0,1]
    E=[1,0]
    S=[0,-1]
    W=[-1,0]
    M=[[0 1];[-1 0]]
    waypoint=[10,1]
    cur_pos=[0,0]
    for line in input
        q=parse(Int,line[2:end])
        if startswith(line,"F")
            cur_pos=cur_pos+q*waypoint
        elseif startswith(line,"L")
            turns=div(q,90)
            waypoint=((-M)^turns)*waypoint
        elseif startswith(line,"R")
            turns=div(q,90)
            waypoint=(M^turns)*waypoint
        elseif startswith(line,"N")
            waypoint=waypoint+q*N
        elseif startswith(line,"E")
            waypoint=waypoint+q*E
        elseif startswith(line,"S")
            waypoint=waypoint+q*S
        elseif startswith(line,"W")
            waypoint=waypoint+q*W
        end
        println(cur_pos)
    end
    return abs(cur_pos[1])+abs(cur_pos[2])
end    

