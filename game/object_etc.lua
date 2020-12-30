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
    if not input:down("action") then
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
  if input:down("right") then
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
  elseif input:down("left") then
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
    if input:down("pause") then
--       End
      love.event.quit()
--
--     End If
    end
--
--     If MultiKey( sc_enter ) Then
  if input:down("action") then
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
    if not input:down("pause") then
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
  if input:down("down") then
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
  elseif input:down("up") then
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
  if input:pressed("action") then
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
  if input:down("pause") then
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
    if input:down("pause") ~= true then
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
  if input:down("down") then
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
  elseif input:down("up") then
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
  if input:pressed("action") then
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
  if input:down("pause") then
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

-- Function __drop_b_key ( this As _char_type Ptr ) As Integer
function __drop_b_key(this)
--
--
--   llg( hero_only ).b_key = 0
  ll_global.hero_only.b_key = 0
--
--   Return 1
  return 1
--
--
--
-- End Function
end

-- Function __bridge_chasm ( this As _char_type Ptr ) As Integer
function __bridge_chasm(this)
--
--
--   If llg( now )[357] <> 0 Then
  if ll_global.now[357] ~= 0 then
--
--
--     LLObject_ShiftState( this, this->reset_state )
    LLObject_ShiftState(this, this.reset_state)
--     this->impassable = 0
    this.impassable = 0
--     Return 0
    return 0
--
--
--
--   End If
  end
-- '  llg( hero_only ).b_key = 0
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

-- Function __play_seq ( this As _char_type Ptr ) As Integer
function __play_seq(this)
--
--   llg( seq ) = this->seq + this->sel_seq
  ll_global.seq = this.seq
  ll_global.seqi = this.seqi + this.sel_seq
--
--
--
--   Return 1
  return 1
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

-- Function __invis_entry ( this As _char_type Ptr ) As Integer
function __invis_entry(this)
--
--   llg( hero_only ).invisibleEntry = -1
  ll_global.hero_only.invisibleEntry = -1
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
      if with0.save[menu_sels].link ~= nil then
--
--                 Dim As Integer weap
        local weap = 0
--
--
--                 weap = .save( menu_sels ).link->weapon Mod 3
        weap = with0.save[menu_sels].link.weapon % 3
--                 If weap < 0 Then weap = 0
        if weap < 0 then weap = 0 end
--
--                 Put( 32, ( menu_sels * 50 ) ), @llg( savImages ).img( weap )->image[0], Trans
        draw(ll_global.savImages.img[weap].image, 32, menu_sels * 50)
--
--
--                 Scope
--
--                   Dim As Integer put_h
        local put_h = 0
--
--                     For put_h = 0 To 5'.save( menu_sels ).link->item - 1
        for put_h = 0, 5 do
--
--                       if .save( menu_sels ).link->hasItem( put_h ) then
          if with0.save[menu_sels].link.hasItem[put_h] ~= 0 then
--                         Put( 57 + ( put_h * 16 ), ( menu_sels * 50 ) + 26 ), @llg( hud ).img(1)->image[ ( put_h + 1 ) * llg( hud ).img(1)->arraysize ], Trans
            draw(ll_global.hud.img[1].image, ll_global.hud.img[1].quads[put_h + 1], 57 + (put_h * 16), (menu_sels * 50) + 26)
--
--                       end if
          end
--
--                     Next
        end
--
--                 End Scope
--
--
--                 Scope
--
--                   Dim As Integer p, x_opt, y_opt
        local p, x_opt, y_opt = 0, 0, 0
--
--                     For p = 0 To 29
        for p = 0, 29 do
--
--                       x_opt = ((p Mod 15 ) * 8) + 8
          x_opt = ((p % 15) * 8) + 8
--                       y_opt = (( p \ 15) * 8) + 8
          y_opt = (math.floor(p / 15) * 8) + 8
--
--                       If ( .save( menu_sels ).link->hp > p ) Then
          if (with0.save[menu_sels].link.hp > p) then
