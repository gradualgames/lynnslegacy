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

-- Function __cond_trigger_projectile ( this As _char_type Ptr ) As Integer
function __cond_trigger_projectile(this)
--
--
--
--
--   Dim As Integer per
  local per = 0
--
--   per = Int ( Rnd * 10 )
  per = math.floor(math.random() * 10)
--
--   If per >= 2 Then this->projectile->active = this->proj_style
  if per >= 2 then this.projectile.active = this.proj_style end
--
--
--   Return 1
  return 1
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
