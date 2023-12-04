using MD5

input=readline("input.txt")

function findk(input,l)
    k=1
    s=bytes2hex(md5(input*"$k"))
    while s[1:l] != '0'^l
        k+=1
        s=bytes2hex(md5(input*"$k"))
    end
    return k
end

@time p1=findk(input,5)
@time p2=findk(input,6)
