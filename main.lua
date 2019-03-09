require('blob')

--Loads a palette file and returns a table with all of the rgb triplets
--of the file as tables. Each r,g,b component is transformed into the
--proper float 0 to 1 range that Love2D expects. If there is a problem
--loading the file, nil is returned. The palette file stores rgb triplets
--as b,g,r (backwards), and this is taken care of by this function.
function loadPalette(fileName)

    paletteBlob = loadBlob(fileName)

    if paletteBlob then
        palette = {}
        for x = 1,256 do
            local b,g,r = readByte(paletteBlob),
                          readByte(paletteBlob),
                          readByte(paletteBlob)
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
--It returns a table with all the frames of the spritesheet. Each frame
--is just an array of pixels where each pixel has x, y, r, g, b, a components in
--a simple Lua table. This data can be processed by a platform specific function
--later for transforming into a usable sprite object for display on the screen,
--but this function should never have to be modified for any future ports.
function loadSpriteSheet(fileName)

    --Load binary data of the .spr file all at once.
    local blob = loadBlob(fileName)
    if blob then

        --Create a table that can contain everything in the file.
        local spriteSheet = {}

        --Load the 16 byte header of the .spr file.
        spriteSheet.width = readInt(blob)
        spriteSheet.height = readInt(blob)
        spriteSheet.arraySize = readInt(blob)
        spriteSheet.frameCount = readInt(blob)
        spriteSheet.frames = {}

        for frameIndex = 1, spriteSheet.frameCount do

            --Create this frame.
            local frame = {}

            --Get the header for the current frame.
            frame.frameWidth = readShort(blob) / 8
            frame.frameHeight = readShort(blob)
            frame.pixels = {}

            --Copy the image data pixel by pixel, converting to our monochrome red format.
            for y=0,frame.frameHeight-1 do
                for x=0,frame.frameWidth-1 do
                    local bt = readByte(blob)
                    table.insert(frame.pixels, {x,y, bt/255, 0, 0, 1})
                end
            end
            table.insert(spriteSheet.frames, frame)
        end

        return spriteSheet
    end

end

