using Primes

input=33100000

function part1(input)
    i=1
    res=0
    while res<input
        i+=1
        res=10*sum(divisors(i))
        end
    return i
end

@time p1=part1(input)

function part2(input)
    i=1
    res=0
    while res<input
        i+=1

        res=11*sum([x for x in divisors(i) if x>=i/50])
        end
    return i
end

@time p2=part2(input)