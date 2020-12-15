require("lib/blob")
require("game/image_structures")

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
  --Create a table that can contain everything in the .spr
  --file and associated .col file if it exists.
  local imageHeader = create_LLSystem_ImageHeader()
  --Load binary data of the .spr file all at once.
  local blob = loadBlob(fileName:lower())
  if blob then
    imageHeader.x = readInt(blob)
    --log.debug("imageHeader.x: "..imageHeader.x)
    imageHeader.y = readInt(blob)
    --log.debug("imageHeader.y: "..imageHeader.y)
    imageHeader.arraysize = readInt(blob)
    --log.debug("imageHeader.arraysize: "..imageHeader.arraysize)
    imageHeader.frames = readInt(blob)
    --log.debug("imageHeader.frames: "..imageHeader.frames)

    --Here we deviate from the FB implementation due to necessity. Where it is
    --loading raw binary data for the entire set of frames, we load it byte by
    --byte and convert to a monochrome red format, where the red component
    --represents the original pixel value / 255, to be used with our palette
    --shader as a lookup into a 256x1 palette texture. I intentionally use a
    --very verbose name for what we're doing here to draw stark contrast with
    --names that were integrated from the original codebase so there is less
    --possibility for confusion.
    local monochromeRedFrameImages = {}
    for frameIndex = 0, imageHeader.frames - 1 do
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
          table.insert(monochromeRedFrameImage.pixels, {x, y, bt / 255, 0, 0, alpha})
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
      monochromeRedFrameImages[frameIndex] = monochromeRedFrameImage
    end

    --Here is where we generate the .image property of the image header. It is
    --converted from the raw pixel data that was converted above into our monochrome
    --red image format, into an actual displayable Love2D image. Used in conjunction
    --with our 256x1 palette texture loaded from the Lynn's Legacy palette file,
    --and our palette_shader.fs, we can display images as though we were using
    --SCREEN 13 like the old days. :)
    local imageX, imageY = 0, 0
    local imageData = love.image.newImageData(imageHeader.x * imageHeader.frames, imageHeader.y)
    for frameIndex = 0, imageHeader.frames - 1 do
      local monochromeRedFrameImage = monochromeRedFrameImages[frameIndex]
      for k, pixel in pairs(monochromeRedFrameImage.pixels) do
        imageData:setPixel(imageX+pixel[1],imageY+pixel[2],pixel[3],pixel[4],pixel[5],pixel[6])
      end
      imageX = imageX + imageHeader.x
    end
    imageHeader.image = love.graphics.newImage(imageData)

    --Now generate quads for use by Love2D later when displaying individual frames
    --of the image.
    imageHeader.quads = {}
    local x = 0
    for i = 0, imageHeader.frames - 1 do
      imageHeader.quads[i] = love.graphics.newQuad(x, 0,
        imageHeader.x, imageHeader.y, imageHeader.image:getDimensions())
      x = x + imageHeader.x
    end
  end

  -- .frame = CAllocate( Len ( LLSystem_FrameShell ) * ( .frames ) )
  for i = 0, imageHeader.frames - 1 do
   imageHeader.frame[i] = create_LLSystem_FrameShell()
  end
  --
  -- If Dir ( kfe( .filename ) + ".col" ) <> "" Then
  local colFileName = string.sub(fileName, 1, #fileName - 4)..".col" --string.sub(file, -#ext)
  --log.debug("Collision file name: "..colFileName)
  if colFileName == "data/pictures/char/copter_fly.col" or
     colFileName == "data/pictures/char/copter_rise.col" then
    --log.level = "debug"
  end
  --
  --   #IfDef LL_IMAGELOADPROGRESS
  --     LLSystem_Log( "Loading collision data.", "imageload.txt" )
  --
  --   #EndIf
  --
  --   o = FreeFile
  --   If Open( kfe( .filename ) + ".col", For Binary Access Read, As o ) = 0 Then
  if love.filesystem.getInfo(colFileName) then
    local blob = loadBlob(colFileName)
    if blob then
      --log.debug("Collision file exists: "..colFileName)
    --
    --     For get_frames = 0 To .frames - 1
      for get_frames = 0, imageHeader.frames - 1 do
    --
    --       With .frame[get_frames]
        imageHeader.frame[get_frames] = create_LLSystem_FrameShell()
    --
    --         Get #o, , .faces
        imageHeader.frame[get_frames].faces = readInt(blob)
        --log.debug(" # of faces: "..imageHeader.frame[get_frames].faces)
    --
    --         .face = CAllocate( Len( LLSystem_FaceType ) * ( .faces ) )
        imageHeader.frame[get_frames].face = {}
    --
    --         For get_faces = 0 To .faces - 1
        for get_faces = 0, imageHeader.frame[get_frames].faces - 1 do
    --
    --           With .face[get_faces]
          imageHeader.frame[get_frames].face[get_faces] = create_LLSystem_FaceType()
    --
    --             Get #o, , .x
          imageHeader.frame[get_frames].face[get_faces].x = readInt(blob)
          --log.debug("  face.x: "..imageHeader.frame[get_frames].face[get_faces].x)
    --             Get #o, , .y
          imageHeader.frame[get_frames].face[get_faces].y = readInt(blob)
          --log.debug("  face.y: "..imageHeader.frame[get_frames].face[get_faces].y)
    --             Get #o, , .w
          imageHeader.frame[get_frames].face[get_faces].w = readInt(blob)
          --log.debug("  face.w: "..imageHeader.frame[get_frames].face[get_faces].w)
    --             Get #o, , .h
          imageHeader.frame[get_frames].face[get_faces].h = readInt(blob)
          --log.debug("  face.h: "..imageHeader.frame[get_frames].face[get_faces].h)
    --             Get #o, , .strength
          imageHeader.frame[get_frames].face[get_faces].strength = readInt(blob)
          --log.debug("  face.strength: "..imageHeader.frame[get_frames].face[get_faces].strength)
    --             Get #o, , .invincible
          imageHeader.frame[get_frames].face[get_faces].invincible = readInt(blob)
          --log.debug("  face.invincible: "..imageHeader.frame[get_frames].face[get_faces].invincible)
    --             Get #o, , .impassable
          imageHeader.frame[get_frames].face[get_faces].impassable = readInt(blob)
          --log.debug("  face.impassable: "..imageHeader.frame[get_frames].face[get_faces].impassable)
    --
    --           End With
    --
    --         Next
        end
    --
    --       End With
    --
    --     Next
      end
    --
    --     Close o
    --
    --   End If
    end
    --
    -- End If
  end

  --log.level = "fatal"

  return imageHeader
end
