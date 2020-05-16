require("game/load/loadxml")
require("game/gfx/convertgfx")
require("game/gfx/screen")
require("game/enemies")
require("game/engine--images")
require("game/engine--LL")
require("game/engine--gfx_LL")
require("game/ll_build")

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
  objectXmlCache = {}

  --Load map data
  map = LLSystem_LoadMap("data/map/forest_fall.map")
  map.imageHeader = getImageHeader(map.tileSetFileName)
  map.imageHeader.spriteBatches = {}
  table.insert(map.imageHeader.spriteBatches, imageToSpriteBatch(map.imageHeader.image))
  table.insert(map.imageHeader.spriteBatches, imageToSpriteBatch(map.imageHeader.image))
  table.insert(map.imageHeader.spriteBatches, imageToSpriteBatch(map.imageHeader.image))

  curRoom = 3

  set_up_room_enemies(map.rooms[curRoom].enemies)

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
  blit_scene()
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
