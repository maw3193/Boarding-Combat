local ui = {}
local util = require "userlib/util"
local uitemplate = {
	panels = nil,
	pressedthing = nil,
	pressedthingkey = nil,
	draw = function(self)
		for _,v in pairs(self.panels) do
			v:draw()
		end
	end,
	update = function(self, dt)
		for _,v in pairs(self.panels) do
			v:update(dt)
		end
	end,
	addpanel = function(self, panel)
		table.insert(self.panels, panel)
	end,
	mousepressed = function(self, x, y, button)
		for k,v in util.ripairs(self.panels) do
			if v:testpoint(x, y) then
				v:mousepressed(x, y, button)
				self.pressedthing = v
				self.pressedthingkey = k
				break
			end
		end
	end,
	mousereleased = function(self, x, y, button)
		if self.pressedthing then
			self.pressedthing:mousereleased(x, y, button)
			table.remove(self.panels, self.pressedthingkey)
			table.insert(self.panels, self.pressedthing)
			self.pressedthing = nil
			self.pressedthingkey = nil
		end
	end,
}

uitemplate.__index = uitemplate

ui.newui = function()
	local temp = setmetatable({}, uitemplate)
	temp.panels = {}
	return temp
end

return ui
