require("game/engine_enums")

-- Function __calc_slide ( this As _char_type Ptr ) As Integer
function __calc_slide(this)
--
--   Dim As Double  thingo
--   thingo = Abs( Log( .01 ) )
--   thingo /= 100
--   thingo *= 5
--
--   Dim As Double SLIDE_CONSTANT = .01 - ( .01 * thingo )
--
--   If this->slide_hold = 0 Then
--
--
--     Dim As Integer all_momentum
--
--
--       For all_momentum = 0 To 7
--
--
--         this->momentum.i( all_momentum ) -= .01
--         If this->momentum.i( all_momentum ) < 0 Then this->momentum.i( all_momentum ) = 0
--
--       Next
--
--       this->slide_hold = Timer + SLIDE_CONSTANT '' !!!!
--
--   End If
--
--   If Timer >= this->slide_hold Then this->slide_hold = 0
--
--   Return 0
  return 0
--
--
-- End Function
end

function __copter_path(this)
  --log.debug("__copter_path called.")
  local exit_cond, c = 0, 0
--
--   this->walk_buffer = this->walk_length
  this.walk_buffer = this.walk_length
--
--   Dim As Integer exit_cond, c
--
--
--   Do
  repeat
--
--     Dim rand_dir As Integer = Int ( Rnd * 8 ) - 1
    local rand_dir = math.floor(love.math.random() * 8) - 1
--
--     this->direction += rand_dir
    this.direction = this.direction + rand_dir
--     If this->direction = -1 Then this->direction = 7
    if this.direction == -1 then this.direction = 7 end
--     this->direction = Abs( this->direction ) And 7
    this.direction = bit.band(math.abs(this.direction), 7)
--
--
--     If move_object( this, MO_JUST_CHECKING ) = 0 Then
    if move_object(this, MO_JUST_CHECKING) == 0 then
--     Else
    else
--       exit_cond = -1
      exit_cond = -1
--
--     End If
    end
--
--     c+= 1
    c = c + 1
--     If c = 20 Then
    if c == 20 then
--       exit_cond = -1
      exit_cond = -1
--
--     End If
    end
--
--
--   Loop While exit_cond = 0
  until exit_cond ~= 0
--
-- '  this->direction = Int ( Rnd * 8 )
--
--
--   Return 1
  return 1
--
end

function __walk(this)
  --log.debug("__walk called.")

  --log.debug("this.walk_hold: "..this.walk_hold)
  --log.debug("this.walk_speed: "..this.walk_speed)
  --log.debug("this.momentum.i[this.direction]: "..this.momentum.i[this.direction])

  --log.debug("this.walk_speed: "..this.walk_speed)
--   If this->walk_hold = 0 Then
  if this.walk_hold == 0 then
--
--
--     this->momentum.i( this->direction ) += this->walk_speed * 2
    this.momentum.i[this.direction] = this.momentum.i[this.direction] + this.walk_speed * 2
--
--     If this->momentum.i( this->direction ) > 1 Then
    if this.momentum.i[this.direction] > 1 then
--       this->momentum.i( this->direction ) = 1
      this.momentum.i[this.direction] = 1
--
--     End If
    end
--
--
--     If this->on_ice = 0 Then
    if this.on_ice == 0 then
--       '' traction
--
      __go_grip( this )
--
--     End If
    end
--
--
--     If this->walk_buffer > this->walk_length Then
    if this.walk_buffer > this.walk_length then
--
--       If this->on_ice = 0 Then
      if this.on_ice == 0 then
--         ''coming off ice check... too much path
--
--         this->walk_buffer = this->walk_length
        this.walk_buffer = this.walk_length
--
--       End If
      end
--
--     End If
    end
--
--
--
--     If move_object( this, MO_JUST_CHECKING, this->momentum.i( this->direction ) ) = 0 Then
    if move_object(this, MO_JUST_CHECKING, this.momentum.i[this.direction]) == 0 then
--       this->walk_steps = this->walk_buffer' - 1
      this.walk_steps = this.walk_buffer
-- '      this->momentum.i( this->direction ) = 0
--
--     Else
    else
--
--       If this->momentum.i( this->direction ) = 0 Then
      if this.momentum.i[this.direction] == 0 then
--         this->walk_steps = this->walk_buffer' - 1
        this.walk_steps = this.walk_buffer
--
--       Else
      else
--         __momentum_move( this )
        __momentum_move(this)
--
--       End If
      end
--
--     End If
    end
