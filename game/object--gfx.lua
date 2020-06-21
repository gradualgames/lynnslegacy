-- Function __active_anim_0 ( this As _char_type Ptr ) As Integer
function active_anim_0(this)
--
--
--   this->current_anim = 0
  this.current_anim = 1
--   this->frame = 0
  this.frame = 1
--
--   Return 1
  return 1
--
--
-- End Function
end

function active_anim_1(this)
  --log.debug("active_anim_1 called.")
--   this->current_anim = 1
  this.current_anim = 2
--   this->frame = 0
  this.frame = 1
--
--   Return 1
  return 1
end

-- Function __active_anim_2 ( this As _char_type Ptr ) As Integer
function active_anim_2(this)
--
--   this->current_anim = 2
  this.current_anim = 3
--   this->frame = 0
  this.frame = 1
--
--   Return 1
  return 1
--
--
-- End Function
end
