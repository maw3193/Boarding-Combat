local w_resize = {}
--Button for resizing
local widgettemplate = {
	parent = nil,
	posx = nil, --position local to the panel it is attached to
	posy = nil,
	width = 16,
	height = 16,
	pressed = false,
	offsetx = nil,
	offsety = nil,
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
		if self.pressed then
			self.parent.width = love.mouse.getX() - self.parent:getX() - self.offsetx + self.width
			self.parent.height = love.mouse.getY() - self.parent:getY() - self.offsety + self.height
			self.posx = love.mouse.getX() - self.offsetx - self.parent:getX()
			self.posy = love.mouse.getY() - self.offsety - self.parent:getY()
			if self.parent.width < self.parent.minwidth then
				self.parent.width = self.parent.minwidth
				self.posx = self.parent.width - self.width
			end
			if self.parent.height < self.parent.minheight then
				self.parent.height = self.parent.minheight
				self.posy = self.height - self.parent.height
			end
			
		end

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
		self.fillcol = {255,255,255,255}
		self.pressed = true
		self.offsetx = x - self:getScreenX()
		self.offsety = y - self:getScreenY()
		print("set pressed")
	end,
	mousereleased = function(self, x, y, button)
		self.fillcol = {127,127,127,255}
		self.pressed = false
		print("unset pressed")
		
	end,
	getScreenX = function(self)
		return self.posx + self.parent:getX()
	end,
	getScreenY = function(self)
		return self.posy + self.parent:getY()
	end,

}
widgettemplate.__index = widgettemplate

w_resize.newresizebutton = function(data)
	local temp = setmetatable({}, widgettemplate)
	if data then
		for k,v in pairs(data) do
			temp[k] = v
		end
	end
	temp.posx = temp.parent.width - temp.width
	temp.posy = temp.parent.height - temp.height
	return temp
end

return w_resize
