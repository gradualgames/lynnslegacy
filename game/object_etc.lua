require("game/constants")
require("game/macros")

-- Function __do_proj( this As _char_type Ptr ) As Integer
function __do_proj(this)
--
--
--   With *this
  local with0 = this
--
--     If .dead Then
  if with0.dead ~= 0 then
--
--       If ( Not ( .unique_id = u_ibug ) ) And ( Not ( .unique_id = u_fbug ) ) Then
    if (not (with0.unique_id == u_ibug)) and (not (with0.unique_id == u_fbug)) then
--         LLObject_ClearProjectiles( *this )
      LLObject_ClearProjectiles(this)
--
--         Return 1
      return 1
--
--       End If
    end
--
--     End If
  end
--
--     If .projectile->refreshTime = 0 Then
  if with0.projectile.refreshTime == 0 then
--
--       If .proj_style = PROJECTILE_BEAM Then
    if with0.proj_style == PROJECTILE_BEAM then
--
--         If .projectile->sound = 0 Then
      if with0.projectile.sound == 0 then
--
--           play_sample( llg( snd )[sound_beam] )
        ll_global.snd[sound_beam]:play()
--           .projectile->sound = -1
        with0.projectile.sound = -1
--
--         End If
      end
--
--       End If
    end
--
--       If .projectile->travelled = 0 Then
    if with0.projectile.travelled == 0 then
--         LLObject_InitializeProjectiles( *this )
      LLObject_InitializeProjectiles(this)
--
--       Else
    else
--         LLObject_IncrementProjectiles( *this )
      LLObject_IncrementProjectiles(this)
--
--       End If
    end
--
--       .projectile->travelled += 1
    with0.projectile.travelled = with0.projectile.travelled + 1
--
--       If .projectile->travelled >= .projectile->length Then
    if with0.projectile.travelled >= with0.projectile.length then
--
--         LLObject_ClearProjectiles( *this )
      LLObject_ClearProjectiles(this)
--         If this->unique_id = u_divine_ball Then
      if this.unique_id == u_divine_ball then
--           Dim As Integer i
        local i = 0
--
--           For i = 0 To now_room().enemy[20].anim[0]->frame[0].faces - 1
        for i = 0, now_room().enemy[20].anim[0].frame[0].faces - 1 do
--             now_room().enemy[20].anim[0]->frame[0].face[i].invincible = 0
          now_room().enemy[20].anim[0].frame[0].face[i].invincible = 0
--
--           Next
        end
--
--         End If
      end
--
--
--
--       End If
    end
--
--       .projectile->refreshTime = Timer + .animControl[.proj_anim].rate
    with0.projectile.refreshTime = timer + with0.animControl[with0.proj_anim].rate
--
--     End If
  end
--
--     If Timer >= .projectile->refreshTime Then .projectile->refreshTime = 0
  if timer >= with0.projectile.refreshTime then with0.projectile.refreshTime = 0 end
--
--   End With
--
--
  return 0
-- End Function
end

-- Function __do_menu ( this As _char_type Ptr ) As Integer
function __do_menu(this)
--
--
--   With *this
  local with0 = this
--
--
--     If .menu_lock Then
  if with0.menu_lock ~= 0 then
--       '' if enter was pressed
--
--       If Not MultiKey ( sc_enter ) Then
    if not love.keyboard.isDown("space") then
--         '' let go of enter
--
--         If .menu_sel = 0 Then
      if with0.menu_sel == 0 then
--           '' menu off
--           llg( hero ).menu_sel = 0
        ll_global.hero.menu_sel = 0
--           .return_trig = 1
        with0.return_trig = 1
--           Exit Function
        return 0
--
--         End If
      end
--
--         If .menu_sel = 1 Then
      if with0.menu_sel == 1 then
--           '' menu off
--           llg( hero ).menu_sel = 2
        ll_global.hero.menu_sel = 2
--           .menu_sel = 0
        with0.menu_sel = 0
--           .state_shift = 2
        with0.state_shift = 2
--           .menu_lock = 0
        with0.menu_lock = 0
