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
      circle.r += 0.1
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
    fillp(0xa5a5.8)
    circfill(circle.x, circle.y, circle.r, circle.col)
    fillp()
  end)
end
