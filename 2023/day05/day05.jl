input=readlines("input.txt")


function part1(input)
    seeds=parse.(Int,[m.match for m in eachmatch(r"\d+",input[1])])
    breaks=findall(input.=="")
    locations=[]
    for seed in seeds
        newseed=copy(seed)
        for (s,e) in zip(breaks[1:end].+2,[breaks[2:end].-1;length(input)])
            for i in s:e
                dest,source,rng = parse.(Int, split(input[i]," "))
                if newseed in source:source+rng
                    newseed=newseed+dest-source
                    #println("$i, $dest, $source, $newseed")
                    break
                end
            #println("Newseed unchanged $newseed")
            end
        end
        push!(locations,newseed)
    end
    return minimum(locations)
end

@time p1=part1(input)
println("Part1: $p1")


function part2(input)
    seeds=parse.(Int,[m.match for m in eachmatch(r"\d+",input[1])])
    breaks=findall(input.=="")
    locations=[]
    ranges=[seeds[i]:seeds[i]+seeds[i+1] for i in 1:2:length(seeds)]

    for r in ranges
        newranges=[r]
        for (s,e) in zip(breaks[1:end].+2,[breaks[2:end].-1;length(input)])
            seedranges=[]
            for seedrange in newranges
                count=0
                for i in s:e
                    dest,source,rng = parse.(Int, split(input[i]," "))
                    intersection=intersect(seedrange,source:source+rng)
                    if !isempty(intersection) 
                        push!(seedranges, intersection .- source .+ dest)
                        count+=1
                    end
                end
                if count==0 #if no intersection with any line then seedrange is unchanged
                    push!(seedranges,seedrange)
                end
            end
            newranges=seedranges
            
        end
        push!(locations,first(minimum(newranges)))
    end
    return minimum(locations)
end

@time p2=part2(input)
println("Part2: $p2")