--
--
--     If this->momentum.i( this->direction ) > 0 Then
    if this.momentum.i[this.direction] > 0 then
--       this->walk_steps +=  1
      this.walk_steps = this.walk_steps + 1
--
--     End If
    end
--
--
--     If this->walk_steps >= this->walk_buffer Then
    if this.walk_steps >= this.walk_buffer then
--       this->frame = 0
      this.frame = 0
--       this->walk_steps = 0
      this.walk_steps = 0
--
--       Return 1
      return 1
--
--     End If
    end
--
--
--     If LLObject_IncrementFrame( this ) <> 0 Then
    if LLObject_IncrementFrame(this) ~= 0 then
--
--       this->frame = 0
      this.frame = 0
--       this->frame_hold = Timer + this->animControl[this->current_anim].rate
      this.frame_hold = timer + this.animControl[this.current_anim].rate
--
--       '' reset rate?
--     End If
    end
--
--   End If
  end
--
--
--   If Timer >= this->walk_hold Then this->walk_hold = 0
  if timer >= this.walk_hold then this.walk_hold = 0 end

  return 0
--
end

-- Function __momentum_move ( this As _char_type Ptr ) As Integer
function __momentum_move(this)
  --log.debug("__momentum_move called.")
--
--   With *this
--
--
--     Dim As Integer movement
--     Dim As Integer look_ahead
--
--     Dim As Integer all_momentum
  local movement, look_ahead, all_momentum = 0, 0, 0
--
--
--     For all_momentum = 0 To 7
  for all_momentum = 0, 7 do
--
--       look_ahead = 0
    look_ahead = 0
--
--
--
--
--       If .momentum.i( all_momentum ) <> 0 Then
    if this.momentum.i[all_momentum] ~= 0 then
--
--         Dim As Integer temp_dir
      local temp_dir = 0
--         temp_dir = .direction
      temp_dir = this.direction
--         .direction = all_momentum
      this.direction = all_momentum
--
--         look_ahead = move_object( this, , .momentum.i( .direction ) )
      look_ahead = move_object(this, 0, this.momentum.i[this.direction])
--
--         If look_ahead = 0 Then
      if look_ahead == 0 then
--           '' momentum dies on impact.
--
--           If ( .is_psfing = 0 ) And ( .is_pushing = 0 ) Then
        if this.is_psfing == 0 and this.is_pushing == 0 then
--
--             .momentum.i( .direction ) = 0
          this.momentum.i[this.direction] = 0
--
--           End If
        end
--
--         End If
      end
--
--         .direction = temp_dir
      this.direction = temp_dir
--
--       End If
    end
--
--       movement Or = .momentum.i( all_momentum ) <> 0
    movement = bit.bor(movement, (this.momentum.i[all_momentum] ~= 0) and 1 or 0)
--
--     Next
  end
--
--
--
--     If movement <> 0 Then
  if movement ~=0 then
--       .walk_hold = Timer + .walk_speed
    this.walk_hold = timer + this.walk_speed
--
--     End If
  end
--
--     Return 1
  return 1
--
--   End With
--
-- End Function
end

-- Function __do_flyback ( this As _char_type Ptr ) As Integer
function __do_flyback(this)
--
--   With *this
--
--     Dim As Integer moveback
  local moveback = 0
--
--
--     If ( .unique_id = u_grult ) Then
  if (this.unique_id == u_grult) then
--
--       If .fly_timer = 0 Then
    if this.fly_timer == 0 then
--
--
--
--         .fly_timer = Timer + .fly_speed
      this.fly_timer = timer + this.fly_speed
--         .fly_count += 1
      this.fly_count = this.fly_count + 1
--
--       End If
    end
--
--       If Timer >= .fly_timer Then .fly_timer = 0
    if timer >= this.fly_timer then this.fly_timer = 0 end
--
--       If .fly_count >= 50 Then
    if this.fly_count >= 50 then
--
--         .fly_count = 0
      this.fly_count = 0
--         .fly_timer = 0
      this.fly_timer = 0
--         .flash_timer = 0
      this.flash_timer = 0
--         .invisible = 0
      this.invisible = 0
--         .mad =  0
      this.mad = 0
--
--         Return 1
      return 1
--
--       End If
    end
--
--       Return 0
    return 0
--
--     End If
  end
--
--
--     If .fly_length = 0 Then
  if this.fly_length == 0 then
--
--       If .fly_timer = 0 Then
    if this.fly_timer == 0 then
