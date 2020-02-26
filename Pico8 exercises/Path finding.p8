pico-8 cartridge // http://www.pico-8.com
version 18
__lua__

#include ../escarlib/vec.lua
#include ../escarlib/random.lua

cls(0)
rect={}
for i = 1,30 do
    local rectx0=crnd(0,128)
    local recty0=crnd(0,128)
    local rectx1=rectx0+crnd(10,20)
    local recty1=recty0+crnd(10,20)
    rectfill(rectx0,recty0,rectx1,recty1,10)
end
for i = 1,30 do
    local rectx0=crnd(0,128)
    local recty0=crnd(0,128)
    local rectx1=rectx0+crnd(10,20)
    local recty1=recty0+crnd(10,20)
    rectfill(rectx0,recty0,rectx1,recty1,14)
end

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
todo[encode(8,8)]=1
next = {}
fx=120
fy=120
finish = encode(fx,fy)
light = finish

while visited[finish]==nil do
    for k,v in pairs(todo) do
        local m={}
        m.x = flr(k)
        m.y = k%1*256
        function addtonext(x,y)
            local val = 0
            if pget(x,y)==10 then
                val=v+3
            elseif pget(x,y)==14 then
                val=v+4
            else
                val=v+2
            end

            if m.x < 0 or m.x > 128 or m.y < 0 or m.y > 128 then
                return
            end   

            if not visited[encode(x,y)] then
                next[encode(x,y)]=val
            else
                if visited[encode(x,y)] > val then
                    next[encode(x,y)]=val
                end
            end
        end
        
        addtonext(m.x+1,m.y)
        addtonext(m.x-1,m.y)
        addtonext(m.x,m.y+1)
        addtonext(m.x,m.y-1)
        visited[k] = v
    end
    todo = next
    next = {}
end

dist = visited[finish]

while dist>1 do 
    local a={}
    local m={}
    m.x = flr(light)
    m.y = light%1*256
    function addtolight(x0,y0)
        if visited[encode(x0,y0)]!=nil then
            if visited[encode(x0,y0)] < dist then
                dist=visited[encode(x0,y0)]
                a={x=x0, y=y0}
            end 
        end
    end
    addtolight(m.x+1,m.y)
    addtolight(m.x-1,m.y)
    addtolight(m.x,m.y+1)
    addtolight(m.x,m.y-1)

    pset(a.x,a.y,8)
    light = encode(a.x,a.y)
end
pset(8,8,12)
pset(120,120,12)