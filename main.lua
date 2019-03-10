require("lib/load")
require("lib/convert")

function love.load()
    baseDir = "LL/data"

    --love.window.setMode(0, 0, {fullscreen = true})
    love.graphics.setDefaultFilter("nearest", "nearest", 1)
    canvas = love.graphics.newCanvas(320,240)

    screenWidth,screenHeight = love.graphics.getDimensions()
    canvasWidth,canvasHeight = canvas:getDimensions()
    scale = math.min(screenWidth/canvasWidth , screenHeight/canvasHeight)

    palette = loadPalette(baseDir.."/palette/ll.pal")
    paletteCanvas = createPaletteCanvas(palette)

    shader = love.graphics.newShader("shader/palette_shader.fs")
    shader:send("u_paletteTexture", paletteCanvas)

    tileSpriteSheet = loadSpriteSheet(baseDir.."/pictures/tiles/fgrass.spr")
    lynnSpriteSheet = loadSpriteSheet(baseDir.."/pictures/char/lynn24.spr")

    tileSpriteBatch = createSpriteBatch(tileSpriteSheet)
    lynnSpriteBatch = createSpriteBatch(lynnSpriteSheet)

    map = loadMap(baseDir.."/map/forest_fall.map")

    ssx = 64
    ssy = 120

    -- source = love.audio.newSource(baseDir.."/music/fsun.it", "stream")
    -- source:setLooping(true)
    -- source:play()
end

function love.update(dt)

    if love.keyboard.isDown("right") then
        ssx = ssx + 1
    end

    if love.keyboard.isDown("left") then
        ssx = ssx - 1
    end

end

function love.draw()

    --Imitating fade to red from Lynn's Legacy
    -- love.graphics.setCanvas(paletteCanvas)
    -- for x = 1,256 do
        -- r,g,b = palette[x][1],palette[x][2],palette[x][3]
        -- palette[x][1] = math.min(palette[x][1] + .01, 1)
        -- palette[x][2] = math.max(palette[x][2] - .04, 0)
        -- palette[x][3] = math.max(palette[x][3] - .04, 0)
        -- love.graphics.setColor(r,g,b)
        -- love.graphics.points(x, 1)
    -- end

    love.graphics.setCanvas(canvas)
    love.graphics.clear()

    love.graphics.draw(tileSpriteBatch)
    love.graphics.draw(lynnSpriteBatch, ssx, ssy)

    love.graphics.setColor(1, 1, 1)
    love.graphics.setCanvas()
    love.graphics.setShader(shader)
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