input=readlines("data/input18.txt")

# The ⋆ operator has the same precedence as multiplication. We define it to perform addition.
⋆(a, b) = a + b

function part1(input)
    sum_result = 0
    for line in input
        # Replace all '+' with ⋆ to ensure they are evaluated at the same precedence level as multiplication.
        modified_line = replace(line, "+" => "⋆")
        # Evaluate the modified expression using eval and Meta.parse.
        sum_result += eval(Meta.parse(modified_line))
    end
    return sum_result
end

# The ⨥ operator has the same precedence as addition. We define it to perform multiplication.
⨥(a, b) = a * b

function part2(input)
    sum_result = 0
    for line in input
        # Replace all '*' with ⨥ and '+' with ⋆ to ensure the correct order of operations is the inverse of typical maths.
        modified_line = replace(line, "*" => "⨥", "+" => "⋆")
        # Evaluate the modified expression using eval and Meta.parse.
        sum_result += eval(Meta.parse(modified_line))
    end
    return sum_result
end
