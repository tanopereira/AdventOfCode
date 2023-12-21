input=readlines("input.txt")

function create_board(input)
    d=Dict()
    push!(d,"button"=>Dict("to"=>["broadcaster"],"type"=>"button"))
    for line in input
        from_, to_=split(line," -> ")
        tos=split(to_,", ")
        for elem in tos
            !haskey(d,elem) && push!(d,elem=>Dict("to"=>[],"type"=>"unknown"))
        end
        if from_=="broadcaster" 
            push!(d,from_=>Dict("to"=>tos,"type"=>"broadcaster"))
        elseif occursin('%',from_)
            push!(d,from_[2:end]=>Dict("to"=>tos,"type"=>"flip-flop","on"=>false))
        elseif occursin('&',from_)
            push!(d,from_[2:end]=>Dict("to"=>tos,"type"=>"conjunction","received"=>Dict()))
        end
    end
    for (k,v) in d
        tos=v["to"]
        for elem in tos
            if d[elem]["type"]=="conjunction"
                push!(d[elem]["received"],k=>"low")
            end
        end
    end
    return d
end

function process_signal(d,q,countlow,counthigh,countbutton)
    newd=deepcopy(d)
    fromnode,tonode,pulse=popfirst!(q)
    pulse=="low" ? countlow+=1 : nothing
    pulse=="high" ? counthigh+=1 : nothing
    type=newd[tonode]["type"]
    tos=newd[tonode]["to"]
    if type=="button"
        push!(q,("button","broadcaster","low"))
        countbutton+=1
    elseif type=="broadcaster"
        send=pulse
        for elem in tos
            push!(q,(tonode,elem,send))
        end
    elseif type=="flip-flop" && pulse=="low"
        status=newd[tonode]["on"]
        status ? send="low" : send="high"
        newd[tonode]["on"]=!status
        for elem in tos
            push!(q,(tonode,elem,send))
        end
    elseif type=="conjunction"
        newd[tonode]["received"][fromnode]=pulse
        memory=[v for (k,v) in newd[tonode]["received"]]
        
        all(memory.=="high") ? send="low" : send="high"
        for elem in tos
            push!(q,(tonode,elem,send))
        end
    end
    return newd,q,countlow,counthigh,countbutton
end

function part1(input,pushes)
    d=create_board(input)
    countlow,counthigh,countbutton=0,0,0
    dnew=deepcopy(d)
    while true
        rxlow=0
        rxhigh=0
    
        q=[("","button","push")]
        while !isempty(q)
            from_,to_,pulse=first(q)
            if to_=="rx"
                pulse=="low" ? rxlow+=1 : rxhigh+=1
                
            end

            dnew,q,countlow,counthigh,countbutton=process_signal(dnew,q,countlow,counthigh,countbutton)
        end
        println("rx low=$rxlow high=$rxhigh")
        dnew==d || countbutton==pushes ? break : nothing
    end

    cycles=pushes/countbutton
    #println("$countlow,$counthigh,$cycles")
    return BigInt(counthigh*countlow*cycles*cycles)
end


function part2(input)
    d=create_board(input)
    countlow,counthigh,countbutton=0,0,0
    dnew=deepcopy(d)
    fm,dk,fg,pq=0,0,0,0
    #these all feed into vr which is a conjunction module so they all need to send a high pulse at the same time
    while true
        q=[("","button","push")]
        
        while !isempty(q)
            from_,to_,pulse=first(q)
            if from_=="fm" && pulse=="high"
                println("fm :$countbutton")
                fm=countbutton
            elseif from_=="dk" && pulse=="high"
                println("dk :$countbutton")
                dk=countbutton
            elseif from_=="fg" && pulse=="high"
                println("fg :$countbutton")
                fg=countbutton
            elseif from_=="pq" && pulse=="high"
                println("pq :$countbutton")
                pq=countbutton
            end

            dnew,q,countlow,counthigh,countbutton=process_signal(dnew,q,countlow,counthigh,countbutton)
        end
        fm>0 && dk>0 && fg>0 && pq>0 ? break : nothing
    end

    #cycles=pushes/countbutton
    #println("$countlow,$counthigh,$cycles")
    return lcm(fm,dk,fg,pq)
end
