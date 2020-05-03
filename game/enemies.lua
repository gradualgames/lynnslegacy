require("game/load/loadxml")
require("game/animation")
require("game/cache")

-- Loads enemy xml and sprite image files from the current map.
function loadEnemies()

  for i = 1, map.rooms[curRoom].numEnemies do
    local roomEnemy = map.rooms[curRoom].enemies[i]
    local enemy = {}
    log.debug("Enemy id: "..roomEnemy.id)
    enemy.id = roomEnemy.id
    log.debug("Enemy x: "..map.rooms[curRoom].enemies[i].xOrigin)
    enemy.mapX = map.rooms[curRoom].enemies[i].xOrigin
    log.debug("Enemy y: "..map.rooms[curRoom].enemies[i].yOrigin)
    enemy.mapY = map.rooms[curRoom].enemies[i].yOrigin
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
        if spriteValue.rate then
          log.debug(" spriteValue.rate: "..spriteValue.rate)
          spriteObject.rate = tonumber(spriteValue.rate)
        end
        if spriteValue.dir_frames then
          log.debug(" spriteValue.dir_frames: "..spriteValue.dir_frames)
          spriteObject.dirFrames = tonumber(spriteValue.dir_frames)
        end
        table.insert(enemy.spriteObjects, spriteObject)
      end
    end
    table.insert(enemies, enemy)
  end
end

-- Creates enemy animations from the sprite objects for each enemy. Should
-- be called after loadEnemies.
function createEnemyAnimations()
  for i, enemy in pairs(enemies) do
    enemy.animations = {}
    for j, spriteObject in pairs(enemy.spriteObjects) do
      if spriteObject.rate and spriteObject.dirFrames then
        local spriteSheet = spriteObject.spriteSheet
        local animation = newAnimation(spriteObject.image, spriteSheet.width,
          spriteSheet.height, spriteObject.dirFrames, 1)
        table.insert(enemy.animations, animation)
      end
    end
  end
end

function updateEnemyAnimations()
  for i, enemy in pairs(enemies) do
    if #enemy.animations >=1 then
      updateAnimation(enemy.animations[1])
    end
  end
end

function drawEnemies()
  for i, enemy in pairs(enemies) do
    local screenX, screenY = enemy.mapX - camera.x, enemy.mapY - camera.y
    --love.graphics.draw(enemy.spriteObjects[1].spriteBatches[1], screenX, screenY)
    --drawImage(enemy.spriteObjects[1].spriteSheet, enemy.spriteObjects[1].image, screenX, screenY)
    if #enemy.animations >= 1 then
      drawAnimation(enemy.animations[1], screenX, screenY)
    end
  end
end
