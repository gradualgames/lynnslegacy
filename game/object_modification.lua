require("game/engine_enums")

-- Function __make_vulnerable ( this As _char_type Ptr ) As Integer
function __make_vulnerable(this)
--
--
--   this->invincible = 0
  this.invincible = 0
--
--   Return 1
  return 1
--
--
-- End Function
end

-- Function __make_invincible ( this As _char_type Ptr ) As Integer
function __make_invincible(this)
--
--
--   this->invincible = 1
  this.invincible = 1
--
--   Return 1
  return 1
--
--
-- End Function
end

-- Function __make_dead ( this As _char_type Ptr ) As Integer
function __make_dead(this)
  log.debug("__make_dead called.")
--
--   With *this
--
--     If ( .unique_id <> u_charger ) And ( .unique_id <> u_ferus ) Then
  if (this.unique_id ~= u_charger) and (this.unique_id ~= u_ferus) then
--       .direction = 0
    this.direction = 0
--       .animating = 1
    this.animating = 1
--
--     End If
  end
--
--     .hurt        = 0
  this.hurt = 0
--     LLObject_ClearDamage( this )
  LLObject_ClearDamage(this)
--
--     .flash_timer = 0
  this.flash_timer = 0
--     .flash_count = 0
  this.flash_count = 0
--     .invisible   = 0
  this.invisible = 0
--     .dead        = -1
  this.dead = -1
--
--     If ( .unique_id = u_pekkle_bomb ) Or ( .unique_id = u_kambot ) Then
  if (this.unique_id == u_pekkle_bomb) or (this.unique_id == u_kambot) then
--
--       play_sample( llg( snd )[sound_explosion], 80 )
    ll_global.snd[sound_explosion]:play()
--
--       .coords.x -= 24
    this.coords.x = this.coords.x - 24
--       .coords.y -= 24
    this.coords.y = this.coords.y - 24
--
--       .perimeter.x = 64
    this.perimeter.x = 64
--       .perimeter.y = 64
    this.perimeter.y = 64
--
--       .strength    = 3
    this.strength = 3
--
--     Else
  else
--
--       .strength    = 0
    this.strength = 0
--
--     End If
  end
--
--     .fly = Type <vector> ( 0, 0 )
  this.fly = create_vector()
--
--     If ( Not ( .unique_id = u_ibug ) ) And ( Not ( .unique_id = u_fbug ) ) And ( Not ( .unique_id = u_boss5_down ) ) And ( Not ( .unique_id = u_boss5_left ) ) And ( Not ( .unique_id = u_boss5_right ) ) Then
  if (not (this.unique_id == u_ibug)) and (not (this.unique_id == u_fbug)) and (not (this.unique_id == u_boss5_down)) and (not (this.unique_id == u_boss5_left)) and (not (this.unique_id == u_boss5_right)) then
--       .proj_style = 0
    this.proj_style = 0
--
--     End If
  end
--
-- TODO: Leaving the rest of this entity specific stuff
-- unported until it becomes relevant.
--     Select Case .unique_id
--
--
--       Case u_sterach
--         '' hack; kill swordie :'(
--         now_room().enemy[0].hp = 0
--         If llg( now )[1203] Then
--
--           LLObject_ShiftState( this, 5 )
--
--
--         End If
--
--       Case u_divine
--
--         '' kill ball.
--         now_room().enemy[21].hp = 0
--         LLObject_ShiftState( Varptr( now_room().enemy[22] ), 1 )
--         now_room().enemy[22].invisible = 0
--
--       Case u_divine_bug
--         Dim As Integer i
--
--         For i = 0 To 5
--           now_room().enemy[i].hp = 0
--
--         Next
--
--         For i = 7 To 19
--           now_room().enemy[i].hp = 0
--
--         Next
--
--       Case u_boss5_right, u_boss5_left, u_boss5_down, u_boss5_crystal
--
--         If llg( now )[598] Then
--           '' boss 5 hack
--
--           LLObject_ShiftState( this, 4 )
--
--
--         End If
--
--     End Select
--
--   End With
--
--
--   Return 1
  return 1
--
--
-- End Function
end

-- Function __dir_up ( this As _char_type Ptr ) As Integer
function __dir_up(this)
--
--   this->direction = 0
  this.direction = 0
--
--   Return 1
  return 1
--
--
-- End Function
end
--
--
--
-- Function __dir_right ( this As _char_type Ptr ) As Integer
function __dir_right(this)
--
--   this->direction = 1
  this.direction = 1
--
--   Return 1
  return 1
--
--
-- End Function
end
--
--
--
-- Function __dir_left ( this As _char_type Ptr ) As Integer
function __dir_left(this)
--
--   this->direction = 3
  this.direction = 3
--
--   Return 1
  return 1
--
--
-- End Function
end
--
--
--
-- Function __dir_down ( this As _char_type Ptr ) As Integer
function __dir_down(this)
--
--   this->direction = 2
  this.direction = 2
--
--   Return 1
  return 1
--
--
-- End Function
end

-- Function __cripple ( this As _char_type Ptr ) As Integer
function __cripple(this)
  log.debug("__cripple called.")
--
--
--   Select Case this->unique_id
--
--     Case u_ghut, u_chest, u_bluechest, u_bluechestitem, u_hotrock, u_coldrock, u_greyrock, u_button, u_gbutton
  if this.unique_id == u_ghut or
     this.unique_id == u_chest or
     this.unique_id == u_bluechest or
     this.unique_id == u_bluechestitem or
     this.unique_id == u_hotrock or
     this.unique_id == u_coldrock or
     this.unique_id == u_greyrock or
     this.unique_id == u_button or
     this.unique_id == u_gbutton then
--       this->invisible = 0
    this.invisible = 0
--
--     Case Else
  else
--       this->invisible = -1
    this.invisible = -1
--
--   End Select
  end
--
--   If this->dead_hold = 0 Then
  if this.dead_hold == 0 then
--     this->dead_hold = Timer + .1
    this.dead_hold = timer + .1
--
--   End If
  end
--
--   If Timer > this->dead_hold Then
  if timer > this.dead_hold then
--     this->dead_hold = 0
    this.dead_hold = 0
--
--     Return 1
    return 1
--
--   End If
  end
--
--
--   this->strength = 0 '' clean up after the pekkle hack.
  this.strength = 0
--   this->impassable = 0
  this.impassable = 0
--   this->animating = 0
  this.animating = 0
--   this->total_dead = -1
  this.total_dead = -1
--
--
  return 0
-- End Function
end
