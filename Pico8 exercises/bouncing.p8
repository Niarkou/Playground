pico-8 cartridge // http://www.pico-8.com
version 18
__lua__

#include ../escarlib/vec.lua

function _init()
    pixels={}
    circles={}

    for i=0,3 do
        add(circles, {pos=vec2(rnd(127),rnd(127)),r=rnd(15)})
    end

    for i=0,39 do
        local vx1=rnd(10)-5
        local vy1=rnd(10)-5
        local posi=vec2(rnd(127),rnd(127))
        for i=1,#circles do
            while in_circle(posi, circles[i]) do
                posi=vec2(rnd(127),rnd(127))
            end
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

        for i=1,#circles do
            if in_circle(p.pos,circles[i]) then
                p.col+=1
                local n=normalize(circles[i].pos-p.pos)
                p.vel=p.vel-(2*(p.vel*n)*n)
                p.pos.x=x
                p.pos.y=y
            end 
        end
    end)
end

function in_circle(pos, circle)
    cp=distance(circle.pos,pos)
    if cp<circle.r then
        return true
    end
end

function _draw()
    cls(1)
    foreach(circles, function(c)
        circfill(c.pos.x,c.pos.y,c.r,0)
    end)
    foreach(pixels, function(p)
        pset(p.pos.x,p.pos.y,p.col)
    end)
end