--           Exit Function
        return 0
--
--
--         End If
      end
--
--
--         .menu_lock = 0
      with0.menu_lock = 0
--
--
--       End If
    end
--
--     End If
  end
--
--
--
--
--     llg( hero ).menu_sel = 1
  ll_global.hero.menu_sel = 1
--
--
--     If MultiKey ( sc_right ) Then
  if love.keyboard.isDown("right") then
--
--
--       If .walk_hold = 0 Then
    if with0.walk_hold == 0 then
--
--
--         .menu_sel += 1
      with0.menu_sel = with0.menu_sel + 1
--         If .menu_sel = 3 Then .menu_sel = 0
      if with0.menu_sel == 3 then with0.menu_sel = 0 end
--
--
--         .walk_hold = Timer + .walk_speed
      with0.walk_hold = timer + with0.walk_speed
--
--
--
--       End If
    end
--
--     ElseIf MultiKey ( sc_left ) Then
  elseif love.keyboard.isDown("left") then
--
--
--       If .walk_hold = 0 Then
    if with0.walk_hold == 0 then
--
--
--         .menu_sel -= 1
      with0.menu_sel = with0.menu_sel - 1
--         If .menu_sel = -1 Then .menu_sel = 2
      if with0.menu_sel == -1 then with0.menu_sel = 2 end
--
--
--         .walk_hold = Timer + .walk_speed
      with0.walk_hold = timer + with0.walk_speed
--
--
--
--       End If
    end
--
--     Else
  else
--
--
--       .walk_hold = 0
    with0.walk_hold = 0
--
--
--     End If
  end
--
--
--     If Timer >= .walk_hold Then .walk_hold = 0
  if timer >= with0.walk_hold then with0.walk_hold = 0 end
--
--     If MultiKey( sc_escape ) Then
    if love.keyboard.isDown("escape") then
--       End
      love.event.quit()
--
--     End If
    end
--
--     If MultiKey( sc_enter ) Then
  if love.keyboard.isDown("space") then
--
--       If .menu_sel = 2 Then
    if with0.menu_sel == 2 then
--
--         End
      love.event.quit()
--
--       End If
    end
--
--       .menu_lock = 1
    with0.menu_lock = 1
--
--     End If
  end
--
--
--   End With
--
--   Return 0
  return 0
--
-- End Function
end

-- Function __do_menu_continue ( this As _char_type Ptr ) As Integer
function __do_menu_continue(this)
--
--
--
--   If ( this->menu_lock <> 0 ) Then
  if (this.menu_lock ~= 0) then
--
--     If Not MultiKey ( sc_escape ) Then
    if not love.keyboard.isDown("escape") then
--
--       this->menu_lock = 0
      this.menu_lock = 0
--       this->menu_sel = 0
      this.menu_sel = 0
--
--       this->read_lock = 0
      this.read_lock = 0
--       this->state_shift = 1
      this.state_shift = 1
--
--
--     End If
    end
--
--   End If
  end
--
--   Dim As Integer i
  local i = 0
--
--   If this->read_lock = 0 Then
  if this.read_lock == 0 then
--
--
--     this->save( 0 ).link = LLSystem_ReadSaveFile( "ll_save1.sav" )
    this.save[0].link = LLSystem_ReadSaveFile("ll_save1.sav")
--     this->save( 1 ).link = LLSystem_ReadSaveFile( "ll_save2.sav" )
    this.save[1].link = LLSystem_ReadSaveFile("ll_save2.sav")
--     this->save( 2 ).link = LLSystem_ReadSaveFile( "ll_save3.sav" )
    this.save[2].link = LLSystem_ReadSaveFile("ll_save3.sav")
--     this->save( 3 ).link = LLSystem_ReadSaveFile( "ll_save4.sav" )
    this.save[3].link = LLSystem_ReadSaveFile("ll_save4.sav")
--
--     this->read_lock = -1
    this.read_lock = -1
--
--   End If
  end
--
--
--
--
--   If MultiKey ( sc_down ) Then
  if love.keyboard.isDown("down") then
