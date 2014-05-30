#!/usr/bin/lua
require "display"

local sin = math.sin

local w,h = display.config.width, display.config.vheight

local sources = {
	{ x = w/2, y = h/2, f = 4 },
}

local timer = .0

function step( x, y )
	local v = 0
	for k = 1, #sources do
		local s = sources[k]
		local dx = s.x - x
		local dy = s.y - y
		local distance = ( dx*dx + dy*dy )^( 1/2 )
		v = v + ( sin( distance/s.f ) / distance * 2 ) / #sources
	end
	--return v > 1
	return .5 < v / 2 + .5
end

while true do
	fact = 3
	for k = 1, #sources do
		sources[1].x = sin( timer / fact ) * w/2 + w/2
		fact = fact * 1.2
		sources[1].y = sin( timer / fact ) * h/2 + h/2
		fact = fact * 1.2
	end
	math.randomseed( 2342 ) --timer%3 + 1 )
	display.udp.fungfx( step )
	timer = timer + .2
	--if timer > 50 then break end
end

