require("game/engine_enums")

-- Sub act_key_in_sub( ip As Integer Ptr, op As Integer Ptr )
function act_key_in_sub(ip, op)
--
--
--
--   '' note: this is only utilized if item is 1 or 2
--
--
--
--   llg( hero_only ).attacking = -1
  ll_global.hero_only.attacking = -1
--
--
--
--   '' decide which func to play
--
--   Select Case llg( hero_only ).selected_item
--
--
--
--     Case 1
  if ll_global.hero_only.selected_item == 1 then
--       '' flare powder func
--       llg( hero ).attack_state = 8
    ll_global.hero.attack_state = 8
--       llg( hero_only ).powder = llg( hero_only ).selected_item
    ll_global.hero_only.powder = ll_global.hero_only.selected_item
--
--
--     Case 2
  elseif ll_global.hero_only.selected_item == 2 then
--       '' ice powder func
--       llg( hero ).attack_state = 9
    ll_global.hero.attack_state = 9
--       llg( hero_only ).powder = llg( hero_only ).selected_item
    ll_global.hero_only.powder = ll_global.hero_only.selected_item
--
--
--     Case 3, 4
  elseif ll_global.hero_only.selected_item == 3 or ll_global.hero_only.selected_item == 4 then
--       '' bridge, idol
--       llg( seq ) = llg( hero_only ).specialSequence
    ll_global.seq = ll_global.hero_only.specialSequence
    ll_global.seqi = 0
--       llg( hero_only ).attacking = 0
    ll_global.hero_only.attacking = 0
--
--     Case 5
  elseif ll_global.hero_only.selected_item == 5 then
--       '' adrenaline boost
--       if llg( hero_only ).adrenaline = 0 then
    if ll_global.hero_only.adrenaline == 0 then
--         if llg( hero ).hp > 3 then
      if ll_global.hero.hp > 3 then
--           llg( hero_only ).adrenaline = timer + 6
        ll_global.hero_only.adrenaline = timer + 6
--           llg( hero ).hp -= 3
        ll_global.hero.hp = ll_global.hero.hp - 3
--           antiHackASSIGN( LL_Global.hero_only.healthDummy, LL_Global.hero.hp )
        ll_global.snd[sound_heart]:play()
--
--         end if
      end
--
--       end if
    end
--
--       llg( hero_only ).attacking = 0
    ll_global.hero_only.attacking = 0
--
--
--     Case 6
  elseif ll_global.hero_only.selected_item == 6 then
--       '' healage
--       if llg( hero_only ).healing = 0 then
    if ll_global.hero_only.healing == 0 then
--         if llg( hero ).hp < llg( hero ).maxhp then
      if ll_global.hero.hp < ll_global.hero.maxhp then
--           if llg( hero ).money > 1 then
        if ll_global.hero.money > 1 then
--             llg( hero ).hp += 1
          ll_global.hero.hp = ll_global.hero.hp + 1
--             llg( hero ).money -= 2
          ll_global.hero.money = ll_global.hero.money - 2
--             antiHackASSIGN( LL_Global.hero_only.moneyDummy, LL_Global.hero.money )
--             antiHackASSIGN( LL_Global.hero_only.healthDummy, LL_Global.hero.hp )
--
--             llg( hero_only ).healing = -1
          ll_global.hero_only.healing = -1
--             play_sample( llg( snd )[sound_heal], 80 )
          ll_global.snd[sound_heal]:setVolume(.8)
          ll_global.snd[sound_heal]:play()
--
--           end if
        end
--         end if
      end
--       end if
    end
--
--       llg( hero_only ).attacking = 0
    ll_global.hero_only.attacking = 0
--
--     Case Else
  else
--       '' return quietly
--       llg( hero_only ).attacking = 0
    ll_global.hero_only.attacking = 0
--
--   End Select
  end
--
-- End Sub
end

-- Sub act_key_out_sub( ip As Integer Ptr, op As Integer Ptr )
function act_key_out_sub(ip, op)
--
--
--   llg( hero_only ).powder = 0
  ll_global.hero_only.powder = 0
--
--
-- End Sub
end

-- Sub atk_key_in_sub( ip As Integer Ptr, op As Integer Ptr )
function atk_key_in_sub(ip, op)
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
--
--
--     End If
    end
--
--
--     Dim lynn_yell As Integer
      -- local lynn_yell = 0
    local lynn_yell = 0
--
--     lynn_yell = Int( Rnd * 4 )
    lynn_yell = math.floor(math.random() * 4)
--     lynn_yell += sound_lynn_attack_1
    lynn_yell = lynn_yell + sound_lynn_attack_1
--
--
--     play_sample( llg( snd )[lynn_yell], 30 )
    ll_global.snd[lynn_yell]:setVolume(.3)
    ll_global.snd[lynn_yell]:play()
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
function atk_key_out_sub(ip, op)
-- End Sub
end

-- Sub conf_key_in_sub( ip As Integer Ptr, op As Integer Ptr )
function conf_key_in_sub(ip, op)
--
--
--   llg( hero )_only.action = 1
  ll_global.hero_only.action = 1
--
--
-- End Sub
end
