pico-8 cartridge // http://www.pico-8.com
version 18
__lua__

function _init()
    pixels={}
    circle={x=64,y=64,r=15}
    for i = 0,39 do
        local vx1=rnd(10)-5
        local vy1=rnd(10)-5
        local v=sqrt((vx1*vx1)+(vy1*vy1))
        local xi=rnd(127)
        local yi=rnd(127)
        while in_circle(xi, yi) do
            xi=rnd(127)
            yi=rnd(127)
        end
        add(pixels, {x=xi, y=yi, vx=vx1/v, vy=vy1/v, col=2, bounce=0})
    end
end

function _update()
    foreach(pixels, function(p)
        local x=p.x
        local y=p.y

        p.x+=p.vx
        p.y+=p.vy 
        p.bounce-=1

        if p.bounce <1 then
            if p.x<1 or p.x>127 then
                p.vx=-p.vx
                p.bounce=10
            end
            if p.y<1 or p.y>127 then
                p.vy=-p.vy
                p.bounce=10
            end 

            if in_circle(p.x, p.y) then
                p.col+=1
                local nx=circle.x-p.x
                local ny=circle.y-p.y
                local vx=p.vx
                local vy=p.vy
                p.vx=vx-(2*(vx*nx+vy*ny)*nx)/(nx*nx+ny*ny)
                p.vy=vy-(2*(vx*nx+vy*ny)*ny)/(nx*nx+ny*ny)
                p.x=x
                p.y=y
                p.bounce=10
            end 
        end
    end)
end

function in_circle(x, y)
    cpx=abs(x-circle.x)
    cpy=abs(y-circle.y)
    if cpx/256*cpx+cpy/256*cpy<circle.r/256*circle.r then
        return true
    end
end

function _draw()
    cls(1)
    foreach(pixels, function(p)
        pset(p.x,p.y,p.col)
    end)
    circfill(circle.x,circle.y,circle.r,0)
end
