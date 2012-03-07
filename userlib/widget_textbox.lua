local w_label = require "userlib/widget_label"
local util = require "userlib/util"
--local ui = require "userlib/ui"

local w_textbox = {
	draw = function(self, dt)
		local offset = 0
		for i,v in ipairs(self.lines) do
			love.graphics.print(v, self:getScreenX(),
			                    self:getScreenY() + offset)
			offset = offset + game.ui.smallfont:getHeight()
		end
	end,
	update = function(self, dt)
		if self.width ~= self.parent.width - 32 then
			self.width = self.parent.width - 32
		end
	end,
	lines = nil,

}
w_textbox.new = function(data)

	local temp = w_label.newlabel(data)
	temp.update = w_textbox.update
	
	local charwidth = math.floor(temp.width/game.ui.smallfont:getWidth("O"))
	print("This textbox is "..charwidth.." characters wide.")
	temp.lines = util.splitstringintolines(temp.text, charwidth)
	return temp
end

return w_textbox
