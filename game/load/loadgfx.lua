require("lib/blob")

--This function will return a table of all file paths
--recursively under a top level folder with the specified
--file extension.
function listAllFiles(folder, fileList, ext)
  local filesTable = love.filesystem.getDirectoryItems(folder)
  for i,v in ipairs(filesTable) do
    local file = folder.."/"..v
    local info = love.filesystem.getInfo(file)
    if info.type == "file" and string.sub(file, -#ext) == ext then
      table.insert(fileList, file)
    elseif info.type == "directory" then
      listAllFiles(file, fileList, ext)
    end
  end
end

--Loads a palette file and returns a table with all of the rgb triplets
--of the file as tables. Each r,g,b component is transformed into the
--proper float 0 to 1 range that Love2D expects. If there is a problem
--loading the file, nil is returned. The palette file stores rgb triplets
--as b,g,r (backwards), and this is taken care of by this function.
function loadPalette(fileName)

  paletteBlob = loadBlob(fileName)

  if paletteBlob then
    palette = {}
    for x = 0,255 do
      local b,g,r = readByte(paletteBlob),
              readByte(paletteBlob),
              readByte(paletteBlob)
      table.insert(palette,{r/255,g/255,b/255})
    end
    return palette
  else
    return nil
  end

end

--Loads a .spr spritesheet file. These are stored in FreeBASIC/QBasic
--GET/PUT format. It starts with a 16 byte header stating the width and height
--of the sprites, arraySize (unused?), and number of frames. Following this
--is each frame, each of which have a 4 byte header consisting of two unsigned
--short integers, the first being 8 times the width and the second being the height.
--Following this is one byte per pixel of the frame, being an index into a 256
--color palette.
--It returns a table with all the frames of the spritesheet. Each frame
--is just an array of pixels where each pixel has x, y, r, g, b, a components in
--a simple Lua table. This data can be processed by a platform specific function
--later for transforming into a usable sprite object for display on the screen,
--but this function should never have to be modified for any future ports.
function loadSpriteSheet(fileName)
  --Load binary data of the .spr file all at once.
  local blob = loadBlob(fileName)
  if blob then
    --Create a table that can contain everything in the file.
    local spriteSheet = {}
    spriteSheet.width = readInt(blob)
    log.debug("spriteSheet.width: "..spriteSheet.width)
    spriteSheet.height = readInt(blob)
    log.debug("spriteSheet.height: "..spriteSheet.height)
    spriteSheet.arraySize = readInt(blob)
    log.debug("spriteSheet.arraySize: "..spriteSheet.arraySize)
    spriteSheet.frameCount = readInt(blob)
    log.debug("spriteSheet.frameCount: "..spriteSheet.frameCount)
    spriteSheet.frames = {}
    for frameIndex = 1, spriteSheet.frameCount do
      --Create this frame.
      local frame = {}
      frame.frameWidth = readShort(blob) / 8
      frame.frameHeight = readShort(blob)
      frame.pixels = {}
      local byteCount = 4
      --Copy the image data pixel by pixel, converting to our monochrome red format.
      for y = 0, frame.frameHeight - 1 do
        for x = 0, frame.frameWidth - 1 do
          local bt = readByte(blob)
          local alpha = 1
          if bt == 0 then alpha = 0 end
          table.insert(frame.pixels, {x,y, bt/255, 0, 0, alpha})
          byteCount = byteCount + 1
        end
      end
      --Eat extra padding at end of frame. All files under data/pictures
      --followed this pattern except eagle.spr, to which we appended 8
      --bytes with a hex editor.
      local arraySizeDiff = (spriteSheet.arraySize * 2) - byteCount
      if arraySizeDiff > 0 then
        readStringL(blob, arraySizeDiff)
      end
      table.insert(spriteSheet.frames, frame)
    end
    return spriteSheet
  end
end
