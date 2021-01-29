require("lib/blob")
require("game/image_structures")

--Loads a .spr spritesheet file. These are stored in FreeBASIC/QBasic
--GET/PUT format. It starts with a 16 byte header stating the width and height
--of the sprites, arraySize (unused?), and number of frames. Following this
--is each frame, each of which have a 4 byte header consisting of two unsigned
--short integers, the first being 8 times the width and the second being the height.
--Following this is one byte per pixel of the frame, being an index into a 256
--color palette.
--It returns a table which is modeled after the LLSystem_ImageHeader type in the
--original FreeBASIC source code. But the image property is not binary pixel
--data but is instead a Love2D Image object. An additional property called quads
--is created to represent the frames of the image. In the original source code
--the image property was just a simple array of sprites. We do it this way because
--it is more efficient for Love2D to store fewer sprite sheets in the form of images
--and draw multiple sprites defined as quads as sub sections of those sprite sheets.
function LLSystem_ImageLoad(fileName, oc, rc)
  --Create a table that can contain everything in the .spr
  --file and associated .col file if it exists.
  local imageHeader = create_LLSystem_ImageHeader()
  --Load binary data of the .spr file all at once.
  local blob = loadBlob(fileName:lower())
  if blob then
    imageHeader.x = readInt(blob)
    imageHeader.y = readInt(blob)
    imageHeader.arraysize = readInt(blob)
    imageHeader.frames = readInt(blob)

    --Here we deviate from the FB implementation due to necessity. Where it is
    --loading raw binary data for the entire set of frames, we load it byte by
    --byte and convert to a monochrome red format, where the red component
    --represents the original pixel value / 255, to be used with our palette
    --shader as a lookup into a 256x1 palette texture. Used in conjunction
    --with our 256x1 palette texture loaded from the Lynn's Legacy palette file,
    --and our palette_shader.fs, we can display images as though we were using
    --SCREEN 13 like the old days. :)
    local imageX, imageY = 0, 0
    local imageData = love.image.newImageData(imageHeader.x * imageHeader.frames, imageHeader.y)
    for frameIndex = 0, imageHeader.frames - 1 do
      --Create this frame.
      local frameWidth = readShort(blob) / 8
      local frameHeight = readShort(blob)
      local byteCount = 4
      --Copy the image data pixel by pixel, converting to our monochrome red format.
      for y = 0, frameHeight - 1 do
        for x = 0, frameWidth - 1 do
          local bt = readByte(blob)
          if bt == oc then
            bt = rc
          end
          local alpha = 1
          if bt == 0 then alpha = 0 end
          imageData:setPixel(imageX + x, imageY + y, bt / 255, 0, 0, alpha)
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
  --
  --   #IfDef LL_IMAGELOADPROGRESS
  --     LLSystem_Log( "Loading collision data.", "imageload.txt" )
  --
  --   #EndIf
  --
  --   o = FreeFile
  --   If Open( kfe( .filename ) + ".col", For Binary Access Read, As o ) = 0 Then
  local colFileName = string.sub(fileName, 1, #fileName - 4)..".col" --string.sub(file, -#ext)
  if love.filesystem.getInfo(colFileName) then
    local blob = loadBlob(colFileName)
    if blob then
    --
    --     For get_frames = 0 To .frames - 1
      for get_frames = 0, imageHeader.frames - 1 do
    --
    --       With .frame[get_frames]
        imageHeader.frame[get_frames] = create_LLSystem_FrameShell()
    --
    --         Get #o, , .faces
        imageHeader.frame[get_frames].faces = readInt(blob)
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
    --             Get #o, , .y
          imageHeader.frame[get_frames].face[get_faces].y = readInt(blob)
    --             Get #o, , .w
          imageHeader.frame[get_frames].face[get_faces].w = readInt(blob)
    --             Get #o, , .h
          imageHeader.frame[get_frames].face[get_faces].h = readInt(blob)
    --             Get #o, , .strength
          imageHeader.frame[get_frames].face[get_faces].strength = readInt(blob)
    --             Get #o, , .invincible
          imageHeader.frame[get_frames].face[get_faces].invincible = readInt(blob)
    --             Get #o, , .impassable
          imageHeader.frame[get_frames].face[get_faces].impassable = readInt(blob)
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

  return imageHeader
end
