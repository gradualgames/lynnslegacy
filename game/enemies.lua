require("game/loadxml")
require("game/cache")

-- Loads enemies from the current map.
function loadEnemies()

  for i = 1, map.rooms[curRoom].numEnemies do
    local roomEnemy = map.rooms[curRoom].enemies[i]
    local enemy = {}
    enemy.id = roomEnemy.id
    log.debug("Loading enemy xml.")
    local enemyXml = getObjectXml(roomEnemy.id)
    log.debug("Loading enemy sprite sheets.")
    local spriteXml = ensureTable(enemyXml.sprite)
    enemy.spriteObjects = {}
    for spriteKey, spriteValue in pairs(spriteXml) do
      if spriteValue.filename then
        log.debug(" spriteValue.filename: "..spriteValue.filename)
        local fixedFileName = string.gsub(spriteValue.filename, "\\", "/")
        log.debug(" fixedFileName: "..fixedFileName)
        local spriteObject = getSpriteObject(fixedFileName)
        layoutSpriteBatch(spriteObject.spriteSheet, spriteObject.spriteBatches[1])
        table.insert(enemy.spriteObjects, spriteObject)
      end
    end
    table.insert(enemies, enemy)
  end
end
