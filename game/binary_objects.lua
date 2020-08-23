-- Sub atk_key_in_sub( ip As Integer Ptr, op As Integer Ptr )
function atk_key_in_sub(ip, op)
  log.debug("atk_key_in_sub called.")
--
--   If llg( hero_only ).isWearing = 1 Then Exit Sub
  if ll_global.hero_only.isWearing == 1 then return end
--   If llg( hero_only ).isWearing = 5 Then Exit Sub
  if ll_global.hero_only.isWearing == 5 then return end
--
--   If llg( hero_only ).weapon <> -1 Then
  if ll_global.hero_only.weapon ~= -1 then
--
--
--
--     llg( hero_only ).attacking = -1
    ll_global.hero_only.attacking = -1
--
--
--
--     If llg( hero_only ).crazy_points >= 99 Then
      if ll_global.hero_only.crazy_points >= 99 then
--
--
--       llg( hero_only ).crazy_points = 0
        ll_global.hero_only.crazy_points = 0
--       llg( hero ).attack_state = 37
        --NOTE: States are stored in a normal 1 indexed Lua array so add 1
        ll_global.hero.attack_state = 37
--       llg( hero ).psycho = -1
        ll_global.hero.psycho = -1
--
--     Else
      else
--
--       llg( hero ).attack_state = 6
        ll_global.hero.attack_state = 6
        log.debug("Set ll_global.hero.attack_state to: "..ll_global.hero.attack_state)
--
--
--     End If
    end
--
--
--     Dim lynn_yell As Integer
      -- local lynn_yell = 0
--
--     lynn_yell = Int( Rnd * 4 )
--     lynn_yell += sound_lynn_attack_1
--
--
--     play_sample( llg( snd )[lynn_yell], 30 )
--
--
--   End If
  end
--
--
-- End Sub
end
--
--
-- Sub atk_key_out_sub( ip As Integer Ptr, op As Integer Ptr )
-- End Sub
