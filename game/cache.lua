require("game/engine--images")
require("game/load/loadxml")

--Returns a loaded imageHeader from the global imageHeaderCache
--cache, or, if there is no image header for the specified file
--name, loads the image header.
function getImageHeader(fileName)

  local imageHeader = imageHeaderCache[fileName]
  if not imageHeader then
    imageHeader = LLSystem_ImageLoad(fileName)
    imageHeaderCache[fileName] = imageHeader
  end
  return imageHeader

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
