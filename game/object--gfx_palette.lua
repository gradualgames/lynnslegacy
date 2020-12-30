require("game/palette")

-- Function __big_color_up ( this As _char_type Ptr ) As Integer
function __big_color_up(this)
--
--   llg( dark ) = 1
  ll_global.dark = 1
--
--   Dim As Integer cols
  local cols = 0
--
--   shift_pal()
  shift_pal()
--
--
--   Return 1
  return 1
--
--
--
-- End Function
end
--
--
--
-- Function __color_down ( this As _char_type Ptr ) As Integer
function __color_down(this)
--
--   If llg( dark ) < 5 Then
  if ll_global.dark < 5 then
--     If now_room().dark <> 0 Then
    if now_room().dark ~= 0 then
--       llg( dark ) += 1
      ll_global.dark = ll_global.dark + 1
--
--     End If
    end
--
--   End If
  end
--
--   Dim As Integer cols
  local cols = 0
--
--
--   shift_pal()
  shift_pal()
--
--
--   Return 1
  return 1
--
--
--
-- End Function
end
--
--
--
-- Function __color_off ( this As _char_type Ptr ) As Integer
function __color_off(this)
--
--   Dim As Integer cols
  local cols = 0
--
--   For cols = 0 To 255
  for cols = 0, 255 do
--
--
--     Palette cols, 0
    palette[cols][0] = 0
    palette[cols][1] = 0
    palette[cols][2] = 0

--
--   Next
  end
--
--
--   Return 1
  return 1
--
-- End Function
end
--
--
-- Function __color_on ( this As _char_type Ptr ) As Integer
function __color_on(this)
--
--
--   Palette Using fb_Global.display.pal
  for cols = 0, 255 do
    palette[cols][0] = masterPalette[cols][0]
    palette[cols][1] = masterPalette[cols][1]
    palette[cols][2] = masterPalette[cols][2]
  end
--
--
--   Return 1
  return 1
--
-- End Function
end
--
--
--
-- Function __color_up ( this As _char_type Ptr ) As Integer
function __color_up(this)
--
--   If llg( dark ) > 0 Then llg( dark ) -= 1
  if ll_global.dark > 0 then ll_global.dark = ll_global.dark - 1 end
--
--   shift_pal()
  shift_pal()
--
--   Return 1
  return 1
--
--
--
-- End Function
end

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
      tmp_val = math.max((this.fade_out - this.song_fade_count), 0)
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

-- Function __fade_to_white ( this As _char_type Ptr ) As Integer
function __fade_to_white(this)
--
--
--   Dim As Integer cols, r, g, b, p, allwhite
  local cols, r, g, b, p, allwhite = 0, 0, 0, 0 ,0, 0
--
--   If this->fade_timer = 0 Then
  if this.fade_timer == 0 then
--
--     For cols = 0 To 255
    for cols = 0, 255 do
--
--
--       Palette Get cols, r, g, b
      r, g, b = palette_get_255(cols)
--
--       If r <> 255 Then r += 4
      if r ~= 255 then r = r + 4 end
--       If g <> 255 Then g + =4
      if g ~= 255 then g = g + 4 end
--       If  b <> 255 Then b += 4
      if b ~= 255 then b = b + 4 end
--
--       If r > 255 Then r = 255
      if r > 255 then r = 255 end
--       If g > 255 Then g = 255
      if g > 255 then g = 255 end
--       If b > 255 Then b = 255
      if b > 255 then b = 255 end
--
--         p = Rgb ( b \ 4, g \ 4, r \ 4  )
      p = rgb(math.floor(r / 4), math.floor(g / 4), math.floor(b / 4))
--
--
--       Palette cols, p
      palette_set_63(cols, p)
--
--     Next
    end
--
--     allwhite = 1
    allwhite = true
--
--     For cols = 0 To 255
    for cols = 0, 255 do
--
--       Palette Get cols, r, g, b
      r, g, b = palette_get_255(cols)
--
--       allwhite And = ( ( r >= 250 ) And ( g >= 250 ) And ( b >= 250 ) )
      allwhite = allwhite and ((r >= 250) and (g >= 250) and (b >= 250))
--
--
--     Next
    end
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
--   If allwhite <> 0 Then
  if allwhite == true then
--
--     For cols = 0 To 255
    for cols = 0, 255 do
--
--       Palette cols, Rgb( 63, 63, 63 )
      palette_set_63(cols, rgb(63, 63, 63))
