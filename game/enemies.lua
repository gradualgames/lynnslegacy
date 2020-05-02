require("game/loadxml")

-- Loads enemies from the current map.
function loadEnemies()

  for i = 1, map.rooms[curRoom].numEnemies do
    local roomEnemy = map.rooms[curRoom].enemies[i]
    local enemy = {}
    enemy.id = roomEnemy.id
    log.debug("Loading enemy xml.")
    local enemyXml = getObjectXml(roomEnemy.id)
    log.debug("Loading enemy sprite sheets.")
    enemy.spriteBatches = {}
    local spriteXml = ensureTable(enemyXml.sprite)
    for spriteKey, spriteValue in pairs(spriteXml) do
    if spriteValue.filename then
      log.debug(" spriteValue.filename: "..spriteValue.filename)
      local fixedFileName = string.gsub(spriteValue.filename, "\\", "/")
      log.debug(" fixedFileName: "..fixedFileName)
      local spriteSheet = getSpriteSheet(fixedFileName)
      local image = spriteSheetToImage(spriteSheet)
      local spriteBatch = imageToSpriteBatch(image)
      layoutSpriteBatch(spriteSheet, spriteBatch)
      table.insert(enemy.spriteBatches, spriteBatch)
    end
  end
  table.insert(enemies, enemy)
  end
end
