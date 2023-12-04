containers=parse.(Int,readlines("input.txt"))
        
@time M=reduce(vcat,digits.(1:2^length(containers)-1,base=2,pad=length(containers))');


@time idx=M*containers.==150;
@time p1=sum(idx)

M2=M[idx,:]

@time p2=sum(sum(M2,dims=2).==minimum(sum(M2,dims=2)))

