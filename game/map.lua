--Updates a room using the tile indices from the room to arrange
--the spritebatch for drawing, based on a sprite sheet.
function layoutLayer(camera, room, layer, spriteSheet, spriteBatch)

  spriteBatch:clear()
  local topLeftMapX = math.floor(camera.x / spriteSheet.width)
  local topLeftMapY = math.floor(camera.y / spriteSheet.height)
  local topLeftScreenX = -(camera.x % spriteSheet.width)
  local topLeftScreenY = -(camera.y % spriteSheet.height)
  local mapX = topLeftMapX
  local mapY = topLeftMapY
  local screenX = topLeftScreenX
  local screenY = topLeftScreenY
  for y = 1, 14 do
    mapX = topLeftMapX
    screenX = topLeftScreenX
    for x = 1, 21 do
      if mapX >= 0 and mapX < room.x and
         mapY >= 0 and mapY < room.y then
        local tileIndex = bit.band(room.layout[layer][room.x * mapY + mapX + 1], 0xff)
        local quad = love.graphics.newQuad(
          spriteSheet.width * tileIndex, 0,
          spriteSheet.width, spriteSheet.height,
          spriteSheet.width * spriteSheet.frameCount, spriteSheet.height)
        spriteBatch:add(quad, screenX, screenY)
      end
      mapX = mapX + 1
      screenX = screenX + spriteSheet.width
    end
    mapY = mapY + 1
    screenY = screenY + spriteSheet.height
  end
  spriteBatch:flush()

end

function layoutLayers()
  layoutLayer(camera, map.rooms[curRoom], 1, map.spriteObject.spriteSheet, map.spriteObject.spriteBatches[1])
  layoutLayer(camera, map.rooms[curRoom], 2, map.spriteObject.spriteSheet, map.spriteObject.spriteBatches[2])
  layoutLayer(camera, map.rooms[curRoom], 3, map.spriteObject.spriteSheet, map.spriteObject.spriteBatches[3])
end

function drawLayers()
  love.graphics.draw(map.spriteObject.spriteBatches[1])
  love.graphics.draw(map.spriteObject.spriteBatches[2])
  drawEnemies()
  love.graphics.draw(map.spriteObject.spriteBatches[3])
end
