require("game/utility")

-- ''''''''''''''''''''''''''
-- ''  Grult
-- ''::::::::::::::::::::::::
--
-- Function __grult_fireball ( this As _char_type Ptr ) As Integer
function __grult_fireball(this)
--
--
--   With *this
  local with0 = this
--
--
--     If .grult_proj_trig = 0 Then
  if with0.grult_proj_trig == 0 then
--
--       .projectile->coords[0].x = 52 + .coords.x '' it's coming out of his mouth
    with0.projectile.coords[0].x = 52 + with0.coords.x
--       .projectile->coords[0].y = 36 + .coords.y
    with0.projectile.coords[0].y = 36 + with0.coords.y
-- '      .projectile->coords[0].x = 52 + .coords.x '' it's coming out of his mouth
-- '      .projectile->coords[0].y = 36 + .coords.y
--
--       __do_grult_proj ( cptr( Any Ptr, 0 ) )
    __do_grult_proj(nil)
--
--       .grult_proj_trig = 1
    with0.grult_proj_trig = 1
--
--     End If
  end
--
--   End With
--
--   Return 1
  return 1
--
--
-- End Function
end
--
--
-- Function __do_grult_proj ( this As _char_type Ptr ) As Integer
function __do_grult_proj(this)
--
--   Static As uByte projLock
  if projLock == nil then projLock = 0 end
--
--   If this = 0 Then
  if this == nil then
--
--     projLock = 0
    projLock = 0
--     Return 0
    return 0
--
--   End If
  end
--
--   If this->fly_timer = 0 Then
  if this.fly_timer == 0 then
--
--     If ( this->projectile->travelled And 3 ) = 0 Then
    if bit.band(this.projectile.travelled, 3) == 0 then
--
--       If ( Abs( this->projectile->coords[0].x - llg( hero ).coords.x ) < 48 ) Then
      if (math.abs(this.projectile.coords[0].x - ll_global.hero.coords.x) < 48) then
--
--         If ( Abs( this->projectile->coords[0].y - llg( hero ).coords.y ) < 48 ) Then
        if (math.abs(this.projectile.coords[0].y - ll_global.hero.coords.y) < 48) then
--
--           projLock = 1
          projLock = 1
--
--         End If
        end
--
--       End If
      end
--
--       Dim As vector_pair grultProjectile
      local grultProjectile = get_next_vector_pair()
--       With this->projectile->coords[0]
      local with0 = this.projectile.coords[0]
--
--         grultProjectile.u.x = .x
      grultProjectile.u.x = with0.x
--         grultProjectile.u.y = .y
      grultProjectile.u.y = with0.y
--
--         grultProjectile.v = Type <vector> ( 4, 4 )
      grultProjectile.v.x = 4
      grultProjectile.v.y = 4
--
--         If projLock = 0 Then
      if projLock == 0 then
--           this->fly = V2_CalcFlyback( V2_MidPoint( LLO_VP( Varptr( llg( hero ) ) ) ), V2_MidPoint( grultProjectile ) )
        local fly = V2_CalcFlyback(V2_MidPoint(LLO_VP(ll_global.hero)), V2_MidPoint(grultProjectile))
        this.fly.x = fly.x
        this.fly.y = fly.y
--
--         End If
      end
--
--       End With
--
--     End If
    end
--
--     this->projectile->coords[0] = V2_Add( this->projectile->coords[0], this->fly )
    local tempVector = V2_Add(this.projectile.coords[0], this.fly)
    this.projectile.coords[0].x = tempVector.x
    this.projectile.coords[0].y = tempVector.y
--
--
--     this->fly_timer = Timer + this->fly_speed
    this.fly_timer = timer + this.fly_speed
--     this->projectile->travelled += 1
    this.projectile.travelled = this.projectile.travelled + 1
--
--   End If
  end
--
--   If Timer >= this->fly_timer Then this->fly_timer = 0
  if timer >= this.fly_timer then this.fly_timer = 0 end
--
--   If this->projectile->travelled >= this->projectile->length Then
  if this.projectile.travelled >= this.projectile.length then
