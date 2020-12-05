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
  initializeTimer()
  initCache()

  ll_global = create_ll_system()

  --log.level = "debug"
  init_splash()
  --log.level = "fatal"

  --log.level = "debug"
  engine_init()
  --log.level = "fatal"

  --log.level = "debug"
  ll_main_entry()
  --log.level = "fatal"

  --Variables not related to the original codebase
  bhist = {}
  dbgrects = {}
end

function love.update(dt)
  dbgrects = {}
  updateBHist("x")
  updateBHist("space")
  for u = 1, loops do
    timerUpdate()
    --timer = timer + .005
    log.level = "debug"
    enemy_main()
    log.level = "fatal"
    log.level = "debug"
    play_sequence(ll_global)
    log.level = "fatal"
    log.level = "debug"
    hero_main()
    log.level = "fatal"
  end
end

function love.draw()
  startDrawing()
  log.level = "debug"
  blit_scene()
  log.level = "fatal"

  for key, dbgrect in pairs(dbgrects) do
    local x, y, w, h = dbgrect.x, dbgrect.y, dbgrect.w, dbgrect.h
    love.graphics.setColor(dbgrect.c, 0.0, 0.0, 1.0)
    love.graphics.rectangle("fill", x, y, w, h)
  end

  -- local x, y, w, h = ll_global.hero.coords.x - ll_global.this_room.cx, ll_global.hero.coords.y - ll_global.this_room.cy, 16, 16
  -- love.graphics.setColor(.03, 0.0, 0.0, 1.0)
  -- love.graphics.rectangle("fill", x, y, w, h)

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

--Initializes the window, sets up some defaults and
--initializes the main drawing canvas, which is a 320x200
--canvas to simulate SCREEN 13.
function initializeScreen()
  love.window.setTitle("Lynn's Legacy")
  love.window.setMode(640, 400, {resizable=true, minwidth=320, minheight=200})
  love.window.setVSync(1)
  love.mouse.setVisible(false)
  love.graphics.setDefaultFilter("nearest", "nearest", 1)
  scaleOptions = {
    function()
      retrieveDimensions()
      scale = math.min(screenWidth / canvasWidth, screenHeight / canvasHeight)
    end,
    function() scale = 1 end,
    function() scale = 2 end,
    function() scale = 3 end,
    function() scale = 4 end,
    function() scale = 5 end,
    function() scale = 6 end
  }
  scaleOption = 1
  canvas = love.graphics.newCanvas(320,200)
end

--Initializes our global palette, paletteCanvas and
--palette shader. This shader simulates a 256 color graphics mode.
--Palette effects can be achieved simply by writing new colors to the
--palette canvas. The palette canvas is a 256x1 texture where each
--pixel is a color. Then, all graphics that are loaded from spritesheets
--are converted such that the red component is an index into this palette
--texture.
function initializePaletteShader()
  masterPalette, palette = loadPalette("data/palette/ll.pal")
  paletteCanvas = paletteToCanvas(palette)
  shader = love.graphics.newShader("shader/palette_shader.fs")
  shader:send("paletteTexture", paletteCanvas)
end

function retrieveDimensions()
  screenWidth, screenHeight = love.graphics.getDimensions()
  canvasWidth, canvasHeight = canvas:getDimensions()
end

--Computes how the main canvas should be scaled based on the dimensions
--of the current screen. This is intended to be used at startup and
--when toggling between windowed and full screen modes.
function computeScale()
  scaleOptions[scaleOption]()
end

--Should be called before drawing anything to the main canvas.
function startDrawing()
  love.graphics.setCanvas(canvas)
  love.graphics.clear()
end

--Should be called after drawing everything to the main canvas.
function doneDrawing()
  love.graphics.setCanvas(paletteCanvas)
  for x = 0, 255 do
    love.graphics.setColor(palette[x][0], palette[x][1], palette[x][2])
    love.graphics.points(x + .5, .5)
  end
  love.graphics.setColor(1, 1, 1)
  love.graphics.setCanvas()
  love.graphics.setShader(shader)
  love.graphics.push()
  --Move to the appropiate top left corner.
  retrieveDimensions()
  love.graphics.translate(math.floor(
    (screenWidth - canvasWidth * scale) / 2),
    math.floor((screenHeight - canvasHeight * scale) / 2))
  love.graphics.scale(scale,scale)
  love.graphics.draw(canvas)
  love.graphics.pop()
  love.graphics.setShader()
end

function initCache()
  imageHeaderCache = {}
  objectXmlCache = {}
end

--Returns a loaded imageHeader from the global imageHeaderCache
--cache, or, if there is no image header for the specified file
--name, loads the image header.
function getImageHeader(fileName)

  local imageHeader = imageHeaderCache[fileName]
  if not imageHeader then
    imageHeader = LLSystem_ImageLoad(fileName)
    imageHeaderCache[fileName] = imageHeader
  end
  return imageHeader

end

--Returns a loaded xml object from the global objects xml
--cache, or, if there is no xml obect for the specified file
--name, loads it.
function getObjectXml(fileName)

  local objectXml = objectXmlCache[fileName]
  if not objectXml then
    objectXml = love.filesystem.read(fileName)
    objectXmlCache[fileName] = objectXml
  end
  return objectXml

end

--Converts an image to a sprite batch.
function imageToSpriteBatch(image)
  return love.graphics.newSpriteBatch(image)
end

--Creates a palette canvas from a 256 color palette. The 256 color palette
--is expected to be a table of 3 entry tables, where each 3 entry table is an
--rgb triplet expected to express each component as a floating point number
--between 0 and 1 inclusive.
function paletteToCanvas(palette)
  local paletteCanvas = love.graphics.newCanvas(256,1)
  love.graphics.setCanvas(paletteCanvas)
  for x = 0,255 do
    local r,g,b = palette[x][0],palette[x][1],palette[x][2]
    love.graphics.setColor(r,g,b)
    love.graphics.points(x + .5, .5)
  end
  love.graphics.setCanvas()
  return paletteCanvas
end

--Loads a palette file and returns a table with all of the rgb triplets
--of the file as tables. Each r,g,b component is transformed into the
--proper float 0 to 1 range that Love2D expects. If there is a problem
--loading the file, nil is returned. The palette file stores rgb triplets
--as b,g,r (backwards), and this is taken care of by this function.
function loadPalette(fileName)

  local paletteBlob = loadBlob(fileName)

  if paletteBlob then
    local palette, masterPalette = {}, {}
    for x = 0, 255 do
      local b,g,r = readByte(paletteBlob) / 255,
              readByte(paletteBlob) / 255,
              readByte(paletteBlob) / 255
      masterPalette[x] = {[0] = r, g, b}
      palette[x] = {[0] = r, g, b}
    end
    return masterPalette, palette
  else
    return nil
  end

end

function initializeTimer()
  timer = love.timer.getTime()
  if love.window.getVSync() == 1 then
    loops = 16
    timerInc = 1 / (loops * 60)
    timerUpdate = function() timer = timer + timerInc end
  else
    loops = 1
    timerUpdate = function() timer = love.timer.getTime() end
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
