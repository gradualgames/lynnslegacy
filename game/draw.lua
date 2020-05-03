function drawFirstSpriteInImage(spriteSheet, image, screenX, screenY)
  local quadX, quadY = 0, 0
  local quad = love.graphics.newQuad(
    quadX,
    quadY,
    spriteSheet.width,
    spriteSheet.height,
    image:getDimensions())
  love.graphics.draw(image, quad, screenX, screenY)
end

function drawImage(spriteSheet, image, screenX, screenY)
  love.graphics.draw(image, screenX, screenY)
end

-- --This function just lays out the first sprite from the sprite
-- --sheet into the sprite batch, just for testing.
-- function layoutFirstSpriteInSpriteBatch(spriteSheet, spriteBatch)
--
--   spriteBatch:clear()
--   local quadX, quadY = 0, 0
--   for i = 1, 1 do
--     local quad = love.graphics.newQuad(
--       quadX,
--       quadY,
--       spriteSheet.width,
--       spriteSheet.height,
--       spriteSheet.width * spriteSheet.frameCount,
--       spriteSheet.height)
--     spriteBatch:add(quad, quadX, quadY)
--     quadX = quadX + spriteSheet.width
--   end
--   spriteBatch:flush()
--
-- end
--
-- --This function lays out a sprite batch with all frames in
-- --order. This is really just used for debugging and inspecting
-- --a given sprite sheet.
-- function layoutSpriteBatch(spriteSheet, spriteBatch)
--
--   spriteBatch:clear()
--   local quadX, quadY = 0, 0
--   for i = 1, spriteSheet.frameCount do
--     local quad = love.graphics.newQuad(
--       quadX,
--       quadY,
--       spriteSheet.width,
--       spriteSheet.height,
--       spriteSheet.width * spriteSheet.frameCount,
--       spriteSheet.height)
--     spriteBatch:add(quad, quadX, quadY)
--     quadX = quadX + spriteSheet.width
--   end
--   spriteBatch:flush()
--
-- end
