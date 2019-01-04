pico-8 cartridge // http://www.pico-8.com
version 16
__lua__
--
-- rosace
--

-- center and radius
local cx,cy = 64,64
local scale = 2

-- rosace parameters
local e = 5
local n = 8

function rosace(theta)
  return 1 + e*cos(n*theta)
end

function _init()
 step = rnd(500)
 cls()
end

function _update60()
 step = step + 1
end

function _draw()
 local theta = step / 500
 local rho = scale * rosace(theta)
 pset(cx + rho*cos(theta),
      cy + rho*sin(theta),
      7)
end