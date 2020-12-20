-- Function __do_nothing ( this As _char_type Ptr ) As Integer
function __do_nothing(this)
--
--
--   Return 1
  return 1
--
--
--
-- End Function
end

-- Function __infinity ( this As _char_type Ptr ) As Integer
function __infinity(this)
--
--   Return 0
  return 0
--
-- End Function
end

-- Function __trigger_projectile ( this As _char_type Ptr ) As Integer
function __trigger_projectile(this)
--
--
--   this->projectile->active = this->proj_style
  this.projectile.active = this.proj_style
--
--   Return 1
  return 1
--
--
-- End Function
end
