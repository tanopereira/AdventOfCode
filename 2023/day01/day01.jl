input = readlines("input.txt")

function part1(input)
    s=0
    for line in input
        s+=parse(Int, match(r"[0-9]",line).match*match(r"[0-9]",reverse(line)).match)
    end
    return s
end

p1=part1(input)

function part2(input)
    d=Dict("one" => "1",
    "two" => "2",
    "three" => "3",
    "four" => "4",
    "five" => "5",
    "six" => "6",
    "seven" => "7",
    "eight" => "8",
    "nine" => "9")
    s=0
    for line in input
        n=[m.match for m in eachmatch(r"[0-9]|one|two|three|four|five|six|seven|eight|nine",line,overlap=true)]
        s+=parse(Int,replace(first(n),d...)*replace(last(n),d...))
    end
    return s
end

p2=part2(input)

println("Part1: $p1")
println("Part2: $p2")