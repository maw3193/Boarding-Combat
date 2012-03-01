local w_resize = {}
--Button for resizing
local icon = require"userlib/icon"
local colour = require"userlib/colour"
local resizeicon = "art/icons/paneldragicon.png"
local widgettemplate = {
	parent = nil,
	posx = nil, --position local to the panel it is attached to
	posy = nil,
	width = 16,
	height = 16,
	pressed = false,
	offsetx = nil,
	offsety = nil,
	icon = nil,
	bordercol = colour.white,
	fillcol = colour.invisible,
	draw = function(self)
		love.graphics.setColor(self.bordercol)
		love.graphics.rectangle("line", self.parent:getX() + self.posx,
		                        self.parent:getY() + self.posy, self.width,
		                        self.height)
		love.graphics.setColor(self.fillcol)
		love.graphics.rectangle("fill", self.parent:getX() + self.posx,
		                        self.parent:getY() + self.posy, self.width,
		                        self.height)
		self.icon:draw(self.parent:getX() + self.posx, 
		self.parent:getY() + self.posy, 1)
		
	end,
	update = function(self, dt)
		if self.pressed then
			if love.mouse.getX() < self.parent:getX() + self.parent.minwidth then --TOO FAR LEFT
				self.parent.width = self.parent.minwidth
				self.posx = self.parent.width - self.width
			else
				self.parent.width = love.mouse.getX() - self.parent:getX() - self.offsetx + self.width
				self.posx = love.mouse.getX() - self.offsetx - self.parent:getX()
			end
			if love.mouse.getY() < self.parent:getY() + self.parent.minheight then --TOO FAR UP
				self.parent.height = self.parent.minheight
				self.posy = self.parent.height - self.height
			else
				self.parent.height = love.mouse.getY() - self.parent:getY() - self.offsety + self.height
				self.posy = love.mouse.getY() - self.offsety - self.parent:getY()

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
		self.fillcol = colour.transwhite
		self.pressed = true
		self.offsetx = x - self:getScreenX()
		self.offsety = y - self:getScreenY()
	end,
	mousereleased = function(self, x, y, button)
		self.fillcol = colour.invisible
		self.pressed = false
		
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
	temp.icon = icon.new(resizeicon, 1,0,0,colour.white)
	return temp
end

return w_resize