--
--
--     If this->walk_hold = 0 Then
    if this.walk_hold == 0 then
--
--
--       this->menu_sel += 1
      this.menu_sel = this.menu_sel + 1
--       If this->menu_sel = 4 Then this->menu_sel = 0
      if this.menu_sel == 4 then this.menu_sel = 0 end
--
--
--       this->walk_hold = Timer + this->walk_speed
      this.walk_hold = timer + this.walk_speed
--
--
--
--     End If
    end
--
--   ElseIf MultiKey ( sc_up ) Then
  elseif love.keyboard.isDown("up") then
--
--
--     If this->walk_hold = 0 Then
    if this.walk_hold == 0 then
--
--
--       this->menu_sel -= 1
      this.menu_sel = this.menu_sel - 1
--       If this->menu_sel = -1 Then this->menu_sel = 3
      if this.menu_sel == -1 then this.menu_sel = 3 end
--
--
--       this->walk_hold = Timer + this->walk_speed
      this.walk_hold = timer + this.walk_speed
--
--
--
--     End If
    end
--
--   Else
  else
--
--
--     this->walk_hold = 0
    this.walk_hold = 0
--
--
--   End If
  end
--
--
--   If Timer >= this->walk_hold Then this->walk_hold = 0
  if timer >= this.walk_hold then this.walk_hold = 0 end
--
--
--
--   If MultiKey( sc_enter ) Then
  if bpressed("space") then
--
--     If this->save( this->menu_sel ).link <> NULL Then
    if this.save[this.menu_sel].link ~= nil then
--
--       llg( hero_only ).isLoading = TRUE
      ll_global.hero_only.isLoading = TRUE
--
--     End If
    end
--
--   End If
  end
--
--   If MultiKey( sc_escape ) Then
  if love.keyboard.isDown("escape") then
--     this->menu_lock = 1
    this.menu_lock = 1
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

-- Function __do_menu_save ( this As _char_type Ptr ) As Integer
function __do_menu_save(this)
--
--
--   llg( hero ).menu_sel = 2
  ll_global.hero.menu_sel = 2
--   llg( do )_hud = 0
  ll_global.do_hud = 0
--
--   llg( hero )_only.action_lock = -1
  ll_global.hero_only.action_lock = -1
--
--
--   If ( this->menu_lock <> 0 ) Then
  if (this.menu_lock ~= 0) then
--
--     If Not MultiKey ( sc_escape ) Then
    if love.keyboard.isDown("escape") ~= true then
--
--
--       this->menu_lock = 0
      this.menu_lock = 0
--       this->menu_sel = 0
      this.menu_sel = 0
--
--       this->read_lock = 0
      this.read_lock = 0
--
--       llg( hero ).menu_sel = 0
      ll_global.hero.menu_sel = 0
--       llg( do )_hud = -1
      ll_global.do_hud = -1
--
--       llg( hero )_only.action_lock = 0
      ll_global.hero_only.action_lock = 0
--
--
--       Return -2
      return -2
--
--     End If
    end
--
--   End If
  end
--
--   Dim op As Integer
  local op = 0
--
--   If this->read_lock = 0 Then
  if this.read_lock == 0 then
--
--
--     this->save( 0 ).link = LLSystem_ReadSaveFile( "ll_save1.sav" )
--     this->save( 1 ).link = LLSystem_ReadSaveFile( "ll_save2.sav" )
--     this->save( 2 ).link = LLSystem_ReadSaveFile( "ll_save3.sav" )
--     this->save( 3 ).link = LLSystem_ReadSaveFile( "ll_save4.sav" )
--
--     this->read_lock = -1
    this.read_lock = -1
--
--   End If
  end
--
--
--
--
--   If MultiKey ( sc_down ) Then
  if love.keyboard.isDown("down") then
--
--
--     If this->walk_hold = 0 Then
    if this.walk_hold == 0 then
--
--
--       this->menu_sel += 1
      this.menu_sel = this.menu_sel + 1