--Converts a spriteSheet table into a usable Love2D spriteBatch.
function createSpriteBatch(spriteSheet)

    local imageX, imageY = 0, 0

    local imageData = love.image.newImageData(spriteSheet.width * spriteSheet.frameCount, spriteSheet.height)
    
    for frameIndex = 1, spriteSheet.frameCount do

        local frame = spriteSheet.frames[frameIndex]

        for k, pixel in pairs(frame.pixels) do
            imageData:setPixel(imageX+pixel[1],imageY+pixel[2],pixel[3],pixel[4],pixel[5],pixel[6])
        end
        imageX = imageX + spriteSheet.width
    end

    local image = love.graphics.newImage(imageData)
    local spriteBatch = love.graphics.newSpriteBatch(image, spriteSheet.frameCount)

    local quadX, quadY = 0, 0

    for i = 1, spriteSheet.frameCount do
        local quad = love.graphics.newQuad(
            quadX,
            quadY,
            spriteSheet.width,
            spriteSheet.height,
            spriteSheet.width * spriteSheet.frameCount,
            spriteSheet.height)
        spriteBatch:add(quad, quadX, quadY)
        quadX = quadX + spriteSheet.width
    end

    return spriteBatch

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

    local mapBlob = loadBlob(fileName)

    if mapBlob then

        map.fileName = readString(mapBlob)
        print("map.fileName: "..map.fileName)
        map.numEntries = readInt(mapBlob)
        print("map.numEntries: "..map.numEntries)
        map.numRooms = readInt(mapBlob)
        print("map.numRooms: "..map.numRooms)
        map.tileSetFileName = readString(mapBlob)
        print("map.tileSetFileName: "..map.tileSetFileName)

        map.rooms = {}

        for roomIndex = 1, 1 do --map.numRooms do

            local room = {}

            room.x = readInt(mapBlob)
            print("room.x: "..room.x)
            room.y = readInt(mapBlob)
            print("room.y: "..room.y)
            room.parallax = readInt(mapBlob)
            print("room.parallax: "..room.parallax)
            --TODO if parallax is nonzero, load parallax image.
            room.dark = readInt(mapBlob)
            print("room.dark: "..room.dark)
            room.numTeleports = readInt(mapBlob)
            print("room.numTeleports: "..room.numTeleports)
            room.song = readInt(mapBlob)
            print("room.song: "..room.song)
            room.songChanges = readInt(mapBlob)
            print("room.songChanges: "..room.songChanges)
            room.changeTo = readInt(mapBlob)
            print("room.changeTo: "..room.changeTo)
            room.reserved = readC(readInt, mapBlob, 18)
            print("#room.reserved: "..#room.reserved)

            room.teleports = {}

            for teleportIndex = 1, room.numTeleports do

                local teleport = {}

                teleport.x = readInt(mapBlob)
                print("teleport.x: "..teleport.x)
                teleport.y = readInt(mapBlob)
                print("teleport.y: "..teleport.y)
                teleport.w = readInt(mapBlob)
                print("teleport.w: "..teleport.w)
                teleport.h = readInt(mapBlob)
                print("teleport.h: "..teleport.h)
                teleport.toRoom = readInt(mapBlob)
                print("teleport.toRoom: "..teleport.toRoom)

                print("offset is: "..offset(mapBlob))

                teleport.toMap = readString(mapBlob)
                print("teleport.toMap: "..teleport.toMap)

                print("offset is: "..offset(mapBlob))

                teleport.dx = readInt(mapBlob)
                print("teleport.dx: "..teleport.dx)
                teleport.dy = readInt(mapBlob)
                print("teleport.dy: "..teleport.dy)
                teleport.dd = readInt(mapBlob)
                print("teleport.dd: "..teleport.dd)
                teleport.toSong = readInt(mapBlob)
                print("teleport.toSong: "..teleport.toSong)
                teleport.reserved = readC(readInt, mapBlob, 20)
                print("#teleport.reserved: "..#teleport.reserved)

                table.insert(room.teleports, teleport)
            end

            room.seq_here = readInt(mapBlob)

            room.numEnemies = readInt(mapBlob)

            room.enemies = {}

            for enemyIndex = 1, 1 do --room.numEnemies do

                local enemy = {}
                enemy.xOrigin = readInt(mapBlob)
                print("enemy.xOrigin: "..enemy.xOrigin)
                enemy.yOrigin = readInt(mapBlob)
                print("enemy.yOrigin: "..enemy.yOrigin)
                enemy.id = readString(mapBlob)
                print("enemy.id: "..enemy.id)
                enemy.direction = readInt(mapBlob)
                print("enemy.direction: "..enemy.direction)
                enemy.seqHere = readInt(mapBlob)
                print("enemy.seqHere: "..enemy.seqHere)
                enemy.spawnH = readShort(mapBlob)
                print("enemy.spawnH: "..enemy.spawnH)
                enemy.isHSet = readShort(mapBlob)
                print("enemy.isHSet: "..enemy.isHSet)
                enemy.chap = readInt(mapBlob)
                print("enemy.chap: "..enemy.chap)
                enemy.spawnD = readInt(mapBlob)
                print("enemy.spawnD: "..enemy.spawnD)
                enemy.isDSet = readInt(mapBlob)
                print("enemy.isDSet: "..enemy.isDSet)
                enemy.reserved_5 = readInt(mapBlob)
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

    tileSpriteSheet = loadSpriteSheet(baseDir.."/pictures/tiles/fgrass.spr")
    lynnSpriteSheet = loadSpriteSheet(baseDir.."/pictures/char/lynn24.spr")

    tileSpriteBatch = createSpriteBatch(tileSpriteSheet)
    lynnSpriteBatch = createSpriteBatch(lynnSpriteSheet)

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