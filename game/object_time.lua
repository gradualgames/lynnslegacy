-- Function __half_second_pause ( this As _char_type Ptr ) As Integer
function __half_second_pause(this)
  log.debug("__half_second_pause called on: "..this.id)
--
--   this->frame = 0
  this.frame = 0
--
--
--
--
--   If this->pause = 0 Then
  if this.pause == 0 then
--
--     this->pause = Timer + .5
    this.pause = timer + .5
--
--
--   End If
  end
--
--   If Timer >= this->pause Then
  if timer >= this.pause then
--     this->pause = 0
    this.pause = 0
--
--     Return 1
    return 1
--
--
--   End If
  end
--
--
  return 0
-- End Function
end

-- Function __if_all_dead ( this As _char_type Ptr ) As Integer
function __if_all_dead(this)
--
--
--   Dim As Integer prb, prbt, veri
  local prb, prbt, veri = 0, 0, 0
--
--   veri = -1
  veri = -1
--
--   For prb = 0 To llg( map )->room[llg( this )_room.i].enemies - 1
  for prb = 0, ll_global.map.room[ll_global.this_room.i].enemies - 1 do
--
--     With llg( map )->room[llg( this )_room.i].enemy[prb]
    local with0 = ll_global.map.room[ll_global.this_room.i].enemy[prb]
--
--       veri = veri And ( .dead <> 0 Or ( _
--                                         .unique_id = u_keydoor  Or _
--                                         .unique_id = u_fkeydoor Or _
--                                         .unique_id = u_ltorch   Or _
--                                         .unique_id = u_torch    Or _
--                                         .unique_id = u_bardoor     _
--                                       ) _
--                       )
    veri = bit.band(veri, (with0.dead ~= 0 or (with0.unique_id == u_keydoor or
                                              with0.unique_id == u_fkeydoor or
                                              with0.unique_id == u_ltorch or
                                              with0.unique_id == u_torch or
                                              with0.unique_id == u_bardoor)) and -1 or 0)
--
--     End With
--
--     If veri = 0 Then Return -1
    if veri == 0 then return -1 end
--
--
--   Next
  end
--
--   For prb = 0 To llg( map )->room[llg( this )_room.i].temp_enemies - 1
  for prb = 0, ll_global.map.room[ll_global.this_room.i].temp_enemies - 1 do
--
--     veri = veri And ( llg( map )->room[llg( this )_room.i].temp_enemy( prb ).dead <> 0 )
    veri = bit.band(veri, ll_global.map.room[ll_global.this_room.i].temp_enemy[prb].dead ~= 0 and -1 or 0)
--
--     If veri = 0 Then Return -1
    if veri == 0 then return -1 end
--
--
--   Next
  end
--
--   If this->chap <> 0 Then
  if this.chap ~= 0 then
--     Return 1
    return 1
--
--   End If
  end
--
-- End Function
end

function __second_pause(this)
  --log.debug("__second_pause called.")
  if this.pause == 0 then
    this.pause = timer + 1
  end

  if timer >= this.pause then
    --log.debug("__second_pause completed for enemy: "..this.id)
    this.pause = 0
    return 1
  end

  return 0
end

-- Function __counted_jump ( this As _char_type Ptr ) As Integer
function __counted_jump(this)
--
--
--   If this->jump_count = this->jump_counter Then
  if this.jump_count == this.jump_counter then
--
--     this->jump_counter = 0
    this.jump_counter = 0
--
--     Return 1
    return 1
--
--   End If
  end
--   this->jump_counter += 1
  this.jump_counter = this.jump_counter + 1
--
--   Return -1
  return -1
--
--
--
-- End Function
end
--
--
--
-- Function __counted_jump_2 ( this As _char_type Ptr ) As Integer
function __counted_jump_2(this)
--
--
--
--   If this->jump_count = this->jump_counter Then
  if this.jump_count == this.jump_counter then
--
--     this->jump_counter = 0
    this.jump_counter = 0
--
--     Return 1
    return 1
--
--   End If
  end
--
--   this->jump_counter += 1
  this.jump_counter = this.jump_counter + 1
--
--   Return -2
  return -2
--
--
--
-- End Function
end

-- Function __return_idle ( this As _char_type Ptr ) As Integer
function __return_idle(this)
  -- log.debug("__return_idle called on "..this.id)
  -- log.debug("this.return_trig: "..this.return_trig)
--
--
--   this->funcs.current_func[this->funcs.active_state] = 0
  this.funcs.current_func[this.funcs.active_state] = 0
--   this->funcs.active_state = 0
  this.funcs.active_state = 0
--   this->funcs.current_func[this->funcs.active_state] = 0
  this.funcs.current_func[this.funcs.active_state] = 0
--
--   Return 0
  return 0
--
--
-- End Function
end

-- Function __return_jump_npc( this As _char_type Ptr ) As Integer
function __return_jump_npc(this)
--
--   this->funcs.current_func[this->funcs.active_state] = 0
  this.funcs.current_func[this.funcs.active_state] = 0
--
--   this->funcs.active_state = this->jump_state
  this.funcs.active_state = this.jump_state
--
--   return 1
  return 1
--
--
--
-- End Function
end

-- Function __return_reset ( this As _char_type Ptr ) As Integer
function __return_reset(this)
  log.debug("__return_reset called.")
--
--   this->funcs.current_func[this->funcs.active_state] = 0
  this.funcs.current_func[this.funcs.active_state] = 0
--
--   this->funcs.active_state = this->reset_state
  this.funcs.active_state = this.reset_state
--
--   Return 0
  return 0
--
-- End Function
end
