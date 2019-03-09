--Creates a new spritesheet.
function newSpriteSheet(width, height, arraySize, frameCount)
    local spriteSheet = {}
    spriteSheet.width = width
    spriteSheet.height = height
    spriteSheet.arraySize = arraySize
    spriteSheet.frameCount = frameCount
    spriteSheet.frames = {}

    return spriteSheet
end

--Creates a new frame.
function newFrame(frameWidth, frameHeight)
    local frame = {}
    frame.frameWidth = frameWidth
    frame.frameHeight = frameHeight
    frame.pixels = {}
    return frame
end
