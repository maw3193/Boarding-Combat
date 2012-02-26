local w_button = {}
--Button for resizing
local template = {
	parent = nil,
	posx = nil, --position local to the panel it is attached to
	posy = nil,
	width = 16,
	height = 16,
	data = nil,
	bordercol = {255,255,255,255},
	fillcol = {127,127,127,255},
	draw = function(self)
		love.graphics.setColor(self.bordercol)
		love.graphics.rectangle("line", self.parent:getX() + self.posx,
		                        self.parent:getY() + self.posy, self.width,
		                        self.height)
		love.graphics.setColor(self.fillcol)
		love.graphics.rectangle("fill", self.parent:getX() + self.posx,
		                        self.parent:getY() + self.posy, self.width,
		                        self.height)
		
	end,
	update = function(self, dt)
	end,
	testpoint = function(self, x, y)
		if x >= self.posx + self.parent:getX()
			and x <= self.posx + self.parent:getX() + self.width
			and y >= self.posy + self.parent:getY()
			and y <= self.posy + self.parent:getY() + self.height
		then
			return true
		else
			return false
		end
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

w_button.newbutton = function(data)
	local temp = setmetatable({}, template)
	if data then
		for k,v in pairs(data) do
			temp[k] = v
		end
	end
	return temp
end

return w_button