--       If this->menu_sel = 4 Then this->menu_sel = 0
      if this.menu_sel == 4 then this.menu_sel = 0 end
--
--
--       this->walk_hold = Timer + this->walk_speed
      this.walk_hold = timer + this.walk_speed
--
--
--
--     End If
    end
--
--   ElseIf MultiKey ( sc_up ) Then
  elseif love.keyboard.isDown("up") then
--
--
--     If this->walk_hold = 0 Then
    if this.walk_hold == 0 then
--
--
--       this->menu_sel -= 1
      this.menu_sel = this.menu_sel - 1
--       If this->menu_sel = -1 Then this->menu_sel = 3
      if this.menu_sel == -1 then this.menu_sel = 3 end
--
--
--       this->walk_hold = Timer + this->walk_speed
      this.walk_hold = timer + this.walk_speed
--
--
--
--     End If
    end
--
--   Else
  else
--
--
--     this->walk_hold = 0
    this.walk_hold = 0
--
--
--   End If
  end
--
--
--   If Timer >= this->walk_hold Then this->walk_hold = 0
  if timer >= this.walk_hold then this.walk_hold = 0 end
--
--
--
--   If MultiKey( sc_enter ) Then
  if bpressed("space") then
--
--     Dim flr As String
    local flr = ""
--     flr = Str( this->menu_sel + 1 )
    flr = ""..(this.menu_sel + 1)
--
--     LLSystem_WriteSaveFile( "ll_save" + flr + ".sav", this->chap )
    LLSystem_WriteSaveFile("ll_save"..flr..".sav", this.chap)
--
--     this->read_lock = 0
    this.read_lock = 0
--
--   End If
  end
--
--   If MultiKey( sc_escape ) Then
  if love.keyboard.isDown("escape") then
--     this->menu_lock = 1
    this.menu_lock = 1
--
--   End If
  end
--
--
--
--
  return 0
-- End Function
end

-- Function __change_map ( this As _char_type Ptr ) As Integer
function __change_map(this)
--
--   llg( hero_only ).dropoutSequence = TRUE
  ll_global.hero_only.dropoutSequence = TRUE
--
--   llg( hero ).switch_room = this->chap
  ll_global.hero.switch_room = this.chap
--
--   llg( hero ).to_map = now_room().teleport[llg( hero ).switch_room].to_map
  ll_global.hero.to_map = now_room().teleport[ll_global.hero.switch_room].to_map
--   llg( hero ).to_entry = now_room().teleport[llg( hero ).switch_room].to_room
  ll_global.hero.to_entry = now_room().teleport[ll_global.hero.switch_room].to_room
--
--   change_room( 0, -1, 1 )
  change_room(0, -1, 1)
--
--   llg( hero ).fade_time = .003
  ll_global.hero.fade_time = .003
--   llg( hero ).seq = 0
  ll_global.hero.seq = nil
  ll_global.hero.seqi = 0
--
--   Return 1
  return 1
--
--
-- End Function
end

-- Function __drop ( this As _char_type Ptr ) As Integer
function __drop(this)
  log.debug("__drop called.")
--
--
--
--   If this->d_health > Int( Rnd * 100 ) Then
  if this.d_health > math.floor(math.random() * 100) then
    log.debug("Dropping health.")
--     this->dropped = 1
    this.dropped = 1
--
--     this->drop->coords.x = this->coords.x + Int( Rnd * ( this->perimeter.x - 8 )  )
    this.drop.coords.x = this.coords.x + math.floor(math.random() * (this.perimeter.x - 8))
--     this->drop->coords.y = this->coords.y + Int( Rnd * ( this->perimeter.y - 8 )  )
    this.drop.coords.y = this.coords.y + math.floor(math.random() * (this.perimeter.y - 8))
--
--     Return 1
    return 1
--
--   End If
  end
--
--
--   If this->d_gold > Int( Rnd * 100 ) Then
  if this.d_gold > math.floor(math.random() * 100) then
--     this->dropped = 2
    this.dropped = 2
