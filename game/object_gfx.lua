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
--   this->current_anim = llg( hero_only ).weapon + 3
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

-- Function __explode ( this As _char_type Ptr ) As Integer
function __explode(this)
--
--   If this->expl_timer = 0 Then
  if this.expl_timer == 0 then
--
--     this->cur_expl += 1
    this.cur_expl = this.cur_expl + 1
--     If this->cur_expl >= this->explosions Then
    if this.cur_expl >= this.explosions then
--       this->cur_expl = this->explosions
      this.cur_expl = this.explosions
--     Else
    else
--
--     End If

    end
--
--     this->expl_timer = Timer + this->expl_delay + ( Rnd * .1 )
    this.expl_timer = timer + this.expl_delay + (math.random() * .1)
--
--   End If
  end
--
--   If Timer >= this->expl_timer Then this->expl_timer = 0
  if timer >= this.expl_timer then this.expl_timer = 0 end
--
--   Dim As Integer do_expl
  local do_expl = 0
--
--   For do_expl = 0 To this->cur_expl - 1
  for do_expl = 0, this.cur_expl - 1 do
--
--
    if this.explosion[do_expl] == nil then
      this.explosion[do_expl] = create_mat_expl()
    end
--     If ( this->explosion( do_expl ).x = 0 ) And ( this->explosion( do_expl ).y = 0 ) Then
    if (this.explosion[do_expl].x == 0) and (this.explosion[do_expl].y == 0) then
--
--       this->explosion( do_expl ).alive = -1
      this.explosion[do_expl].alive = -1
--
--       Dim As Integer _xo = this->expl_x_off, _yo = this->expl_y_off, _xs = this->expl_x_size, _ys = this->expl_y_size
      local _xo, _yo, _xs, _ys = this.expl_x_off, this.expl_y_off, this.expl_x_size, this.expl_y_size
--
--       this->explosion( do_expl ).x = this->coords.x + _xo - ( ( this->anim[this->expl_anim]->x ) \ 2 ) '(this->coords.x + this->animControl[this->current_anim].x_off ) + _xo
      this.explosion[do_expl].x = this.coords.x + _xo - math.floor((this.anim[this.expl_anim].x) / 2)
--       this->explosion( do_expl ).y = this->coords.y + _yo - ( ( this->anim[this->expl_anim]->y ) \ 2 ) '(this->coords.y + this->animControl[this->current_anim].y_off ) + _yo
      this.explosion[do_expl].y = this.coords.y + _yo - math.floor((this.anim[this.expl_anim].y) / 2)
--
--
--       If _xs <> 0 Then
      if _xs ~= 0 then
--         this->explosion( do_expl ).x += Int(Rnd * _xs)
        this.explosion[do_expl].x = this.explosion[do_expl].x + math.floor(math.random() * _xs)
--
--       Else
      else
--         this->explosion( do_expl ).x += Int(Rnd * this->perimeter.x)
        this.explosion[do_expl].x = this.explosion[do_expl].x + math.floor(math.random() * this.perimeter.x)
--
--       End If
      end
--
--       If _ys <> 0 Then
      if _ys ~= 0 then
--         this->explosion( do_expl ).y += Int(Rnd * _ys)
        this.explosion[do_expl].y = this.explosion[do_expl].y + math.floor(math.random() * _ys)
--
--       Else
      else
--         this->explosion( do_expl ).y += Int(Rnd * this->perimeter.y)
        this.explosion[do_expl].y = this.explosion[do_expl].y + math.floor(math.random() * this.perimeter.y)
--
--       End If
      end
--
--     End If
    end
--
--     If this->explosion( do_expl ).alive <> 0 Then
    if this.explosion[do_expl].alive ~= 0 then
--
--       If this->explosion( do_expl ).frame <= Int( Rnd * this->anim[this->expl_anim]->frames ) Then
      if this.explosion[do_expl].frame <= math.floor(math.random() * this.anim[this.expl_anim].frames) then