--
--     Next
    end
--
--     Return 1
    return 1
--
--   End If
  end
--
--
  return 0
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

-- Function __fade_down_to_color( this As _char_type Ptr ) As Integer
function __fade_down_to_color(this)
--
--
--   Dim As Integer cols
  local cols = 0
--
--   Static As Integer col_Get
  if col_Get == nil then col_Get = 0 end
--   Static As palette_Data col_Store( 255 ), col_Inc( 255 )
  if col_Store == nil then col_Store = {} end
  if col_Inc == nil then col_Inc = {} end
--
--
--   If col_Get = 0 Then
  if col_Get == 0 then
--
--     For cols = 0 To 255
    for cols = 0, 255 do
--
--       With col_Inc( cols )
      col_Inc[cols] = {}
--
--         .b = ( 255 - ( ( ( fb_Global.display.pal[cols] Shr 16 ) And &hFF ) Shl 2 ) ) / 64
      col_Inc[cols][0] = (255 - (((masterPalette[cols][0] * 63)) * 4)) / 64
--         .g = ( 255 - ( ( ( fb_Global.display.pal[cols] Shr 8  ) And &hFF ) Shl 2 ) ) / 64
      col_Inc[cols][1] = (255 - (((masterPalette[cols][1] * 63)) * 4)) / 64
--         .r = ( 255 - ( ( ( fb_Global.display.pal[cols]        ) And &hFF ) Shl 2 ) ) / 64
      col_Inc[cols][2] = (255 - (((masterPalette[cols][2] * 63)) * 4)) / 64
--
--       End With
--
--       With col_Store( cols )
      col_Store[cols] = {}
--
--         .r = 255
      col_Store[cols][0] = 255
--         .g = 255
      col_Store[cols][1] = 255
--         .b = 255
      col_Store[cols][2] = 255
--
--       End With
--
--     Next
    end
--
--     col_Get = -1
    col_Get = -1
--
--   End If
  end
--
--   If this->fade_timer = 0 Then
  if this.fade_timer == 0 then
--
--     For cols = 0 To 255
    for cols = 0, 255 do
--
--       With col_Store( cols )
--
--         Palette cols, CInt( .r ), CInt( .g ), CInt( .b )
      palette[cols][0] = col_Store[cols][0] / 255
      palette[cols][1] = col_Store[cols][1] / 255
      palette[cols][2] = col_Store[cols][2] / 255
--
--         .r -= col_Inc( cols ).r
      col_Store[cols][0] = col_Store[cols][0] - col_Inc[cols][0]
--         .g -= col_Inc( cols ).g
      col_Store[cols][1] = col_Store[cols][1] - col_Inc[cols][1]
--         .b -= col_Inc( cols ).b
      col_Store[cols][2] = col_Store[cols][2] - col_Inc[cols][2]
--
--       End With
--
--     Next
    end
--
--     this->fade_count += 1
    this.fade_count = this.fade_count + 1
--     this->fade_timer = Timer + this->fade_time
    this.fade_timer = timer + this.fade_time
--
--   End If
  end
--
--   If Timer >= this->fade_timer Then this->fade_timer = 0
  if timer >= this.fade_timer then this.fade_timer = 0 end
--
--   If this->fade_count = 64 Then
  if this.fade_count == 64 then
--
    --NOTE: Hack to restore font to being white after possible
    --color changes during a fully faded-to-white cutscene.
    ll_global.font = ll_global.fontWhite
--     shift_pal()
    shift_pal()
--
--     this->fade_count= 0
    this.fade_count = 0
--     col_Get = 0
    col_Get = 0
--
--     Return 1
    return 1
--
--   End If
  end
--
--
--   Return 0
  return 0
--
--
-- End Function
end

-- Function __flash_down( this As _char_type Ptr ) As Integer
function __flash_down(this)
--
--
--   Dim As Integer cols
  local cols = 0
--
--   Static As Integer col_Get
  if col_Get == nil then col_Get = 0 end
--   Static As palette_Data col_Store( 255 ), col_Inc( 255 )
  if col_Store == nil then col_Store = {} end
  if col_Inc == nil then col_Inc = {} end
--
--
--   If col_Get = 0 Then
  if col_Get == 0 then
--
--     For cols = 0 To 255
    for cols = 0, 255 do
