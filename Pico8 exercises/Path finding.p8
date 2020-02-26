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

function size(t)
    local s=0
    for k,v in pairs(t) do
        s+=1
    end
    return s
end

visited = {}
todo={}
todo[encode(20,20)]=1
next = {}
dist = 0
finish = encode(100,100)
light = finish

while size(todo) > 0 do
    for k,v in pairs(todo) do
        if k==finish then
            visited[k] = dist
            todo = {}
        end
    end
    for k,v in pairs(todo) do
        local m={}
        m.x = flr(k)
        m.y = k%1*256
        if m.x > -5 and m.x < 132 and m.y > -5 and m.y < 132 then
            if not visited[encode(m.x+1,m.y)] then
                next[encode(m.x+1,m.y)]=1
            end
            if not visited[encode(m.x-1,m.y)] then
                next[encode(m.x-1,m.y)]=1
            end
            if not visited[encode(m.x,m.y+1)] then
                next[encode(m.x,m.y+1)]=1
            end
            if not visited[encode(m.x,m.y-1)] then
                next[encode(m.x,m.y-1)]=1
            end
        end
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
pset(20,20,12)
pset(100,100,12)