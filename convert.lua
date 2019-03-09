--Converts a spriteSheet table into a usable Love2D spriteBatch.
function createSpriteBatch(spriteSheet)

    local imageX, imageY = 0, 0

    local imageData = love.image.newImageData(spriteSheet.width * spriteSheet.frameCount, spriteSheet.height)

    for frameIndex = 1, spriteSheet.frameCount do

        local frame = spriteSheet.frames[frameIndex]

        for k, pixel in pairs(frame.pixels) do
            imageData:setPixel(imageX+pixel[1],imageY+pixel[2],pixel[3],pixel[4],pixel[5],pixel[6])
        end
        imageX = imageX + spriteSheet.width
    end

    local image = love.graphics.newImage(imageData)
    local spriteBatch = love.graphics.newSpriteBatch(image, spriteSheet.frameCount)

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

    return spriteBatch

end

--Creates a palette canvas from a 256 color palette. The 256 color palette
--is expected to be a table of 3 entry tables, where each 3 entry table is an
--rgb triplet expected to express each component as a floating point number
--between 0 and 1 inclusive.
function createPaletteCanvas(palette)
    local paletteCanvas = love.graphics.newCanvas(256,1)
    love.graphics.setCanvas(paletteCanvas)
    for x = 1,256 do
        local r,g,b = palette[x][1],palette[x][2],palette[x][3]
        love.graphics.setColor(r,g,b)
        love.graphics.points(x, 1)
    end
    love.graphics.setCanvas()
    return paletteCanvas
end
