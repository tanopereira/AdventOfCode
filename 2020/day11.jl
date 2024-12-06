input=hcat(stack(readlines("data/input11.txt")))

valid(pos,M)=1<=pos[1]<=size(M)[1] && 1<=pos[2]<=size(M)[2]

function part1(input)
    oldgrid=copy(input)
    directions=[[-1,-1],[0,-1],[1,-1],[-1,0],[1,0],[-1,1],[0,1],[1,1]]
    haschanged=true
    while haschanged
        haschanged=false
        newgrid=copy(oldgrid)
        for x in 1:size(input)[1]
            for y in 1:size(input)[2]
                
                neigh_seats=0
                pos=[x,y]
                if oldgrid[x,y]=='.'
                    continue
                end
               
                for dir in directions
                    newpos=pos.+dir
                    
                    if valid(newpos,oldgrid) && oldgrid[newpos[1],newpos[2]]=='#'
                        neigh_seats+=1
                    end
                end
                if oldgrid[x,y]=='L' && neigh_seats==0
                    newgrid[x,y]='#'
                    haschanged=true
                elseif oldgrid[x,y]=='#' && neigh_seats>=4
                    newgrid[x,y]='L'
                    haschanged=true
                else 
                    newgrid[x,y]=oldgrid[x,y]
                end
            end
        end
        oldgrid=newgrid
        #println(oldgrid)
    end
    return sum(oldgrid.=='#')
end


function part2(input)
    oldgrid=copy(input)
    directions=[[-1,-1],[0,-1],[1,-1],[-1,0],[1,0],[-1,1],[0,1],[1,1]]
    haschanged=true
    while haschanged
        haschanged=false
        newgrid=copy(oldgrid)
        for x in 1:size(input)[1]
            for y in 1:size(input)[2]
                neigh_seats=0
                pos=[x,y]
               
                if oldgrid[x,y]=='.'
                    continue
                end
               
                for dir in directions
                    newpos=pos.+dir
                    
                    while valid(newpos,oldgrid)
                        if oldgrid[newpos[1],newpos[2]]=='.' 
                            newpos=newpos.+dir
                            
                        elseif oldgrid[newpos[1],newpos[2]]=='#'
                            neigh_seats+=1
                            break
                        else
                            break
                        end
                    end
                end
                if oldgrid[x,y]=='L' && neigh_seats==0
                    newgrid[x,y]='#'
                    haschanged=true
                elseif oldgrid[x,y]=='#' && neigh_seats>=5
                    newgrid[x,y]='L'
                    haschanged=true
                else 
                    newgrid[x,y]=oldgrid[x,y]
                end
            end
        end
        oldgrid=newgrid
        #println(oldgrid)
    end
    return sum(oldgrid.=='#')
end

