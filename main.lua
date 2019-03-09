BlobReader = require('BlobReader')

--Loads an entire file into a string and returns an object
--which acts as a virtual file for reading binary data.
function loadVFile(fileName)
    local file = io.open(fileName, 'rb')
    local blob = BlobReader(file:read('*all'))
    file:close()
    return blob
end

--Returns the offset currently pointed to in a virtual file.
function offset(vFile)
    return vFile._readPtr
end

--Reads a 4 byte integer from a virtual file, advancing the offset
--in the vFile by 4.
function readInt(vFile)
    return vFile:u32()
end

--Reads a 2 byte integer from a virtual file, advancing the offset
--in the vFile by 2.
function readShort(vFile)
    return vFile:u16()
end

--Reads a byte from a virtual file, advancing the offset in the
--vFile by 1.
function readByte(vFile)
    return vFile:u8()
end

--Reads a string from a virtual file, advancing the offset
--by the length of the string (the header of this string) + 2.
function readString(vFile)
    return vFile:raw(vFile:u16())
end

--Reads a string from a virtual file, where we
--already know the length of string to read.
function readStringL(vFile, length)
    return vFile:raw(length)
end

--Repeats a given read function count times with the
--passed vFile. Returns a table of the values returned
--from readF.
function readC(readF, vFile, count)
    local field = {}
    for c = 1, count do
        local value = readF(vFile)
        table.insert(field, value)
    end
    return field
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

--Loads a Lynn's Legacy .map file. Assumes it is an uncompressed .map file.
--The original set of files were zlib compressed. I ran them through the
--offzip utility to decompress them.
--At the time of this writing, this function will be incomplete as we are only
--concerned with loading all the data in the map file; we will then slowly
--piece together how to use all that data later (such as loading and placing
--enemies, determining what sequences are, etc.)
function loadMap(fileName)

    local map = {}

    local mapVFile = loadVFile(fileName)

    if mapVFile then

        map.fileName = readString(mapVFile)
        print("map.fileName: "..map.fileName)
        map.numEntries = readInt(mapVFile)
        print("map.numEntries: "..map.numEntries)
        map.numRooms = readInt(mapVFile)
        print("map.numRooms: "..map.numRooms)
        map.tileSetFileName = readString(mapVFile)
        print("map.tileSetFileName: "..map.tileSetFileName)

        map.rooms = {}

        for roomIndex = 1, 1 do --map.numRooms do

            local room = {}

            room.x = readInt(mapVFile)
            print("room.x: "..room.x)
            room.y = readInt(mapVFile)
            print("room.y: "..room.y)
            room.parallax = readInt(mapVFile)
            print("room.parallax: "..room.parallax)
            --TODO if parallax is nonzero, load parallax image.
            room.dark = readInt(mapVFile)
            print("room.dark: "..room.dark)
            room.numTeleports = readInt(mapVFile)
            print("room.numTeleports: "..room.numTeleports)
            room.song = readInt(mapVFile)
            print("room.song: "..room.song)
            room.songChanges = readInt(mapVFile)
            print("room.songChanges: "..room.songChanges)
            room.changeTo = readInt(mapVFile)
            print("room.changeTo: "..room.changeTo)
            room.reserved = readC(readInt, mapVFile, 18)
            print("#room.reserved: "..#room.reserved)

            room.teleports = {}

            for teleportIndex = 1, room.numTeleports do

                local teleport = {}

                teleport.x = readInt(mapVFile)
                print("teleport.x: "..teleport.x)
                teleport.y = readInt(mapVFile)
                print("teleport.y: "..teleport.y)
                teleport.w = readInt(mapVFile)
                print("teleport.w: "..teleport.w)
                teleport.h = readInt(mapVFile)
                print("teleport.h: "..teleport.h)
                teleport.toRoom = readInt(mapVFile)
                print("teleport.toRoom: "..teleport.toRoom)

                print("offset is: "..offset(mapVFile))

                teleport.toMap = readString(mapVFile)
                print("teleport.toMap: "..teleport.toMap)

                print("offset is: "..offset(mapVFile))

                teleport.dx = readInt(mapVFile)
                print("teleport.dx: "..teleport.dx)
                teleport.dy = readInt(mapVFile)
                print("teleport.dy: "..teleport.dy)
                teleport.dd = readInt(mapVFile)
                print("teleport.dd: "..teleport.dd)
                teleport.toSong = readInt(mapVFile)
                print("teleport.toSong: "..teleport.toSong)
                teleport.reserved = readC(readInt, mapVFile, 20)
                print("#teleport.reserved: "..#teleport.reserved)

                table.insert(room.teleports, teleport)
            end

            room.seq_here = readInt(mapVFile)

            room.numEnemies = readInt(mapVFile)

            room.enemies = {}

            for enemyIndex = 1, 1 do --room.numEnemies do

                local enemy = {}
                enemy.xOrigin = readInt(mapVFile)
                print("enemy.xOrigin: "..enemy.xOrigin)
                enemy.yOrigin = readInt(mapVFile)
                print("enemy.yOrigin: "..enemy.yOrigin)
                enemy.id = readString(mapVFile)
                print("enemy.id: "..enemy.id)
                enemy.direction = readInt(mapVFile)
                print("enemy.direction: "..enemy.direction)
                enemy.seqHere = readInt(mapVFile)
                print("enemy.seqHere: "..enemy.seqHere)
                enemy.spawnH = readShort(mapVFile)
                print("enemy.spawnH: "..enemy.spawnH)
                enemy.isHSet = readShort(mapVFile)
                print("enemy.isHSet: "..enemy.isHSet)
                enemy.chap = readInt(mapVFile)
                print("enemy.chap: "..enemy.chap)
                enemy.spawnD = readInt(mapVFile)
                print("enemy.spawnD: "..enemy.spawnD)
                enemy.isDSet = readInt(mapVFile)
                print("enemy.isDSet: "..enemy.isDSet)
                enemy.reserved_5 = readInt(mapVFile)
                print("enemy.reserved_5: "..enemy.reserved_5)

                --TODO: Continue transcribing enemy load loop.
            end

        end

    end

    return map

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

    map = loadMap(baseDir.."/mapu/forest_fall.map")

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