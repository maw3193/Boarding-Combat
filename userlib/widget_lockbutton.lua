local w_lock = {}
--A button for locking the parent panel. Stays in the top-right corner.
local button = require "userlib/widget_button"


w_lock.togglelock = function(self, x, y, button)
	if self.parent.locked then
		self.parent.locked = false
	else
		self.parent.locked = true
	end
end

w_lock.update = function(self, dt)
		if self.parent.width ~= (self.posx + self.width) then
			self.posx = self.parent.width - self.width
		end
end

w_lock.newbutton = function(data)
	data.mousereleased = w_lock.togglelock
	data.update = w_lock.update
	data.posy = 0
	data.posx = data.parent.width - 16
	temp = button.newbutton(data)
	return temp
end

return w_lock
