using Memoize, LRUCache
input=readlines("input.txt")


function valid(s,vs)
    if !occursin('?',s)
        return [length(m.match) for m in eachmatch(r"#+",s)]==vs
    else
        short_s=s[1:findfirst(isequal('?'),s)-1]
        isempty(short_s) && return true
        ls=[length(m.match) for m in eachmatch(r"#+",short_s)]
        isempty(ls) && return true
        l=length(ls)
        if l>length(vs) return false end
        if l==1 
            return ls[1]<=vs[1]
        else
            return all(ls[1:l-1].==vs[1:l-1]) && ls[l]<=vs[l]
        end
    end
end

function find_pots(line)
    pots=[]
    res=[]
    s,vs=split(line," ")
    vs=parse.(Int,[m.match for m in eachmatch(r"\d+",vs)])
    push!(pots,s)
    while !isempty(pots)
        s=popfirst!(pots)
        #println(s)
            if !occursin('?',s)
                valid(s,vs) && push!(res,s)
            else
                snew=replace(s,'?' => '#',count=1)
                snew2=replace(s, '?' => '.',count=1)
                valid(snew,vs) && push!(pots,snew)
                valid(snew2,vs) && push!(pots,snew2)
                
            end
        
    end
    return res
end

function part1(input)
    return sum([length(find_pots(line)) for line in input])
end



@memoize LRU{Tuple{Any,Any},Any}(maxsize=1000000) function solve(s,vs)
    res=0
    
    if length(s)==0
        return 1*(isempty(vs))
    end
    
    if isempty(vs)
        return 1*(!in('#',s))
    end
    if occursin(s[1],".?")
        res+=solve(s[2:end],vs)
    end

    if occursin(s[1],"#?") && vs[1]<=length(s) && !in('.',s[1:vs[1]]) && (vs[1]==length(s) || s[vs[1]+1]!='#')
        res+=solve(s[vs[1]+2:end],vs[2:end])
    end
    return res

end

function part1(input)
    res=0
    for line in input
        s,vs=split(line," ")
        vs=parse.(Int,[m.match for m in eachmatch(r"\d+",vs)])
        res+=solve(collect(s),vs)
    end
    return res
end

function unfold_line(line)
    s1,s2=split(line," ")
    new_s="$s1?$s1?$s1?$s1?$s1 $s2,$s2,$s2,$s2,$s2"
end

function part2(input)
    res=0
    for (i,line) in enumerate(input)
        new_line=unfold_line(line)
        s,vs=split(new_line," ")
        vs=parse.(Int,[m.match for m in eachmatch(r"\d+",vs)])
        res+=solve(collect(s),vs)
        #println("$i $res")
    end
    return res
end