#!/usr/bin/lua
require "display"

display.config.setvpixels(0)

local w,h = display.config.width, display.config.vheight

-- get offset from coordnates
-- wraps large nums with modulo
local function off(x,y)
	return (x%w)+w*(y%h)
end

local st = { { }, { } }

function init( x, y )
	local c, d = x%100 < 50, (y+50)%100 < 50
	local b = ((c and d) or not (c or d)) and math.random( 8 ) == 5
	st[1][off( x, y )] = b
	st[2][off( x, y )] = b
	return b
end

function step( x, y )
	local b = st[1][off( x, y )]
	c = 0
	for dx = -1, 1 do for dy = -1, 1 do
		if st[1][off(x+dx, y+dy)] then c = c+1 end
	end end
	b = ( c == 3 or ( b and c == 4 ) )
	st[2][off( x, y )] = b
	return b
end

display.udp.fungfx( init )
while true or os.execute "sleep 0.25" do
	display.udp.fungfx( step )
	st[1], st[2] = st[2], st[1]
end

-- -- the code (tm)
-- for i = 0, math.huge do
-- 	local r = i % h
-- 	if r > h/2 then  r = h - r  end
-- 	display.udp.fungfx( function( x, y )
-- 		x = x - w/2
-- 		y = y - h/2
-- 		return x*x+y*y < r^2 and math.random(r) == 1
-- 	end )
-- end

