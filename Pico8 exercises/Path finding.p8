pico-8 cartridge // http://www.pico-8.com
version 18
__lua__

#include ../escarlib/vec.lua
cls(0)
function encode(x,y)
    n = x + y/256
    return n
end

function crnd(a, b)
  return min(a, b) + rnd(abs(b - a))
end

function tabrnd(tab)
    n = flr(crnd(1, #tab+1))
    return tab[n]
end

visited = {}
todo = {encode(10,10)}
next = {}
dist = 0
finish = encode(100,100)
light = finish

while #todo > 0 do
    for i = 1, #todo do
        if todo[i]==finish then
            visited[todo[i]] = dist
            todo = {}
        end
    end
    for i = 1, #todo do
        local m={}
        m.x = flr(todo[i])
        m.y = todo[i]%1*256

        if m.x > -5 and m.x < 132 and m.y > -5 and m.y < 132 then
            if not visited[encode(m.x+1,m.y)] then
                del(next, encode(m.x+1,m.y))
                add(next, encode(m.x+1,m.y))
            end
            if not visited[encode(m.x-1,m.y)] then
                del(next, encode(m.x-1,m.y))
                add(next, encode(m.x-1,m.y))
            end
            if not visited[encode(m.x,m.y+1)] then
                del(next, encode(m.x,m.y+1))
                add(next, encode(m.x,m.y+1))
            end
            if not visited[encode(m.x,m.y-1)] then
                del(next, encode(m.x,m.y-1))
                add(next, encode(m.x,m.y-1))
            end
        end
        visited[todo[i]] = dist
    end
    --print(#visited)
    --print(#todo)
    dist += 1
    todo = next
    next = {}
end
--print(visited[finish], 20, 100)
while dist>1 do
    dist-=1 
    local a={}
    local tolight={}
    local m={}
    m.x = flr(light)
    m.y = light%1*256
    if visited[encode(m.x+1,m.y)] == dist-1 then
        add(tolight, {x=m.x+1, y=m.y,8})
    end
    if visited[encode(m.x-1,m.y)] == dist-1 then
        add(tolight, {x=m.x-1,y=m.y,8})
    end
    if visited[encode(m.x,m.y+1)] == dist-1 then
        add(tolight, {x=m.x,y=m.y+1,8})
    end
    if visited[encode(m.x,m.y-1)] == dist-1 then
        add(tolight, {x=m.x,y=m.y-1,8})
    end
    a=tabrnd(tolight)
    pset(a.x,a.y,8)
    light = encode(a.x,a.y)
end