--         .fly_timer = Timer + .2
      this.fly_timer = timer + .2
--
--       End If
    end
--       If Timer > .fly_timer Then .fly_timer = 0
    if timer > this.fly_timer then this.fly_timer = 0 end
--
--       If .fly_timer = 0 Then
    if this.fly_timer == 0 then
--
--         .fly_count = 0
      this.fly_count = 0
--         .fly_timer = 0
      this.fly_timer = 0
--         .flash_timer = 0
      this.flash_timer = 0
--         .invisible = 0
      this.invisible = 0
--         .mad =  0
      this.mad = 0
-- '        .return_trig = -1
--
--         Return 1
      return 1
--
--
--       End If
    end
--
--       Return 0
    return 0
--
--     End If
  end
--
--     If .fly_timer = 0 Then
  if this.fly_timer == 0 then
--
--       .fly_hold = .direction
    this.fly_hold = this.direction
--
--
--       Select Case .fly.y
--
--         Case Is < 0
    if this.fly.y < 0 then
--
--           .direction = 0
      this.direction = 0
--             move_object( this, , Abs( .fly.y ) )
      move_object(this, nil, math.abs(this.fly.y))
--
--         Case Is > 0
    elseif this.fly.y > 0 then
--
--           .direction = 2
      this.direction = 2
--             move_object( this, , Abs( .fly.y ) )
      move_object(this, nil, math.abs(this.fly.y))
--
--         Case 0
    elseif this.fly.y == 0 then
--
--
--
--       End Select
    end
--
--       Select Case .fly.x
--
--         Case Is < 0
    if this.fly.x < 0 then
--
--           .direction = 3
      this.direction = 3
--
--             move_object( this, , Abs( .fly.x ) )
      move_object(this, nil, math.abs(this.fly.x))
--
--         Case Is > 0
    elseif this.fly.x > 0 then
--
--           .direction = 1
      this.direction = 1
--
--             move_object( this, , Abs( .fly.x ) )
      move_object(this, nil, math.abs(this.fly.x))
--
--
--         Case 0
    elseif this.fly.x == 0 then
--
--
--
--
--       End Select
    end
--
--
--       .fly_timer = Timer + .fly_speed
    this.fly_timer = timer + this.fly_speed
--       .fly_count += 1
    this.fly_count = this.fly_count + 1
--       .direction = .fly_hold
    this.direction = this.fly_hold
--
--     End If
  end
--
--     If Timer >= .fly_timer Then .fly_timer = 0
  if timer >= this.fly_timer then this.fly_timer = 0 end
--
--     If .fly_count >= .fly_length Then
  if this.fly_count >= this.fly_length then
--
--       .fly_count = 0
    this.fly_count = 0
--       .fly_timer = 0
    this.fly_timer = 0
--       .flash_timer = 0
    this.flash_timer = 0
--       .invisible = 0
    this.invisible = 0
--       .mad =  0
    this.mad = 0
--
--       Return 1
    return 1
--
--     End If
  end
--
--   End With
--
--
  return 0
-- End Function
end

-- Function __go_grip ( this As _char_type Ptr ) As Integer
function __go_grip(this)
--
--
--   Dim As Integer all_momentum
  local all_momentum = 0
--
--   For all_momentum = 0 To 7
  for all_momentum = 0, 7 do
--
--     If this->momentum.i( all_momentum ) <> 0 Then
    if this.momentum.i[all_momentum] ~= 0 then
--
--       this->momentum.i( all_momentum ) = 1
      this.momentum.i[all_momentum] = 1
--
--     End If
    end
--
--   Next
  end
--
--   Return 1
  return 1
--
--
--
-- End Function
end

-- Function __stop_grip ( this As _char_type Ptr ) As Integer
function __stop_grip(this)
--
--
--   Scope
--
--     Dim As Integer all_momentum
  local all_momentum = 0
--
--       For all_momentum = 0 To 7
  for all_momentum = 0, 7 do
--
--         this->momentum_history.i( all_momentum ) = this->momentum.i( all_momentum )
    this.momentum_history.i[all_momentum] = this.momentum.i[all_momentum]
--
--         If this->momentum.i( all_momentum ) <> 0 Then
    if this.momentum.i[all_momentum] ~= 0 then
--
--           this->momentum.i( all_momentum ) = 0
      this.momentum.i[all_momentum] = 0
--
--         End If
    end
--
--       Next
  end
--
--   End Scope
--
--   Return 1
  return 1
--
--
-- End Function
--
end
