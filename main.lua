require("game/loadgfx")
require("game/loadmap")
require("game/loadxml")
require("game/loadenemies")
require("game/convertgfx")
require("game/drawenemies")
require("game/drawmap")
require("game/screen")

log = require("lib/log/log")
log.usecolor = false
log.level = "fatal"

function love.load()
  initializeScreen()
  computeScale()
  initializePaletteShader()

  spriteObjectCache = {}

  --The original game loaded all image data at once during a splash
  --screen, but I've chosen to move to a lazy loading design so that
  --the development of the port will go a bit faster. We could move back
  --to pre-loading later if we want to.
  --loadSpriteSheets()

  objectXmlCache = {}

  --Load map data
  map = loadMap("data/map/forest_fall.map")
  map.spriteObject = getSpriteObject(map.tileSetFileName)

  curRoom = 3

  enemies = {}

  loadEnemies()

  camera = {}
  camera.x = 0
  camera.y = 0
  camera.s = 4

  --source = love.audio.newSource("data/music/fsun.it", "stream")
  --source:setLooping(true)
  --source:play()
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

  drawRoom(camera, map.rooms[curRoom], 1, map.spriteObject.spriteSheet, map.spriteObject.spriteBatches[1])
  drawRoom(camera, map.rooms[curRoom], 2, map.spriteObject.spriteSheet, map.spriteObject.spriteBatches[2])
  drawRoom(camera, map.rooms[curRoom], 3, map.spriteObject.spriteSheet, map.spriteObject.spriteBatches[3])
end

function love.draw()
  startDrawing()

  love.graphics.draw(map.spriteObject.spriteBatches[1])
  love.graphics.draw(map.spriteObject.spriteBatches[2])
  drawEnemies()
  love.graphics.draw(map.spriteObject.spriteBatches[3])

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
