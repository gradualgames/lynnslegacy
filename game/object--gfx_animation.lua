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
