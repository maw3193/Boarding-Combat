local w_lock = {}
--A button for locking the parent panel. Stays in the top-right corner.
local button = require "userlib/widget_button"
local colour = require "userlib/colour"
local icon = require "userlib/icon"
local lockicon = "art/icons/lockicon.png"

w_lock.togglelock = function(self, x, y, button)
	self.parent.locked = not self.parent.locked
	if self.parent.locked then 
		self.icon.colour = colour.grey
	else
		self.icon.colour = colour.white
	end
end

w_lock.update = function(self, dt)
		if self.posx ~= (self.parent.width - self.width) then
			self.posx = self.parent.width - self.width
		end
end

w_lock.newbutton = function(data)
	data.mousereleased = w_lock.togglelock
	data.update = w_lock.update
	data.posy = 0
	data.posx = data.parent.width - 16
	temp = button.newbutton(data)
	temp.icon = icon.new(lockicon, 1, 0, 0, colour.white)
	return temp
end

return w_lock
