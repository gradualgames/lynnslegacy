function computeScale()

    screenWidth, screenHeight = love.graphics.getDimensions()
    canvasWidth, canvasHeight = canvas:getDimensions()
    scale = math.min(screenWidth / canvasWidth, screenHeight / canvasHeight)

end

function startDrawing()
    love.graphics.setCanvas(canvas)
    love.graphics.clear()
end

function doneDrawing()
    love.graphics.setColor(1, 1, 1)
    love.graphics.setCanvas()
    love.graphics.setShader(shader)
    love.graphics.push()
    --Move to the appropiate top left corner.
    love.graphics.translate(math.floor(
        (screenWidth - canvasWidth * scale) / 2),
        math.floor((screenHeight - canvasHeight * scale) / 2))
    love.graphics.scale(scale,scale)
    love.graphics.draw(canvas)
    love.graphics.pop()
    love.graphics.setShader()
end
