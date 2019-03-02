function bytesToInt(b1, b2, b3, b4)
    return b1 + b2*256 + b3*65536 + b4*16777216
end

function bytesToShort(b1, b2)
    return b1 + b2*256
end

--Loads an entire file into a string and initializes an offset
--into that string starting at the beginning of the file. The
--data and this offset are returned as a two element table called
--a virtual file.
function loadVFile(fileName)
    local fileData = love.filesystem.read(fileName)
    if fileData then
        local vFile = {
            data = fileData,
            offset = 1
        }
        return vFile
    else
        return nil
    end
end

--Reads a 4 byte integer from a virtual file, advancing the offset
--in the vFile by 4.
function readInt(vFile)
    local offset = vFile.offset
    local int = bytesToInt(vFile.data:byte(offset, offset + 3))
    vFile.offset = vFile.offset + 4
    return int
end

--Reads a 2 byte integer from a virtual file, advancing the offset
--in the vFile by 2.
function readShort(vFile)
    local offset = vFile.offset
    local short = bytesToShort(vFile.data:byte(offset, offset + 1))
    vFile.offset = vFile.offset + 2
    return short
end

--Reads a byte from a virtual file, advancing the offset in the
--vFile by 1.
function readByte(vFile)
    local offset = vFile.offset
    local bt = vFile.data:byte(offset)
    vFile.offset = vFile.offset + 1
    return bt
end

--Loads a palette file and returns a table with all of the rgb triplets
--of the file as tables. Each r,g,b component is transformed into the
--proper float 0 to 1 range that Love2D expects. If there is a problem
--loading the file, nil is returned. The palette file stores rgb triplets
--as b,g,r (backwards), and this is taken care of by this function.
function loadPalette(fileName)

    paletteVFile = loadVFile(fileName)

    if paletteVFile then
        palette = {}
        for x = 1,256 do
            local b,g,r = readByte(paletteVFile),
                          readByte(paletteVFile),
                          readByte(paletteVFile)
            table.insert(palette,{r/255,g/255,b/255})
        end
        return palette
    else
        return nil
    end

end

--Loads a .spr spritesheet file. These are stored in FreeBASIC/QBasic
--GET/PUT format. It starts with a 16 byte header stating the width and height
--of the sprites, arraySize (unused?), and number of frames. Following this
--is each frame, each of which have a 4 byte header consisting of two unsigned
--short integers, the first being 8 times the width and the second being the height.
--Following this is one byte per pixel of the frame, being an index into a 256
--color palette.
function loadSpriteSheet(fileName)

    --Load binary data of the .spr file all at once.
    local vFile = loadVFile(fileName)
    if vFile then

        --Load the 16 byte header of the .spr file.
        local width = readInt(vFile)
        local height = readInt(vFile)
        local arraySize = readInt(vFile)
        local frames = readInt(vFile)

        --Create an image that can contain everything in the file.
        local imageData = love.image.newImageData(width * frames, height)
        local imageX, imageY = 0, 0

        for frameIndex = 1, frames do

            --Get the header for the current frame.
            local frameWidth = readShort(vFile) / 8
            local frameHeight = readShort(vFile)

            --Copy the image data pixel by pixel, converting to our monochrome red format.
            for y=0,height-1 do
                for x=0,width-1 do
                    local bt = readByte(vFile)
                    imageData:setPixel(imageX+x,imageY+y, bt/255, 0, 0, 1)
                end
            end
            imageX = imageX + width
        end

        local image = love.graphics.newImage(imageData)
        local spriteBatch = love.graphics.newSpriteBatch(image, frames)

        local quadX, quadY = 0, 0

        for i = 1, frames do
            local quad = love.graphics.newQuad(quadX, quadY, width, height, width * frames, height)
            spriteBatch:add(quad, quadX, quadY)
            quadX = quadX + width
        end

        return spriteBatch
    end

end

--Creates a palette canvas from a 256 color palette. The 256 color palette
--is expected to be a table of 3 entry tables, where each 3 entry table is an
--rgb triplet expected to express each component as a floating point number
--between 0 and 1 inclusive.
function createPaletteCanvas(palette)
    local paletteCanvas = love.graphics.newCanvas(256,1)
    love.graphics.setCanvas(paletteCanvas)
    for x = 1,256 do
        local r,g,b = palette[x][1],palette[x][2],palette[x][3]
        love.graphics.setColor(r,g,b)
        love.graphics.points(x, 1)
    end
    love.graphics.setCanvas()
    return paletteCanvas
end

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

    shader = love.graphics.newShader("palette_shader.fs")
    shader:send("u_paletteTexture", paletteCanvas)

    tileSpriteBatch = loadSpriteSheet(baseDir.."/pictures/tiles/fgrass.spr")

    lynnSpriteBatch = loadSpriteSheet(baseDir.."/pictures/char/lynn24.spr")

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