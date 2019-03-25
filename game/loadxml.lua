require("game/convertxml")
xml2lua = require("lib/xml2lua/xml2lua")
xmlHandler = require("lib/xml2lua/xmlhandler.tree")

--Loads all object xml files from the specified directory. Uses
--the global objectXml table.
function loadObjects(dir)

	local xmlFilePaths = {}
	listAllFiles("data/object", xmlFilePaths, "xml")

	for i, v in ipairs(xmlFilePaths) do
		local xmlData = love.filesystem.read(v)
		local handler = xmlHandler:new()
		local parser = xml2lua.parser(handler)
		parser:parse(xmlData)
		for objectKey, objectValue in pairs(handler.root) do
			objectXml[objectKey] = objectValue
			log.level = "debug"
			xmlToObject(objectValue)
			log.level = "fatal"
			log.debug("path: "..v)
			log.debug("objectKey: "..objectKey)
			log.debug("#objectValue.sprite: "..#objectValue["sprite"])
			break
		end

	end

end
