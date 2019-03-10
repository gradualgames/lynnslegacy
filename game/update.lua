--Updates a room using the tile indices from the room to arrange
--the spritebatch for drawing, based on a sprite sheet.
function updateRoom(room, spriteSheet, spriteBatch)

    spriteBatch:clear()

    local quadX, quadY = 0, 0

    for i = 1, spriteSheet.frameCount do
        local quad = love.graphics.newQuad(
            quadX,
            quadY,
            spriteSheet.width,
            spriteSheet.height,
            spriteSheet.width * spriteSheet.frameCount,
            spriteSheet.height)
        spriteBatch:add(quad, quadX, quadY)
        quadX = quadX + spriteSheet.width
    end

    spriteBatch:flush()

end
