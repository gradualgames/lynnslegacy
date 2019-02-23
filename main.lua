function bytesToInt(b1, b2, b3, b4)
    return b1 + b2*256 + b3*65536 + b4*16777216
end

function bytesToShort(b1, b2)
    return b1 + b2*256
end

function loadSpriteSheet(fileName)

    --Load binary data of the .spr file all at once.
    local fileData = love.filesystem.read(fileName)

    --Load the 16 byte header of the .spr file.
    local width = bytesToInt(fileData:byte(1, 4))
    local height = bytesToInt(fileData:byte(5, 8))
    local arraySize = bytesToInt(fileData:byte(9, 12))
    local frames = bytesToInt(fileData:byte(13, 16))
    local fileDataIndex = 17

    --Create an image that can contain everything in the file.
    local imageData = love.image.newImageData(width * frames+16, height + 16)
    local imageX, imageY = 0, 0

    for frameIndex = 1, frames do

        --Get the header for the current frame.
        local frameWidth = bytesToShort(fileData:byte(fileDataIndex, fileDataIndex + 1))/8
        local frameHeight = bytesToShort(fileData:byte(fileDataIndex + 2, fileDataIndex + 3))
        fileDataIndex = fileDataIndex + 4

        --Copy the image data pixel by pixel, converting to our monochrome red format.
        for y=1,height do
            for x=1,width do
                local bt = fileData:byte(fileDataIndex)
                imageData:setPixel(imageX+x,imageY+y, bt/255, 0, 0, 1)
                fileDataIndex = fileDataIndex + 1
            end
        end
        imageX = imageX + width
    end

    return imageData

end

function love.load()
    baseDir = "LL/data"

    --love.window.setMode(0, 0, {fullscreen = true})
    love.graphics.setDefaultFilter("nearest", "nearest", 1)
    canvas = love.graphics.newCanvas(320,240)

    screenWidth,screenHeight = love.graphics.getDimensions()
    canvasWidth,canvasHeight = canvas:getDimensions()
    scale = math.min(screenWidth/canvasWidth , screenHeight/canvasHeight)

    paletteData = love.filesystem.read(baseDir.."/palette/ll.pal")

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

    tileImageData = loadSpriteSheet(baseDir.."/pictures/tiles/fgrass.spr")
    tileImage = love.graphics.newImage(tileImageData)

    lynnImageData = loadSpriteSheet(baseDir.."/pictures/char/lynn24.spr")
    lynnImage = love.graphics.newImage(lynnImageData)

    ssx = 64
    ssy = 120

    -- source = love.audio.newSource("fsun.it", "stream")
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

    love.graphics.draw(tileImage, 0, 0)
    love.graphics.draw(lynnImage, ssx, ssy)

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