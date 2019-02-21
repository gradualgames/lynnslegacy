function love.load()
    --love.window.setMode(0, 0, {fullscreen = true})
    love.graphics.setDefaultFilter("nearest", "nearest", 1)
    canvas = love.graphics.newCanvas(320,240)

    screenWidth,screenHeight = love.graphics.getDimensions()
    canvasWidth,canvasHeight = canvas:getDimensions()
    scale = math.min(screenWidth/canvasWidth , screenHeight/canvasHeight)

    paletteData = love.filesystem.read("ll.pal")
    spriteData = love.filesystem.read("lynn24.spr")
    spriteOffset = 0

    paletteCanvas = love.graphics.newCanvas(256,1)
    love.graphics.setCanvas(paletteCanvas)
    palette = {}
    local i = 1
    for x = 1,256 do
        local b,g,r = string.byte(paletteData, i),
                      string.byte(paletteData, i+1),
                      string.byte(paletteData, i+2)
        table.insert(palette,{r/255,g/255,b/255})
        love.graphics.setColor(r/255,g/255,b/255)
        love.graphics.points(x, 1)
        i = i + 3
    end

    love.graphics.setCanvas()

    shader = love.graphics.newShader("palette_shader.fs")
    shader:send("u_paletteTexture", paletteCanvas)

    -- source = love.audio.newSource("fsun.it", "stream")
    -- source:setLooping(true)
    -- source:play()
end

function love.update(dt)

    if love.keyboard.isDown("right") then
        spriteOffset = spriteOffset + 16
    end

    if love.keyboard.isDown("left") then
        spriteOffset = spriteOffset - 16
    end

end

function love.draw()

    --Imitating fade to white from Lynn's Legacy
    love.graphics.setCanvas(paletteCanvas)
    for x = 1,256 do
        r,g,b = palette[x][1],palette[x][2],palette[x][3]
        palette[x][1] = math.min(palette[x][1] + .01, 1)
        palette[x][2] = math.min(palette[x][2] + .01, 1)
        palette[x][3] = math.min(palette[x][3] + .01, 1)
        love.graphics.setColor(r,g,b)
        love.graphics.points(x, 1)
    end

    love.graphics.setShader(shader)
    love.graphics.setCanvas(canvas)
    love.graphics.clear()

    i = 1
    for y=1,128 do
        for x = 1,16 do
            local bt = string.byte(spriteData, i + spriteOffset)
            love.graphics.setColor(bt/255,0,0)
            love.graphics.points(x+100,y+100)
            i = i + 1
        end
    end

    love.graphics.setColor(1, 1, 1)
    love.graphics.setCanvas()

    love.graphics.push() -- Push transformation state, The translate and scale will affect everything bellow until love.graphics.pop()
    love.graphics.translate( math.floor((screenWidth - canvasWidth * scale)/2) , math.floor((screenHeight - canvasHeight * scale)/2)) -- Move to the appropiate top left corner
    love.graphics.scale(scale,scale) -- Scale
    love.graphics.draw(canvas) -- Draw the canvas
    love.graphics.pop() -- pop transformation state
    love.graphics.setShader()
end

function love.keypressed(key, scancode, isrepeat)
   if key == "escape" then
      love.event.quit()
   end
end