--
--     this->drop->coords.x = this->coords.x + Int( Rnd * ( this->perimeter.x - 8 )  )
    this.drop.coords.x = this.coords.x + math.floor(math.random() * (this.perimeter.x - 8))
--     this->drop->coords.y = this->coords.y + Int( Rnd * ( this->perimeter.y - 8 )  )
    this.drop.coords.y = this.coords.y + math.floor(math.random() * (this.perimeter.y - 8))
--
--     Return 1
    return 1
--
--   End If
  end
--
--
--   If this->d_silver > Int( Rnd * 100 ) Then
  if this.d_silver > math.floor(math.random() * 100) then
--     this->dropped = 3
    this.dropped = 3
--
--     this->drop->coords.x = this->coords.x + Int( Rnd * ( this->perimeter.x - 8 )  )
    this.drop.coords.x = this.coords.x + math.floor(math.random() * (this.perimeter.x - 8))
--     this->drop->coords.y = this->coords.y + Int( Rnd * ( this->perimeter.y - 8 )  )
    this.drop.coords.y = this.coords.y + math.floor(math.random() * (this.perimeter.y - 8))
--
--     Return 1
    return 1
--
--   End If
  end
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

-- Function __give_b_key ( this As _char_type Ptr ) As Integer
function __give_b_key(this)
--
--
--   llg( hero_only ).b_key += 1
  ll_global.hero_only.b_key = ll_global.hero_only.b_key + 1
--
--   Return 1
  return 1
--
--
--
-- End Function
end

-- Function __give_item ( this As _char_type Ptr ) As Integer
function __give_item(this)
--
--
-- '  llg( hero_only ).has_item += 1
--   llg( hero_only ).hasItem( this->chap ) = TRUE
  ll_global.hero_only.hasItem[this.chap] = TRUE
--   antiHackASSIGN2( LL_Global.hero_only.itemDummy, LL_Global.hero_only.hasItem )
--
--   Return 1
  return 1
--
--
--
-- End Function
end

-- Function __give_key ( this As _char_type Ptr ) As Integer
function __give_key(this)
--
--   llg( hero ).key += 1
  ll_global.hero.key = ll_global.hero.key + 1
--
--
--   Return 1
  return 1
--
--
--
-- End Function
end

-- Function __give_weapon ( this As _char_type Ptr ) As Integer
function __give_weapon(this)
--
--
-- '  ? llg( hero_only ).weapon
-- '  ? llg( hero_only ).has_weapon
-- '  reveal()
-- '  Sleep
-- '
--
--   llg( hero_only ).has_weapon += 1
  ll_global.hero_only.has_weapon = ll_global.hero_only.has_weapon + 1
--
-- '  Select Case llg( hero_only ).has_weapon
-- '
-- '    Case 1
--       llg( hero_only ).weapon = llg( hero_only ).has_weapon
  ll_global.hero_only.weapon = ll_global.hero_only.has_weapon
--
-- '    Case 2
-- '      llg( hero_only ).weapon = 1
-- '
-- '    Case 3
-- '      llg( hero_only ).weapon = 2
-- '
-- '  End Select
--
--   antiHackASSIGN( LL_Global.hero_only.weaponDummy, LL_Global.hero_only.has_weapon )
--
--   Return 1
  return 1
--
--
--
-- End Function
end

-- Function __off_happen ( this As _char_type Ptr ) As Integer
function __off_happen(this)
--
--   llg( now )[this->chap] = 0
  ll_global.now[this.chap] = 0
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

-- Function __set_happen ( this As _char_type Ptr ) As Integer
function __set_happen(this)
--
--
--   llg( now )[this->chap] = Not 0
  ll_global.now[this.chap] = -1
--
--
--
--   Return 1
  return 1
--
--
-- End Function
end

-- Function __return_trig ( this As _char_type Ptr ) As Integer
function __return_trig(this)
--
--
--   this->return_trig = 1
  this.return_trig = 1
--
-- '  ? "HO"
-- '  reveal()
-- '  sleep
--
--
--   Return 1
  return 1
--
--
-- End Function
end

