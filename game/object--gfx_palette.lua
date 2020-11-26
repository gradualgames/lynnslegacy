require("game/palette")

-- Function __fade_to_black ( this As _char_type Ptr ) As Integer
function __fade_to_black(this)
  --log.debug("__fade_to_black called.")
--
--   Dim As Integer cols, r, g, b, blackened, p
  local cols, r, g, b, blackened, p = 0, 0.0, 0.0, 0.0, false, {}
--
--   If this->fade_timer = 0 Then
  if this.fade_timer == 0 then
--
--     For cols = 0 To 255
    for cols = 0, 255 do
--
--       Palette Get cols, r, g, b
      r, g, b = palette_get_255(cols)
--
--       If r <> 0 Then r -= 4
      if r ~= 0 then r = r - 4 end
--       If g <> 0 Then g - =4
      if g ~= 0 then g = g - 4 end
--       If  b <> 0 Then b -= 4
      if b ~= 0 then b = b - 4 end
--
--       If r < 0 Then r = 0
      if r < 0 then r = 0 end
--       If g < 0 Then g = 0
      if g < 0 then g = 0 end
--       If b < 0 Then b = 0
      if b < 0 then b = 0 end
--
--       p = Rgb ( b Shr 2, g Shr 2, r Shr 2 )
      p = rgb(math.floor(r / 4), math.floor(g / 4), math.floor(b / 4))
--
--       Palette cols, p
      palette_set_63(cols, p)
--
--     Next
    end
--
--     blackened = 1
    blackened = true
--
--     For cols = 0 To 255
    for cols = 0, 255 do
--
--       Palette Get cols, r, g, b
      r = palette[cols][0] * 255
      g = palette[cols][1] * 255
      b = palette[cols][2] * 255
--       blackened = blackened And ( (r = 0) And (g = 0) And (b = 0) )
      blackened = blackened and ((r == 0) and (g == 0) and (b == 0))
--
--     Next
    end
--
--     If llg( song )_fade <> 0 Then
    if ll_global.song_fade ~= 0 then
      log.debug("ll_global.song_fade was nonzero.")
--
--       this->song_fade_count += 1
      this.song_fade_count = this.song_fade_count + 1
--
--       Dim As Double tmp_val
      local tmp_val = 0.0
--       tmp_val = ( this->fade_out - this->song_fade_count ) '' 0-63
      tmp_val = (this.fade_out - this.song_fade_count)
--       tmp_val Shl= 3 '' 0 - 512
--       tmp_val /= 5.12 '' close enough...
--       LLMusic_SetVolume( CInt( tmp_val ) )
      --log.debug("tmp_val: "..tmp_val)
      LLMusic_SetVolume(tmp_val / 63)
-- '        bass_setconfig( BASS_CONFIG_GVOL_MUSIC, tmp_val )
--
--     End If
    end
--
--     this->fade_timer = Timer + this->fade_time
    this.fade_timer = timer + this.fade_time
--
--   End If
  end
--
--   If Timer >= this->fade_timer Then this->fade_timer = 0
  if timer >= this.fade_timer then this.fade_timer = 0 end
--
--   If blackened Then
  if blackened then
--
--     this->fade_out = 0
    this.fade_out = 0
--     this->song_fade_count = 0
    this.song_fade_count = 0
--
--     If llg( song )_fade <> 0 Then
    if ll_global.song_fade ~= 0 then
--
--       LLMusic_Stop()
      love.audio.stop()
--
--     End If
    end
--
--
--     Return 1
    return 1
--
--   End If
  end
--
  return 0
--
-- End Function
end

-- Function __fade_to_red ( this As _char_type Ptr ) As Integer
function __fade_to_red(this)
  --log.debug("__fade_to_red called.")
--
--
--   Dim As Integer cols, r, g, b, allwhite, p
  local cols, r, g, b, allwhite, p
--
--
--   If this->fade_timer = 0 Then
  if this.fade_timer == 0 then
--
--     allwhite = 1
    allwhite = 1
--
--       For cols = 0 To 255
    for cols = 0, 255 do
--
--         Palette Get cols, r, g, b
      r, g, b = palette_get_255(cols)
--
--         If r <> 255 Then r += 2
      if r ~= 255 then r = r + 2 end
--         If g <> 0 Then g - =4
      if g ~= 0 then g = g - 4 end
--         If  b <> 0 Then b -= 4
      if b ~= 0 then b = b - 4 end
--
--         If r > 255 Then r = 255
      if r > 255 then r = 255 end
--         If g < 0 Then g = 0
      if g < 0 then g = 0 end
--         If b < 0 Then b = 0
      if b < 0 then b = 0 end
--
--         p = Rgb ( b\4 , g\4 , r\4  )
      p = rgb(math.floor(r / 4), math.floor(g / 4), math.floor(b / 4))
