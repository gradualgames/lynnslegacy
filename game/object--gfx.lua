-- Function __flicker ( this As _char_type Ptr ) As Integer
function __flicker(this)
--
--
--
--   If this->flash_timer = 0 Then
  if this.flash_timer == 0 then
--     '' flash timer is initialized
--
--     this->invisible = IIf( this->invisible = 0, -1, 0 )
    this.invisible = this.invisible == 0 and -1 or 0
--
--     this->flash_timer = Timer + this->flash_time
    this.flash_timer = timer + this.flash_time
--     this->flash_count += 1
    this.flash_count = this.flash_count + 1
--
--
--   End If
  end
--
--
--   If Timer >= this->flash_timer Then
  if timer >= this.flash_timer then
--     '' flash timer has expired, initialize it
--
--     this->flash_timer = 0
    this.flash_timer = 0
--
--   End If
  end
--
--
--   If this->flash_count >= this->flash_length Then
  if this.flash_count >= this.flash_length then
--     '' flash counter filled up
--
--     '' reset  damage flags
--     this->flash_count = 0
    this.flash_count = 0
--     this->flash_timer = 0
    this.flash_timer = 0
--     this->invisible = 0
    this.invisible = 0
-- '    LLObject_ClearDamage( this )
-- '    this->damaged_by = -1
--
--     Return 1
    return 1
--
--   End If
  end
--
--   If this->dead <> 0 then
  if this.dead ~= 0 then
--
--     If this->isBoss Or ( this->unique_id = u_charger ) Or ( this->unique_id = u_swordie ) Then '( this->unique_id = u_grult ) Or ( this->unique_id = u_dyssius ) Or ( this->unique_id = u_steelstrider ) Or ( this->unique_id = u_anger ) Or ( this->unique_id = u_sterach ) Or ( this->unique_id = u_swordie ) Or ( this->unique_id = u_divine ) Or ( this->unique_id = u_divine_bug ) Then
    if this.isBoss or (this.unique_id == u_charger) or (this.unique_id == u_swordie) then
--       Return 1
      return 1
--
--     End If
    end
--
--   End If
  end
--
--
--
  return 0
-- End Function
end

-- Function __flashy ( this As _char_type Ptr ) As Integer
function __flashy(this)
  -- log.debug("__flashy called.")
  -- log.debug("this.flash_timer: "..this.flash_timer)
  -- log.debug("this.flash_time: "..this.flash_time)
  -- log.debug("this.flash_count: "..this.flash_count)
  -- log.debug("this.flash_length: "..this.flash_length)
  -- log.debug("this.invisible: "..this.invisible)
--
--   If this->flash_timer = 0 Then
  if this.flash_timer == 0 then
--     '' flash timer is initialized
--
--     this->invisible = Not this->invisible
    this.invisible = bit.bnot(this.invisible)
--     this->flash_timer = Timer + this->flash_time
    this.flash_timer = timer + this.flash_time
--     this->flash_count += 1
    this.flash_count = this.flash_count + 1
--
--
--   End If
  end
--
--
--   If Timer >= this->flash_timer Then
  if timer >= this.flash_timer then
--     '' flash timer has expired, initialize it
--
--     this->flash_timer = 0
    this.flash_timer = 0
--
--   End If
  end
--
--
--   If this->flash_count >= this->flash_length Then
  if this.flash_count >= this.flash_length then
--
--     '' reset damage & flash flags
--     this->flash_count = 0
    this.flash_count = 0
--     this->flash_timer = 0
    this.flash_timer = 0
--     this->invisible = 0
    this.invisible = 0
--
--     this->dmg.id = 0
    this.dmg.id = 0
--     If this->unique_id <> u_pekkle_grey Then
    if this.unique_id ~= u_pekkle_grey then
--
--       LLObject_ClearDamage( this )
      LLObject_ClearDamage(this)
--
--     End If
    end
--
--
--   End If
  end
--
--   Return 0
  return 0
--
-- End Function
end

-- Function __weapon_anim ( this As _char_type Ptr ) As Integer
function __weapon_anim(this)
  -- log.debug("__weapon_anim called.")
