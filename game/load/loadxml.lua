xml2lua = require("lib/xml2lua/xml2lua")
xmlHandler = require("lib/xml2lua/xmlhandler.tree")

--This examines a single element of an xml node as returned
--from xml2lua and ensures that if it is a singleton, a table
--with one element is returned, otherwise it returns the element
--if it was already a table. This makes it easier to process.
function ensureTable(xmlObject)
  local table = {}
  if type(xmlObject) == "string" then
    return {xmlObject}
  elseif type(xmlObject) == "table" and #xmlObject > 0 then
    table = xmlObject
  else
    table = {xmlObject}
  end
  return table
end

--Loads all object xml files from the specified directory. Uses
--the global objectXml table.
function loadObjectXmls(dir)

  local xmlFilePaths = {}
  listAllFiles("data/object", xmlFilePaths, "xml")

  for i, v in ipairs(xmlFilePaths) do
    objectXmlCache[v] = loadObject(v)
  end

end

--Loads one object xml file. Adds or replaces an entry in the
--global objectXml table which maps file path to xml object.
function loadObjectXml(xmlFilePath)
  local xmlData = love.filesystem.read(xmlFilePath)
  local handler = xmlHandler:new()
  local parser = xml2lua.parser(handler)
  local objectXml = nil
  parser:parse(xmlData)
  for objectKey, objectValue in pairs(handler.root) do
    objectXml = objectValue
    break
  end
  return objectXml
end
