local w_sprite = {}
local template = {
	parent = nil,
	sprite = nil,
	posx = 0,
	posy = 0,
	width = 16,
	height = 16,
	scale = 1,
	rot = 0,
	draw = function(self)
		self.sprite:draw(self.posx + self.parent:getX(),
		                self.posy + self.parent:getY(), 
		                self.rot, self.scale)
	end,
	update = nil, --An update function(self,dt) can be called
	testpoint = function(self, x, y)
		return false
	end,
	mousepressed = nil, --function(self,x,y,button)
	mousereleased = nil, --function(self,x,y,button)
	getScreenX = function(self)
		return self.posx + self.parent:getX()
	end,
	getScreenY = function(self)
		return self.posy + self.parent:getY()
	end,
}
template.__index = template

w_sprite.new = function(data)
	local temp = setmetatable({}, template)
	for k,v in pairs(data) do
		temp[k] = v
	end
	return temp
end

return w_sprite