--                         Put( 49 + x_opt, y_opt + m_opt ), @llg( hud ).img(0)->image[0], Trans
            draw(ll_global.hud.img[0].image, ll_global.hud.img[0].quads[0], 49 + x_opt, y_opt + m_opt)
--
--                       ElseIf (.save( menu_sels ).link->maxhp ) > p Then
          elseif (with0.save[menu_sels].link.maxhp) > p then
--                         Put( 49 + x_opt, y_opt + m_opt ), @llg( hud ).img(0)->image[34], Trans
            draw(ll_global.hud.img[0].image, ll_global.hud.img[0].quads[1], 49 + x_opt, y_opt + m_opt)
--
--                       Else
          else
--                         Put( 49 + x_opt, y_opt + m_opt ), @llg( hud ).img(0)->image[68], Trans
            draw(ll_global.hud.img[0].image, ll_global.hud.img[0].quads[2], 49 + x_opt, y_opt + m_opt)
--
--
--                       End If
          end
--
--                     Next
        end
--
--                 End Scope
--
--
--                 Put ( 275, ( 16 ) + m_opt), @llg( hud ).img(2)->image[0], Trans
        draw(ll_global.hud.img[2].image, 275, (16) + m_opt)
--
--                 Scope
--
--                   Dim mny As String
        local mny = ""
--
--                     mny = String(  3 - Len( Str( .save( menu_sels ).link->gold ) ), "0" )
--                     mny += Str( .save( menu_sels ).link->gold )
        mny = ""..with0.save[menu_sels].link.gold
        while #mny < 3 do
          mny = "0"..mny
        end
--
--                   Dim As Integer nums
        local nums = 0
--
--                     For nums = 0 To 2
        for nums = 0, 2 do
--
--                       Put ( 289 + ( nums * 8 ), ( 16 ) + m_opt ), @llg( hud ).img(3)->image[( mny[nums] - 48 ) * llg( hud ).img(3)->arraysize], Trans
          draw(ll_global.hud.img[3].image, ll_global.hud.img[3].quads[(string.byte(mny, nums + 1) - 48)], 289 + (nums * 8), (16) + m_opt)
--
--                     Next
        end
--
--                 End Scope
--
--               End If
      end
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

-- Function __make_enemy ( this As _char_type Ptr ) As Integer
function __make_enemy(this)
--
--   If now_room().temp_enemies <> MAX_TEMP_ENEMIES Then
  if now_room().temp_enemies ~= MAX_TEMP_ENEMIES then
--
--
--
--     now_room().temp_enemy( now_room().temp_enemies ).id = this->spawns_id
    now_room().temp_enemy[now_room().temp_enemies] = create_Object()
    log.debug("this.spawns_id: "..this.spawns_id)
    now_room().temp_enemy[now_room().temp_enemies].id = this.spawns_id
--
--     LLSystem_CopyNewObject( now_room().temp_enemy( now_room().temp_enemies ) )
    LLSystem_CopyNewObject(now_room().temp_enemy[now_room().temp_enemies])
--
--     now_room().temp_enemy( now_room().temp_enemies ).coords.y = this->spawn_y + this->coords.y
    now_room().temp_enemy[now_room().temp_enemies].coords.y = this.spawn_y + this.coords.y
--     now_room().temp_enemy( now_room().temp_enemies ).coords.x = this->spawn_x + this->coords.x
    now_room().temp_enemy[now_room().temp_enemies].coords.x = this.spawn_x + this.coords.x
--
--     now_room().temp_enemies += 1
    now_room().temp_enemies = now_room().temp_enemies + 1
--
--
--   End If
  end
--
--   Return 1
  return 1
--
--
-- End Function
end

-- Function __give_100_gold ( this As _char_type Ptr ) As Integer
function __give_100_gold(this)
--
--
--   llg( hero ).money += 100
  ll_global.hero.money = ll_global.hero.money + 100