--
--         If this->explosion( do_expl ).sound = 0 Then
        if this.explosion[do_expl].sound == 0 then
--
--           this->explosion( do_expl ).sound = -1
          this.explosion[do_expl].sound = -1
--
--           play_sample( llg( snd )[sound_explosion], 70 )
          this.explosion[do_expl].sound_source:setVolume(.7)
          this.explosion[do_expl].sound_source:play()
--
--
--         End If
        end
--
--       End If
      end
--
--       If this->explosion( do_expl ).frame_hold = 0 Then
      if this.explosion[do_expl].frame_hold == 0 then
--
--         this->explosion( do_expl ).frame += 1
        this.explosion[do_expl].frame = this.explosion[do_expl].frame + 1
--
--         If this->explosion( do_expl ).frame = this->anim[this->expl_anim]->frames Then
        if this.explosion[do_expl].frame == this.anim[this.expl_anim].frames then
--           this->explosion( do_expl ).frame = 0
          this.explosion[do_expl].frame = 0
--           this->explosion( do_expl ).alive = 0
          this.explosion[do_expl].alive = 0
--
--         End If
        end
--
--         this->explosion( do_expl ).frame_hold = Timer + this->animControl[this->expl_anim].rate
        this.explosion[do_expl].frame_hold = timer + this.animControl[this.expl_anim].rate
--
--       End If
      end
--
--       If Timer >= this->explosion( do_expl ).frame_hold Then
      if timer >= this.explosion[do_expl].frame_hold then
--         this->explosion( do_expl ).frame_hold = 0
        this.explosion[do_expl].frame_hold = 0
--
--       End If
      end
--
--     End If
    end
--
--   Next
  end
--
--   Dim ver As Integer = -1
  local ver = -1
--
--   For do_expl = 0 To this->explosions - 1
  for do_expl = 0, this.explosions - 1 do
--
    if this.explosion[do_expl] == nil then
      this.explosion[do_expl] = create_mat_expl()
    end
--     ver = ver And ( this->explosion( do_expl ).alive = 0 )
    ver = bit.band(ver, ((this.explosion[do_expl].alive == 0) and -1 or 0))
--
--   Next
  end
--
--
--   If ver Then
  if ver ~= 0 then
--
--     For do_expl = 0 To this->explosions - 1
    for do_expl = 0, this.explosions - 1 do
--
--       this->explosion( do_expl ).x = 0
      this.explosion[do_expl].x = 0
--       this->explosion( do_expl ).y = 0
      this.explosion[do_expl].y = 0
--       this->explosion( do_expl ).frame = 0
      this.explosion[do_expl].frame = 0
--       this->explosion( do_expl ).alive = 0
      this.explosion[do_expl].alive = 0
--       this->explosion( do_expl ).sound = 0
      this.explosion[do_expl].sound = 0
--
--     Next
    end
--
--     this->cur_expl = 0
    this.cur_expl = 0
--     this->expl_timer = 0
    this.expl_timer = 0
--
--     If this->isBoss Or ( this->unique_id = u_charger ) Or ( this->unique_id = u_swordie ) Then '( this->unique_id = u_grult ) Or ( this->unique_id = u_dyssius ) Or ( this->unique_id = u_steelstrider ) Or ( this->unique_id = u_anger ) Or ( this->unique_id = u_sterach ) Or ( this->unique_id = u_swordie ) Or ( this->unique_id = u_charger ) Or ( this->unique_id = u_divine ) Or ( this->unique_id = u_divine_bug ) Then
    if this.isBoss ~= 0 or (this.unique_id == u_charger) or (this.unique_id == u_swordie) then
--       Return 3
      return 3
--
--     End If
    end
--
--     '' if you put "fireworks" on, then the explosion waits until now to advance.
--
--     If this->fireworks <> 0 Then
    if this.fireworks ~= 0 then
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
--   If this->fireworks = 0 Then
  if this.fireworks == 0 then
--     Return 1
    return 1
--
--   End If
  end
--
--
--
--
  return 0
-- End Function
end
