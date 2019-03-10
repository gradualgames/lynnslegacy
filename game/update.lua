--Updates a room using the tile indices from the room to arrange
--the spritebatch for drawing, based on a sprite sheet.
function updateRoom(room, spriteSheet, spriteBatch)

    spriteBatch:clear()

    for layer = 1,3 do
        for y = 0, room.y - 1 do
            for x = 0, room.x - 1 do

                --We consider only the low byte here for the tile index. This is
                --what the original source code does, as well.
                --TODO: What is the upper byte for and how is it used?
                local tileIndex = bit.band(room.layout[layer][room.x * y + x + 1], 0xff)

                local quad = love.graphics.newQuad(
                    spriteSheet.width * tileIndex,
                    0,
                    spriteSheet.width,
                    spriteSheet.height,
                    spriteSheet.width * spriteSheet.frameCount,
                    spriteSheet.height)
                spriteBatch:add(quad, spriteSheet.width * x, spriteSheet.height * y)
            end
        end
    end

    spriteBatch:flush()

end
