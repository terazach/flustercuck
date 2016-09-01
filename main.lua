local LightWorld = require "lib"
local GameState = require "gamestate"

local mainMenu = {}
local playGame = {}

function mainMenu:init()
	mainMenuBgm = love.audio.newSource("res/mus/menu.mp3")

	mainMenuMap = love.graphics.newImage("res/tx/solid.png")
	mainMenuLogo = love.graphics.newImage("res/tx/logo.png")
	mainMenuButton = love.graphics.newImage("res/tx/button.png")

	gameFont = love.graphics.newFont("res/Bitter-Regular.ttf", 25)
	love.graphics.setFont(gameFont);

	mainMenuBgm:setVolume(0.1)
	mainMenuBgm:setPitch(1.3)
	mainMenuBgm:play()

	lightWorld = LightWorld({
    	ambient = {55,55,55},       
  	})

  	lightWorld:newLight(love.graphics.getWidth()/2, love.graphics.getHeight()/2, 255, 119, 119, love.graphics.getDimensions())
end


function mainMenu:draw()
	love.graphics.push()
    lightWorld:draw(function()
		for i = 0, love.graphics.getWidth() / mainMenuMap:getWidth() do
			for j = 0, love.graphics.getHeight() / mainMenuMap:getHeight() do
				love.graphics.draw(mainMenuMap, i * mainMenuMap:getWidth(), j * mainMenuMap:getHeight())
			end
		end
    end)

    love.graphics.draw(mainMenuLogo, love.graphics.getWidth()/2, love.graphics.getHeight()/2, 0, 1, 1, mainMenuLogo:getWidth()/2, mainMenuLogo:getHeight()/2)
    
    --play button
    love.graphics.draw(mainMenuButton, love.graphics.getWidth()/2, love.graphics.getHeight()/2+150, 0, 1, 1, mainMenuLogo:getWidth()/2, mainMenuLogo:getHeight()/2)
    love.graphics.print("Play", love.graphics.getWidth()/2+230, love.graphics.getHeight()/2+150, 0, 1, 1, mainMenuLogo:getWidth()/2, mainMenuLogo:getHeight()/2 )

    --exit button
    love.graphics.draw(mainMenuButton, love.graphics.getWidth()/2, love.graphics.getHeight()/2+200, 0, 1, 1, mainMenuLogo:getWidth()/2, mainMenuLogo:getHeight()/2)
  	love.graphics.print("Exit", love.graphics.getWidth()/2+230, love.graphics.getHeight()/2+200, 0, 1, 1, mainMenuLogo:getWidth()/2, mainMenuLogo:getHeight()/2)

  	love.graphics.pop()
end

function mainMenu:update(dt)
end

function love.load()
	GameState.registerEvents()
	GameState.switch(mainMenu)
end

function love.update(dt)

end