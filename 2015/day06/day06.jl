input=readlines("input.txt");

function parse_input(M,s)
    row1,col1,row2,col2=parse.(Int, [m.match for m in eachmatch(r"[0-9]+",s)]) .+1
    if occursin("on",s)
        M[row1:row2,col1:col2].=1
    elseif occursin("off",s)
        M[row1:row2,col1:col2].=0
    else
        M[row1:row2,col1:col2]=1 .- M[row1:row2,col1:col2]
    end
    return M
end

function part1(input)
    M=zeros(Int,1000,1000)
    for s in input
        M=parse_input(M,s)
    end
    return M
end

@time p1=sum(part1(input))

function parse_input2(M,s)
    row1,col1,row2,col2=parse.(Int, [m.match for m in eachmatch(r"[0-9]+",s)]) .+1
    if occursin("on",s)
        M[row1:row2,col1:col2].=1 .+ M[row1:row2,col1:col2]
    elseif occursin("off",s)
        M[row1:row2,col1:col2].=max.(0,M[row1:row2,col1:col2].-1)
    else
        M[row1:row2,col1:col2]=2 .+ M[row1:row2,col1:col2]
    end
    return M
end

function part2(input)
    M=zeros(Int,1000,1000)
    for s in input
        M=parse_input2(M,s)
    end
    return M
end

@time p2=sum(part2(input))