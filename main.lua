function love.load()
    love.window.setMode(0, 0, {fullscreen = true})
    love.graphics.setDefaultFilter("nearest", "nearest", 1)

    canvas = love.graphics.newCanvas(320,240)

    screenWidth,screenHeight = love.graphics.getDimensions()
    canvasWidth,canvasHeight = canvas:getDimensions()
    scale = math.min(screenWidth/canvasWidth , screenHeight/canvasHeight)

    paletteData, size = love.filesystem.read("ll.pal", 768)
end

function love.update(dt)
end

function love.draw()
    love.graphics.setCanvas(canvas)
    love.graphics.clear()

    -- Render stuff in the game here
    love.graphics.setLineStyle("rough")
    love.graphics.rectangle("line",50,50,100,100)
    love.graphics.points(110,110)

    --The following code attempts to plot each color from
    --ll.pal on the screen as a pixel. It does not work, everything
    --comes up black.
    --[
    print("****")
    local i = 1
    for y=1,16 do
        for x = 1,16 do
            local r,g,b = string.byte(paletteData, i),
                          string.byte(paletteData, i+1),
                          string.byte(paletteData, i+2)
            print("red: "..r.." green: "..g.." blue: " ..b)
            love.graphics.setColor(r/255,g/255,b/255)
            love.graphics.points(x*2+100, y*2+100)
            i = i + 3
        end
    end

    love.graphics.setCanvas()

    love.graphics.push() -- Push transformation state, The translate and scale will affect everything bellow until love.graphics.pop()
    love.graphics.translate( math.floor((screenWidth - canvasWidth * scale)/2) , math.floor((screenHeight - canvasHeight * scale)/2)) -- Move to the appropiate top left corner
    love.graphics.scale(scale,scale) -- Scale
    love.graphics.draw(canvas) -- Draw the canvas
    love.graphics.pop() -- pop transformation state
end

function love.keypressed(key, scancode, isrepeat)
   if key == "escape" then
      love.event.quit()
   end
end