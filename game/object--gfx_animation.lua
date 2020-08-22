require("game/object--gfx_frame")

function active_animate(this)
  log.debug("active_animate called.")
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
function directional_animate(this)
  log.debug("directional_animate called.")
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
