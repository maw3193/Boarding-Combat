local sprite = {}
local colour = require "userlib/colour"
local template = {
	ox = 0,
	oy = 0,
	scale = 1,
	image = nil,
	imagepath = "",
	[1] = {q = nil,
	     col = colour.white},
	[2] = {q = nil,
	     col = colour.transblue},
	[3] = {q = nil,
	     col = colour.transgreen},
	[4] = {q = nil,
	     col = colour.black},
	draw = function(self, x, y, r, scale)
		scale = scale or 1
		for i, v  in ipairs(self) do
			love.graphics.setColor(v.col)
			love.graphics.drawq(self.image, v.q, x, y, r, 
			                    self.scale * scale, 
			                    self.scale * scale, 
			                    self.ox, self.oy)
		end
	end,
	update = function(self, dt)
	
	end,
	__serialize = function(self)
	
	end,
}
template.__index = template

sprite.new = function(ui, imagepath, colours, data) --Loads image 
	local temp = setmetatable({}, template)
	temp.imagepath = imagepath
	temp.image = ui:addimage(imagepath)
	local w = temp.image:getWidth()
	local h = temp.image:getHeight()
	local quadcount = h / w
	temp.ox = w/2
	temp.oy = w/2
	for i = 1, quadcount do
		temp[i] = {}
		temp[i].q = love.graphics.newQuad(0, (i - 1)*w, w, w, w, h)
		if colours then
			if colours[i] then
				temp[i].col = colours[i]
			elseif template[i].col then
				temp[i].col = template[i].col
			end
		end
	end
	if data then
		for k,v in pairs(data) do
			temp[k] = v
		end
	end
	return temp
end

return sprite
