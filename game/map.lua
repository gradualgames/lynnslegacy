--Updates a room using the tile indices from the room to arrange
--the spritebatch for drawing, based on an image header.
function layoutLayer(camera, room, layer, imageHeader, spriteBatch)

  spriteBatch:clear()
  local topLeftMapX = math.floor(camera.x / imageHeader.x)
  local topLeftMapY = math.floor(camera.y / imageHeader.y)
  local topLeftScreenX = -(camera.x % imageHeader.x)
  local topLeftScreenY = -(camera.y % imageHeader.y)
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
          imageHeader.x * tileIndex, 0,
          imageHeader.x, imageHeader.y,
          imageHeader.x * imageHeader.frames, imageHeader.y)
        spriteBatch:add(quad, screenX, screenY)
      end
      mapX = mapX + 1
      screenX = screenX + imageHeader.x
    end
    mapY = mapY + 1
    screenY = screenY + imageHeader.y
  end
  spriteBatch:flush()

end

function layoutLayers()
  layoutLayer(camera, map.rooms[curRoom], 1, map.imageHeader, map.imageHeader.spriteBatches[1])
  layoutLayer(camera, map.rooms[curRoom], 2, map.imageHeader, map.imageHeader.spriteBatches[2])
  layoutLayer(camera, map.rooms[curRoom], 3, map.imageHeader, map.imageHeader.spriteBatches[3])
end

function drawLayers()
  love.graphics.draw(map.imageHeader.spriteBatches[1])
  love.graphics.draw(map.imageHeader.spriteBatches[2])
  --drawEnemies()
  love.graphics.draw(map.imageHeader.spriteBatches[3])
end
