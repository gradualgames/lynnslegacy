require("game/cache")
require("game/gfx/convertgfx")
require("game/gfx/screen")
require("game/engine--images")
require("game/engine--LL")
require("game/engine--gfx_LL")
require("game/ll_build")
require("game/global_structures")
require("game/utility")

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

  log.level = "debug"
  init_splash()
  log.level = "fatal"

  log.level = "debug"
  engine_init()
  log.level = "fatal"

  log.level = "debug"
  ll_main_entry()
  log.level = "fatal"

  --Variables not related to the original codebase
  bhist = {}
  dbgrects = {}
end

function love.update(dt)
  dbgrects = {}
  updateBHist("x")
  accumulator = accumulator + dt
  if accumulator >= tickPeriod then
    accumulator = accumulator - tickPeriod
  end
  local loops = love.window.getVSync() and 4 or 1
  for u = 1, loops do
    timer = love.timer.getTime()
    --log.level = "debug"
    enemy_main()
    --log.level = "fatal"
    log.level = "debug"
    play_sequence(ll_global)
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
    local x, y, w, h = dbgrect.x, dbgrect.y, dbgrect.w, dbgrect.h
    love.graphics.setColor(dbgrect.c, 0.0, 0.0, 1.0)
    love.graphics.rectangle("fill", x, y, w, h)
  end

  -- local x, y, w, h = ll_global.hero.coords.x - ll_global.this_room.cx, ll_global.hero.coords.y - ll_global.this_room.cy, 16, 16
  -- love.graphics.setColor(.03, 0.0, 0.0, 1.0)
  -- love.graphics.rectangle("fill", x, y, w, h)

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