--   antiHackASSIGN( LL_Global.hero_only.moneyDummy, LL_Global.hero.money )
--   Return 1
  return 1
--
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

-- Function __after_slime( this As char_type Ptr ) As Integer
function __after_slime(this)
--
--   If llg( now )[1150] <> 0 Then
  if ll_global.now[1150] ~= 0 then
--
--     this->sel_seq = 3
    this.sel_seq = 3
--     Return 1
    return 1
--
--
--   End If
  end
--
  return 0
--
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

-- Function __templewood_bridge( this As char_type Ptr ) As Integer
function __templewood_bridge(this)
--
--
--   '' if event not set, then
--   if llg( now )[1206] = 0 then
  if ll_global.now[1206] == 0 then
--
--     this->anim[this->current_anim]->frame[0].face[0].impassable = 1
    this.anim[this.current_anim].frame[0].face[0].impassable = 1
--
--     if multikey( llg( conf_key ).code ) then
    if input:down("action") then
--
--       if LLObject_isTouching( llg( hero ), this[0] ) = 0 then
      if LLObject_isTouching(ll_global.hero, this) == 0 then
--       '' if touching then
--
--         if llg( hero_only ).hasItem( 2 ) then
        if ll_global.hero_only.hasItem[2] ~= 0 then
--         '' if has bridge box then
--
--           llg( seq ) = this->seq
          ll_global.seq = this.seq
          ll_global.seqi = this.seqi
--         else
        else
--
--           if llg( now )[1208] = 0 then
          if ll_global.now[1208] == 0 then
--             llg( seq ) = this->seq + 1
            ll_global.seq = this.seq
            ll_global.seqi = this.seqi + 1
--             llg( now )[1208] = -1
            ll_global.now[1208] = -1
--
--           end if
          end
--
--         end if
        end
--
--
--       end if
      end
--
--
--     end if
    end
--
--   else
  else
--
--     this->invisible = 0
    this.invisible = 0
--     this->anim[this->current_anim]->frame[0].face[0].impassable = 0
    this.anim[this.current_anim].frame[0].face[0].impassable = 0
--     return 1
    return 1
--
--   end if
  end
--
--   Return 0
  return 0
--
-- End Function
end

-- Function __arx_bridge( this As char_type Ptr ) As Integer
function __arx_bridge(this)
--
--
--   '' if event not set, then
--   if llg( now )[470] = 0 then
  if ll_global.now[470] == 0 then
--     this->anim[this->current_anim]->frame[0].face[0].impassable = 1
    this.anim[this.current_anim].frame[0].face[0].impassable = 1
--
--     if multikey( llg( conf_key ).code ) then
    if input:down("action") then
--
--       if LLObject_isTouching( llg( hero ), this[0] ) = 0 then
      if LLObject_isTouching(ll_global.hero, this) == 0 then
--       '' if touching then
--
--         if llg( hero_only ).hasItem( 2 ) then
        if ll_global.hero_only.hasItem[2] ~= 0 then
--         '' if has bridge box then
--
--           llg( seq ) = this->seq
          ll_global.seq = this.seq
          ll_global.seqi = this.seqi
--         else
        else
--
--           if llg( now )[471] = 0 then
          if ll_global.now[471] == 0 then
--             llg( seq ) = this->seq + 1
            ll_global.seq = this.seq
            ll_global.seqi = this.seqi + 1
--             llg( now )[471] = -1
            ll_global.now[471] = -1
--
--           end if
          end
--
--         end if
        end
--
--
--       end if
      end
--
--
--     end if
    end
--
--   else
  else
--
--     this->invisible = 0
    this.invisible = 0
--     this->anim[this->current_anim]->frame[0].face[0].impassable = 0
    this.anim[this.current_anim].frame[0].face[0].impassable = 0
--     return 1
    return 1
--
--   end if
  end
--
--   Return 0
  return 0
--
-- End Function
end

-- function __check_lynn_contact( this As char_type Ptr ) as integer
function __check_lynn_contact(this)
  log.debug("__check_lynn_contact called on: "..this.id)
