require("game/cache")
require("game/gfx/convertgfx")
require("game/gfx/screen")
require("game/engine--images")
require("game/engine--LL")
require("game/engine--gfx_LL")
require("game/ll_build")
require("game/global_structures")

log = require("lib/log/log")
log.usecolor = false
log.level = "fatal"

function love.load()
  initializeScreen()
  computeScale()
  initializePaletteShader()
  tickPeriod = 1/60
  accumulator = 0.0
  timer = love.timer.getTime()

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

  --log.level = "debug"
  ll_global = create_ll_system()
  engine_init()
  set_up_room_enemies(map.rooms[curRoom].enemies)
  --log.level = "fatal"

  ll_global.current_cam = ll_global.hero
  ll_global.this_room.cx = 0
  ll_global.this_room.cy = 0

  --FIXME: Not a ported variable, just used for now
  speed = 4

  --source = love.audio.newSource("data/music/fsun.it", "stream")
  --source:setLooping(true)
  --source:play()
end

function love.update(dt)
  accumulator = accumulator + dt
  if accumulator >= tickPeriod then
    if love.keyboard.isDown("up") then
      ll_global.hero.coords.y = ll_global.hero.coords.y - speed
    end

    if love.keyboard.isDown("down") then
      ll_global.hero.coords.y = ll_global.hero.coords.y + speed
    end

    if love.keyboard.isDown("right") then
      ll_global.hero.coords.x = ll_global.hero.coords.x + speed
    end

    if love.keyboard.isDown("left") then
      ll_global.hero.coords.x = ll_global.hero.coords.x - speed
    end

    for u = 1, 4 do
      timer = love.timer.getTime()
      --log.level = "debug"
      enemy_main()
      --log.level = "fatal"
    end

    accumulator = accumulator - tickPeriod
  end
end

function love.draw()
  startDrawing()
  --log.level = "debug"
  blit_scene()
  --log.level = "fatal"
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