--
--     LLObject_ClearProjectiles( *this )
    LLObject_ClearProjectiles(this)
--     this->fly_timer = 0
    this.fly_timer = 0
--
--     this->grult_proj_trig = 0
    this.grult_proj_trig = 0
--
--
--   End If
  end
--
  return 0
--
-- End Function
end
--
--
-- Function __do_circle ( this As _char_type Ptr ) As Integer
function __do_circle(this)
--
--   If this->walk_hold = 0 Then
  if this.walk_hold == 0 then
--
--     Dim As Double Radians = ( 3.14159 / 180 ) * this->Degree
    local radians = (3.14159 / 180) * this.degree
--     Dim As Single mov_x = this->radius * Sin( Radians )
    local mov_x = this.radius * math.sin(radians)
--     Dim As Single mov_y = this->radius * Cos( Radians )
    local mov_y = this.radius * math.cos(radians)
--
--
--     this->coords.x = this->x_origin + mov_x
    this.coords.x = this.x_origin + mov_x
--     this->coords.y = this->y_origin - mov_y
    this.coords.y = this.y_origin - mov_y
--
--
--     If this->degree Mod 45 = 0 Then
    if math.floor(this.degree) % 45 == 0 then
--       '' could shoot...
--
--       If chance_Percent( 30 ) Then
      if chance_Percent(30) then
--         this->funcs.current_func[this->funcs.active_state] = 0
        this.funcs.current_func[this.funcs.active_state] = 0
--         this->funcs.active_state = this->proj_state
        this.funcs.active_state = this.proj_state
--         this->funcs.current_func[this->funcs.active_state] = 0
        this.funcs.current_func[this.funcs.active_state] = 0
--
--         Return
        return 0
--
--       End If
      end
--
--     End If
    end
--
--     If this->degree >= 360 Then this->degree = 0 Else this->degree += .75
    if this.degree >= 360 then this.degree = 0 else this.degree = this.degree + .75 end
--
--     this->walk_hold = Timer + this->walk_speed
    this.walk_hold = timer + this.walk_speed
--
--   End If
  end
--
--   If Timer >= this->walk_hold Then
  if timer >= this.walk_hold then
--     this->walk_hold = 0
    this.walk_hold = 0
--
--   End If
  end
--
--   If LLObject_IncrementFrame( this ) <> 0 Then
  if LLObject_IncrementFrame(this) ~= 0 then
--     this->animating = 0
    this.animating = 0
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

-- ''***************************************
-- ''  dyssius
-- ''***************************************
--
-- Function __dyssius_slide( this As _char_type Ptr ) As Integer
function __dyssius_slide(this)
--
--
--   Static slide_length As Integer = 100, slide_hold
  if slide_length == nil then slide_length = 100 end
  if slide_hold == nil then slide_hold = 0 end
--   Dim As Double slideSpeed
  local slideSpeed = 0.0
--   Dim As Integer i
  local i = 0
--
--   With *this
  local with0 = this
--
--     If .walk_hold = 0 Then
  if with0.walk_hold == 0 then
--
--
--       If slide_hold = 0 Then
    if slide_hold == 0 then
--         .frame = 1
      with0.frame = 1
--         Do
      repeat
--           i += 1
        i = i + 1
--
--           .direction = Int( Rnd * 8 )
        with0.direction = math.floor(math.random() * 8)
--           If move_object( this, MO_JUST_CHECKING ) <> 0 Then
        if move_object(this, MO_JUST_CHECKING) ~= 0 then
--             Exit Do
          break
--
--           End If
        end
--           If i = 20 Then Exit Do
        if i == 20 then break end
--
--         Loop
      until false
--
--       End If
    end
--
--
--       If .unique_id = u_steelstrider Then
    if with0.unique_id == u_steelstrider then
--         slideSpeed = 4
      slideSpeed = 4
--       Else
    else
--         slideSpeed = .walk_speed * 2
      slideSpeed = with0.walk_speed * 2
--
--       End If
    end
--       .momentum.i( .direction ) += slideSpeed
    with0.momentum.i[with0.direction] = with0.momentum.i[with0.direction] + slideSpeed
