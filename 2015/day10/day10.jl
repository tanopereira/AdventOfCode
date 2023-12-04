input=readline("input.txt")

function encode(s)
    res=Vector{Char}()
    regex=r"(.)\1*"
    for m in eachmatch(regex,s)
        append!(res,Char(48+length(m.match)))
        append!(res,m.captures[1])
    end
    return string(res...)
end

s=input
@time begin
    for i in 1:40
    s=encode(s)
    end
end

p1=length(s)
@time begin
for i in 1:10
    s=encode(s)
end
end
p2=length(s)