--Updates a room using the tile indices from the room to arrange
--the spritebatch for drawing, based on a sprite sheet.
function updateRoom(room, spriteSheet, spriteBatch)

    spriteBatch:clear()

    for layer = 1,3 do
        for y = 1, room.y do
            for x = 1, room.x do

                local tileIndex = room.layout[layer][room.x * y + x]

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
