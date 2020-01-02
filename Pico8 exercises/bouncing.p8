pico-8 cartridge // http://www.pico-8.com
version 18
__lua__

#include ../escarlib/vec.lua

v = vec2(1,3)
p = vec2(2,-3)

v = 3 * p - v
v *= 3
v += p/2
v.x += 1

print(v.x)
print(v.y)
print('v is '..v:str())
print(length(v))
print(distance(v,p))


function _init()
    pixels={}
    circle={pos=vec2(64,64),r=15}
    for i = 0,39 do
        local vx1=rnd(10)-5
        local vy1=rnd(10)-5
        local posi=vec2(rnd(127),rnd(127))
        while in_circle(posi) do
            posi=vec2(rnd(127),rnd(127))
        end
        add(pixels, {pos=posi, vel=normalize(vec2(vx1,vy1)), col=2})
    end
end

function _update()
    foreach(pixels, function(p)
        local x=p.pos.x
        local y=p.pos.y

        p.pos+=p.vel

        if p.pos.x<1 or p.pos.x>127 then
            p.vel.x=-p.vel.x
        end
        if p.pos.y<1 or p.pos.y>127 then
            p.vel.y=-p.vel.y
        end 

        if in_circle(p.pos) then
            p.col+=1
            local n=normalize(circle.pos-p.pos)
            p.vel=p.vel-(2*(p.vel*n)*n)
            p.pos.x=x
            p.pos.y=y
        end 
    end)
end

function in_circle(pos)
    cp=distance(circle.pos,pos)
    if cp<circle.r then
        return true
    end
end

function _draw()
    cls(1)
    circfill(circle.pos.x,circle.pos.y,circle.r,0)
    foreach(pixels, function(p)
        pset(p.pos.x,p.pos.y,p.col)
    end)
end
