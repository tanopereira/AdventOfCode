input=readlines("input.txt");

function rule1(s)
    m=findall(r"[aeiou]",s)
    return length(m)>=3
end

function rule2(s)
    m=findall(r"(.)\1",s)
    return length(m)>=1
end

function rule3(s)
    forbidden=["ab","cd","pq","xy"]
    return !any(occursin.(forbidden,s))
end

is_nice(s)=rule1(s) && rule2(s) && rule3(s)

function rule4(s)
    m=match(r"([a-z][a-z]).*\1",s)
    return !isnothing(m)
end

function rule5(s)
    m=match(r"(.).\1",s)
    return !isnothing(m)
end

is_nice2(s)=rule4(s) && rule5(s)

@time p1=sum(is_nice.(input))
@time p2=sum(is_nice2.(input))