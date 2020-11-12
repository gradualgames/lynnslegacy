-- Function __fade_to_black ( this As _char_type Ptr ) As Integer
function __fade_to_black(this)
  log.debug("__fade_to_black called.")
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
      r = palette[cols][0] * 255
      g = palette[cols][1] * 255
      b = palette[cols][2] * 255
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
      --NOTE: The following line was only to convert to
      --the range 0 to 63 for old VGA palettes. Not needed here.
      --We convert from 0.0 to 1.0 to 0 to 255 and then back instead.
--       p = Rgb ( b Shr 2, g Shr 2, r Shr 2 )
--
--       Palette cols, p
      palette[cols][0] = r / 255
      palette[cols][1] = g / 255
      palette[cols][2] = b / 255
--
--     Next
    end
--
--     blackened = 1
    blackened = 1
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
--
--       this->song_fade_count += 1
--
--       Dim As Double tmp_val
--       tmp_val = ( this->fade_out - this->song_fade_count ) '' 0-63
--       tmp_val Shl= 3 '' 0 - 512
--       tmp_val /= 5.12 '' close enough...
--       LLMusic_SetVolume( CInt( tmp_val ) )
-- '        bass_setconfig( BASS_CONFIG_GVOL_MUSIC, tmp_val )
--
--     End If
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
  if blackened ~= 0 then
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
--
--     End If
    end
--
--
--     Return 1
    return 0
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
  log.debug("__fade_to_red called.")
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
      r = palette[cols][0] * 255
      g = palette[cols][1] * 255
      b = palette[cols][2] * 255
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
      --NOTE: The following line was only to convert to
      --the range 0 to 63 for old VGA palettes. Not needed here.
      --We convert from 0.0 to 1.0 to 0 to 255 and then back instead.
--         p = Rgb ( b\4 , g\4 , r\4  )
--
--
--         allwhite = allwhite And ( (g < 128) And (b < 128) )
      allwhite = allwhite and ((g < 128) and (b < 128))
--
--         Palette cols, p
      palette[cols][0] = r / 255
      palette[cols][1] = g / 255
      palette[cols][2] = b / 255
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
