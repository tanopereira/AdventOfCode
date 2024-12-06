input=readlines("data/input07.txt")

function part1_a(input,color)
    res=Set()
    for line in input
        m=match(Regex("(.+) bags contain.+$color"),line)
        if !isnothing(m)
            push!(res,m.captures[1])
        end
    end
    return res
end

function part1(input,color)
    S=Set()
    res=part1_a(input,color)
    push!(S,res...)
    newres=union([part1_a(input,color) for color in res]...)
    while length(newres)>0
        push!(S,newres...)
        newres=setdiff(union([part1_a(input,color) for color in newres]...),S)
    end
    return length(S)
end

struct Bag
    color::String
    contains::Vector{Tuple{Int, String}}
end

function parse_bags(input)
    bags=Dict()
    for line in input
        s1,s2=split(line, " bags contain ")
        v=[]
        for s in split(s2,", ")
            #println(s)
            sx=split(s," ")
            if sx[1]!="no"     
                push!(v,(parse(Int,sx[1]),"$(sx[2]) $(sx[3])"))
            else
                push!(v,(0,""))
            end
        end
        push!(bags,s1=>Bag(s1,v))
    end
    return bags
end

function find_parents(bags, target_color)
    parents = Set()  # Use a set to avoid duplicates

    # Helper function for recursive traversal
    function traverse(bag_color)
        for (parent_color, bag) in bags
            if any(x-> x[2] == bag_color, bag.contains)
                push!(parents, parent_color)
                traverse(parent_color)  # Recursively find parents of the parent
            end
        end
    end

    traverse(target_color)
    return collect(parents) # Convert back to a vector if needed
end

function count_contained_bags(bags, color)
    bag = bags[color]
  
    function recursive_count(bag_contents)
      total = 0
      for (c, child_color) in bag_contents
        if child_color != ""
          total += c * recursive_count(bags[child_color].contains)
        end
      end
      return total+1 # Add 1 for the current bag itself
    end
  
    return recursive_count(bag.contains)-1# Subtract 1 to exclude the initial bag
  end