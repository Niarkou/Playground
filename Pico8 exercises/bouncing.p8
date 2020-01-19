pico-8 cartridge // http://www.pico-8.com
version 18
__lua__

#include ../escarlib/vec.lua

function _init()
    poke(0x5f2d, 1)
    pixels={}
    circles={}
    click_pos=vec2(0,0)
    click=false
    gravity=vec2(0,0.1)

    for i=0,3 do
        add(circles, {pos=vec2(rnd(127),rnd(127)),r=rnd(10)+10,vel=normalize(vec2(rnd(10)-5,rnd(10)-5))})
    end
end

function _update()
    player_click()

    if click then
        for i=1,5 do
            local vx1=rnd(10)-5
            local vy1=rnd(10)-5
            click_valid=true
            for i=1,#circles do
                if in_circle(click_pos, circles[i]) then
                    click_valid=false
                end
            end
            if click_valid==true then  
                add(pixels, {pos=click_pos, vel=normalize(vec2(vx1,vy1)), col=2, bounce=0})
            end         
        end
        click=false
        click_valid=true
    end

    foreach(pixels, function(p)
        local x=p.pos.x
        local y=p.pos.y

        p.vel+=gravity
        p.pos+=p.vel
        p.bounce-=1

        
        if p.pos.x<0 or p.pos.x>127 then
            p.vel.x=-p.vel.x
            p.pos.x=x
        end
        if p.pos.y>128 then
            p.vel.y=-p.vel.y*0.9
            p.vel.x=p.vel.x*0.9
            p.pos.y=y
        end

        if p.bounce<1 then
            for i=1,#circles do
                if in_circle(p.pos,circles[i]) then
                    p.col+=1
                    local n=normalize(circles[i].pos-p.pos)
                    p.vel=normalize(p.vel-(2*(p.vel*n)*n))*2
                    p.pos.x=x
                    p.pos.y=y
                    p.bounce=3
                end 
            end

            if p.pos.y>126 and length(p.vel)<0.1 then
                del(pixels, p)
            end
        end
    end)

    foreach(circles, function(c)
        local x=c.pos.x
        local y=c.pos.y

        c.pos+=c.vel
        
        if c.pos.x-c.r<0 or c.pos.x+c.r>128 then
            c.vel.x=-c.vel.x
            c.pos.x=x
        end
        if c.pos.y+c.r>128 or c.pos.y-c.r<0 then
            c.vel.y=-c.vel.y
            c.pos.y=y
        end
    end)
end

function in_circle(pos, circle)
    cp=distance(circle.pos,pos)
    if cp<circle.r then
        return true
    end
end

function player_click()
    if stat(34) == 1 then
        click_pos=vec2(stat(32),stat(33))
        click=true
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
    spr(2,stat(32)-1,stat(33)-1)
    print("pixels:"..#pixels, 10, 10, 7)
end

__gfx__
00000000000000000500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000100005650000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000001110005765000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000011111005776500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000001110005777650000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000100005777750000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000005675500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000557500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
