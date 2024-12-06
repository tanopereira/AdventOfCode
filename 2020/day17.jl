input=stack(readlines("data/input17.txt"))

function neighbors(v)
    x,y,z=v
    l=[]
    for dx in -1:1
        for dy in -1:1
            for dz in -1:1
                if (dx==0 && dy==0 && dz==0)
                    continue
                else
                    push!(l,[x+dx,y+dy,z+dz])
                end
            end
        end
    end
    return l
end

function parse_input(input)
    d=Dict()

    x,y=size(input)
    for i in 1:x
        for j in 1:y
            if input[i,j] == '#'
                d[[i,j,0]]=input[i,j]
            end
        end
    end
    return d
end

function evolve(d)
    newd=copy(d)
    all_potentials=union([neighbors(x) for x in keys(d)]...,[k for k in keys(d)])
    for v in all_potentials
        l=length(intersect(neighbors(v),keys(d)))
        if haskey(d,v)
            if l==2 || l==3
                newd[v]=d[v]
            else
                delete!(newd,v)
            end
        else
            if l==3
                newd[v]='#'
            end
        end
    end
    return newd
end

function solve_part1(input)
    d=parse_input(input)
    for i in 1:6
        d=evolve(d)
    end
    return length(keys(d))
end

function neighbors2(v)
    x,y,z,w=v
    l=[]
    for dx in -1:1
        for dy in -1:1
            for dz in -1:1
                for dw in -1:1
                    if (dw==0 && dx==0 && dy==0 && dz==0)
                        continue
                    else
                        push!(l,[x+dx,y+dy,z+dz,w+dw])
                    end
                end
            end
        end
    end
    return l
end

function parse_input2(input)
    d=Dict()

    x,y=size(input)
    for i in 1:x
        for j in 1:y
            if input[i,j] == '#'
                d[[i,j,0,0]]=input[i,j]
            end
        end
    end
    return d
end

function evolve2(d)
    newd=copy(d)
    all_potentials=union([neighbors2(x) for x in keys(d)]...,[k for k in keys(d)])
    for v in all_potentials
        l=length(intersect(neighbors2(v),keys(d)))
        if haskey(d,v)
            if l==2 || l==3
                newd[v]=d[v]
            else
                delete!(newd,v)
            end
        else
            if l==3
                newd[v]='#'
            end
        end
    end
    return newd
end

function solve_part2(input)
    d=parse_input2(input)
    for i in 1:6
        d=evolve2(d)
    end
    return length(keys(d))
end

function neighbors_general(v,n)
    l=[]
    for x in Iterators.product(repeat([[-1,0,1]],n)...)
        
            push!(l,v.+x)

    end
    filter!(x->x!=v,l)
    return l
end

function neighbors_general2(v,n)
    l=[]
    for x in CartesianIndices(ntuple(d-> -1:1,n))
        
            push!(l,v.+Tuple(x))

    end
    filter!(x->x!=v,l)
    return l
end


function parse_general(input,n)
    d=Dict()
    x,y=size(input)
    for i in 1:x
        for j in 1:y
            if input[i,j] == '#'
                v=[i,j]
                for i in 1:n-2
                    append!(v,0)
                end
                push!(d,v=>'#')
            end
        end
    end
    return d
end

function evolve_general(d,n)
    newd=copy(d)
    all_potentials=Set()
    for k in keys(d)
        push!(all_potentials,k)
        for v in neighbors_general(k,n)
            push!(all_potentials,v)
        end
    end
    

    #all_potentials=union([neighbors_general(x,n) for x in keys(d)]...,[k for k in keys(d)])
    for v in all_potentials
        l=length(intersect(neighbors_general(v,n),keys(d)))
        if haskey(d,v)
            if l==2 || l==3
                newd[v]=d[v]
            else
                delete!(newd,v)
            end
        else
            if l==3
                newd[v]='#'
            end
        end
    end
    return newd
end

function solve(input,n)
    d=parse_general(input,n)
    for i in 1:6
        d=evolve_general(d,n)
    end
    return length(keys(d))
end

