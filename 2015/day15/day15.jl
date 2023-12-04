input=readlines("input.txt")

parse_line(l)=parse.(Int,[m.match for m in eachmatch(r"-[0-9]+|[0-9]+",l)])


function solution(input,part=1)
    M=reduce(vcat,parse_line.(input)')
    max_cookie=0
    max_ing=[0 0 0 0]
    for i in 0:100
        for j in 0:100-i
            for k in 0:100-i-j
                a=[i j k 100-i-j-k]*M
                a=a .* (a.>0)
                res=prod(a[1:4])    
                if res>max_cookie
                    if (part!=2 || a[5]==500) 
                        max_cookie=res
                        max_ing=[i j k 100-i-j-k]
                    end
                end
            end
        end
    end
    return max_cookie, max_ing
end

p1=solution(input,1)
p2=solution(input,2)
