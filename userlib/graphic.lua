local graphic = {}
local util = require"userlib/util"
local colour = require"userlib/colour"
local template = {
	scale = 1, --general scaling factor
	layer1 = nil, --Bottom layer bitmap
	path1 = "",
	colour1 = colour.white, --tinting to the base image
	scale1 = 1, --scaling factor individual to this layer
	ox1 = 0,
	oy1 = 0,
	layer2 = nil, --middle layer bitmap, big details
	path2 = "",
	colour2 = colour.transgrey, --Player colour details
	scale2 = 1,
	ox2 = 0,
	oy2 = 0,
	layer3 = nil, --top layer bitmap, minor details
	path3 = "",
	colour3 = colour.transblack --Miscellaneous identifiers e.g. selected
	scale3 = 1,
	ox3 = 0,
	oy3 = 0,
	__serialize = function(self)
		return "graphic.new(" .. self.scale .. ",\"" .. self.path1 .. 
		       "\",{" self.colour1[1] .. "," .. self.colour1[2] .. "," .. self.colour1[3] .. "," .. self.colour1[4] .. "}," ..
		       self.scale1 .. ",\"" .. self.path2 .. "\"," .. 
		       ",{" self.colour2[1] .. "," .. self.colour2[2] .. "," .. self.colour2[3] .. "," .. self.colour2[4] .. "}," ..
		       self.scale2 .. ",\"" .. self.path3 .. "\"," ..
		       ",{" self.colour3[1] .. "," .. self.colour3[2] .. "," .. self.colour3[3] .. "," .. self.colour3[4] .. "}," ..
		       self.scale3 .. ")"
	end,
	draw = function(self, x, y, r, scale)
		if layer1 then
			love.graphics.setColor(self.colour1)
			love.graphics.draw(self.layer1, x, y, r, 
			                   scale*self.scale*self.scale1,
			                   scale*self.scale*self.scale1, 
			                   self.ox1, self.oy1)
		end
		if layer2 then
			love.graphics.setColor(self.colour2)
			love.graphics.draw(self.layer2, x, y, r, 
			                   scale*self.scale*self.scale2, 
			                   scale*self.scale*self.scale2, 
			                   self.ox2, self.oy2)
		end
		if layer3 then
			love.graphics.setColor(self.colour3)
			love.graphics.draw(self.layer3, x, y, r, 
			                   scale*self.scale*self.scale3, 
			                   scale*self.scale*self.scale3, 
			                   self.ox3, self.oy3)
		end
	end,
	update = function(self, dt) --I have no idea what I'd use this for.
		
	end,
}
template.__index = template

graphic.new = function(scale, path1, col1, scale1, path2, col2, scale2, 
            path3, col3, scale3)
	local temp = setmetatable({}, template)
	if scale then temp.scale = scale end
	if scale1 then temp.scale1 = scale1 end
	if scale2 then temp.scale2 = scale2 end
	if scale3 then temp.scale3 = scale3 end
	if col1 then temp.colour1 = col1 end
	if col2 then temp.colour2 = col2 end
	if col3 then temp.colour3 = col3 end
	if path1 and path1 ~= "" then
		temp.path1 = path1
		temp.layer1 = util.addbitmap(path1)
		temp.ox1 = temp.layer1:getWidth()
		temp.oy1 = temp.layer1:getHeight()
	end
	if path2 and path2 ~= "" then
		temp.path2 = path2
		temp.layer2 = util.addbitmap(path2)
		temp.ox2 = temp.layer2:getWidth()
		temp.oy2 = temp.layer2:getHeight()
	end
	if path3 and path3 ~= "" then
		temp.path3 = path3
		temp.layer3 = util.addbitmap(path3)
		temp.ox3 = temp.layer3:getWidth()
		temp.oy3 = temp.layer3:getHeight()
	end
	
	return temp
end

return graphic
