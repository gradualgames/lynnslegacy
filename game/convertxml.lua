--This examines a single element of an xml node as returned
--from xml2lua and ensures that if it is a singleton, a table
--with one element is returned, otherwise it returns the element
--if it was already a table. This makes it easier to process.
function ensureTable(xmlObject)
	local table = {}
	if #xmlObject > 0 then
		table = xmlObject
	else
		table = {xmlObject}
	end
	return table
end

--Converts one xml object to a character object.
function xmlToObject(xmlObject)

	for k, child in pairs(xmlObject) do
		if k == "sprite" then
			log.debug("Processing key: "..k)
			for i, sprite in ipairs(ensureTable(child)) do
				log.debug("Processing sprite: "..i)
				for sk, spriteChild in pairs(sprite) do
					log.debug("Processing key: "..sk)
					if sk == "anim_id" then
						log.debug("anim_id contents: "..spriteChild)
					elseif sk == "filename" then
						log.debug("filename contents: "..spriteChild)
					elseif sk == "dir_frames" then
						log.debug("dir_frames contents: "..spriteChild)
					elseif sk == "rate" then
						log.debug("rate contents: "..spriteChild)
					elseif sk == "madrate" then
						log.debug("madrate contents: "..spriteChild)
					elseif sk == "x_off" then
						log.debug("x_off contents: "..spriteChild)
					elseif sk == "y_off" then
						log.debug("y_off contents: "..spriteChild)
					end
				end
			end
		end
	end
end
