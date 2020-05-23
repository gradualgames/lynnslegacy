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
  imageHeader.frame = {}
  --   frames As Integer
  imageHeader.frames = 0
  -- End Type
  return imageHeader
end
