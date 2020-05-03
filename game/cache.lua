require("game/load/loadgfx")
require("game/load/loadxml")

--Returns a loaded sprite object from the global spriteBatchCache
--cache, or, if there is no sprite object for the specified file
--name, loads the sprite sheet, image and creates sprite batches for
--it.
function getSpriteObject(fileName)

  local spriteObject = spriteObjectCache[fileName]
  if not spriteObject then
    spriteObject = {}
    spriteObject.spriteSheet = loadSpriteSheet(fileName)
    spriteObject.image = spriteSheetToImage(spriteObject.spriteSheet)
    spriteObjectCache[fileName] = spriteObject
  end
  return spriteObject

end

--Returns a loaded xml object from the global objects xml
--cache, or, if there is no xml obect for the specified file
--name, loads it.
function getObjectXml(fileName)

  local objectXml = objectXmlCache[fileName]
  if not objectXml then
    objectXml = loadObjectXml(fileName)
    objectXmlCache[fileName] = objectXml
  end
  return objectXml

end
