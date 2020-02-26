pico-8 cartridge // http://www.pico-8.com
version 18
__lua__

#include ../escarlib/vec.lua
#include ../escarlib/random.lua

cls(0)
function encode(x,y)
    n = x + y/256
    return n
end

function size(t)
    local s=0
    for k,v in pairs(t) do
        s+=1
    end
    return s
end

visited = {}
todo={}
todo[encode(10,10)]=1
next = {}
dist = 0
finish = encode(100,100)
light = finish

while todo[finish]==nil do
    for k,v in pairs(todo) do
        local m={}
        m.x = flr(k)
        m.y = k%1*256
        function addtonext(x,y)
            if m.x > -5 and m.x < 132 and m.y > -5 and m.y < 132 then
                if not visited[encode(x,y)] then
                    next[encode(x,y)]=1
                end
            end
        end
            addtonext(m.x+1,m.y)
            addtonext(m.x-1,m.y)
            addtonext(m.x,m.y+1)
            addtonext(m.x,m.y-1)
            
        visited[k] = dist
    end
    --print(#visited)
    --print(#todo)
    dist += 1
    todo = next
    next = {}
end
--print(visited[finish], 20, 100)
while dist>1 do 
    local a={}
    local tolight={}
    local m={}
    m.x = flr(light)
    m.y = light%1*256
    function addtolight(x0,y0)
        if visited[encode(x0,y0)] == dist-1 then
            add(tolight, {x=x0, y=y0})
        end 
    end
    addtolight(m.x+1,m.y)
    addtolight(m.x-1,m.y)
    addtolight(m.x,m.y+1)
    addtolight(m.x,m.y-1)

    dist-=1
    a=ccrnd(tolight)
    pset(a.x,a.y,8)
    light = encode(a.x,a.y)
end
pset(10,10,12)
pset(100,100,12)