input="vzbxkghb"

needed=[r[1]*r[2]*r[3] for r in zip('a':'z','b':'z','c':'z')]

rule1(s)=any(occursin.(needed,s))
rule2(s)=!any(occursin.(['i','o','l'],s))
rule3(s)=length(unique([m.captures for m in eachmatch(r"(.)\1",s)]))>=2


valid(s)=rule1(s) & rule2(s) & rule3(s)

function next_s(s)
    new_s=reverse(s)
    b26=evalpoly(26,collect(new_s).-'a')+1
    digs=digits(b26,base=26,pad=8).+'a'
    return string(reverse(digs)...)
end
    

function next_password(s)
    while !valid(s)
        s=next_s(s)
        #println(s)
    end
    return s
end

@time p1=next_password(input)
@time p2=next_password(next_s(p1))