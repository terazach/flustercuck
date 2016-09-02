local LightWorld = require "lib"
local GameState = require "gamestate"

local mainMenu = {}
local playGame = {}
local pauseMenu = {}

function love.load()
  love.mouse.setGrabbed(false)

	GameState.registerEvents()
	GameState.switch(mainMenu)
end

function love.update(dt)

end

function printStats(cX, cY)
   if love.keyboard.isDown("c") then
      local coordsX = love.mouse.getX()
      local coordsY = love.mouse.getY()
      love.graphics.print("Mouse: " .. coordsX .. " , " .. coordsY, cX, cY)
      love.graphics.print("FPS: "..tostring(love.timer.getFPS()), cX, cX+25)
      love.graphics.print("DT: "..tostring(love.timer.getAverageDelta()), cX, cX+50)

   end
end

function mainMenu:init()
	mainMenuBgm = love.audio.newSource("res/mus/menu.mp3")

	mainMenuMap = love.graphics.newImage("res/tx/solid.png")
	mainMenuLogo = love.graphics.newImage("res/tx/logo.png")
	mainMenuButton = love.graphics.newImage("res/tx/button.png")

	local gameFont = love.graphics.newFont("res/Bitter-Regular.ttf", 25)
	love.graphics.setFont(gameFont);

	--mainMenuBgm:setVolume(0.1)
	--mainMenuBgm:play()

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

  printStats(50, 50)

  love.graphics.pop()
end

function mainMenu:keypressed(key)
    if key == 'e' then
        return GameState.switch(playGame) 
    end

    if key == 'escape' then
        return love.event.quit()
    end
end

function playGame:init()
  love.mouse.setVisible(false)
  mainMenuBgm:stop()
end

function playGame:draw()
  printStats(50, 50)

  lightWorld:draw(function()
    for i = 0, love.graphics.getWidth() / mainMenuMap:getWidth() do
      for j = 0, love.graphics.getHeight() / mainMenuMap:getHeight() do
        love.graphics.draw(mainMenuMap, i * mainMenuMap:getWidth(), j * mainMenuMap:getHeight())
      end
    end
  end)
end

function playGame:keypressed(key)
    if key == 'escape' then
        return GameState.push(pauseMenu) 
    end
end

function pauseMenu:enter(from)
  self.from = from
end

function pauseMenu:draw()
  self.from:draw()

  love.graphics.draw(mainMenuLogo, love.graphics.getWidth()/2, love.graphics.getHeight()/2, 0, 1, 1, mainMenuLogo:getWidth()/2, mainMenuLogo:getHeight()/2)

    --exit button
  love.graphics.draw(mainMenuButton, love.graphics.getWidth()/2, love.graphics.getHeight()/2+200, 0, 1, 1, mainMenuLogo:getWidth()/2, mainMenuLogo:getHeight()/2)
  love.graphics.print("Exit", love.graphics.getWidth()/2+230, love.graphics.getHeight()/2+200, 0, 1, 1, mainMenuLogo:getWidth()/2, mainMenuLogo:getHeight()/2)
end

function pauseMenu:keypressed(key)
    if key == 'escape' then
        return GameState.pop(playGame) 
    end
end
