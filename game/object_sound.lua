-- Function __play_sound ( this As _char_type Ptr ) As Integer
function __play_sound(this)
  log.level = "debug"
  log.debug("__play_sound called on "..this.id)
--
--
--   With *this
  local with0 = this
--
--     .playing_handle = play_sample( llg( snd )[.sound[.chap]], .vol[.chap] )
  local vol = with0.vol[with0.chap]
  ll_global.snd[with0.sound[with0.chap]]:setVolume(vol and vol or 1)
  with0.playing_handle = ll_global.snd[with0.sound[with0.chap]]:play()
--
--   End With
--
  log.level = "fatal"
--   Return 1
  return 1
--
--
--
-- End Function
end
