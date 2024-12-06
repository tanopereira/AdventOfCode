input=readlines("input.txt");

function wrapping(input)
    s=0
    l=0
    for line in input
        n1,n2,n3=parse.(Int,split(line,'x'))
        s+=2*(n1*n2+n1*n3+n2*n3)+minimum([n1*n2,n1*n3,n2*n3])
        l+=n1*n2*n3+2*minimum([n1+n2,n1+n3,n2+n3])
        println("$s $l")
    end
    return s,l
end

@time p1,p2=wrapping(input)