--
--   if check_bounds( LLO_VP( this ), LLO_VP( varptr( llg( hero ) ) ) ) = 0 then
  if check_bounds(LLO_VP(this), LLO_VP(ll_global.hero)) == 0 then
--     '' lynn's on this
--
--     with llg( hero )
    local with0 = ll_global.hero
--
--       If .dmg.id = 0 Then
    if with0.dmg.id == 0 then
--         .hp -= 1
      with0.hp = with0.hp - 1
--         antiHackASSIGN( LL_Global.hero_only.healthDummy, LL_Global.hero.hp )
--         .hurt = 1
      with0.hurt = 1
--         .dmg.id = 1
      with0.dmg.id = 1
--
--         .fly.x = 0
      with0.fly.x = 0
--         .fly.y = 0
      with0.fly.y = 0
--
--         If .hp < 1 Then
      if with0.hp < 1 then
--
--
--           If .dead = 0 Then
        if with0.dead == 0 then
--             '' first time initialization.
--
--             LLObject_ShiftState( Varptr( llg( hero ) ), .death_state )
          LLObject_ShiftState(ll_global.hero, with0.death_state)
--
--             .dead = 1
          with0.dead = 1
--             .fade_time = .07
          with0.fade_time = .07
--
--           End If
        end
--
--
--           '' reset damaged status.
--           LLObject_ClearDamage( Varptr( llg( hero ) ) )
        LLObject_ClearDamage(ll_global.hero)
--
--         End If
      end
--
--       End If
    end
--
--     end with
--
--
--
--     LLObject_ShiftState( this, 1 )
    LLObject_ShiftState(this, 1)
--
--
--   else
  else
--     this->impassable = 1
    this.impassable = 1
--     LLObject_ShiftState( this, 0 )
    LLObject_ShiftState(this, 0)
--
--
--
--   end if
  end
--
--   function = 0
  return 0
--
--
-- end function
end

-- Function __bandit_check( this As char_type Ptr ) As Integer
function __bandit_check(this)
--
--
--   If llg( hero_only ).hasItem( 3 ) Then
  if ll_global.hero_only.hasItem[3] ~= 0 then
--
--     this->sel_seq = 1
    this.sel_seq = 1
--
--   End If
  end
--
--   Function = 0
  return 0
--
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

-- Function __outfit_branch( this As char_type Ptr ) As Integer
function __outfit_branch(this)
--
--
--   if llg( hero ).money < this->chap then
  if ll_global.hero.money < this.chap then
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

-- Function __give_gold_amount( this As char_type Ptr ) As Integer
function __give_gold_amount(this)
--
--
--   llg( hero ).money += this->chap
  ll_global.hero.money = ll_global.hero.money + this.chap
--   antiHackASSIGN( LL_Global.hero_only.moneyDummy, LL_Global.hero.money )
--
--   Function = 1
  return 1
--
--
-- End Function
end

-- Function __dec_sel_seq( this As char_type Ptr ) As Integer
function __dec_sel_seq(this)
--
--
--   this->sel_seq -= 1
  this.sel_seq = this.sel_seq - 1
--
--   Function = 1
  return 1
--
--
-- End Function
end

-- Function __poondodge_branch( this As char_type Ptr ) As Integer
function __poondodge_branch(this)
--
--
--   if llg( now )[1220] = 0 then
  if ll_global.now[1220] == 0 then
--     if llg( now )[1221] then
    if ll_global.now[1221] ~= 0 then
--       this->sel_seq = 1
      this.sel_seq = 1
--
--     end if
    end
--   end if
  end
--
--   Function = 1
  return 1
--
--
-- End Function
end

-- Function __give_outfit( this As char_type Ptr ) As Integer
function __give_outfit(this)
--
--
--   llg( hero_only ).hasCostume( this->chap ) = TRUE
  ll_global.hero_only.hasCostume[this.chap] = TRUE
