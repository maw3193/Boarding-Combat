local panel = {}
--A draggable, resizable container that holds widgets.
local util = require "userlib/util"
local paneltemplate = {
	posx = 0,
	posy = 0,
	width = 100,
	height = 100,
	minwidth = 32,
	minheight = 32,
	grabbed = false,
	locked = false,
	grabbedx = nil, --position the cursor grabbed at
	grabbedy = nil,
	widgets = nil,
	pressedwidget = nil,
	bordercol = {255,255,255,255},
	fillcol = {127,127,127,127},
	draw = function(self)
		love.graphics.setColor(self.bordercol)
		love.graphics.rectangle("line", self.posx, self.posy,
		                        self.width, self.height)
		love.graphics.setColor(self.fillcol)
		love.graphics.rectangle("fill", self.posx, self.posy,
		                        self.width, self.height)
		for _,v in util.ripairs(self.widgets) do
			v:draw()
		end
	end,
	update = function(self, dt)
		if self.grabbed then
			self.posx = love.mouse.getX() - self.grabbedx
			self.posy = love.mouse.getY() - self.grabbedy
		end
		if self.widgets then
			for _,v in pairs(self.widgets) do
				v:update(dt)
			end
		end
	end,
	testpoint = function(self, screenx, screeny)
		if screenx >= self.posx
			and screenx <= self.posx + self.width
			and screeny >= self.posy
			and screeny <= self.posy + self.height
		then
			return true
		else
			return false
		end
	end,
	mousepressed = function(self, x, y, button)
		for k,v in pairs(self.widgets) do
			if v:testpoint(x,y) then
				v:mousepressed(x, y, button)
				self.pressedwidget = v
				break
			end
		end
		if button == "l" and not self.locked and not self.pressedwidget then
			self.grabbed = true
			self.grabbedx = x - self.posx
			self.grabbedy = y - self.posy
		end
	end,
	mousereleased = function(self, x, y, button)
		if self.pressedwidget then
			self.pressedwidget:mousereleased(x, y, button)
			self.pressedwidget = nil
		end
		if button == "l" and not self.locked and not self.pressedwidget then
			self.grabbed = false
			self.grabbedx = nil
			self.grabbedy = nil
		end
	end,
	getX = function(self)
		return self.posx
	end,
	getY = function(self)
		return self.posy
	end,
	addwidget = function(self, widget)
		table.insert(self.widgets, widget)
	end,

}

paneltemplate.__index = paneltemplate

panel.newpanel = function(data)
	local temp = setmetatable({}, paneltemplate)
	temp.widgets = {}
	if data then
		for k,v in pairs(data) do
			temp[k] = v
		end
	end
	return temp
end

return panel
