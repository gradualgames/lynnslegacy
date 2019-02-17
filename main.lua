function love.load()
    love.window.setMode(0, 0, {fullscreen = true})
    love.graphics.setDefaultFilter("nearest", "nearest", 1)
    screenWidth, screenHeight = 320, 240
    graphicsWidth, graphicsHeight = love.graphics.getDimensions()
    scaleWidth, scaleHeight = graphicsWidth/screenWidth, graphicsHeight/screenHeight

    --paletteData, size = love.filesystem.read("ll.pal", 768)
end

function love.update(dt)
end

function love.draw()
    love.graphics.push()
    love.graphics.scale(scaleWidth,scaleHeight)

    --Insize of our pushed scale, I would have expected this to draw a big
    --fat pixel. Instead it is a tiny pixel of the density of the current
    --screen.
    love.graphics.setColor(255,0,0)
    love.graphics.points(100,100)
    
    --The following code attempts to plot each color from
    --ll.pal on the screen as a pixel. It does not work, everything
    --comes up black.
    --[[
    local i = 1
    for y=1,16 do
        for x = 1,16 do
            local r,g,b = string.byte(paletteData, i),
                          string.byte(paletteData, i+1),
                          string.byte(paletteData, i+2)
            love.graphics.setColor(r,g,b)
            love.graphics.points(x+100, y+100)
        end
    end
    --]]

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