--   antiHackASSIGN2( LL_Global.hero_only.outfitDummy, LL_Global.hero_only.hasCostume )
--
--   select case as const this->chap
--     case 1
  if this.chap == 1 then
--       llg( hero ).money -= 10
    ll_global.hero.money = ll_global.hero.money - 10
--     case 2
  elseif this.chap == 2 then
--       llg( hero ).money -= 35
    ll_global.hero.money = ll_global.hero.money - 35
--     case 3
  elseif this.chap == 3 then
--     case 4
  elseif this.chap == 4 then
--       llg( hero ).money -= 70
    ll_global.hero.money = ll_global.hero.money - 70
--     case 5
  elseif this.chap == 5 then
--       llg( hero ).money -= 50
    ll_global.hero.money = ll_global.hero.money - 50
--
--
--   end select
  end
--
--   antiHackASSIGN( LL_Global.hero_only.moneyDummy, LL_Global.hero.money )
--
--
--   Function = 1
  return 1
--
--
-- End Function
end

-- Function __outfit_swap( this As char_type Ptr ) As Integer
function __outfit_swap(this)
--
--   static as integer swapState
  if swapState == nil then swapState = 0 end
--
--   if swapState = 0 then
  if swapState == 0 then
--
--     set_regular()
    set_regular()
--
--   else
  else
--
--     select case as const llg( hero_only ).isWearing
--
--       case 1
    if ll_global.hero_only.isWearing == 1 then
--         '' Cat
--         set_cougar()
      set_cougar()
--       case 2
    elseif ll_global.hero_only.isWearing == 2 then
--         '' Lynnity
--         set_lynnity()
      set_lynnity()
--
--       case 3
    elseif ll_global.hero_only.isWearing == 3 then
--         '' Ninja
--         set_ninja()
      set_ninja()
--
--       case 4
    elseif ll_global.hero_only.isWearing == 4 then
--         '' Bikini
--         set_bikini()
      set_bikini()
--
--       case 5
    elseif ll_global.hero_only.isWearing == 5 then
--         '' Red Knight
--         set_rknight()
      set_rknight()
--
--     end select
    end
--
--   end if
  end
--
--   swapState xor= 1
  swapState = bit.bxor(swapState, 1)
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

-- Function __give_costume( this As char_type Ptr ) As Integer
function __give_costume(this)
--
--
--   llg( hero_only ).hasCostume( this->chap ) = TRUE
  ll_global.hero_only.hasCostume[this.chap] = TRUE
--   antiHackASSIGN2( LL_Global.hero_only.outfitDummy, LL_Global.hero_only.hasCostume )
--
--   Function = 1
  return 1
--
--
-- End Function
end

-- Function __heal_lynn( this As char_type Ptr ) As Integer
function __heal_lynn(this)
--
--
--   llg( hero ).hp = llg( hero ).maxhp
  ll_global.hero.hp = ll_global.hero.maxhp
--   antiHackASSIGN( LL_Global.hero_only.healthDummy, LL_Global.hero.hp )
--
--   Function = 1
  return 1
--
--
-- End Function
end

-- Function __turn_off_tiles( this As char_type Ptr ) As Integer
function __turn_off_tiles(this)
--
--
--   llg( tilesDisabled ) = TRUE
  ll_global.tilesDisabled = TRUE
--
--   Function = 1
  return 1
--
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

-- Function __turn_on_tiles( this As char_type Ptr ) As Integer
function __turn_on_tiles(this)
--
--
--   llg( tilesDisabled ) = FALSE
  ll_global.tilesDisabled = FALSE
--
--   Function = 1
  return 1
--
--
-- End Function
end

-- Function __quake( this As char_type Ptr ) As Integer
function __quake(this)
--
--
--   llg( hero_only ).quakeViolence = IIf( this->chap = -1, 0, this->chap )
  ll_global.hero_only.quakeViolence = iif(this.chap == -1, 0, this.chap)
--
--   Function = 1
  return 1
