input=readlines("data/input04.txt")

function part1(input)
    valid=["byr","iyr","eyr","hgt","hcl","ecl","pid"]
    current_keys=[]
    s=0
    i=1
    while i<=length(input)
        line=input[i]
        m=[k.captures[1] for k in eachmatch(r"(\w+):",line)]
        for k in m
            push!(current_keys,k)
            #println("Current keys $current_keys")
        end    
        if line=="" || i==length(input)
            if all([v in current_keys for v in valid])
                s+=1
            end
            current_keys=[]
        end
        i+=1
    end
    return s
end
                
function part2(input)
    s=0
    valid=["byr","iyr","eyr","hgt","hcl","ecl","pid"]
    d=Dict()
    i=1
    while i<=length(input)
        line=input[i]
        ksvs=split(line," ")
        if line!=""
            for kv in ksvs
                k,v=split(kv,":")
                push!(d,k=>v)
            end
        end
        if line=="" || i==length(input)
            if all([v in keys(d) for v in valid])
                byr_valid=parse(Int,d["byr"])>=1920 && parse(Int,d["byr"])<=2002
                iyr_valid=parse(Int,d["iyr"])>=2010 && parse(Int,d["iyr"])<=2020
                eyr_valid=parse(Int,d["eyr"])>=2020 && parse(Int,d["eyr"])<=2030
                hgt=filter(isdigit,d["hgt"])
                meas=filter(!isdigit,d["hgt"])
                meas=="cm" ? hgt_valid=(150<=parse(Int,hgt)<=193) : hgt_valid=(59<=parse(Int,hgt)<=76)
                hcl_match = match(r"#[a-f|0-9]+",d["hcl"])
                isnothing(hcl_match) ? hcl_valid=false : hcl_valid=length(hcl_match.match)==7
                ecl_valid = d["ecl"] in ["amb","blu","brn","gry","grn","hzl","oth"]
                pid_valid = length(filter(isdigit,d["pid"]))==9
                if all((byr_valid,iyr_valid,eyr_valid,hgt_valid,hcl_valid,ecl_valid,pid_valid))
                    s+=1
                end
            end
            d=Dict()
        end
        i+=1
    end
    return s
end             

#input2=split(open(f->read(f,String),"data/input04.txt"),"\n\n")

#split(input2[2])
@time p1=part1(input)
@time p2=part2(input)