local ui = require "userlib/ui"
local colour = require "userlib/colour"
local panel = require "userlib/panel"
local wrbutton = require "userlib/widget_resizebutton"
local wlbutton = require "userlib/widget_lockbutton"
local wlabel = require "userlib/widget_label"
local wtitle = require "userlib/widget_title"
function love.load()
	love.graphics.setLineWidth(1.5)
	game = {}
	game.bitmaps = {}
	game.ui = ui.newui()
	game.ui:addpanel(panel.newpanel({posx = 10, fillcol = colour.transred, minwidth=32, minheight=32}))
	game.ui:addpanel(panel.newpanel({fillcol = colour.transblue}))
	game.ui.panels[1]:addwidget(wrbutton.newresizebutton({parent = game.ui.panels[1]}))
	game.ui.panels[1]:addwidget(wlbutton.newbutton({parent = game.ui.panels[1]}))
	game.ui.panels[1]:addwidget(wtitle.new(game.ui.panels[1], "Red box"))
end

function love.update(dt)
	game.ui:update(dt)
end

function love.draw()
	game.ui:draw()
end

function love.quit()

end

function love.mousepressed(x, y, button)
	game.ui:mousepressed(x, y, button)
end

function love.mousereleased(x, y, button)
	game.ui:mousereleased(x, y, button)
end

function love.keypressed(x, y, button)

end

function love.keyreleased(x, y, button)

end

