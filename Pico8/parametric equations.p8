pico-8 cartridge // http://www.pico-8.com
version 16
__lua__
--
-- rosace
--

-- center and radius
local cx,cy = 64,64
local scale = 20

-- rosace parameters
local e = 1
local n = 2

function rosace(theta)
  return 1 + e*cos(n*theta)
end

function _init()
end

function _update60()
  if btnp(0) then
    e /= 1.1
  elseif btnp(1) then
    e *= 1.1
  end
  if btnp(2) then
    n *= 1.1
  elseif btnp(3) then
    n /= 1.1
  end
end

function _draw()
 cls()
 for i = 0, 10, 0.001 do
 local rho = scale * rosace(i)
 pset(cx + rho*cos(i),
      cy + rho*sin(i),
      7)
 end
 print("e = "..e, 5, 5, 13)
 print("n = "..n, 5, 12, 13)
end