--
--       With col_Inc( cols )
      if col_Inc[cols] == nil then col_Inc[cols] = {} end
      local with0 = col_Inc[cols]
--
--         .b = ( 255 - ( ( ( fb_Global.display.pal[cols] Shr 16 ) And &hFF ) Shl 2 ) ) / 16
--         .g = ( 255 - ( ( ( fb_Global.display.pal[cols] Shr 8  ) And &hFF ) Shl 2 ) ) / 16
--         .r = ( 255 - ( ( ( fb_Global.display.pal[cols]        ) And &hFF ) Shl 2 ) ) / 16
      with0.b = (255 - (((masterPalette[cols][0])) * 255)) / 16
      with0.g = (255 - (((masterPalette[cols][1])) * 255)) / 16
      with0.r = (255 - (((masterPalette[cols][2])) * 255)) / 16
--
--       End With
--
--       With col_Store( cols )
      if col_Store[cols] == nil then col_Store[cols] = {} end
      local with1 = col_Store[cols]
--
--         .r = 255
--         .g = 255
--         .b = 255
      with1.r = 255
      with1.g = 255
      with1.b = 255
--
--       End With
--
--     Next
    end
--
--     col_Get = -1
    col_Get = -1
--
--   End If
  end
--
--
--   For cols = 0 To 255
  for cols = 0, 255 do
--
--     With col_Store( cols )
    local with0 = col_Store[cols]
--
--       Palette cols, CInt( .r ), CInt( .g ), CInt( .b )
    palette[cols][0] = math.floor(with0.r) / 255
    palette[cols][1] = math.floor(with0.g) / 255
    palette[cols][2] = math.floor(with0.b) / 255
--
--       .r -= col_Inc( cols ).r
    with0.r = with0.r - col_Inc[cols].r
--       .g -= col_Inc( cols ).g
    with0.g = with0.g - col_Inc[cols].g
--       .b -= col_Inc( cols ).b
    with0.b = with0.b - col_Inc[cols].b
--
--     End With
--
--   Next
  end
--
--   this->fade_count += 1
  this.fade_count = this.fade_count + 1
--
--
--   If this->fade_count = 16 Then
  if this.fade_count == 16 then
--
--     shift_pal()
    shift_pal()
--
--     this->fade_count= 0
    this.fade_count = 0
--     col_Get = 0
    col_Get = 0
--
--
--     Return 1
    return 1
--
--   End If
  end
--
--   Return 0
  return 0
--
--
-- End Function
end

-- Function __flash_down_gray( this As _char_type Ptr ) As Integer
function __flash_down_gray(this)
--
--
--   Dim As Integer cols
  local cols = 0
--
--   Static As Integer col_Get
  if col_Get == nil then col_Get = 0 end
--   Static As palette_Data col_Store( 255 ), col_Inc( 255 )
  if col_Store == nil then col_Store = {} end
  if col_Inc == nil then col_Inc = {} end
--
--
--   If col_Get = 0 Then
  if col_Get == 0 then
--
--     For cols = 0 To 255
    for cols = 0, 255 do
--
--       Dim As Integer r, g, b, c
      local r, g, b, c = 0, 0, 0, 0
--
--       b = ( fb_Global.display.pal[cols] Shr 16 ) And &hFF
      b = masterPalette[cols][2] * 63
--       g = ( fb_Global.display.pal[cols] Shr 8  ) And &hFF
      g = masterPalette[cols][1] * 63
--       r = ( fb_Global.display.pal[cols]        ) And &hFF
      r = masterPalette[cols][0] * 63
--
--       c = r + g + b
      c = r + g + b
--       c = c \ 3
      c = math.floor(c / 3)
--
--
--
--       With col_Inc( cols )
      local with0 = col_Inc[cols]
--
--         .b = ( 255 - ( ( c ) Shl 2 ) ) / 16
      with0[2] = (255 - bit.lshift(c, 2)) / 16
--         .g = ( 255 - ( ( c ) Shl 2 ) ) / 16
      with0[1] = (255 - bit.lshift(c, 2)) / 16
--         .r = ( 255 - ( ( c ) Shl 2 ) ) / 16
      with0[0] = (255 - bit.lshift(c, 2)) / 16
--
--       End With
--
--       With col_Store( cols )
      local with1 = col_Store[cols]
--
--         .r = 255
      with1[0] = 255
--         .g = 255
      with1[1] = 255
