local LightWorld = require "lib"
local GameState = require "gamestate"

local mainMenu = {}
local playGame = {}

function mainMenu:init()
	mainMenuBgm = love.audio.newSource("res/mus/menu.mp3")
	mainMenuBg = love.graphics.newImage("res/tx/checker.png")

	mainMenuBgm:setVolume(0.7)
	mainMenuBgm:setPitch(1.1)
	mainMenuBgm:play()
end


function mainMenu:draw()
	local lightWorld = LightWorld({
    	ambient = {55,55,55},       
  	})

	love.graphics.push()
    lightWorld:draw(function()
			for i = 0, love.graphics.getWidth() / mainMenuBg:getWidth() do
				for j = 0, love.graphics.getHeight() / mainMenuBg:getHeight() do
					love.graphics.draw(mainMenuBg, i * mainMenuBg:getWidth(), j * mainMenuBg:getHeight())
				end
			end
    end)

  love.graphics.pop()
end

function love.load()
	GameState.registerEvents()
	GameState.switch(mainMenu)
end

function love.update(dt)

end

function love.draw()

end
