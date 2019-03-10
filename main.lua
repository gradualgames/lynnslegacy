require("game/load")
require("game/convert")
require("game/update")
require("game/screen")
log = require("lib/log")
log.usecolor = false
log.level = "fatal"

function love.load()
    love.window.setTitle("Lynn's Legacy")
    love.graphics.setDefaultFilter("nearest", "nearest", 1)
    canvas = love.graphics.newCanvas(320,200)
    computeScale()

    baseDir = "LL/"

    palette = loadPalette(baseDir.."data/palette/ll.pal")
    paletteCanvas = paletteToCanvas(palette)

    shader = love.graphics.newShader("shader/palette_shader.fs")
    shader:send("paletteTexture", paletteCanvas)

    --Load map data
    map = loadMap(baseDir.."data/map/forest_fall.map")

    map.spriteSheet = loadSpriteSheet(baseDir..map.tileSetFileName)
    map.spriteSheetImage = spriteSheetToImage(map.spriteSheet)
    map.spriteBatchLayers = {}

    for layer = 1, 3 do
        local spriteBatch = imageToSpriteBatch(map.spriteSheetImage)
        table.insert(map.spriteBatchLayers, spriteBatch)
    end

    camera = {}
    camera.x = 0
    camera.y = 0
    camera.s = 4

    -- source = love.audio.newSource(baseDir.."data/music/fsun.it", "stream")
    -- source:setLooping(true)
    -- source:play()
end

function love.update(dt)

    if love.keyboard.isDown("up") then
        camera.y = camera.y - camera.s
    end

    if love.keyboard.isDown("down") then
        camera.y = camera.y + camera.s
    end

    if love.keyboard.isDown("right") then
        camera.x = camera.x + camera.s
    end

    if love.keyboard.isDown("left") then
        camera.x = camera.x - camera.s
    end

    updateRoom(camera, map.rooms[3], 1, map.spriteSheet, map.spriteBatchLayers[1])
    updateRoom(camera, map.rooms[3], 2, map.spriteSheet, map.spriteBatchLayers[2])
    updateRoom(camera, map.rooms[3], 3, map.spriteSheet, map.spriteBatchLayers[3])

end

function love.draw()
    startDrawing()

    love.graphics.draw(map.spriteBatchLayers[1])
    love.graphics.draw(map.spriteBatchLayers[2])
    love.graphics.draw(map.spriteBatchLayers[3])

    --Imitating fade to red from Lynn's Legacy
    -- love.graphics.setCanvas(paletteCanvas)
    -- for x = 1,256 do
    --     r,g,b = palette[x][1],palette[x][2],palette[x][3]
    --     palette[x][1] = math.min(palette[x][1] + .01, 1)
    --     palette[x][2] = math.max(palette[x][2] - .04, 0)
    --     palette[x][3] = math.max(palette[x][3] - .04, 0)
    --     love.graphics.setColor(r,g,b)
    --     love.graphics.points(x, 1)
    -- end

    doneDrawing()
end

function love.keypressed(key, scancode, isrepeat)

    if key == "escape" then
       love.event.quit()
    end

    if love.keyboard.isDown("ralt") and key == "return" then
        if not fullscreen then
            love.window.setFullscreen(true, "desktop")
            fullscreen = true
        else
            love.window.setFullscreen(false, "desktop")
            fullscreen = false
        end
        computeScale()
    end
end