--         .b = 255
      with1[2] = 255
--
--       End With
--
--     Next
    end
--
--     col_Get = -1
    col_Get = -1
--
--   End If
  end
--
--
--   For cols = 0 To 255
  for cols = 0, 255 do
--
--     With col_Store( cols )
    local with0 = col_Store[cols]
--
--       Palette cols, CInt( .r ), CInt( .g ), CInt( .b )
    palette[cols][0] = with0[0] / 255
    palette[cols][1] = with0[1] / 255
    palette[cols][2] = with0[2] / 255
--
--       .r -= col_Inc( cols ).r
    with0[0] = with0[0] - col_Inc[cols][0]
--       .g -= col_Inc( cols ).g
    with0[1] = with0[1] - col_Inc[cols][1]
--       .b -= col_Inc( cols ).b
    with0[2] = with0[2] - col_Inc[cols][2]
--
--     End With
--
--   Next
  end
--
--   If this->fade_count = 16 Then
  if this.fade_count == 16 then
--
-- '    shift_pal()
--
--     this->fade_count= 0
    this.fade_count = 0
--     col_Get = 0
    col_Get = 0
--
--     Return __make_black_and_white( this )
    return __make_black_and_white(this)
--
--   End If
  end
--
--   this->fade_count += 1
  this.fade_count = this.fade_count + 1
--
--   Return 0
  return 0
--
--
-- End Function
end

-- Function __big_color_down ( this As _char_type Ptr ) As Integer
function __big_color_down(this)
--
--   llg( dark ) = 4
  ll_global.dark = 4
--
--   Dim As Integer cols
  local cols = 0
--
--   shift_pal()
  shift_pal()
--
--   Return 1
  return 1
--
--
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

-- Function __make_black_and_white ( this As _char_type Ptr ) As Integer
function __make_black_and_white(this)
--
--
--   '' iterate through colors
--   '' take average ( ( r + g + b ) / 3 )
--   '' set color ( rgb( avg, avg, avg ) )
--
--   Dim As Integer i, r, g, b, c
  local i, r, g, b, c = 0, 0, 0, 0, 0
--
--
--   For i = 0 To 255
  for i = 0, 255 do
--
--     Palette Get i, r, g, b
    r = palette[i][0] * 255
    g = palette[i][1] * 255
    b = palette[i][2] * 255
--
--     r Shr= 2
    r = bit.rshift(r, 2)
--     g Shr= 2
    g = bit.rshift(g, 2)
--     b Shr= 2
    b = bit.rshift(b, 2)
--
--     c = r + g + b
    c = r + g + b
--     c = c \ 3
    c = math.floor(c / 3)
--
--     Palette i, Rgb( c, c, c )
    palette[i][0] = c / 63
    palette[i][1] = c / 63
    palette[i][2] = c / 63
--
--   Next
  end
--
--
--   Return 1
  return 1
--
--
--
-- End Function
end

-- Function __black_text_on ( this As _char_type Ptr ) As Integer
function __black_text_on(this)
--
--
--   Dim As Integer i, r, g, b, c
--
--   b = ( ( ( ( fb_Global.display.pal[247] Shr 16 ) And &hFF ) Shl 2 ) )
--   g = ( ( ( ( fb_Global.display.pal[247] Shr 8  ) And &hFF ) Shl 2 ) )
--   r = ( ( ( ( fb_Global.display.pal[247]        ) And &hFF ) Shl 2 ) )
--
--   Palette 247, Rgb( r, g, b )
  palette[255][0] = .5
  palette[255][1] = .5
  palette[255][2] = .5
--
--   Return 1
  return 1
--
--
--
-- End Function
end

-- Function __fade_down_to_gray( this As _char_type Ptr ) As Integer
function __fade_down_to_gray(this)
--
--
--   Dim As Integer cols
  local cols = 0
--
--   Static As Integer col_Get
  if col_Get == nil then col_Get = 0 end
--   Static As palette_Data col_Store( 255 ), col_Inc( 255 )
  if col_Store == nil then col_Store = {} end
  if col_Inc == nil then col_Inc = {} end
--
--
--   If col_Get = 0 Then
  if col_Get == 0 then
--
--     For cols = 0 To 255
    for cols = 0, 255 do
--
--       Dim As Integer r, g, b, c
      local r, g, b, c = 0, 0, 0, 0
