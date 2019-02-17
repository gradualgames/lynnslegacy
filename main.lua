function love.load()
    love.window.setMode(0, 0, {fullscreen = true})
    love.graphics.setDefaultFilter("nearest", "nearest", 1)
    screenWidth, screenHeight = 320, 240
    graphicsWidth, graphicsHeight = love.graphics.getDimensions()
    scaleWidth, scaleHeight = graphicsWidth/screenWidth, graphicsHeight/screenHeight
end

function love.update(dt)
end

function love.draw()
    love.graphics.push()
    love.graphics.scale(scaleWidth,scaleHeight)

    love.graphics.print("Hello, World!", 110, 120)
    love.graphics.setColor(255, 255, 255)
    love.graphics.circle("fill", 300, 300, 50, 100) -- Draw white circle with 100 segments.

    love.graphics.pop()
end

function love.keypressed(key, scancode, isrepeat)
   if key == "escape" then
      love.event.quit()
   end
end