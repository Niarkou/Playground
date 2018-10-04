pico-8 cartridge // http://www.pico-8.com
version 16
__lua__

function crnd(min, max)
  return min + rnd(max-min)
end

function ccrnd(tab)  -- takes a tab and choose randomly between the elements of the table
  n = flr(crnd(1, #tab+1))
  return tab[n]
end

--
-- standard pico-8 workflow
--

function _init()
  stars = {}
  smoke = {}
    while #stars < 200 do
      add(stars, {x = crnd(0, 127), y = crnd(0, 128), col = ccrnd({5, 6, 7})})
    end
    while #smoke < 120 do
      add(smoke, {x = crnd(-5, 5), y = crnd(0, 128), r = crnd(0, 20), col = ccrnd({5, 6})})
    end
end

function _update()
  foreach(stars, function(star)
    if star.x >= 0 then
      if star.col == 7 then
        star.x -= 1
      elseif star.col == 6 then
        star.x -= 0.5
      else star.x -= 0.2
      end
    else 
      star.x = 128 
      star.y = crnd(0, 128) 
    end end)

  foreach(smoke, function(circle)
    if circle.r < 20 then
      circle.r += 0.5
    elseif circle.r >= 20 then
      circle.x = crnd(-5, 5)
      circle.y = crnd(0, 128)
      circle.r = crnd(0, 7)
      circle.col = ccrnd({5, 6})
    end
    end)
end

function _draw()
  palt(0, false)
  cls(0)
  foreach(stars, function(star)
    if star.col == 5 then
      pset(star.x, star.y, star.col)
    end end)

  foreach(stars, function(star)
    if star.col == 6 then
      pset(star.x, star.y, star.col)
    end end)

  foreach(stars, function(star)
    if star.col == 7 then
      pset(star.x, star.y, star.col)
      pset(star.x + 1, star.y + 1, 1)
      pset(star.x + 1, star.y - 1, 1)
      pset(star.x - 1, star.y + 1, 1)
      pset(star.x - 1, star.y - 1, 1)
    end end)

  foreach(smoke, function(circle)
    if circle.col == 5 then
      local p={0x0, 0x0, 0x5050, 0x5050, 0x5a5a, 0xfafa}
      fillp(p[flr(circle.r * (#p - 1) / 20) + 1] + 0x.8)
      circfill(circle.x + 6, circle.y, circle.r, circle.col)
      fillp()
    end end)

  foreach(smoke, function(circle)
    if circle.col == 6 then
    local p={0x0, 0x0, 0x5050, 0x5050, 0x5a5a, 0xfafa}
      fillp(p[flr(circle.r * (#p - 1) / 20) + 1] + 0x.8)
      circfill(circle.x - 2, circle.y, circle.r, circle.col)
      fillp()
    end end)
end