--
--       b = ( fb_Global.display.pal[cols] Shr 16 ) And &hFF
      b = masterPalette[cols][2] * 63
--       g = ( fb_Global.display.pal[cols] Shr 8  ) And &hFF
      g = masterPalette[cols][1] * 63
--       r = ( fb_Global.display.pal[cols]        ) And &hFF
      r = masterPalette[cols][0] * 63
--
--       c = r + g + b
      c = r + g + b
--       c = c \ 3
      c = math.floor(c / 3)
--
--
--       With col_Inc( cols )
--
--         .b = ( 255 - ( ( c ) Shl 2 ) ) / 64
      col_Inc[cols][2] = (255 - bit.lshift(c, 2)) / 64
--         .g = ( 255 - ( ( c ) Shl 2 ) ) / 64
      col_Inc[cols][1] = (255 - bit.lshift(c, 2)) / 64
--         .r = ( 255 - ( ( c ) Shl 2 ) ) / 64
      col_Inc[cols][0] = (255 - bit.lshift(c, 2)) / 64
--
--       End With
--
--       With col_Store( cols )
--
--         .r = 255
      col_Store[cols][0] = 255
--         .g = 255
      col_Store[cols][1] = 255
--         .b = 255
      col_Store[cols][2] = 255
--
--       End With
--
--     Next
    end
--
--     col_Get = -1
    col_Get = -1
--
--   End If
  end
--
--   If this->fade_timer = 0 Then
  if this.fade_timer == 0 then
--
--     For cols = 0 To 255
    for cols = 0, 255 do
--
--       With col_Store( cols )
--
--         Palette cols, CInt( .r ), CInt( .g ), CInt( .b )
      palette[cols][0] = col_Store[cols][0] / 255
      palette[cols][1] = col_Store[cols][1] / 255
      palette[cols][2] = col_Store[cols][2] / 255
--
--         .r -= col_Inc( cols ).r
      col_Store[cols][0] = col_Store[cols][0] - col_Inc[cols][0]
--         .g -= col_Inc( cols ).g
      col_Store[cols][1] = col_Store[cols][1] - col_Inc[cols][1]
--         .b -= col_Inc( cols ).b
      col_Store[cols][2] = col_Store[cols][2] - col_Inc[cols][2]
--
--       End With
--
--     Next
    end
--
--     this->fade_count += 1
    this.fade_count = this.fade_count + 1
--     this->fade_timer = Timer + this->fade_time
    this.fade_timer = timer + this.fade_time
--
--   End If
  end
--
--   If Timer >= this->fade_timer Then this->fade_timer = 0
  if timer >= this.fade_timer then this.fade_timer = 0 end
--
--   If this->fade_count = 64 Then
  if this.fade_count == 64 then
--
--     this->fade_count= 0
    this.fade_count = 0
--     col_Get = 0
    col_Get = 0
--
--     Return __make_black_and_white( this )
    return __make_black_and_white(this)
--
--   End If
  end
--
--
--   Return 0
  return 0
--
--
-- End Function
end

-- Function __red_tint( this As _char_type Ptr ) As Integer
function __red_tint(this)
--
--
--   Dim As Integer cols, r, g, b
  local cols, r, g, b = 0, 0, 0, 0
--
--
--   For cols = 0 To 255
  for cols = 0, 255 do
--
--     r = ( ( fb_Global.display.pal[cols] Shr 16 ) And &hFF )' Shl 2
    r = masterPalette[cols][0] * 63
--     g = ( ( fb_Global.display.pal[cols] Shr 8  ) And &hFF )' Shl 2
    g = masterPalette[cols][1] * 63
--     b = ( ( fb_Global.display.pal[cols]        ) And &hFF )' Shl 2
    b = masterPalette[cols][2] * 63
--
--     g -= 64
    g = g - 64
-- '    b -= 64
--     r -= 64
    b = b - 64
--
--     g = IIf( g < 0, 0, g )
    g = iif(g < 0, 0, g)
-- '    b = IIf( b < 0, 0, b )
--     r = IIf( r < 0, 0, r )
    b = iif(b < 0, 0, b)
--
-- '    r += 20
-- '    r = IIf( r > 255, 255, r )
--
--     Palette cols, Rgb( r, g, b )
    palette[cols][0] = r / 63
    palette[cols][1] = g / 63
    palette[cols][2] = b / 63
--
--   Next
  end
--
--   Return 1
  return 1
--
-- End Function
end
