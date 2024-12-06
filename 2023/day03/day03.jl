input=readlines("input.txt")


function extract_valid_numbers(i,input)
    M=stack(input,dims=1)
    symbols=filter(x->!occursin(r"\d|\.","$x"),[c for c in unique(M)])
    Mrow,Mcol=size(M)
    res=[]
    pot=findall(r"\d+",input[i])
    rowmin=max(1,i-1)
    rowmax=min(i+1,Mrow)
    for m in pot
        colmin=max(1,first(m)-1)
        colmax=min(last(m)+1,Mcol)
        mm=M[rowmin:rowmax,colmin:colmax]
        isempty(intersect(symbols,collect(mm[:]))) ? continue : push!(res,parse(Int,input[i][m]))
    end
    return res
end

function part1(input)
    s=0
    for i in 1:140
        s+=sum(extract_valid_numbers(i,input))
    end
    return s
end

p1=part1(input)
println("Part1: $p1")

function create_dict_p2(input)
    M=stack(input,dims=1)
    symbols=filter(x->!occursin(r"\d|\.","$x"),[c for c in unique(M)])
    Mrow,Mcol=size(M)
    d=Dict()
    for i in 1:Mrow
        pot=findall(r"\d+",input[i])
        rowmin=max(1,i-1)
        rowmax=min(i+1,Mrow)
        for m in pot
            n=parse(Int,input[i][m])
            colmin=max(1,first(m)-1)
            colmax=min(last(m)+1,Mcol)
            for row in rowmin:rowmax
                for col in colmin:colmax
                    if M[row,col]=='*'
                        haskey(d,(row,col)) ? d[(row,col)]=[d[(row,col)];n] : d[(row,col)]=[n]
                    end
                end
            end
        end
    end
    return d
end

function part2(input)
    s=0
    d=create_dict_p2(input)
    for (k,v) in d
        if length(v)==2
            s+=prod(v)
        end
    end
    return s
end

p2=part2(input)
println("Part2: $p2")