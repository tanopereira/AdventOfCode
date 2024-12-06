

input=readlines("input.txt")

parse_line(l)=parse.(Int,[m.match for m in eachmatch(r"[0-9]+",l)]) #find all numbers in a parse_line

create_vector(v)=collect(Iterators.take(Iterators.cycle([repeat([v[1]],v[2]);repeat([0],v[3])]),2503)) |> cumsum
#cycles the input, collects the first 2503 values and accumulates the sum

M=reduce(hcat,create_vector.(parse_line.(input)));
#gets all the created vectors and makes them into a Matrix

@time p1=maximum(M[end,:])

@time p2=maximum(sum(reduce(hcat,[M[i,:].==maximum(M[i,:]) for i in 1:2503]),dims=2))
