require("game/object--gfx_frame")

function __active_animate(this)
  --log.debug("__active_animate called.")
  -- this->animating = 1
  this.animating = 1
  -- If LLObject_IncrementFrame( this ) <> 0 Then
  if LLObject_IncrementFrame(this) ~= 0 then
  --     this->frame -= 1
    this.frame = this.frame - 1
  --     this->frame_hold = Timer + this->animControl[this->current_anim].rate
    this.frame_hold = timer + this.animControl[this.current_anim].rate
  --     this->animating = 0
    this.animating = 0
  --     Return 1
    return 1
  --  End If
  end
  return 0
end

-- Function __active_animate_x ( this As _char_type Ptr ) As Integer
function __active_animate_x(this)
--
--
--   this->animating = 1
  this.animating = 1
--
--   If LLObject_IncrementFrame( this ) <> 0 Then
  if LLObject_IncrementFrame(this) ~= 0 then
--
--
--     this->frame -= 1
    this.frame = this.frame - 1
--
--     this->frame_hold = Timer + this->animControl[this->current_anim].rate
    this.frame_hold = timer + this.animControl[this.current_anim].rate
--
--     this->animating = 0
    this.animating = 0
--
--     Return 1
    return 1
--
--   End If
  end
--
--
  return 0
-- End Function
end

-- Function __dead_animate ( this As _char_type Ptr ) As Integer
function __dead_animate(this)
--
--
--   this->animating = 1
  this.animating = 1
--
--   If LLObject_IncrementFrame( this ) <> 0 Then
  if LLObject_IncrementFrame(this) ~= 0 then
--
--
--     this->frame -= 1
    this.frame = this.frame - 1
--
--     this->frame_hold = Timer + this->animControl[this->current_anim].rate
    this.frame_hold = timer + this.animControl[this.current_anim].rate
--
--     this->animating = 0
    this.animating = 0
--
--     Function = 1
    return 1
--
--   End If
  end
--
  return 0
-- End Function
end

-- Function __directional_animate ( this As _char_type Ptr ) As Integer
function __directional_animate(this)
  --log.debug("__directional_animate called.")
--
--   '' no "animating" for direction
--   If LLObject_IncrementFrame( this ) <> 0 Then
  if LLObject_IncrementFrame(this) ~= 0 then
--
--     this->frame -= 1
    this.frame = this.frame - 1
--
--     this->frame_hold = Timer + this->animControl[this->current_anim].rate
    this.frame_hold = timer + this.animControl[this.current_anim].rate
--     Return 1
    return 1
--
--   End If
  end
--
--
  return 0
-- End Function
end

-- Function __directional_animate_x ( this As _char_type Ptr ) As Integer
function __directional_animate_x(this)
--
--
--   If LLObject_IncrementFrame( this ) <> 0 Then
  if LLObject_IncrementFrame(this) ~= 0 then
--
--     this->frame = 0
    this.frame = 0
--     this->frame_hold = Timer + this->animControl[this->current_anim].rate
    this.frame_hold = timer + this.animControl[this.current_anim].rate
--
--     Return 1
    return 1
--
--   End If
  end
--
--
  return 0
-- End Function
end

-- Function __idle_animate ( this As _char_type Ptr ) As Integer
function __idle_animate(this)
--
--   this->animating = 1
  this.animating = 1
--
--
--   If LLObject_IncrementFrame( this ) <> 0 Then
  if LLObject_IncrementFrame(this) ~= 0 then
--
--     this->animating = 0
    this.animating = 0
--
--     this->frame = 0
    this.frame = 0
--     this->frame_hold = Timer + this->animControl[this->current_anim].rate
    this.frame_hold = timer + this.animControl[this.current_anim].rate
--
--     Function = 1
    return 1
--
--   End If
  end
--
--
  return 0
-- End Function
end

-- Function __true_active_animate ( this As _char_type Ptr ) As Integer
function __true_active_animate(this)
--
--
--   this->animating = 1
  this.animating = 1
--
--   If LLObject_IncrementFrame( this ) <> 0 Then
  if LLObject_IncrementFrame(this) ~= 0 then
--
--     this->animating = 0
    this.animating = 0
--
--     this->frame = 0
    this.frame = 0
--     this->frame_hold = Timer + this->animControl[this->current_anim].rate
    this.frame_hold = timer + this.animControl[this.current_anim].rate
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

-- Function __explode_lynn( this As _char_type Ptr ) As Integer
function __explode_lynn(this)
--
--   Static As Integer explo
  if explo == nil then explo = 0 end
--
--   If explo = 0 Then
  if explo == 0 then
--     play_sample( llg( snd )[sound_explosion] )
    ll_global.snd[sound_explosion]:play()
--     explo += 1
    explo = explo + 1
--
--   End If
  end
--
--
--
--   this->coords.x = llg( hero ).coords.x - 24
  this.coords.x = ll_global.hero.coords.x - 24
--   this->coords.y = llg( hero ).coords.y - 24
  this.coords.y = ll_global.hero.coords.y - 24
--
--   If LLObject_IncrementFrame( this ) <> 0 Then
  if LLObject_IncrementFrame(this) ~= 0 then
--
--     this->frame = 0
    this.frame = 0
--     this->frame_hold = Timer + this->animControl[this->current_anim].rate
    this.frame_hold = timer + this.animControl[this.current_anim].rate
--     explo = 0
    explo = 0
--     Return 1
    return 1
--
--   End If
  end
--
--
  return 0
-- End Function
end
