local icon = {}
local util = require"userlib/util"
local colour = require"userlib/colour"
local template = {
	image = nil,
	imagetext = "",
	scale = 1,
	ox = 0,
	oy = 0,
	colour = colour.white,
	__serialize = function(self)
		return "icon.new(\"" 
		       .. self.imagetext .. "\"," 
		       .. self.scale .. "," 
		       .. self.ox .. "," 
		       .. self.oy .. ",{" 
		       .. self.colour[1] .. ","
		       .. self.colour[2] .. "," 
		       .. self.colour[3] .. "," 
		       .. self.colour[4] .. "})"
	end,
	draw  = function(self, x, y, scale)
		love.graphics.setColor(self.colour)
		love.graphics.draw(self.image, x, y, 0, self.scale * scale,
		                   self.scale * scale, self.ox, self.oy)
	end,
}
template.__index = template

icon.new = function(text, scale, offx, offy, colour)
	local temp = setmetatable({}, template)
	temp.image = util.addbitmap(text)
	temp.imagetext = text
	temp.ox = offx
	temp.oy = offy
	temp.scale = scale
	temp.colour = colour
	return temp
end

return icon
