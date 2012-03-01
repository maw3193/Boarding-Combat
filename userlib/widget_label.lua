local w_label = {}
local colour = require "userlib/colour"
local ui = require "userlib/ui"
local template = {
	parent = nil,
	text = "default text",
	align = "left",
	posx = 0,
	posy = 0,
	width = 0,
	colour = colour.white,
	font = nil,
	draw = function(self)
		if self.font then 
			love.graphics.setFont(self.font) 
		end
		love.graphics.setColor(self.colour)
		love.graphics.printf(self.text, self.posx + self.parent:getX(),
		                     self.posy + self.parent:getY(), self.width,
		                     self.align)
	end,
	update = function(self, dt)
	
	end,
	testpoint = function(self, x, y)
		return false
	end,
	mousepressed = function(self, x, y, button)
	end,
	mousereleased = function(self, x, y, button)
		
	end,
	getScreenX = function(self)
		return self.posx + self.parent:getX()
	end,
	getScreenY = function(self)
		return self.posy + self.parent:getY()
	end,

}
template.__index = template

w_label.newlabel = function(data)
	local temp = setmetatable({}, template)
	for k,v in pairs(data) do
		temp[k] = v
	end
	return temp
end

return w_label