-- Function __handle_menu( this As _char_type Ptr ) As Integer
function __handle_menu(this)
--
--
--
--
--   With *this
  local with0 = this
--
--     Select Case llg( hero ).menu_sel
--
--       Case 1
  if ll_global.hero.menu_sel == 1 then
--         '' Start Continue Quit menu.
--
--
--         Put( 32, 32 ), @.anim[0]->image[0], Trans
    draw(with0.anim[0].image, 32, 32)
--
--         Scope
--
--           Dim As Integer menu_sels
    local menu_sels = 0
--
--             For menu_sels = 0 To 2
    for menu_sels = 0, 2 do
--               '' isn't that such beautiful?
--
--               Put( 64 * ( menu_sels + 1 ), 96 ), @.anim[menu_sels * 2 + 1 + ( Abs( .menu_sel = menu_sels ) )]->image[0], Trans
      local offs = (with0.menu_sel == menu_sels) and 1 or 0
      draw(with0.anim[menu_sels * 2 + 1 + offs].image, 64 * (menu_sels + 1), 96)
--
--             Next
    end
--
--         End Scope
--
--
--       Case 2
  elseif ll_global.hero.menu_sel == 2 then
--
--         Scope
--
--           Dim As Integer menu_sels, m_opt
    local menu_sels, m_opt = 0
--
--             For menu_sels = 0 To 3
    for menu_sels = 0, 3 do
--               m_opt = ( menu_sels * 50 )
      m_opt = (menu_sels * 50)
--
--               '' more beauty...
--               Put( 0, menu_sels * 50 ), @.anim[menu_sels * 2 + 7 + ( Abs( .menu_sel = menu_sels ) )]->image[0], Trans
      draw(with0.anim[menu_sels * 2 + 7 + (with0.menu_sel == menu_sels and 0 or 1)].image, 0, menu_sels * 50)
--
--
--               If .save( menu_sels ).link <> 0 Then
--
--                 Dim As Integer weap
--
--
--                 weap = .save( menu_sels ).link->weapon Mod 3
--                 If weap < 0 Then weap = 0
--
--                 Put( 32, ( menu_sels * 50 ) ), @llg( savImages ).img( weap )->image[0], Trans
--
--
--                 Scope
--
--                   Dim As Integer put_h
--
--                     For put_h = 0 To 5'.save( menu_sels ).link->item - 1
--
--                       if .save( menu_sels ).link->hasItem( put_h ) then
--                         Put( 57 + ( put_h * 16 ), ( menu_sels * 50 ) + 26 ), @llg( hud ).img(1)->image[ ( put_h + 1 ) * llg( hud ).img(1)->arraysize ], Trans
--
--                       end if
--
--                     Next
--
--                 End Scope
--
--
--                 Scope
--
--                   Dim As Integer p, x_opt, y_opt
--
--                     For p = 0 To 29
--
--                       x_opt = ((p Mod 15 ) * 8) + 8
--                       y_opt = (( p \ 15) * 8) + 8
--
--                       If ( .save( menu_sels ).link->hp > p ) Then
--                         Put( 49 + x_opt, y_opt + m_opt ), @llg( hud ).img(0)->image[0], Trans
--
--                       ElseIf (.save( menu_sels ).link->maxhp ) > p Then
--                         Put( 49 + x_opt, y_opt + m_opt ), @llg( hud ).img(0)->image[34], Trans
--
--                       Else
--                         Put( 49 + x_opt, y_opt + m_opt ), @llg( hud ).img(0)->image[68], Trans
--
--
--                       End If
--
--                     Next
--
--                 End Scope
--
--
--                 Put ( 275, ( 16 ) + m_opt), @llg( hud ).img(2)->image[0], Trans
--
--                 Scope
--
--                   Dim mny As String
--
--                     mny = String(  3 - Len( Str( .save( menu_sels ).link->gold ) ), "0" )
--                     mny += Str( .save( menu_sels ).link->gold )
--
--                   Dim As Integer nums
--
--                     For nums = 0 To 2
--
--                       Put ( 289 + ( nums * 8 ), ( 16 ) + m_opt ), @llg( hud ).img(3)->image[( mny[nums] - 48 ) * llg( hud ).img(3)->arraysize], Trans
--
--                     Next
--
--                 End Scope
--
--               End If
--
--
--             Next
  end
