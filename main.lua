require("game/loadgfx")
require("game/loadxml")
require("game/convertgfx")
require("game/update")
require("game/screen")

log = require("lib/log/log")
log.usecolor = false
log.level = "fatal"

function love.load()
	initializeScreen()
	computeScale()
	initializePaletteShader()

	spriteSheetCache = {}

	--The original game loaded all image data at once during a splash
	--screen, but I've chosen to move to a lazy loading design so that
	--the development of the port will go a bit faster. We could move back
	--to pre-loading later if we want to.
	--loadSpriteSheets()

	objectXmlCache = {}

	--Load map data
	map = loadMap("data/map/forest_fall.map")

	map.spriteSheet = getSpriteSheet(map.tileSetFileName)
	map.spriteSheetImage = spriteSheetToImage(map.spriteSheet)
	map.spriteBatchLayers = {}

	for layer = 1, 3 do
		local spriteBatch = imageToSpriteBatch(map.spriteSheetImage)
		table.insert(map.spriteBatchLayers, spriteBatch)
	end

  curRoom = 3

  enemies = {}

  log.level = "debug"
	log.outfile = "log.txt"
	for i = 1, map.rooms[curRoom].numEnemies do
		local roomEnemy = map.rooms[curRoom].enemies[i]
		local enemy = {}
		if roomEnemy.id == "data/object/gcopter.xml" then
			enemy.id = roomEnemy.id
			if objectXmlCache[roomEnemy.id] == nil then
				log.debug("Loading copter xml.")
				local copterXml = getObjectXml(roomEnemy.id)
				log.debug("Loading copter sprite sheets.")
				enemy.spriteBatches = {}
				for spriteKey, spriteValue in pairs(copterXml.sprite) do
					if spriteValue.filename then
						log.debug(" spriteValue.filename: "..spriteValue.filename)
						local fixedFileName = string.gsub(spriteValue.filename, "\\", "/")
						log.debug(" fixedFileName: "..fixedFileName)
						local spriteSheet = getSpriteSheet(fixedFileName)
						local image = spriteSheetToImage(spriteSheet)
						local spriteBatch = imageToSpriteBatch(image)
						layoutSpriteBatch(spriteSheet, spriteBatch)
						table.insert(enemy.spriteBatches, spriteBatch)
					end
				end
				table.insert(enemies, enemy)
			end
		end
	end
	log.level = "fatal"

	camera = {}
	camera.x = 0
	camera.y = 0
	camera.s = 4

	-- source = love.audio.newSource(baseDir.."data/music/fsun.it", "stream")
	-- source:setLooping(true)
	-- source:play()
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

	updateRoom(camera, map.rooms[curRoom], 1, map.spriteSheet, map.spriteBatchLayers[1])
	updateRoom(camera, map.rooms[curRoom], 2, map.spriteSheet, map.spriteBatchLayers[2])
	updateRoom(camera, map.rooms[curRoom], 3, map.spriteSheet, map.spriteBatchLayers[3])
end

function love.draw()
	startDrawing()

	love.graphics.draw(map.spriteBatchLayers[1])
	love.graphics.draw(map.spriteBatchLayers[2])
	love.graphics.draw(map.spriteBatchLayers[3])

  log.level = "debug"
  log.debug(enemies[1].id)
  love.graphics.draw(enemies[1].spriteBatches[1])

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
