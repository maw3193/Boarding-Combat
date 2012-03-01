local w_label = require "userlib/widget_label"
local w_title = {
	update = function(self, dt)
		if self.width ~= self.parent.width - 32 then
			self.width = self.parent.width - 32
		end
	end,

}
w_title.new = function(par, txt)
	local temp = w_label.newlabel({parent = par, update = w_title.update,
	                               align="center", posx=16, 
	                               width=par.width - 32, text=txt})
	return temp
end

return w_title
