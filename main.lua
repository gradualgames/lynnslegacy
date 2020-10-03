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

  ll_global = create_ll_system()

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
  set_up_room_enemies(map.room[curRoom].enemy)
  --log.level = "fatal"

  ll_global.hero.coords.x = 320
  ll_global.hero.coords.y = 480

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
    log.level = "debug"
    enemy_main()
    log.level = "fatal"
    --log.level = "debug"
    hero_main()
    --log.level = "fatal"
  end
end

function love.draw()
  startDrawing()
  --log.level = "debug"
  blit_scene()

  for key, dbgrect in pairs(dbgrects) do
    love.graphics.setColor(1.0, 1.0, 1.0, 1.0)
    local rectx = dbgrect.x * 16 - ll_global.this_room.cx
    local recty = dbgrect.y * 16 - ll_global.this_room.cy
    love.graphics.rectangle("fill", rectx, recty, 16, 16)
  end

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