--
--
--         allwhite = allwhite And ( (g < 128) And (b < 128) )
      allwhite = allwhite and ((g < 128) and (b < 128))
--
--         Palette cols, p
      palette_set_63(cols, p)
--
--
--       Next
    end
--
--
--     this->fade_timer = Timer + this->fade_time
    this.fade_timer = timer + this.fade_time
--
--   Else
  else
--
--     If Timer >= this->fade_timer Then this->fade_timer = 0
    if timer >= this.fade_timer then this.fade_timer = 0 end
--
--   End If
  end
--
--   If allwhite Then Return 1
  if allwhite then return 1 end

  return 0
--
--
--
-- End Function
end

-- Function __flash ( this As _char_type Ptr ) As Integer
function __flash(this)
--
--   Dim As Integer cols
  local cols = 0
--
--
--   For cols = 0 To 255
  for cols = 0, 255 do
--
--
--     Palette cols, Rgb( 63, 63, 63 )
    palette_set_63(cols, rgb(63, 63, 63))
--
--   Next
  end
--
--   static as double blehTimer
  if blehTimer == nil then blehTimer = 0.0 end
--
--   if blehTimer = 0 then
  if blehTimer == 0.0 then
--     blehTimer = timer + .125
    blehTimer = timer + .125
--
--   end if
  end
--
--   if timer > blehTimer then
  if timer > blehTimer then
--     blehTimer = 0
    blehTimer = 0
--     return 1
    return 1
--
--   end if
  end
--
--
--
--   Return 0
  return 0
--
-- End Function
end

-- Function __fade_up_to_color ( this As _char_type Ptr ) As Integer
function __fade_up_to_color(this)
  --log.debug("__fade_up_to_color called.")
--
--   const as integer slices = 64
  local slices = 64
--
--   If this->fade_timer = 0 Then
  if this.fade_timer == 0 then
--
--     Dim As Integer cols
    local cols = 0
--
--     For cols = 0 To 255
    for cols = 0, 255 do
--       Palette cols,       Int( ( ( this->fade_count * ( 5 - (llg( dark ) * .63) )) / 5 ) * ( (fb_Global.display.pal[cols] Shr 0  And &hff)) / 64) Or _
--                           Int( ( ( this->fade_count * ( 5 - (llg( dark ) * .63) )) / 5 ) * ( (fb_Global.display.pal[cols] Shr 8  And &hff)) / 64) Shl 8 Or _
--                           Int( ( ( this->fade_count * ( 5 - (llg( dark ) * .63) )) / 5 ) * ( (fb_Global.display.pal[cols] Shr 16 And &hff)) / 64) Shl 16
      --Int( ( ( this->fade_count * ( 5 - (llg( dark ) * .63) )) / 5 ) * ( (fb_Global.display.pal[cols] Shr 0  And &hff)) / 64)
      local b = math.floor(((this.fade_count * (5 - (ll_global.dark * .63))) / 5) * ((masterPalette[cols][2] * 63)) / 63)
      --Int( ( ( this->fade_count * ( 5 - (llg( dark ) * .63) )) / 5 ) * ( (fb_Global.display.pal[cols] Shr 8  And &hff)) / 64)
      local g = math.floor(((this.fade_count * (5 - (ll_global.dark * .63))) / 5) * ((masterPalette[cols][1] * 63)) / 63)
      --Int( ( ( this->fade_count * ( 5 - (llg( dark ) * .63) )) / 5 ) * ( (fb_Global.display.pal[cols] Shr 16 And &hff)) / 64)
      local r = math.floor(((this.fade_count * (5 - (ll_global.dark * .63))) / 5) * ((masterPalette[cols][0] * 63)) / 63)
      palette_set_63(cols, rgb(r, g, b))
--
--     Next
    end
--
--     this->fade_count += 1
    this.fade_count = this.fade_count + 1
--
--     If llg( song_fade ) <> 0 Then
--
--       #IfDef ll_audio
--
--         Dim As Double tmp_val
--
--         tmp_val = slices' - this->fade_count
-- '        tmp_val = ( this->fade_count ) / 64 '' 0-1
--         tmp_val *= (100 / slices) '' 0 - 100
--         bass_setconfig( BASS_CONFIG_GVOL_MUSIC, tmp_val )
--
--       #EndIf
--
--
--
--     End If
--
--
--
--     If this->fade_count = slices Then
    if this.fade_count == slices then
--
--
--       shift_pal()
      shift_pal()
--
--
--       this->fade_count= 0
      this.fade_count = 0
--       Return 1
      return 1
--
--     End If
    end
--
--     this->fade_timer = Timer + this->fade_time
    this.fade_timer = timer + this.fade_time
--
--   End If
  end
--
--   If Timer >= this->fade_timer Then this->fade_timer = 0
  if timer >= this.fade_timer then this.fade_timer = 0 end
--
--
--
  return 0
-- End Function
end
