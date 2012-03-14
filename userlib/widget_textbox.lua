local w_label = require "userlib/widget_label"
local util = require "userlib/util"
local wbutton = require "userlib/widget_button"
local icon = require "userlib/icon"
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
			self:scroll(-1)
		elseif (button == "wd") then
			self:scroll(1)
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
	scroll = function(self, n)
		if (n > 0) then
			if (self.currentline < self.totallines - self.linestodraw + 1) then
				self.currentline = self.currentline + n
			end			
		elseif (n < 0) then
			if (self.currentline > 1) then
				self.currentline = self.currentline + n
			end
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
	temp.scroll = w_textbox.scroll
	temp.currentline = 1
	temp:makelines()

	return temp
end
w_textbox.addtopanel = function(panel, data) --Preferred way of making it
	local temp = w_textbox.new(data)     --because it includes buttons
	table.insert(panel.widgets, temp)
	local buttonsize = 16
	local buttonposx = temp.posx + temp.width
	local bottombuttonposy = temp.posy + temp.height - buttonsize
	table.insert(panel.widgets, wbutton.newbutton{parent=panel, target=temp,
	                            posx=buttonposx, posy=temp.posy,
	                            width=buttonsize, height=buttonsize,
	                            icon=icon.new("art/icons/upicon.png"), 
	                            mousereleased = function(self)
	                            	self.target:scroll(-1)
	                            end})
	table.insert(panel.widgets, wbutton.newbutton{parent=panel, target=temp,
	                            posx=buttonposx, posy=bottombuttonposy,
	                            width=buttonsize, height=buttonsize,
	                            icon=icon.new("art/icons/downicon.png"), 
	                            mousereleased = function(self)
	                            	self.target:scroll(1)
	                            end})
end

return w_textbox
