pico-8 cartridge // http://www.pico-8.com
version 16
__lua__

--
-- standard pico-8 workflow
--

function _init()
  player = {x = 64, y = 64, speed = 1}
  balls = {}
end

function _update()
  update_player()
  update_balls()
end

function _draw()
  draw_world()
  draw_player()
  draw_balls()
  draw_debug()
end

--
-- cool functions
--

function crnd(min, max)
    return min + rnd(max-min)
end

--
-- play handling
--

function update_player()
  if btn(0) and not wall(player.x - 4 - player.speed, player.y - 0.5, 0, 3.5) then
    player.x -= player.speed
  end
  if btn(1) and not wall(player.x + 3 + player.speed, player.y - 0.5, 0, 3.5) then
    player.x += player.speed
  end
  if btn(2) and not wall(player.x - 0.5, player.y - 4 - player.speed, 3.5, 0) then
    player.y -= player.speed
  end
  if btn(3) and not wall(player.x - 0.5, player.y + 3 + player.speed, 3.5, 0) then
    player.y += player.speed
  end
end

function update_balls()
  if btnp(4) then
    add(balls, {x=crnd(20,108), y=crnd(20,108)})
  end
end

--
-- walls
--

function wall(x,y,w,h)
  local s = mget((x+w)/8,(y+h)/8)
  local t = mget((x-w)/8,(y-h)/8)
  if fget(s, 0) or fget(t, 0) then
    return true
  end
end

--
-- drawing
--

function draw_player()
  spr(1, player.x - 4, player.y - 4)
end

function draw_balls(ball)
  foreach(balls, function(ball) circ(ball.x,ball.y,2,14) end)
end

function draw_world()
  map(0,0,0,0,32,32)
end

function draw_debug()
  print(tostr(player.x).."  "..tostr(player.y), 4, 4, 7)
end

__gfx__
00000000888888884444444411111111000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000888888884444444411111111000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700888888884444444411111111000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000888888884444444411111111000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000888888884444444411111111000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700888888884444444411111111000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000888888884444444411111111000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000888888884444444411111111000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__gff__
0000010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__map__
0202020202020202030302020202020204040000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0203030303030303030303030303030200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0203030303030303030303030303030200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0203030303030303030303030303030200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0203030303030303030303030303030200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0203030303030303030303030303030200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0203030303030303030303030303030200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0203030303030303030303030303030300000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0303030303030303030303030303030300000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0303030303030303030303030303030200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0203030303030303030303030303030200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0203030303030303030303030303030200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0203030303030303030303030303030200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0203030303030303030303030303030204040000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0203030303030303030303030303030200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0202020202020303020202020202020200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
