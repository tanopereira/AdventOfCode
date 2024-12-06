using JSON

input=JSON.parse(read("input.txt",String));


value(n::Int,_)=n
value(s::String,_)=0
function value(d::Dict,part)
    if part==2 
        any([v=="red" for v in values(d)]) && return 0
    end 
    return sum([value(v,part) for (k,v) in d])
end

function value(v::Vector,part)
    sum([value(x,part) for x in v])
end

@time p1=value(input,1)
@time p2=value(input,2)