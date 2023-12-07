using StatsBase

input=readlines("input.txt")

function hand_value(hand)
    c=countmap(hand) #count cards
    u=sort(collect(values(c))) #order them by least to most cards held
    if u==[5] #five of a kind
        return 7
    elseif u==[1,4] #four of a kind
        return 6
    elseif u==[2,3] #full house
        return 5
    elseif u==[1,1,3] #three of a kind
        return 4
    elseif u==[1,2,2] #two pair
        return 3
    elseif u==[1,1,1,2] #one pair
        return 2
    elseif u==[1,1,1,1,1] #high card
        return 1
    end
end

function worse_hand(hand1,hand2,d, hand_value_function) #passes a d dictionary of card values and a function to calculate hand value
    if hand_value_function(hand1[1])!=hand_value_function(hand2[1]) #different hand values
        return hand_value_function(hand1[1])<hand_value_function(hand2[1])
    else
        return [d[c] for c in hand1[1]]<[d[c] for c in hand2[1]] #order by first to last card value
    end
end

function transform_hand_value(hand)
    s=hand
    max_value=hand_value(s)
    if !occursin('J',s) 
        return max_value
    else
        for c in cards #check the value of a hand if we changed the Js to anything (even Js!)
            new_s=replace(s,'J' => c)
            if hand_value(new_s)>max_value #typical max loop
                max_value=hand_value(new_s)
            end
        end
    end
    return max_value
end

card_values=collect(2:14)
cards=[collect('2':'9')...,'T','J','Q','K','A']
d=Dict([c => v for (c,v) in zip(cards,card_values)]...)
d2=copy(d)
d2['J']=1

function solution(input,d,hvf)
    hands=[(hand,parse(Int64,bid)) for (hand,bid) in split.(input," ")]
    os=sort(hands,lt=(x,y) -> worse_hand(x,y,d,hvf))
    res=[o[2] for o in os]' * [collect(1:1000)...] #dot product (actually matrix multiplication row times column)
    return res
end

@time p1=solution(input,d,hand_value)
@time p2=solution(input,d2,transform_hand_value)

println("Part1: $p1")
println("Part2: $p2")
