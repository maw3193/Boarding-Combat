local w_label = require "userlib/widget_label"
local util = require "userlib/util"
--local ui = require "userlib/ui"

local w_textbox = {
	draw = function(self, dt)
		local offset = 0
		local i
		local startline = self.currentline
		local endline = startline + self.linestodraw - 1
		love.graphics.setColor(self.colour)
		for i = startline, endline do
			love.graphics.print(self.lines[i], self:getScreenX(),
			                    self:getScreenY() + offset)
			offset = offset + game.ui.smallfont:getHeight()
		end
	end,
	update = function(self, dt)
		if self.width ~= self.parent.width - 32 then
			self.width = self.parent.width - 32
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
	mousereleased = function(self, x, y, button)
		if (button == "wu") then
			if (self.currentline > 1) then
				self.currentline = self.currentline - 1
			end
		elseif (button == "wd") then
			if (self.currentline < self.totallines - self.linestodraw + 1) then
				self.currentline = self.currentline + 1
			end
		end
	end,
	makelines = function(self, text)
		if text then
			self.text = text
		end
		local charwidth = math.floor(self.width / 
		                             game.ui.smallfont:getWidth("O"))
		self.lines = util.splitstringintolines(self.text, charwidth)
		self.totallines = #self.lines
		self.linestodraw = math.floor(self.height / 
		                              game.ui.smallfont:getHeight())
		if (self.linestodraw > self.totallines) then
			self.linestodraw = self.totallines - 1
		end
		if (self.currentline > self.totallines - self.linestodraw) then
			self.currentline = self.totallines - self.linestodraw
		end
	end,
	lines = nil,
	currentline = nil,
	totallines = nil,
	linestodraw = nil,

}
w_textbox.new = function(data)

	local temp = w_label.newlabel(data)
	temp.update = w_textbox.update
	temp.draw = w_textbox.draw
	temp.makelines = w_textbox.makelines
	temp.mousereleased = w_textbox.mousereleased
	temp.testpoint = w_textbox.testpoint
	temp.currentline = 1
	temp:makelines()

	return temp
end

return w_textbox
