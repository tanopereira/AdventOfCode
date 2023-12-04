using DataFrames
using Tidier

input=readlines("input.txt")

function parse_line(l)
    d=Dict()
    s=split(l,r"Sue \d+: ")[2]
    p=split(s,", ")
    for el in p
        k,v=split(el,": ")
        push!(d, k => parse(Int,v))
    end
    return DataFrame(d)
end

@time df=reduce(vcat,parse_line.(input),cols=:union)

@time p1=@chain df begin
    @mutate(row=row_number())
    @filter(if_else(children==3,true,false,true))
    @filter(if_else(cats==7,true,false,true))
    @filter(if_else(samoyeds==2,true,false,true))
    @filter(if_else(pomeranians==3,true,false,true))
    @filter(if_else(akitas==0,true,false,true))
    @filter(if_else(vizslas==0,true,false,true))
    @filter(if_else(goldfish==5,true,false,true))
    @filter(if_else(trees==3,true,false,true))
    @filter(if_else(cars==2,true,false,true))
    @filter(if_else(perfumes==1,true,false,true))
    @pull(row)
end

@time p2=@chain df begin
    @mutate(row=row_number())
    @filter(if_else(children==3,true,false,true))
    @filter(if_else(cats>7,true,false,true))
    @filter(if_else(samoyeds==2,true,false,true))
    @filter(if_else(pomeranians<3,true,false,true))
    @filter(if_else(akitas==0,true,false,true))
    @filter(if_else(vizslas==0,true,false,true))
    @filter(if_else(goldfish<5,true,false,true))
    @filter(if_else(trees>3,true,false,true))
    @filter(if_else(cars==2,true,false,true))
    @filter(if_else(perfumes==1,true,false,true))
    @pull(row)
end