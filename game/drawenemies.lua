function drawEnemies()
  for i, enemy in pairs(enemies) do
    local screenX, screenY = enemy.mapX - camera.x, enemy.mapY - camera.y
    love.graphics.draw(enemy.spriteObjects[1].spriteBatches[1], screenX, screenY)
  end
end
