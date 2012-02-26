local ui = require"userlib/ui"
local panel = require"userlib/panel"
local wrbutton = require "userlib/widget_resizebutton"
local wlbutton = require"userlib/widget_lockbutton"
function love.load()
	love.graphics.setLineWidth(2)
	game = {}
	game.ui = ui.newui()
	game.ui:addpanel(panel.newpanel({posx = 10, fillcol = {255,0,0,127}}))
	game.ui:addpanel(panel.newpanel({fillcol = {0,0,255,127}}))
	game.ui.panels[1]:addwidget(wrbutton.newresizebutton({parent = game.ui.panels[1]}))
	game.ui.panels[1]:addwidget(wlbutton.newbutton({parent = game.ui.panels[1]}))
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

