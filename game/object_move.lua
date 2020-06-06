require("game/engine_enums")

function copter_path(this)
  log.debug("copter_path called.")
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
    --FIXME: Hard coded 0 here so we can test just one case of object movement to start. Remove.
    log.debug("Setting direction to 0.")
    this.direction = 0 --this.direction + rand_dir
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

function walk(this)
  log.debug("walk called.")
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
  end
--
--
--     If this->on_ice = 0 Then
  if this.on_ice == 0 then
--       '' traction
--
--       __go_grip( this )
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
    this.frame = 1
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
    this.frame = 1
--       this->frame_hold = Timer + this->animControl[this->current_anim].rate
    this.frame_hold = timer + this.animControl[this.current_anim].rate
--
--       '' reset rate?
--     End If
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
