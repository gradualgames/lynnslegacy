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

function create_LLSystem_FaceType()
  -- Type LLSystem_FaceType
  local faceType = {}
  --   As Integer x, y, w, h
  faceType.x = 0
  faceType.y = 0
  faceType.w = 0
  faceType.h = 0
  --   strength   As Integer
  faceType.strength = 0
  --   invincible As Integer
  faceType.invincible = 0
  --   impassable As Integer
  faceType.impassable = 0
  -- End Type
  return faceType
end

function create_LLSystem_FrameShell()
  -- Type LLSystem_FrameShell
  local frameShell = {}
  --   faces As Integer
  frameShell.faces = 0
  --   face As LLSystem_FaceType Ptr
  frameShell.face = create_LLSystem_FaceType()
  --   sound As Integer
  frameShell.sound = 0
  --   vol As Integer
  frameShell.vol = 0
  --   chan As Integer
  frameShell.chan = 0
  --   uni_sound as byte
  frameShell.uni_sound = 0
  -- End Type
  return frameShell
end

function create_LLSystem_ImageHeader()
  -- Type LLSystem_ImageHeader
  local imageHeader = {}
  --   filename As String
  imageHeader.filename = ""
  --   As Integer x, y, x_off, y_off
  imageHeader.x = 0
  imageHeader.y = 0
  imageHeader.x_off = 0
  imageHeader.y_off = 0
  --   arraysize As Integer
  imageHeader.arraysize = 0

  --   image As Short Ptr
  -- NOTE: This property is the integration point at which we deviate from
  -- the low level representation of image data. Instead of a pointer to raw
  -- binary data, this will be a Love2D Image converted from the binary pixel
  -- format found in a .spr file. The binary pixel data is temporarily loaded
  -- into a monochrome red format where each pixel is the pixel value / 255,
  -- stored in the red component of the pixel, used as a lookup into a 256x1
  -- palette texture using a shader.
  imageHeader.image = nil

  --   frame As LLSystem_FrameShell Ptr
  imageHeader.frame = create_LLSystem_FrameShell()
  --   frames As Integer
  imageHeader.frames = 0
  -- End Type
  return imageHeader
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
function LLSystem_ImageLoad(fileName)
  --Load binary data of the .spr file all at once.
  local blob = loadBlob(fileName)
  if blob then
    --Create a table that can contain everything in the file.
    local imageHeader = create_LLSystem_ImageHeader()
    imageHeader.x = readInt(blob)
    log.debug("imageHeader.x: "..imageHeader.x)
    imageHeader.y = readInt(blob)
    log.debug("imageHeader.y: "..imageHeader.y)
    imageHeader.arraysize = readInt(blob)
    log.debug("imageHeader.arraysize: "..imageHeader.arraysize)
    imageHeader.frames = readInt(blob)
    log.debug("imageHeader.frames: "..imageHeader.frames)

    --Here we deviate from the FB implementation due to necessity. Where it is
    --loading raw binary data for the entire set of frames, we load it byte by
    --byte and convert to a monochrome red format, where the red component
    --represents the original pixel value / 255, to be used with our palette
    --shader as a lookup into a 256x1 palette texture. I intentionally use a
    --very verbose name for what we're doing here to draw stark contrast with
    --names that were integrated from the original codebase so there is less
    --possibility for confusion.
    local monochromeRedFrameImages = {}
    for frameIndex = 1, imageHeader.frames do
      --Create this frame.
      local monochromeRedFrameImage = {}
      monochromeRedFrameImage.frameWidth = readShort(blob) / 8
      monochromeRedFrameImage.frameHeight = readShort(blob)
      monochromeRedFrameImage.pixels = {}
      local byteCount = 4
      --Copy the image data pixel by pixel, converting to our monochrome red format.
      for y = 0, monochromeRedFrameImage.frameHeight - 1 do
        for x = 0, monochromeRedFrameImage.frameWidth - 1 do
          local bt = readByte(blob)
          local alpha = 1
          if bt == 0 then alpha = 0 end
          table.insert(monochromeRedFrameImage.pixels, {x,y, bt/255, 0, 0, alpha})
          byteCount = byteCount + 1
        end
      end
      --Eat extra padding at end of frame. All files under data/pictures
      --followed this pattern except eagle.spr, to which we appended 8
      --bytes with a hex editor.
      local arraySizeDiff = (imageHeader.arraysize * 2) - byteCount
      if arraySizeDiff > 0 then
        readStringL(blob, arraySizeDiff)
      end
      table.insert(monochromeRedFrameImages, monochromeRedFrameImage)
    end

    --Here is where we generate the .image property of the image header. It is
    --converted from the raw pixel data that was converted above into our monochrome
    --red image format, into an actual displayable Love2D image. Used in conjunction
    --with our 256x1 palette texture loaded from the Lynn's Legacy palette file,
    --and our palette_shader.fs, we can display images as though we were using
    --SCREEN 13 like the old days. :)
    local imageX, imageY = 0, 0
    local imageData = love.image.newImageData(imageHeader.x * imageHeader.frames, imageHeader.y)
    for frameIndex = 1, imageHeader.frames do
      local monochromeRedFrameImage = monochromeRedFrameImages[frameIndex]
      for k, pixel in pairs(monochromeRedFrameImage.pixels) do
        imageData:setPixel(imageX+pixel[1],imageY+pixel[2],pixel[3],pixel[4],pixel[5],pixel[6])
      end
      imageX = imageX + imageHeader.x
    end
    imageHeader.image = love.graphics.newImage(imageData)

    return imageHeader
  end
end
