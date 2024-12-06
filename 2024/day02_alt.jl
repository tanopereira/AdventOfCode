using Revise, Distributed

# Read input lines from file
@time input = readlines("data/input02.txt")

# Function to check if a sequence is safe based on given rules
function is_safe(b)
    # Rule 1: All differences should have the same sign or be zero
    rule1 = all(x -> sign(x) == sign(b[1]), b)
    # Rule 2: Absolute values of differences should be between 1 and 3 inclusive
    rule2 = all(1 .≤ abs.(b) .≤ 3)
    return rule1 && rule2
end

# Function to solve Part 1 using vectorized operations
function part1(input)
    # Parse input lines, compute differences, and check if each sequence is safe
    parsed_input = map(x -> parse.(Int, split(x)), input)
    diff_input = map(diff, parsed_input)
    return sum(is_safe, diff_input)
end

# Function to solve Part 2 using parallel processing
function part2(input)
    total_safe = 0
    
    function check_line(line)
        a = parse.(Int, split(line))
        b = diff(a)
        
        # Check if the original sequence is safe
        if is_safe(b)
            return true
        end
        
        # Try removing each element and check if the resulting sequence is safe
        for i in eachindex(a)
            b_modified = diff(deleteat!(copy(a), i))
            if is_safe(b_modified)
                return true
            end
        end
        return false
    end
    
    # Use @distributed to parallelize the checking of each line
    total_safe = @sync @distributed (+) for i = 1:length(input) 
        check_line(input[i]) 
    end
    
    return total_safe
end

# Measure and print the time taken to execute Part 1
@time println("Part1: ", part1(input))

# Alternative vectorized implementation for Part 1 (less efficient but demonstrates broadcasting)
@time println("Part1 alt:", sum(is_safe.(map(diff, map(x -> parse.(Int, x), split.(input))))))

# Measure and print the time taken to execute Part 2
@time println("Part2: ", part2(input))