require("game/load/loadgfx")
require("game/load/loadmap")
require("game/load/loadxml")
require("game/gfx/convertgfx")
require("game/gfx/screen")
require("game/enemies")
require("game/map")

log = require("lib/log/log")
log.usecolor = false
log.level = "fatal"

function love.load()
  initializeScreen()
  computeScale()
  initializePaletteShader()
  tickPeriod = 1/60
  accumulator = 0.0

  imageHeaderCache = {}

  --The original game loaded all image data at once during a splash
  --screen, but I've chosen to move to a lazy loading design so that
  --the development of the port will go a bit faster. We could move back
  --to pre-loading later if we want to.
  --loadSpriteSheets()

  objectXmlCache = {}

  --Load map data
  map = loadMap("data/map/forest_fall.map")
  map.imageHeader = getImageHeader(map.tileSetFileName)
  map.imageHeader.spriteBatches = {}
  table.insert(map.imageHeader.spriteBatches, imageToSpriteBatch(map.imageHeader.image))
  table.insert(map.imageHeader.spriteBatches, imageToSpriteBatch(map.imageHeader.image))
  table.insert(map.imageHeader.spriteBatches, imageToSpriteBatch(map.imageHeader.image))

  curRoom = 3

  --enemies = {}
  log.level = "debug"
  log.outfile = "log.txt"
  set_up_room_enemies(map.rooms[curRoom].enemies)
  log.level = "fatal"

  --LLSystem_ObjectFromXML()
  --createEnemyAnimations()

  camera = {}
  camera.x = 0
  camera.y = 0
  camera.s = 4

  source = love.audio.newSource("data/music/fsun.it", "stream")
  source:setLooping(true)
  source:play()
end

function love.update(dt)
  accumulator = accumulator + dt
  if accumulator >= tickPeriod then
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

    --log.level = "debug"
    --updateEnemies()
    --log.level = "fatal"
    --updateEnemyAnimations()

    accumulator = accumulator - tickPeriod
  end
end

function love.draw()
  startDrawing()

  layoutLayers()

  drawLayers()

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

function love.resize(w, h)
  computeScale()
end

function love.keypressed(key, scancode, isrepeat)
  if key == "escape" then
     love.event.quit()
  end

  if love.keyboard.isDown("f12") then
    scaleOption = scaleOption + 1
    if scaleOption > #scaleOptions then
      scaleOption = 1
    end
    computeScale()
  end

  if (love.keyboard.isDown("ralt") and key == "return") or
     love.keyboard.isDown("f11") then
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
