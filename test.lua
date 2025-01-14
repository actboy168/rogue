local c = require "rogue.core"

c.init {
	title = "测试",
	width = 80,
	height = 25,
	fps = 25,
	resizeable = true,
}

local background = c.sprite {
	"..........................................",
	"..........................................",
	"..........................................",
	"..........................................",
	"..........................................",
	"..........................................",
	"..........................................",
	"..........................................",
	"..........................................",
	"..........................................",
	"..........................................",
	color = 0x404040,
}

local s = c.sprite {
	".-----.",
	"| ^ ^ |",
	"|  -  |",
	".-----.",
	color = 0xff0000,
	transparency = '.',
	layer = 1,
}

local title = c.sprite {
	"       ",
	"       ",
	color = 0x80ff,
	layer = 2,
}

local s2 = s:clone()
s2:setcolor(0xff00)
s2:setcolor {
	Y = 0xffff00,
	W = 0xffffff,
	".-----.",
	"| Y Y |",
	"|  W  |",
	".-----.",
}


local x = 0
local y = 0

local EVENT = {}

function EVENT.QUIT()
	return true
end

function EVENT.KEY(name, press)
	if press then
		if name == "Left" then
			x = x - 1
		elseif name == "Right" then
			x = x + 1
		elseif name == "Up" then
			y = y - 1
		elseif name == "Down" then
			y = y + 1
		elseif name == "Q" then
			background:visible(false)
		end
	else
		if name == "Q" then
			background:visible(true)
		end
	end
end

local function dispatch(name, ...)
	if name then
		return not EVENT[name](...)
	else
		return true
	end
end

while dispatch(c.event()) do
	s:setpos(x,y)
	title:setpos(x, y+4)
	title:text(string.format("x = %d\ny = %d", x, y))
	c.frame()
end