local ui = require "userlib/ui"
local colour = require "userlib/colour"
local panel = require "userlib/panel"
local wbutton = require "userlib/widget_button"
local wrbutton = require "userlib/widget_resizebutton"
local wlbutton = require "userlib/widget_lockbutton"
local wlabel = require "userlib/widget_label"
local wsprite = require "userlib/widget_sprite"
local wtitle = require "userlib/widget_title"
local wtextbox = require "userlib/widget_textbox"
local sprite = require "userlib/sprite"
local icon = require "userlib/icon"
function love.load()
	love.graphics.setLineWidth(1.5)
	game = {}
	game.bitmaps = {}
	game.ui = ui.newui()
	love.graphics.setFont(game.ui.smallfont)
	game.ui:addpanel(panel.newpanel{posx = 10, fillcol = colour.transred, minwidth=32, minheight=32})
	game.ui:addpanel(panel.newpanel{fillcol = colour.transblue})
	game.ui.panels[1]:addwidget(wrbutton.newresizebutton{parent = game.ui.panels[1]})
	game.ui.panels[1]:addwidget(wlbutton.newbutton{parent = game.ui.panels[1]})
	game.ui.panels[1]:addwidget(wtitle.new(game.ui.panels[1], "Red box"))
	game.sprite = sprite.new(game.ui, "art/sprites/rifleman.png", {colour.white, colour.blue, colour.invisible, colour.black}, {ox=6, oy=16.5})
	game.ui.panels[1]:addwidget(wsprite.new{parent=game.ui.panels[1], posx=32, posy=32, scale=1, sprite=game.sprite})
	wtextbox.addtopanel(game.ui.panels[2], 
	                    {parent=game.ui.panels[2], posx=0, posy=0, width=84,
	                    height=100, text= "SATOR\nAREPO\nTENET\nOPERA\nROTAS"})
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

function love.keypressed(key)
	if key == "rctrl" then --set to whatever key you want to use
		debug.debug()
	end
end

function love.keyreleased(key)

end

