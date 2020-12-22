require("game/palette")

-- Function __fade_off ( this As _char_type Ptr ) As Integer
function __fade_off(this)
--
--   llg( song_fade ) = 0
  ll_global.song_fade = 0
--
--   Return 1
  return 1
--
-- End Function
end

-- Function __stop_sound ( this As _char_type Ptr ) As Integer
function __stop_sound(this)
--
--   #IfDef ll_audio
--     BASS_ChannelStop( this->playing_handle )
  if this.playing_handle ~= nil then
    this.playing_handle:stop()
  end
--
--   #EndIf
--
--   Return 1
  return 1
--
-- End Function
end

-- Function __kill_song ( this As _char_type Ptr ) As Integer
function __kill_song(this)
--
--
--   this->fade_out = 0
  this.fade_out = 0
--
--   this->song_fade_count = 0
  this.song_fade_count = 0
--
--   LLMusic_Stop()
  LLMusic_Stop()
--
--   Return 1
  return 1
--
-- End Function
end

-- Function __play_dead_sound ( this As _char_type Ptr ) As Integer
function __play_dead_sound(this)
--
--   play_sample( llg( snd )[this->dead_sound] )
  ll_global.snd[this.dead_sound]:play()
--
--   Return 1
  return 1
--
-- End Function
end

-- Function __play_sound ( this As _char_type Ptr ) As Integer
function __play_sound(this)
  log.debug("__play_sound called on "..this.id)
--
--
--   With *this
  local with0 = this
--
--     .playing_handle = play_sample( llg( snd )[.sound[.chap]], .vol[.chap] )
  local vol = with0.vol[with0.chap]
  ll_global.snd[with0.sound[with0.chap]]:setVolume(vol and vol or 1)
  with0.playing_handle = ll_global.snd[with0.sound[with0.chap]]
  with0.playing_handle:play()
--
--   End With
--
--   Return 1
  return 1
--
--
--
-- End Function
end

-- Function __set_fade ( this As _char_type Ptr ) As Integer
function __set_fade(this)
--
--
--   Dim As Integer hi_r, cols, r, g, b
  local hi_r, cols, r, g, b = 0, 0, 0, 0, 0
--
--
--     For cols = 0 To 255
  for cols = 0, 255 do
--
--       Palette Get cols, r, g, b
    r, g, b = palette_get_255(cols)
--
--       If r > hi_r Then
    if r > hi_r then
--         hi_r = r
      hi_r = r
--
--       End If
    end
--
--     Next
  end
--
--     this->fade_out = hi_r \ 4
  this.fade_out = math.floor(hi_r / 4)
--
--   llg( song_fade ) = -1
  ll_global.song_fade = -1
--
--
--
--   Return 1
  return 1
--
--
--
-- End Function
end

-- Function __set_vol_fade ( this As _char_type Ptr ) As Integer
function __set_vol_fade(this)
--
--   this->vol_fade_trig = -1
  this.vol_fade_trig = -1
--
--   Return 1
  return 1
--
--
-- End Function
end
