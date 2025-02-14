--PROF_CAPTURE = true
--prof = require("jprof")
baton = require("lib.baton.baton")
require("game.engine_images")
require("game.engine_LL")
require("game.engine_gfx_LL")
require("game.ll_build")
require("game.matrices")
require("game.global_structures")
require("game.utility")

log = require("lib.log.log")
log.usecolor = false
log.level = "fatal"

function love.load()
  initScreen()
  initScale()
  initPaletteShader()
  initDraw()
  initCache()
  initInput()
  init_vector_pool()
  init_vector_pair_pool()
  init_tile_quad_pool()
  init_quad_pool()
  init_main()

  ll_global = create_ll_system()
  init_splash()
  engine_init()
  ll_main_entry()
  --prof.connect()
end

function love.draw()
  startDrawing()
  local success, result = coroutine.resume(main_crt)
  if not success then
    error(debug.traceback(main_crt, result))
  end
  doneDrawing()
end

function love.resize(w, h)
  scaleOptions[scaleOption]()
end

function love.keypressed(key, scancode, isrepeat)
  if not key:find("shift") then
    if love.keyboard.isDown("lshift") or love.keyboard.isDown("rshift") then
      table.insert(keybuffer, key:upper())
    else
      table.insert(keybuffer, key)
    end
  end

  if love.keyboard.isDown("f12") then
    scaleOption = scaleOption + 1
    if scaleOption > #scaleOptions then
      scaleOption = 1
    end
    scaleOptions[scaleOption]()
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
    scaleOptions[scaleOption]()
  end
end

function love.quit()
  --prof.write("prof.mpack")
end

function init_main()
  main_crt = coroutine.create(main)
end

function main()
  timer = love.timer.getTime()  
  local timerInc = .001
  local maxLoops = 20
  repeat
    --prof.enabled(true)
    --prof.push("frame")
    local currentTime = love.timer.getTime()
    local loop = true    
    local loops = 0
    while loop do
      loop = timer < currentTime and loops < maxLoops
      reset_vector_pool()
      reset_vector_pair_pool()
      reset_tile_quad_pool()
      reset_quad_pool()
      input:update()
      timer = timer + timerInc
      --timer = timer + .005
      --prof.push("enemy_main")
      enemy_main()
      --prof.pop("enemy_main")
      --prof.push("hero_main")
      hero_main()
      --prof.pop("hero_main")
      --prof.push("play_sequence")
      play_sequence(ll_global)
      --prof.pop("play_sequence")
      --prof.push("blit_scene")
      draw = loop and noop or love.graphics.draw
      blit_scene()
      --prof.pop("blit_scene")
      loops = loops + 1
    end
    --prof.pop("frame")
    --prof.enabled(false)
    if not stillPlaying() then break end

    coroutine.yield()
  until false
  LL_RollCredits()
  love.event.quit()
end

--Initializes the window, sets up some defaults and
--initializes the main drawing canvas, which is a 320x200
--canvas to simulate SCREEN 13.
function initScreen()
  love.window.setTitle("Lynn's Legacy")
  love.window.setMode(640, 400, {resizable = true, minwidth = 320, minheight = 200})
  love.window.setFullscreen(true, "desktop")
  fullscreen = true
  love.window.setVSync(1)
  love.mouse.setVisible(false)
  love.graphics.setDefaultFilter("nearest", "nearest", 1)
  canvas = love.graphics.newCanvas(320, 200)
  savedCanvas = love.graphics.newCanvas(320, 200)
  clearmode = true
  --used by screenQuake
  tripPosition = 0
  tripOffset = create_vector()
end

function initScale()
  scaleOptions = {}
  table.insert(scaleOptions,
    function()
      retrieveDimensions()
      scale = math.min(screenWidth / canvasWidth, screenHeight / canvasHeight)
    end)
  for s = 1, 6 do
    table.insert(scaleOptions, function() scale = s end)
  end
  scaleOption = 1
  scaleOptions[scaleOption]()
end

--Initializes our global palette, paletteCanvas and
--palette shader. This shader simulates a 256 color graphics mode.
--Palette effects can be achieved simply by writing new colors to the
--palette canvas. The palette canvas is a 256x1 texture where each
--pixel is a color. Then, all graphics that are loaded from spritesheets
--are converted such that the red component is an index into this palette
--texture.
function initPaletteShader()
  masterPalette, palette = loadPalette("data/palette/ll.pal")
  paletteCanvas = love.graphics.newCanvas(256, 1)
  shader = love.graphics.newShader("shader/palette_shader.fs")
  shader:send("paletteTexture", paletteCanvas)
end

function initCache()
  imageHeaderCache = {}
  objectXmlCache = {}
end

function initDraw()
  --Allows us to temporarily make all drawing no-op if needed
  draw = love.graphics.draw
end

function initInput()
  keybuffer = {}

  input = baton.new {
    controls = {
      left = {'key:left', 'key:a', 'axis:leftx-', 'button:dpleft'},
      right = {'key:right', 'key:d', 'axis:leftx+', 'button:dpright'},
      up = {'key:up', 'key:w', 'axis:lefty-', 'button:dpup'},
      down = {'key:down', 'key:s', 'axis:lefty+', 'button:dpdown'},
      attack = {'key:x', 'button:a'},
      item = {'key:z', 'button:x'},
      action = {'key:space', 'button:b'},
      map = {'key:m', 'button:y'},
      pause = {'key:escape', 'button:start'},
      cycleleft = {'key:[', 'button:leftshoulder'},
      cycleright = {'key:]', 'button:rightshoulder'}
    },
    pairs = {
      move = {'left', 'right', 'up', 'down'}
    },
    joystick = love.joystick.getJoysticks()[1],
  }
end

--Should be called before drawing anything to the main canvas.
function startDrawing()
  love.graphics.setCanvas(canvas)
  if clearmode then love.graphics.clear() end
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
  love.graphics.translate(
    math.floor((screenWidth - canvasWidth * scale) / 2),
    math.floor((screenHeight - canvasHeight * scale) / 2))
  love.graphics.scale(scale, scale)
  love.graphics.draw(canvas, tripOffset.x, tripOffset.y)
  love.graphics.pop()
  love.graphics.setShader()
  love.graphics.setCanvas(savedCanvas)
  love.graphics.clear()
  love.graphics.draw(canvas)
  love.graphics.setCanvas()
end

function retrieveDimensions()
  screenWidth, screenHeight = love.graphics.getDimensions()
  canvasWidth, canvasHeight = canvas:getDimensions()
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