--
--         End Scope
--
--     End Select
  end
--
--   End With
--
--   Return 0
  return 0
--
-- End Function
end

-- Function __after_moenia_townspeople( this As char_type Ptr ) As Integer
function __after_moenia_townspeople(this)
--
--   If llg( now )[199] <> 0 Then
  if ll_global.now[199] ~= 0 then
--
--     LLObject_ShiftState( this, this->reset_state )
    LLObject_ShiftState(this, this.reset_state)
--     Return 0
    return 0
--
--
--   End If
  end
--
--   If this->shifty_lock = 0 Then
  if this.shifty_lock == 0 then
--
--     this->coords.x = 800
    this.coords.x = 800
--     this->coords.y = 800
    this.coords.y = 800
--
--     this->shifty_lock = -1
    this.shifty_lock = -1
--
--   End If
  end
--
--
--
  return 0
-- End Function
end

-- Function __set_camera( this As char_type Ptr ) As Integer
function __set_camera(this)
--
--
--   llg( current_cam ) = this
  ll_global.current_cam = this
--
--   Return 1
  return 1
--
-- End Function
end

-- Function __healthguy_branch( this As char_type Ptr ) As Integer
function __healthguy_branch(this)
--
--
--   if llg( hero ).money < healthFormula then
  if ll_global.hero.money < healthFormula() then
--     this->sel_seq = 2
    this.sel_seq = 2
--
--   end if
  end
--
--   if llg( hero ).maxhp = 30 then
  if ll_global.hero.maxhp == 30 then
--     this->sel_seq = 1
    this.sel_seq = 1
--
--   end if
  end
--
--   Function = 1
  return 1
--
--
-- End Function
end

-- Function __fade_music_out( this As char_type Ptr ) As Integer
function __fade_music_out(this)
--
--   llg( hero_only ).songFade = CAllocate( Len( songFading_type ) )
  ll_global.hero_only.songFade = create_songFading_type()
--   llg( hero_only ).songFade->pulseLength = ( 4 / 64 )
  ll_global.hero_only.songFade.pulseLength = (4 / 64)
--
--   Function = 1
  return 1
--
-- End Function
end

-- Function __buy_health( this As char_type Ptr ) As Integer
function __buy_health(this)
--
--   dim as integer hPrice = healthFormula
  local hPrice = healthFormula()
--
--   llg( hero ).money -= hPrice
  ll_global.hero.money = ll_global.hero.money - hPrice
--   antiHackASSIGN( LL_Global.hero_only.moneyDummy, LL_Global.hero.money )
--   llg( hero ).maxhp += 1
  ll_global.hero.maxhp = ll_global.hero.maxhp + 1
--   antiHackASSIGN( LL_Global.hero_only.maxhealthDummy, LL_Global.hero.maxhp )
--   Function = 1
  return 1
--
--
-- End Function
end

-- Function __translate_result( this As char_type Ptr ) As Integer
function __translate_result(this)
--
--   sequence_FullReset( *llg( seq ) )
  sequence_FullReset(ll_global.seq[ll_global.seqi])
--
--   select case llg( t_rect ).selected
--
--     case 0
  if ll_global.t_rect.selected == 0 then
--       llg( seq ) = this->seq + this->dest_x
    ll_global.seqi = this.seqi + this.dest_x
--       this->dest_x = 0
    this.dest_x = 0
--
--     case 1
  elseif ll_global.t_rect.selected == 1 then
--       llg( seq ) = this->seq + this->dest_y
    ll_global.seqi = this.seqi + this.dest_y
--       this->dest_y = 0
    this.dest_y = 0
--
--   End Select
  end
--
--
--   llg( hero_only ).dropoutSequence = TRUE
  ll_global.hero_only.dropoutSequence = TRUE
--
--   Function = 0
  return 0
--
--
-- End Function
end
