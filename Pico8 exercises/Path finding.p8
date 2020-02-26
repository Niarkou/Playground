pico-8 cartridge // http://www.pico-8.com
version 18
__lua__

#include ../escarlib/vec.lua
cls(0)
function encode(x,y)
    n = x + y/256
    return n
end

visited = {}
todo = {encode(10,10)}
next = {}
dist = 0
finish = encode(50,50)

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
        visited[todo[i]] = dist
    end
    print(#visited, 10,60)
    print(#todo, 10, 80)
    dist += 1
    todo = next
    next = {}
end
print(visited[finish], 20, 100)