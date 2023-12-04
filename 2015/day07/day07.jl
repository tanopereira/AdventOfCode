input=readlines("input.txt")

function part1(input)
    d=Dict()
    i=0
    while any([isnan(v) for v in values(d)]) || length(d)==0
        i+=1
        for s in input
            #println(s)
            #print(d)
            s1,s2=split(s," -> ")
            !haskey(d,s2) && push!(d,s2 => NaN)
            if occursin("1 AND",s1)
                _,k2=split(s1," AND ")
                !haskey(d,k2) || isnan(d[k2]) ? continue : d[s2]= UInt16(1) & d[k2]
            elseif occursin("AND",s1)
                k1,k2 = split(s1," AND ")
                !haskey(d,k1) || !haskey(d,k2) || isnan(d[k1]) || isnan(d[k2]) ? continue : d[s2]=d[k1] & d[k2]
            elseif occursin("RSHIFT",s1)
                k1,v1=split(s1," RSHIFT ")
                !haskey(d,k1) || isnan(d[k1]) ? continue : d[s2]=d[k1] >> parse(Int,v1)
            elseif occursin("OR",s1)
                k1,k2=split(s1," OR ")
                !haskey(d,k1) || !haskey(d,k2) || isnan(d[k1]) || isnan(d[k2]) ? continue : d[s2]=d[k1] | d[k2]
            elseif occursin("LSHIFT",s1)
                k1,v1=split(s1," LSHIFT ")
                !haskey(d,k1) || isnan(d[k1]) ? continue : d[s2]=d[k1] << parse(Int,v1)
            elseif occursin("NOT",s1)
                _,k2=split(s1,"NOT ")
                !haskey(d,k2) || isnan(d[k2]) ? continue : d[s2]=~(d[k2])
            else
                if !isnothing(match(r"[0-9]+",s1)) 
                    d[s2]=parse(UInt16,s1)
                else
                    !haskey(d,s1) || isnan(d[s1]) ? continue : d[s2]=d[s1]
                end
            end
        end
    end
    print(i)
    return Int(d["a"])
end

@time p1=part1(input)

input2=copy(input);
input2[55]="$p1 -> b";

@time p2=part1(input2)