--   this->current_anim = llg( hero_only ).weapon + 3
  --NOTE: Animations are in a 1-indexed array so bump up offset by 1
  this.current_anim = ll_global.hero_only.weapon + 3
--   this->frame = 0
  this.frame = 0
--
--   Return 1
  return 1
--
--
-- End Function
end

-- Function __active_anim_0 ( this As _char_type Ptr ) As Integer
function __active_anim_0(this)
  log.debug("__active_anim_0 called.")
--
--
--   this->current_anim = 0
  this.current_anim = 0
--   this->frame = 0
  this.frame = 0
--
--   Return 1
  return 1
--
--
-- End Function
end

function __active_anim_1(this)
  log.debug("__active_anim_1 called.")
--   this->current_anim = 1
  this.current_anim = 1
--   this->frame = 0
  this.frame = 0
--
--   Return 1
  return 1
end

-- Function __active_anim_2 ( this As _char_type Ptr ) As Integer
function __active_anim_2(this)
--
--   this->current_anim = 2
  this.current_anim = 2
--   this->frame = 0
  this.frame = 0
--
--   Return 1
  return 1
--
--
-- End Function
end

-- Function __active_anim_3 ( this As _char_type Ptr ) As Integer
function __active_anim_3(this)
--
--
--   this->current_anim = 3
  this.current_anim = 3
--   this->frame = 0
  this.frame = 0
--
--   Return 1
  return 1
--
--
-- End Function
end

-- Function __active_anim_4 ( this As _char_type Ptr ) As Integer
function __active_anim_4(this)
--   this->current_anim = 4
  this.current_anim = 4
--   this->frame = 0
  this.frame = 0
--
--   Return 1
  return 1
--
--
-- End Function
end
--
--
-- Function __active_anim_5 ( this As _char_type Ptr ) As Integer
function __active_anim_5(this)
--   this->current_anim = 5
  this.current_anim = 5
--   this->frame = 0
  this.frame = 0
--
--   Return 1
  return 1
--
--
-- End Function
end
--
--
-- Function __active_anim_6 ( this As _char_type Ptr ) As Integer
function __active_anim_6(this)
--   this->current_anim = 6
  this.current_anim = 6
--   this->frame = 0
  this.frame = 0
--
--   Return 1
  return 1
--
--
-- End Function
end
--
--
-- Function __active_anim_7 ( this As _char_type Ptr ) As Integer
function __active_anim_7(this)
--   this->current_anim = 7
  this.current_anim = 7
--   this->frame = 0
  this.frame = 0
--
--   Return 1
  return 1
--
--
-- End Function
end
--
--
-- Function __active_anim_8 ( this As _char_type Ptr ) As Integer
function __active_anim_8(this)
--   this->current_anim = 8
  this.current_anim = 8
--   this->frame = 0
  this.frame = 0
--
--   Return 1
  return 1
--
--
-- End Function
end
--
--
-- Function __active_anim_9 ( this As _char_type Ptr ) As Integer
function __active_anim_9(this)
--   this->current_anim = 9
  this.current_anim = 9
--   this->frame = 0
  this.frame = 0
--
--   Return 1
  return 1
--
--
-- End Function
end
--
--
-- Function __active_anim_10 ( this As _char_type Ptr ) As Integer
function __active_anim_10(this)
--   this->current_anim = 10
  this.current_anim = 10
--   this->frame = 0
  this.frame = 0
--
--   Return 1
  return 1
--
--
-- End Function
end
--
--
-- Function __active_anim_0 ( this As _char_type Ptr ) As Integer
function __active_anim_0(this)
--
--
--   this->current_anim = 0
  this.current_anim = 0
--   this->frame = 0
  this.frame = 0
--
--   Return 1
  return 1
--
--
-- End Function
end
--
--
-- Function __active_anim_dead ( this As _char_type Ptr ) As Integer
function __active_anim_dead(this)
--
--
--   this->frame = 0
  this.frame = 0
--   this->current_anim = this->dead_anim
  this.current_anim = this.dead_anim
--
--   Return 1
  return 1
--
--
-- End Function
end
