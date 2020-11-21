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

  ll_global = create_ll_system()

  --Load map data
  ll_global.map = LLSystem_LoadMap("data/map/forest_fall.map")
  ll_global.map.imageHeader = getImageHeader(ll_global.map.tileSetFileName)
  ll_global.map.imageHeader.spriteBatches = {}
  ll_global.map.imageHeader.spriteBatches[0] = imageToSpriteBatch(ll_global.map.imageHeader.image)
  ll_global.map.imageHeader.spriteBatches[1] = imageToSpriteBatch(ll_global.map.imageHeader.image)
  ll_global.map.imageHeader.spriteBatches[2] = imageToSpriteBatch(ll_global.map.imageHeader.image)

  ll_global.this_room.i = 2

  --NOTE: Not certain if we will keep this structure,
  --but in the original source code, init_splash would show the splash
  --screen but also load all assets, including sound. We might refactor
  --this later.
  --log.level = "debug"
  init_splash()
  --log.level = "fatal"

  --log.level = "debug"
  engine_init()
  --log.level = "fatal"

  --log.level = "debug"
  set_up_room_enemies(now_room().enemies, now_room().enemy)
  --log.level = "fatal"

  ll_global.hero.coords.x = 320
  ll_global.hero.coords.y = 100

  --Hard-code Lynn's weapon to the sapling for now.
  ll_global.hero_only.weapon = 0

  ll_global.current_cam = ll_global.hero
  ll_global.this_room.cx = 0
  ll_global.this_room.cy = 0

  --FIXME: Not a ported variable, just used for now
  speed = 4

  --Variables not related to the Lynn's Legacy engine
  bhist = {}
  dbgrects = {}

  source = love.audio.newSource("data/music/world.it", "stream")
  source:setLooping(true)
  source:play()
end

function love.update(dt)
  dbgrects = {}
  updateBHist("x")
  accumulator = accumulator + dt
  if accumulator >= tickPeriod then
    -- if love.keyboard.isDown("up") then
    --   ll_global.hero.coords.y = ll_global.hero.coords.y - speed
    -- end
    --
    -- if love.keyboard.isDown("down") then
    --   ll_global.hero.coords.y = ll_global.hero.coords.y + speed
    -- end
    --
    -- if love.keyboard.isDown("right") then
    --   ll_global.hero.coords.x = ll_global.hero.coords.x + speed
    -- end
    --
    -- if love.keyboard.isDown("left") then
    --   ll_global.hero.coords.x = ll_global.hero.coords.x - speed
    -- end

    accumulator = accumulator - tickPeriod
  end
  local loops = love.window.getVSync() and 4 or 1
  for u = 1, loops do
    timer = love.timer.getTime()
    --log.level = "debug"
    enemy_main()
    --log.level = "fatal"
    log.level = "debug"
    hero_main()
    log.level = "fatal"
  end
end

function love.draw()
  startDrawing()
  log.level = "debug"
  blit_scene()

  for key, dbgrect in pairs(dbgrects) do
    local x, y, w, h = dbgrect.x, dbgrect.y, dbgrect.w, dbgrect.h
    love.graphics.setColor(dbgrect.c, 0.0, 0.0, 1.0)
    love.graphics.rectangle("fill", x, y, w, h)
  end

  -- local x, y, w, h = ll_global.hero.coords.x - ll_global.this_room.cx, ll_global.hero.coords.y - ll_global.this_room.cy, 16, 16
  -- love.graphics.setColor(.03, 0.0, 0.0, 1.0)
  -- love.graphics.rectangle("fill", x, y, w, h)

  log.level = "fatal"
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

function bpressed(key)
  return bhist[key] and bhist[key][1] == false and bhist[key][2] == true
end

function updateBHist(key)
  if bhist[key] == nil then
    bhist[key] = {false, love.keyboard.isDown(key)}
  else
    table.remove(bhist[key], 1)
    table.insert(bhist[key], love.keyboard.isDown(key))
  end
end