--
--       If move_object( this, MO_JUST_CHECKING, .momentum.i( .direction ) ) = 0 Then
    if move_object(this, MO_JUST_CHECKING, with0.momentum.i[with0.direction]) == 0 then
--         slide_hold = slide_length - 1
      slide_hold = slide_length - 1
--       Else
    else
--         __momentum_move( this )
      __momentum_move(this)
--
--       End If
    end
--
--
--
--       slide_hold += 1
    slide_hold = slide_hold + 1
--
--       If slide_hold = slide_length Then
    if slide_hold == slide_length then
--         slide_hold = 0
      slide_hold = 0
--         Return 1
      return 1
--
--       End If
    end
--
--       .walk_hold = Timer + .walk_speed
    with0.walk_hold = timer + with0.walk_speed
--
--     End If
  end

--
--     If Timer > .walk_hold Then .walk_hold = 0
  if timer > with0.walk_hold then with0.walk_hold = 0 end
--
--   End With
--
--
  return 0
-- End Function
end
--
--
-- Function __dyssius_after_slide( this As _char_type Ptr ) As Integer
function __dyssius_after_slide(this)
--
--   If this->momentum.i( this->direction ) = 0 Then
  if this.momentum.i[this.direction] == 0 then
--     this->frame = 0
    this.frame = 0
--     Return 1
    return 1
--
--   End If
  end
--
  return 0
-- End Function
end
--
--
-- Function __dyssius_idle_gate( this As _char_type Ptr ) As Integer
function __dyssius_idle_gate(this)
--
--
--   If chance_Percent( 30 ) Then
  if chance_Percent(30) then
--     Return 1
    return 1
--
--   Else
  else
--     __return_idle( this )
    __return_idle(this)
--
--   End If
  end
--
--
  return 0
-- End Function
end
--
--
-- Function __do_dyssius_proj( this As _char_type Ptr ) As Integer
function __do_dyssius_proj(this)
--
--   With *this
  local with0 = this
--
--     If .projectile->refreshTime = 0 Then
  if with0.projectile.refreshTime == 0 then
--
--       If .projectile->sound = 0 Then
    if with0.projectile.sound == 0 then
--
--         play_sample( llg( snd )[sound_beam] )
      ll_global.snd[sound_beam]:play()
--         .projectile->sound = -1
      with0.projectile.sound = -1
--
--       End If
    end
--
--
--       If .projectile->travelled = 0 Then
    if with0.projectile.travelled == 0 then
--         ''initing proj
--         .projectile->coords[0].x = 120 + .coords.x
      with0.projectile.coords[0].x = 120 + with0.coords.x
--         .projectile->coords[0].y = 105 + .coords.y
      with0.projectile.coords[0].y = 105 + with0.coords.y
--
--         .projectile->coords[1].x = .projectile->coords[0].x
      with0.projectile.coords[1].x = with0.projectile.coords[0].x
--         .projectile->coords[1].y = .projectile->coords[0].y + 16
      with0.projectile.coords[1].y = with0.projectile.coords[0].y + 16
--
--         .projectile->travelled += 1
      with0.projectile.travelled = with0.projectile.travelled + 1
--
--       Else
    else
--
--
--         .projectile->coords[0].y += 16
      with0.projectile.coords[0].y = with0.projectile.coords[0].y + 16
--         .projectile->coords[1].y += 16
      with0.projectile.coords[1].y = with0.projectile.coords[1].y + 16
--
--         .projectile->travelled += 1
      with0.projectile.travelled = with0.projectile.travelled + 1
--
--         If .projectile->travelled >= .projectile->length Then
      if with0.projectile.travelled >= with0.projectile.length then
--
--           LLObject_ClearProjectiles( *this )
        LLObject_ClearProjectiles(this)
--
--           Return 1
        return 1
--
--         End If
      end
--
--       End If
    end
--
--       .projectile->refreshTime = Timer + .animControl[.proj_anim].rate
    with0.projectile.refreshTime = timer + with0.animControl[with0.proj_anim].rate
--
--     Else
  else
