input=parse.(Int,readlines(ARGS[1]))

function part1(input)
    """
    Solves the first part of the problem by finding two numbers in the input that sum to 2020 and returns their product.

    Arguments:
        input (Vector{Int}): A vector of integers representing the data read from a file.

    Returns:
        Int: The product of the two numbers that sum to 2020.

    Example:
        If the input contains the numbers [1721, 979, 366, 299, 675, 1456], part1 will return 514579 (since 1721 * 299 = 514579).
    """
    seen = Set{Int}()
    for x in input
        comp = 2020 - x
        if !(comp in seen)
            push!(seen, x)
        else
            return x * comp
        end
    end
end

function part2(input)
    """
    Solves the second part of the problem by finding three numbers in the input that sum to 2020 and returns their product.

    Arguments:
        input (Vector{Int}): A vector of integers representing the data read from a file.

    Returns:
        Int: The product of the three numbers that sum to 2020.

    Example:
        If the input contains the numbers [1721, 979, 366, 299, 675, 1456], part2 will return 241861950 (since 979 * 366 * 675 = 241861950).
    """
    for i in 1:length(input) - 2
        for j in (i + 1):length(input) - 1
            s1 = input[i]
            s2 = input[j]
            p = 2020 - s1 - s2
            if p in input[(j + 1):end]
                return p * s1 * s2
            end
        end
    end
end

function part2_search(input)
    """
    Solves the second part of the problem using a more efficient search method.

    Arguments:
        input (Vector{Int}): A vector of integers representing the data read from a file.

    Returns:
        Int: The product of the three numbers that sum to 2020.

    Example:
        If the input contains the numbers [1721, 979, 366, 299, 675, 1456], part2_search will return 241861950 (since 979 * 366 * 675 = 241861950).
    """
    sort!(input)
    for i in 1:length(input) - 2
        left = i + 1
        right = length(input)
        while left < right
            s = input[i] + input[left] + input[right]
            if s == 2020
                return input[i] * input[left] * input[right]
            elseif s < 2020
                left += 1
            else
                right -= 1
            end
        end
    end
end


# function part1(input)
#     seen=Set{Int}()
#     for x in input
#         comp=2020-x
#         !in(comp,seen) ? push!(seen,x) : return(x*comp)
#     end
# end


# function part2(input)
#     for i in 1:length(input)-2
#         for j in (i+1):length(input)-1
#             s1=input[i]
#             s2=input[j]
#             p=2020-s1-s2
#             in(p,input[(j+1):end]) && return(p*s1*s2)
#         end
#     end
# end

# function part2_search(input)
#     sort!(input)
#     for i in 1:length(input)-2
#         left=i+1
#         right=length(input)
#         while left<right
#             s=input[i]+input[left]+input[right]
#             if s==2020
#                 return(input[i]*input[left]*input[right])
#             elseif s<2020
#                 left+=1
#             else
#                 right-=1
#             end
#         end
#     end
# end

@time println(part1(input))
@time println(part2(input))
@time println(part2_search(input))
