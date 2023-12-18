input=readlines("input.txt")

function oldpart1(input) #used a fill thinking that part2 would be about coloring by nearest border or something similar
    d=Dict()
    directions=Dict("R"=>[0 1],"L"=>[0 -1],"D"=>[1 0],"U"=>[-1 0])
    cur_pos=[0 0]
    for line in input
        dir,n,color=split(line," ")
        n=parse(Int,n)
        for i in 1:n
            cur_pos+=directions[dir]
            push!(d,cur_pos=>color)
        end
    end
    inside=Set()
    seen=Set()
    q=Set()
    minrow,maxrow=extrema([k[1] for k in keys(d)])
    mincol,maxcol=extrema([k[2] for k in keys(d) if k[1]==minrow])
    push!(q,[minrow+1 mincol+1])
    while !isempty(q)
        pos=pop!(q)
        #println(pos)
        push!(seen,pos)
        push!(inside,pos)
        for i in -1:1
            for j in -1:1
                newpos=pos+[i j]
                if !in(newpos,seen) && !haskey(d,newpos)
                    push!(q,newpos)
                end 
            end
        end
    end
    return length(d)+length(inside),d, inside
end

function create_dict_1(input)
    d=[]
    directions=Dict("R"=>[0 1],"L"=>[0 -1],"D"=>[1 0],"U"=>[-1 0])
    cur_pos=[0 0]
    trench=0
    for line in input
        dir,n,color=split(line," ")
        n=parse(Int,n)
        trench+=n
        cur_pos=cur_pos+n*directions[dir]
        push!(d,cur_pos)
    end
    return d,trench
end
    
function shoelace(v)
    L=length(v)
    0.5*(sum([v[i][1]*v[mod1(i+1,L)][2]-v[i][2]*v[mod1(i+1,L)][1] for i in 1:L]))
end

#Shoelace gets the area
#Pick's theorem says that when vertices are integer A=interior+(boundary/2)-1
#For this problem we want boundary+interior
#interior=A-(boundary/2)+1
#so interior+boundary=A-(boundary/2)+boundary+1=A+boundary/2+1
function part1(input)
    d,trench=create_dict_1(input)
    return abs(shoelace(d))+trench/2+1
end

function create_dict_2(input)
    d=[]
    directions=Dict('0'=>[0 1],'2'=>[0 -1],'1'=>[1 0],'3'=>[-1 0])
    cur_pos=[0 0]
    trench=0
    for line in input
        _,_,color=split(line," ")
        n=parse(Int,color[3:end-2],base=16)
        dir=directions[color[end-1]]
        trench+=n

        cur_pos=cur_pos+n*dir
        push!(d,cur_pos)
    end
    return d, trench
end

function part2(input)
    d,trench=create_dict_2(input)
    return BigInt(abs(shoelace(d))+trench/2+1)
end

@time p1=part1(input)
println("Part1: $(Int(p1))")
@time p2=part2(input)
println("Part2: $p2")
