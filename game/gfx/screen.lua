--Initializes the window, sets up some defaults and
--initializes the main drawing canvas, which is a 320x200
--canvas to simulate SCREEN 13.
function initializeScreen()
  love.window.setTitle("Lynn's Legacy")
  love.window.setMode(640, 400, {resizable=true, minwidth=320, minheight=200})
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
  palette = loadPalette("data/palette/ll.pal")
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
