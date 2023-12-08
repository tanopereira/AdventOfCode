input=readlines("input.txt")

instructions=collect(input[1])

function buildmap(input)
    d=Dict()
    for i in 3:length(input)
        s=split(input[i]," = ")
        node=s[1]
        dests=[m.match for m in eachmatch(r"[A-Z]+",s[2])]
        push!(d,node => Dict('L' => dests[1],'R' => dests[2]))
    end
    return d
end

map=buildmap(input)

function part1(instructions, map, start_node, end_node)
    i=0
    current_node=start_node
    while current_node!=end_node
        inst=popfirst!(instructions)
        i+=1
        current_node=map[current_node][inst]
        push!(instructions,inst)
    end
    return i
end

@time p1=part1(instructions,map,"AAA","ZZZ")
println("Part1: $p1")

function part2_1(instructions, map, start_node, end_node_letter)
    i=0
    current_node=start_node
    while last(current_node)!=end_node_letter
        inst=popfirst!(instructions)
        i+=1
        current_node=map[current_node][inst]
        push!(instructions,inst)
    end
    return current_node,i
end

function part2(instructions, map, start_node_letter, end_node_letter)
    c=[k for k in keys(map) if last(k)==start_node_letter]
    res=[part2_1(instructions,map,node,end_node_letter) for node in c]
    v=[r[2] for r in res]
    return lcm(v)
end

@time p2=part2(instructions,map,'A','Z')
println("Part2: $p2")