--
--
-- End Function
end

-- Function __set_finish( this As char_type Ptr ) As Integer
function __set_finish(this)
--
-- 	llg( xxyxx ) = -1
  ll_global.xxyxx = -1
--
--   Function = 1
  return 1
--
--
-- End Function
end

-- Function __logosta_console( this As char_type Ptr ) As Integer
function __logosta_console(this)
--
--   Const As String consolePrompt = "PASS> ", passWord = "FerUs686"
  local consolePrompt, passWord = "PASS> ", "FerUs686"
--   Const As Integer maxEntry = 10
  local maxEntry = 10
--   Const As Double cursorRate = .6
  local cursorRate = .6
--
--   Dim As Integer cursorOn, outty
  local cursorOn, outty = 0, 0
--   Dim As Double cursorToggle
  local cursorToggle = 0.0
--
--   Dim As String inputString
  local inputString = ""
--   Get( 0, 0 )-( 319, 199 ), llg( menu_ScreenSave )
--   fb_ScreenRefresh()
--   shift_pal()
  shift_pal()
--
--   Dim As String gfxDump
  local gfxDump = ""
--
  drawing = true
  keybuffer = {}
--   Do
  repeat
--
--     fb_GetKey()
--
--     If StrPtr( fb_Global.keyBuffer ) <> NULL Then
    if #keybuffer > 0 then
--
--       Select Case fb_Global.keyBuffer[0]
--
--         Case 8
      if keybuffer[1] == "backspace" then
--           '' backspace
--           inputString = Left( inputString, Len( inputString ) - 1 )
        inputString = inputString:sub(1, #inputString - 1)
--
--         Case 13
      elseif keybuffer[1] == "return" then
--           '' enter
--
--           sequence_FullReset( *llg( seq ) )
        sequence_FullReset(ll_global.seq[ll_global.seqi])
--
--           If inputString = passWord Then
        if inputString == passWord then
--             '' correct
--             llg( seq ) = this->seq + 2
          ll_global.seq = this.seq
          ll_global.seqi = this.seqi + 2
--
--           Else
        else
--             '' incorrect
--             llg( seq ) = this->seq + 1
          ll_global.seq = this.seq
          ll_global.seqi = this.seqi + 1
--
--
--           End If
        end
--           llg( hero_only ).dropoutSequence = TRUE
        ll_global.hero_only.dropoutSequene = TRUE
--           outty = TRUE
        outty = TRUE
--
--         Case Else
      else
--
--           If Len( inputString ) <> maxEntry Then
        if #inputString ~= maxEntry then
--             inputString += Chr( fb_Global.keyBuffer[0] )
          inputString = inputString..keybuffer[1]
--
--           End If
        end
--
--       End Select
      end
--
      keybuffer = {}
--     End If
    end
--
--     If fb_WindowKill() Then End
--
--     If Timer > cursorToggle Then
    if timer > cursorToggle then
--       cursorOn = Not cursorOn
      cursorOn = bit.bnot(cursorOn)
--       cursorToggle = Timer + cursorRate
      cursorToggle = timer + cursorRate
--
--     End If
    end
--
--
--     gfxDump = consolePrompt + inputString
    gfxDump = consolePrompt..inputString
--     If cursorOn Then
    if cursorOn ~= 0 then
--       gfxDump += "_"
      gfxDump = gfxDump.."_"
--
--     End If
    end
--
--     gfxprint( gfxDump, 0, 48 )
    graphicalString(gfxDump, 0, 48)
--     fb_ScreenRefresh()
    coroutine.yield()
--
--   Loop Until outty
  until outty ~= 0
--   Put( 0, 0 ), llg( menu_ScreenSave )
--
--   Function = 0
  return 0
--
--
-- End Function
end

-- Function __set_song( this As char_type Ptr ) As Integer
function __set_song(this)
--
--   llg( song ) = this->chap
  ll_global.song = this.chap
--
--   Function = 1
  return 1
--
--
-- End Function
end