--
--       If Timer >= .projectile->refreshTime Then .projectile->refreshTime = 0
    if timer >= with0.projectile.refreshTime then with0.projectile.refreshTime = 0 end
--
--     End If
  end
--
--
--
--
--   End With
--
--
  return 0
-- End Function
end
--
--
-- Function __dyssius_flyback ( this As _char_type Ptr ) As Integer
function __dyssius_flyback(this)
--
--
--
--   With *this
  local with0 = this
--
--
--     If .fly_timer = 0 Then
  if with0.fly_timer == 0 then
--       .fly_timer = Timer + .fly_speed
    with0.fly_timer = timer + with0.fly_speed
--       .fly_count += 1
    with0.fly_count = with0.fly_count + 1
--
--     End If
  end
--
--     If Timer >= .fly_timer Then .fly_timer = 0
  if timer >= with0.fly_timer then with0.fly_timer = 0 end
--
--     If ( .projectile->coords[0].x <> 0 ) Or ( .projectile->coords[0].y <> 0 ) Then
  if (with0.projectile.coords[0].x ~= 0) or (with0.projectile.coords[0].y ~= 0) then
--       .projectile->coords[0].x = 0
    with0.projectile.coords[0].x = 0
--       .projectile->coords[0].y = 0
    with0.projectile.coords[0].y = 0
--       .projectile->coords[1].x = 0
    with0.projectile.coords[1].x = 0
--       .projectile->coords[1].y = 0
    with0.projectile.coords[1].y = 0
--       .projectile->refreshTime = 0
    with0.projectile.refreshTime = 0
--       .projectile->travelled = 0
    with0.projectile.travelled = 0
--       .projectile->sound = 0
    with0.projectile.sound = 0
--
--     End If
  end
--
--     If .fly_count >= 50 Then
  if with0.fly_count >= 50 then
--
--       .fly_count = 0
    with0.fly_count = 0
--       .fly_timer = 0
    with0.fly_timer = 0
--       .invisible = 0
    with0.invisible = 0
--
--       LLObject_ClearDamage( this )
    LLObject_ClearDamage(this)
--
--       __return_idle( this )
    __return_idle(this)
--
--
--     End If
  end
--
--
--
--     Return 0
  return 0
--
--   End With
--
--
-- End Function
end
--
--
--
--
--
--
--
-- Function __dyssius_jump_slide( this As _char_type Ptr ) As Integer
function __dyssius_jump_slide(this)
--
--   this->funcs.current_func[this->funcs.active_state] = 0
  this.funcs.current_func[this.funcs.active_state] = 0
--   this->funcs.active_state = 0
  this.funcs.active_state = 0
--   this->funcs.current_func[this->funcs.active_state] = 2
  this.funcs.current_func[this.funcs.active_state] = 2
--
--   Return 0
  return 0
--
-- End Function
end
--
--
--
--
-- Function __dyssius_patience( this As _char_type Ptr ) As Integer
function __dyssius_patience(this)
--
--
--   If this->sway = 0 Then
  if this.sway == 0 then
--     this->sway = Timer + 4.5
    this.sway = timer + 4.5
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
--
--
-- Function __dyssius_eye_explode( this As _char_type Ptr ) As Integer
function __dyssius_eye_explode(this)
--
--   this->expl_x_off = 117
  this.expl_x_off = 117
--   this->expl_y_off = 98
  this.expl_y_off = 98
--
--   this->expl_x_size = 16
  this.expl_x_size = 16
--   this->expl_y_size = 16
  this.expl_y_size = 16
--
--   this->explosions = 5
  this.explosions = 5
--
--   Return 1
  return 1
--
--
-- End Function
end
--
--
-- Function __dyssius_full_explode( this As _char_type Ptr ) As Integer
function __dyssius_full_explode(this)
--
--   this->expl_x_off = 0
  this.expl_x_off = 0
--   this->expl_y_off = 0
  this.expl_y_off = 0
--
--   this->expl_x_size = 0
  this.expl_x_size = 0
--   this->expl_y_size = 0
  this.expl_y_size = 0
--
--   this->explosions = 30
  this.explosions = 30
--
--   Return 1
  return 1
--
-- End Function
end
