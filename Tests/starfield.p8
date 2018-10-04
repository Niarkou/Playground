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
    while #stars < 200 do
    add(stars, {x = crnd(0,127), y = crnd(0, 128), col = ccrnd({5, 6, 7})})
    end
end

function _update()
  foreach(stars, function(star)
    if star.x >= 0 then
      if star.col == 7 then
        star.x -= 1
      elseif star.col == 6 then
        star.x -= 0.5
      else star.x -= 0.25
      end
    else 
      star.x = 128 
      star.y = crnd(0, 128) 
    end end)
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
end
