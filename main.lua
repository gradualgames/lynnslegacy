function love.load()
    love.window.setMode(0, 0, {fullscreen = true})
    love.graphics.setDefaultFilter("nearest", "nearest", 1)

    canvas = love.graphics.newCanvas(320,240)

    screenWidth,screenHeight = love.graphics.getDimensions()
    canvasWidth,canvasHeight = canvas:getDimensions()
    scale = math.min(screenWidth/canvasWidth , screenHeight/canvasHeight)
end

function love.update(dt)
end

function love.draw()
    love.graphics.setCanvas(canvas)

    -- Render stuff in the game here
    love.graphics.setLineStyle("rough")
    love.graphics.rectangle("line",50,50,100,100)
    love.graphics.points(110,110)

    love.graphics.setCanvas()

    love.graphics.push() -- Push transformation state, The translate and scale will affect everything bellow until love.graphics.pop()
    love.graphics.translate( math.floor((screenWidth - canvasWidth * scale)/2) , math.floor((screenHeight - canvasHeight * scale)/2)) -- Move to the appropiate top left corner
    love.graphics.scale(scale,scale) -- Scale
    love.graphics.draw(canvas) -- Draw the canvas
    love.graphics.pop() -- pop transformation state

    --love.graphics.push()
    --love.graphics.scale(scaleWidth,scaleHeight)

    --Insize of our pushed scale, I would have expected this to draw a big
    --fat pixel. Instead it is a tiny pixel of the density of the current
    --screen.

    -- love.graphics.setCanvas(canvas)

    -- love.graphics.setColor(255,0,0)
    -- love.graphics.points(100,100,101,100,102,100)

    -- love.graphics.setCanvas()

    -- love.graphics.setBlendMode("alpha", "premultiplied")
    -- love.graphics.draw(canvas)

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

    --love.graphics.print("Hello, World!", 110, 120)
    --love.graphics.setColor(255, 255, 255)
    --love.graphics.circle("fill", 300, 300, 50, 100) -- Draw white circle with 100 segments.

    --love.graphics.pop()
end

function love.keypressed(key, scancode, isrepeat)
   if key == "escape" then
      love.event.quit()
   end
end