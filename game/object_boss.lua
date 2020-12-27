require("game/macros")
require("game/matrices")
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

-- Function __anger_flyback( this As _char_type Ptr ) As Integer
function __anger_flyback(this)
--
--
--
--   With *this
  local with0 = this
--
--     If .slide_hold = 0 Then
  if with0.slide_hold == 0 then
--       .slide_hold = Timer + .fly_speed
    with0.slide_hold = timer + with0.fly_speed
--       .shifty_state += 1
    with0.shifty_state = with0.shifty_state + 1
--
--     End If
  end
--
--     If Timer >= .slide_hold Then .slide_hold = 0
  if timer >= with0.slide_hold then with0.slide_hold = 0 end
--
--     If .shifty_state >= 70 Then
  if with0.shifty_state >= 70 then
--
--       .shifty_state = 0
    with0.shifty_state = 0
--       .slide_hold   = 0
    with0.slide_hold = 0
--       .invisible    = 0
    with0.invisible = 0
--       LLObject_ClearDamage( this )
    LLObject_ClearDamage(this)
--
--       Return 1
    return 1
--
--     End If
  end
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
-- Function __anger_fireball_lock( this As _char_type Ptr ) As Integer
function __anger_fireball_lock(this)
--
--   Static As Double h
  if h == nil then h = 0.0 end
--
--
--
--   this->degree = h
  this.degree = h
--   h += ( 360 / 8 )
  h = h + (360 / 8)
--   If Abs( h - 360 ) < 1 Then
  if math.abs(h - 360) < 1 then
--     h = 0
    h = 0
--
--   End If
  end
--
--   Return 0
  return 0
--
-- End Function
end
--
--
-- Function __anger_fireball_circle( this As _char_type Ptr ) As Integer
function __anger_fireball_circle(this)
--
--
--
--   If this->walk_hold = 0 Then
  if this.walk_hold == 0 then
--
--
--
--     Dim As Double Radians = ( 3.14159 / 180 ) * this->Degree
    local Radians = (3.14159 / 180) * this.degree
--     Dim As Single mov_x = this->radius * Sin( Radians )
    local mov_x = this.radius * math.sin(Radians)
--     Dim As Single mov_y = this->radius * Cos( Radians )
    local mov_y = this.radius * math.cos(Radians)
--
--     this->coords.x = this->x_origin + mov_x
    this.coords.x = this.x_origin + mov_x
--     this->coords.y = this->y_origin - mov_y
    this.coords.y = this.y_origin - mov_y
--
--     If this->sway = 0 Then
    if this.sway == 0 then
--       this->sway = .5
      this.sway = .5
--
--     End If
    end
--
--     If this->lose_time <> 0 Then
    if this.lose_time ~= 0 then
--       this->sway = 1
      this.sway = 1
--       If ( this - 1 )->radius <> 0 Then
      if this.prev.radius ~= 0 then
--
--         If this->radius >= ( this - 1 )->radius Then
        if this.radius >= this.prev.radius then
--           this->lose_time = 0
          this.lose_time = 0
--
--           ( this )->sway = ( this - 1 )->sway
          this.sway = this.prev.sway
--           If ( this - 1 )->radius <> 0 Then
          if this.prev.radius ~= 0 then
--             ( this )->radius = ( this - 1 )->radius
            this.radius = this.prev.radius
--
--           End If
          end
--
--         End If
        end
--       Else
      else
--         If this->radius >= 32 Then
        if this.radius >= 32 then
--           this->lose_time = 0
          this.lose_time = 0
--
--           ( this )->sway = ( this - 1 )->sway
          this.sway = this.prev.sway
--           If ( this - 1 )->radius <> 0 Then
          if this.prev.radius ~= 0 then
--             ( this )->radius = ( this - 1 )->radius
            this.radius = this.prev.radius
--
--           End If
          end
--
--         End If
        end
--
--       End If
      end
--
--     Else
    else
--
--       If ( this->radius > 36 ) Or ( this->radius < 24 ) Then
      if (this.radius > 36) or (this.radius < 24) then
--         this->sway = -this->sway
        this.sway = -this.sway
--
--       End If
      end
--
--     End If
    end
--
--     this->radius += this->sway
    this.radius = this.radius + this.sway
--
--
--     If this->degree >= 360 Then this->degree = 0 Else this->degree += 3
    if this.degree >= 360 then this.degree = 0 else this.degree = this.degree + 3 end
--
--
--
--     this->walk_hold = Timer + this->walk_speed
    this.walk_hold = timer + this.walk_speed
--
--
--
--   End If
  end
--
--
--   If Timer >= this->walk_hold Then
  if timer >= this.walk_hold then
--
--
--
--     this->walk_hold = 0
    this.walk_hold = 0
--
--
--   End If
  end
--
--
--
--   If LLObject_IncrementFrame( this ) <> 0 Then
  if LLObject_IncrementFrame(this) ~= 0 then
--
--     this->animating = 0
    this.animating = 0
--     this->frame = 0
    this.frame = 0
--     this->frame_hold = Timer + this->animControl[this->current_anim].rate
    this.frame_hold = timer + this.animControl[this.current_anim].rate
--
--     '' reset rate?
--   End If
  end
--
--
--   Return 1
  return 1
--
--
-- End Function
end
--
--
--
--
--
-- Function __anger_kill_fireball( this As _char_type Ptr ) As Integer
function __anger_kill_fireball(this)
--
--   Dim As Integer c = 51, i
  local c, i = 51, 0
--
--   For i = c To c + 7
  for i = c, c + 7 do
--     __make_Dead( @now_room().enemy[i] )
    __make_dead(now_room().enemy[i])
--     __cripple( @now_room().enemy[i] )
    __cripple(now_room().enemy[i])
--
--
--
--
--   Next
  end
--
--   Return 1
  return 1
--
-- End Function
end
--
--
-- Function __anger_new_fireball( this As _char_type Ptr ) As Integer
function __anger_new_fireball(this)
--
--
--   Static As Integer active_ball
  if active_ball == nil then active_ball = 0 end
--
--   Dim As Integer c = active_ball + 1  + 50
  local c = active_ball + 1 + 50
--
--   del_room_enemies( 1,  @now_room().enemy[c] )
--   LLSystem_CopyNewObject( now_room().enemy[c] )
  LLSystem_CopyNewObject(now_room().enemy[c])
--
--   now_room().enemy[c].lose_time = -1
  now_room().enemy[c].lose_time = -1
--
--   now_room().enemy[c].radius = 1
  now_room().enemy[c].radius = 1
--   now_room().enemy[c].degree = now_room().enemy[c - 1].degree + 45
  now_room().enemy[c].degree = now_room().enemy[c - 1].degree + 45
--   now_room().enemy[c].degree Mod= 360
  now_room().enemy[c].degree = now_room().enemy[c].degree % 360
--
--   active_ball += 1
  active_ball = active_ball + 1
--   If active_ball = 8 Then
  if active_ball == 8 then
--     active_ball = 0
    active_ball = 0
--
--     __return_idle( this )
    __return_idle(this)
--
--     Return 0
    return 0
--
--   End If
  end
--
--
--
--
--   Return 1
  return 1
--
--
-- End Function
end
--
--
-- Function __anger_middle( this As _char_type Ptr ) As Integer
function __anger_middle(this)
--
--   this->coords.x = 320
  this.coords.x = 320
--   this->coords.y = 320
  this.coords.y = 320
--
--
--
--   Return 1
  return 1
--
--
-- End Function
end
--
-- Function __anger_teleport( this As _char_type Ptr ) As Integer
function __anger_teleport(this)
--
--   this->coords.x = 256
  this.coords.x = 256
--   this->coords.y = 256
  this.coords.y = 256
--
--   this->coords.x += Int( Rnd * ( 416 - 256 ) )
  this.coords.x = this.coords.x + math.floor(math.random() * (416 - 256))
--   this->coords.y += Int( Rnd * ( 416 - 256 ) )
  this.coords.y = this.coords.y + math.floor(math.random() * (416 - 256))
--
--
--
--   this->sway = 0
  this.sway = 0
--
--   Return 1
  return 1
--
--
-- End Function
end
--
-- Function __explode_jump( this As _char_type Ptr ) As Integer
function __explode_jump(this)
--
--   this->jump_count = 20000
  this.jump_count = 20000
--
--   Return 1
  return 1
--
--
-- End Function
end
--
--
-- Function __anger_trigger( this As _char_type Ptr ) As Integer
function __anger_trigger(this)
--
--   Static As Integer active_ball
  if active_ball1 == nil then active_ball1 = 0 end
--
--   If this->sway = 0 Then
  if this.sway == 0 then
--     Dim As Integer c = active_ball + 1 + 50
    local c = active_ball1 + 1 + 50
--
--     now_room().enemy[c].funcs.current_func[this->funcs.active_state] = 0
    now_room().enemy[c].funcs.current_func[this.funcs.active_state] = 0
--     now_room().enemy[c].funcs.active_state = 1
    now_room().enemy[c].funcs.active_state = 1
--     now_room().enemy[c].funcs.current_func[this->funcs.active_state] = 0
    now_room().enemy[c].funcs.current_func[this.funcs.active_state] = 0
--
--     active_ball += 1
    active_ball1 = active_ball1 + 1

--     If active_ball = 8 Then
    if active_ball1 == 8 then
--
--       active_ball = 0
      active_ball1 = 0
--       this->sway = -1
      this.sway = -1
--       this->funcs.current_func[this->funcs.active_state] = 0
      this.funcs.current_func[this.funcs.active_state] = 0
--       this->funcs.active_state = 2
      this.funcs.active_state = 2
--       this->funcs.current_func[this->funcs.active_state] = 0
      this.funcs.current_func[this.funcs.active_state] = 0
--
--       Return 0
      return 0
--
--     End If
    end
--
--   End If
  end
--
--
--  Return 1
  return 1
--
--
-- End Function
end
--
--
-- Function __anger_shoot( this As _char_type Ptr ) As Integer
function __anger_shoot(this)
--
--
--   If this->fly_timer = 0 Then
  if this.fly_timer == 0 then
--
--
--     If this->projectile->travelled = 0 Then
    if this.projectile.travelled == 0 then
--
--
--       Dim As vector_pair origin, target
      local origin, target = get_next_vector_pair(), get_next_vector_pair()
--
--       origin.u = llg( hero ).coords
      origin.u.x = ll_global.hero.coords.x
      origin.u.y = ll_global.hero.coords.y
--       origin.v = llg( hero ).perimeter
      origin.v.x = ll_global.hero.perimeter.x
      origin.v.y = ll_global.hero.perimeter.y

--
--       target.u = this->coords
      target.u.x = this.coords.x
      target.u.y = this.coords.y
--       target.v = this->perimeter
      target.v.x = this.perimeter.x
      target.v.y = this.perimeter.y
--
--       this->fly = V2_CalcFlyback( V2_MidPoint( origin ), V2_MidPoint( target ) )
      local temp_vector = V2_CalcFlyback(V2_MidPoint(origin), V2_MidPoint(target))
      this.fly.x = temp_vector.x
      this.fly.y = temp_vector.y
--
--     End If
    end
--
--     this->coords.x += ( this->fly.x )
    this.coords.x = this.coords.x + (this.fly.x)
--     this->coords.y += ( this->fly.y )
    this.coords.y = this.coords.y + (this.fly.y)
--
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
--   If ( this->projectile->travelled >= this->projectile->length ) Then
  if (this.projectile.travelled >= this.projectile.length) then
--
--
--     LLObject_ClearProjectiles( *this )
    LLObject_ClearProjectiles(this)
--
--     '' keal it...
--     __make_dead( this )
    __make_dead(this)
--     __cripple( this )
    __cripple(this)
--
--     Return 1
    return 1
--
--
--   End If
  end
--
--
  return 0
-- End Function
end
--
-- Function __anger_fireball2 ( this As _char_type Ptr ) As Integer
function __anger_fireball2(this)
--
--
--   With *this
  local with0 = this
--
--
--     If .anger_proj_trig = 0 Then
  if with0.anger_proj_trig == 0 then
--
--       .projectile->coords[0].x = 11 + .coords.x '' it's coming out of his .. whatever
    with0.projectile.coords[0].x = 11 + with0.coords.x
--       .projectile->coords[0].y = 24 + .coords.y
    with0.projectile.coords[0].y = 24 + with0.coords.y
--
--       __do_anger_proj ( cptr( Any Ptr, 0 ) )
    __do_anger_proj(nil)
--
--       .anger_proj_trig = 1
    with0.anger_proj_trig = 1
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
-- Function __do_anger_proj ( this As _char_type Ptr ) As Integer
function __do_anger_proj(this)
--
--   Static As uByte lock_x, lock_y
  if lock_x == nil then lock_x = 0 end
  if lock_y == nil then lock_y = 0 end
--   If this = 0 Then
  if this == nil then
--     lock_x = 0
    lock_x = 0
--     lock_y = 0
    lock_y = 0
--     Return 0
    return 0
--
--   End If
  end
--
--   Dim As vector DoingItRight
  local DoingItRight = get_next_vector()
--   Dim As vector_pair origin, target
  local origin, target = get_next_vector_pair(), get_next_vector_pair()
--
--
--   If this->fly_timer = 0 Then
  if this.fly_timer == 0 then
--
--
--     If this->projectile->travelled Mod 3 = 0 Then
    if (this.projectile.travelled % 3) == 0 then
--
--
--       If ( Abs( this->projectile->coords[0].x - llg( hero ).coords.x ) < 48 ) Then
      if (math.abs(this.projectile.coords[0].x - ll_global.hero.coords.x) < 48) then
--         If ( Abs( this->projectile->coords[0].y - llg( hero ).coords.y ) < 48 ) Then
        if (math.abs(this.projectile.coords[0].y - ll_global.hero.coords.y) < 48) then
--           lock_x = 1
          lock_x = 1
--           lock_y = 1
          lock_y = 1
--
--         End If
        end
--
--       End If
      end
--
--
--
--       origin.u = llg( hero ).coords
      origin.u.x = ll_global.hero.coords.x
      origin.u.y = ll_global.hero.coords.y
--       origin.v = llg( hero ).perimeter
      origin.v.x = ll_global.hero.perimeter.x
      origin.v.y = ll_global.hero.perimeter.y
--
--       target.u.x = this->projectile->coords[0].x
      target.u.x = this.projectile.coords[0].x
--       target.u.y = this->projectile->coords[0].y
      target.u.y = this.projectile.coords[0].y
--
--       target.v.x = 16
      target.v.x = 16
--       target.v.y = 16
      target.v.y = 16
--
--       DoingItRight = V2_CalcFlyback( V2_MidPoint( origin ), V2_MidPoint( target ) )
      DoingItRight = V2_CalcFlyback(V2_MidPoint(origin), V2_MidPoint(target))
--
--       If lock_x = 0 Then
      if lock_x == 0 then
--         this->fly.x = DoingItRight.x
        this.fly.x = DoingItRight.x
--
--       End If
      end
--
--       If lock_y = 0 Then
      if lock_y == 0 then
--         this->fly.y = DoingItRight.y
        this.fly.y = DoingItRight.y
--
--       End If
      end
--
--       lock_x = 1
      lock_x = 1
--       lock_y = 1
      lock_y = 1
--
--     End If
    end
--
--     this->projectile->coords[0].x += this->fly.x
    this.projectile.coords[0].x = this.projectile.coords[0].x + this.fly.x
--     this->projectile->coords[0].y += this->fly.y
    this.projectile.coords[0].y = this.projectile.coords[0].y + this.fly.y
--
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
--     this->anger_proj_trig = 0
    this.anger_proj_trig = 0
--
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
-- Function __sword_angle( this As _char_type Ptr ) As Integer
function __sword_angle(this)
--
--
--   Dim As Double a = get_angle( V2_MidPoint( LLO_VP( this ) ), V2_MidPoint( LLO_VP( @llg( hero ) ) ) )
  local a = get_angle(V2_MidPoint(LLO_VP(this)), V2_MidPoint(LLO_VP(ll_global.hero)))
--
--
--   '' hehehe...
--   a += ( 22.5 ) / 4
  a = a + ((22.5) / 4)
--
--   If a < 0 Then
  if a < 0 then
--     a += 360
    a = a + 360
--
--   ElseIf a >= 360 Then
  elseif a >= 360 then
--     a -= 360
    a = a - 360
--
--   End If
  end
--
--
--   a = a / ( 360 / 16 ) '' 16 Frames in sword anim!!!
  a = a / (360 / 16)
--   a = Int( a )
  a = math.floor(a)
--
--   this->frame = a
  this.frame = a
--   Return 1
  return 1
--
--
-- End Function
end
--
--
--
-- Function __sword_fly( this As _char_type Ptr ) As Integer
function __sword_fly(this)
--
--   With *this
  local with0 = this
--     If .fly_count = 0 Then
  if with0.fly_count == 0 then
--
--       this->fly = V2_CalcFlyback( V2_MidPoint( LLO_VP( this ) ), V2_MidPoint( LLO_VP( @llg( hero ) ) ) )
    local temp_vector = V2_CalcFlyback(V2_MidPoint(LLO_VP(this)), V2_MidPoint(LLO_VP(ll_global.hero)))
    this.fly.x = temp_vector.x
    this.fly.y = temp_vector.y
--
--     End If
  end
--
--     If .fly_timer = 0 Then
  if with0.fly_timer == 0 then
--
--       .fly_hold = .direction
    with0.fly_hold = with0.direction
--
--       Select Case .fly.y
--
--         Case Is > 0
    if with0.fly.y > 0 then
--
--           .direction = 0
      with0.direction = 0
--             If move_object( this, , Abs( .fly.y ) * 2 ) = 0 Then
      if move_object(this, nil, math.abs(with0.fly.y) * 2) == 0 then
--               .fly_count = .fly_length - 1
        with0.fly_count = with0.fly_length - 1
--
--             End If
      end
--
--
--         Case Is < 0
    elseif with0.fly.y < 0 then
--
--           .direction = 2
      with0.direction = 2
--             If move_object( this, , Abs( .fly.y ) * 2 ) = 0 Then
      if move_object(this, nil, math.abs(with0.fly.y) * 2) == 0 then
--               .fly_count = .fly_length - 1
        with0.fly_count = with0.fly_length - 1
--
--             End If
      end
--
--         Case 0
    elseif with0.fly.y == 0 then
--           '' nothin
--
--       End Select
    end
--
--
--       Select Case .fly.x
--
--         Case Is > 0
    if with0.fly.x > 0 then
--
--           .direction = 3
      with0.direction = 3
--
--             If move_object( this, , Abs( .fly.x ) * 2 ) = 0 Then
      if move_object(this, nil, math.abs(with0.fly.x) * 2) == 0 then
--               .fly_count = .fly_length - 1
        with0.fly_count = with0.fly_length - 1
--
--             End If
      end
--
--         Case Is < 0
    elseif with0.fly.x < 0 then
--
--           .direction = 1
      with0.direction = 1
--
--             If move_object( this, , Abs( .fly.x ) * 2 ) = 0 Then
      if move_object(this, nil, math.abs(with0.fly.x) * 2) == 0 then
--               .fly_count = .fly_length - 1
        with0.fly_count = with0.fly_length - 1
--
--             End If
      end
--
--
--         Case 0
    elseif with0.fly.x == 0 then
--
--       End Select
    end
--
--
--       .fly_timer = Timer + .fly_speed
    with0.fly_timer = timer + with0.fly_speed
--       .fly_count += 1
    with0.fly_count = with0.fly_count + 1
--       .direction = .fly_hold
    with0.direction = with0.fly_hold
--
--     End If
  end
--
--     If Timer >= .fly_timer Then .fly_timer = 0
  if timer >= with0.fly_timer then with0.fly_timer = 0 end
--
--     If .fly_count >= .fly_length Then
  if with0.fly_count >= with0.fly_length then
--
--       .fly_count = 0
    with0.fly_count = 0
--       .fly_timer = 0
    with0.fly_timer = 0
--
--       Return 1
    return 1
--
--     End If
  end
--
--   End With
--
--
--
  return 0
--
-- End Function
end
--
--
--
-- Function __sword_jump( this As _char_type Ptr ) As Integer
function __sword_jump(this)
--
--
--   LLObject_ShiftState( now_room().enemy, 1 )
  LLObject_ShiftState(now_room().enemy[0], 1)
--
--   Return 1
  return 1
--
--
-- End Function
end
--
--
--
-- Function __sterach_call( this As _char_type Ptr ) As Integer
function __sterach_call(this)
--
--
--   now_room().enemy[1].current_anim = 3
  now_room().enemy[1].current_anim = 3
--   now_room().enemy[1].frame = 0
  now_room().enemy[1].frame = 0
--
--   Return 1
  return 1
--
--
-- End Function
end
--
--
--
-- Function __sword_glow( this As _char_type Ptr ) As Integer
function __sword_glow(this)
--
--
--   now_room().enemy->current_anim Xor= 1
  now_room().enemy[0].current_anim = bit.bxor(now_room().enemy[0].current_anim, 1)
--
--   Return 1
  return 1
--
--
-- End Function
end
--
--
--
-- Function __sword_return( this As _char_type Ptr ) As Integer
function __sword_return(this)
--
--
--   Dim As vector flyback
  local flyback = get_next_vector()
--
--   With *this
  local with0 = this
--
--
--     this->fly = V2_CalcFlyback( V2_MidPoint( LLO_VP( this ) ), V2_MidPoint( LLO_VP( @now_room().enemy[1] ) ) )
  local temp_vector = V2_CalcFlyback(V2_MidPoint(LLO_VP(this)), V2_MidPoint(LLO_VP(now_room().enemy[1])))
  this.fly.x = temp_vector.x
  this.fly.y = temp_vector.y
--
--     If .fly_timer = 0 Then
  if with0.fly_timer == 0 then
--
--       .fly_hold = .direction
    with0.fly_hold = with0.direction
--
--       Select Case .fly.y
--
--         Case Is > 0
    if with0.fly.y > 0 then
--
--           .direction = 0
      with0.direction = 0
--             move_object( this, , Abs( .fly.y ) )
      move_object(this, nil, math.abs(with0.fly.y))
--
--         Case Is < 0
    elseif with0.fly.y < 0 then
--
--           .direction = 2
      with0.direction = 2
--             move_object( this, , Abs( .fly.y ) )
      move_object(this, nil, math.abs(with0.fly.y))
--
--         Case 0
    elseif with0.fly.y == 0 then
--           '' nothin
--
--       End Select
    end
--
--
--       Select Case .fly.x
--
--         Case Is > 0
    if with0.fly.x > 0 then
--
--           .direction = 3
      with0.direction = 3
--
--             move_object( this, , Abs( .fly.x ) )
      move_object(this, nil, math.abs(with0.fly.x))
--
--         Case Is < 0
    elseif with0.fly.x < 0 then
--
--           .direction = 1
      with0.direction = 1
--
--             move_object( this, , Abs( .fly.x ) )
      move_object(this, nil, math.abs(with0.fly.x))
--
--
--         Case 0
    elseif with0.fly.x == 0 then
--
--       End Select
    end
--
--
--       .fly_timer = Timer + .fly_speed
    with0.fly_timer = timer + with0.fly_speed
--       .direction = .fly_hold
    with0.direction = with0.fly_hold
--
--     End If
  end
--
--     If Timer >= .fly_timer Then .fly_timer = 0
  if timer >= with0.fly_timer then with0.fly_timer = 0 end
--
--     If now_room().enemy[1].funcs.active_state <> 1 Then
  if now_room().enemy[1].funcs.active_state ~= 1 then
--
--       If check_bounds( LLO_VP( this ), LLO_VP( @now_room().enemy[1] ) ) = 0 Then
    if check_bounds(LLO_VP(this), LLO_VP(now_room().enemy[1])) == 0 then
--         LLObject_ShiftState( @now_room().enemy[1], 1 )
      LLObject_ShiftState(now_room().enemy[1], 1)
--
--       End If
    end
--
--     Else
  else
--
--         Dim As vector res
    local res = get_next_vector()
--         res = v2_Absolute( v2_Subtract( v2_MidPoint( LLO_VP( @now_room().enemy[1] ) ), v2_MidPoint( LLO_VP( this ) ) ) )
    res = V2_Absolute(V2_Subtract(V2_MidPoint(LLO_VP(now_room().enemy[1])), V2_MidPoint(LLO_VP(this))))
--
--       If res.x < 1 And _
    if res.x < 1 and
--          res.y < 1     _
       res.y < 1
--                                                                                               _
--       Then
    then
--
--         '' sword is really close to him, just reset.
--         LLObject_ShiftState( this, 0 )
      LLObject_ShiftState(this, 0)
--
--
--       End If
    end
--
--
--     End If
  end
--
--
--
--   End With
--
--   Return 0
  return 0
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
--
-- Function __push_lynn_back( this As char_type Ptr ) As Integer
function __push_lynn_back(this)
--
--
--   Dim As vector flyback
--
--   flyback = V2_CalcFlyback( _
--                             V2_MidPoint( LLObject_VectorPair( Varptr( llg( hero ) ) ) ), _
--                             V2_MidPoint( LLObject_VectorPair( this ) ) _
--                           )
  local flyback = V2_CalcFlyback(
                            V2_MidPoint(LLObject_VectorPair(ll_global.hero)),
                            V2_MidPoint(LLObject_VectorPair(this))
                          )
--
--   llg( hero ).fly = V2_Scale( flyback, 3 )
  local tempVector = V2_Scale(flyback, 3)
  ll_global.hero.fly.x = tempVector.x
  ll_global.hero.fly.y = tempVector.y
--
--   Return 1
  return 1
--
--
-- End Function
end
--
--
-- Function __check_for_dead_faces( this As char_type Ptr ) As Integer
function __check_for_dead_faces(this)
--
--   Dim As Integer deadFace, iterate
  local deadFace, iterate = 0, 0
--
--   For iterate = 0 To now_room().enemies - 1
  for iterate = 0, now_room().enemies - 1 do
--
--     With now_room().enemy[iterate]
    local with0 = now_room().enemy[iterate]
--
--       Select Case .unique_id
--
--         Case u_boss5_left, u_boss5_right, u_boss5_down
    if with0.unique_id == u_boss5_left or
       with0.unique_id == u_boss5_right or
       with0.unique_id == u_boss5_down then
--           If .dead Then
      if with0.dead ~= 0 then
--             deadFace += 1
        deadFace = deadFace + 1
--
--           End If
      end
--
--         Case Else
    else
--
--       End Select
    end
--
--     End With
--
--   Next
  end
--
--   If deadFace = 3 Then
  if deadFace == 3 then
--     '' boss defeated
--
--     LLObject_ShiftState( this, 3 )
    LLObject_ShiftState(this, 3)
--
--   End If
  end
--
--   Return 0
  return 0
--
--
-- End Function
end
--
--
-- Function __divine_fireball( this As char_type Ptr ) As Integer
--
--   '' 152 24
--   LLObject_ShiftState( Varptr( now_room().enemy[21] ), 1 )
--
--   now_room().enemy[21].walk_buffer = now_room().enemy[21].walk_length
--   now_room().enemy[21].direction = IIf( ( llg( hero ).coords.x Shr 4 ) > ( now_room().x Shr 1 ), 6, 7 ) ''hehehhe
--
--   Dim As Integer i
--
--   For i = 0 To now_room().enemy[20].anim[0]->frame[0].faces - 1
--     now_room().enemy[20].anim[0]->frame[0].face[i].invincible = -1
--
--   Next
--
--   Function = 1
--
--
-- End Function
--
-- Function __divine_ball_return( this As char_type Ptr ) As Integer
--
--   '' 152 24
--
--   this->coords.x = 152
--   this->coords.y = 24
--
--
--
--   Function = 1
--
--
-- End Function
--
-- #define v2_Cmp(__U__,__V__) ( ( __U__.x = __V__.x ) and ( __U__.y = __V__.y ) )
-- Function __moth_random_loc( this As char_type Ptr ) As Integer
--
--   '' 13/41, 17/62, 60/51, 44/26, and 65/16
--
--   static as vector locs( 4 ) => _
--   { _
--     ( 13 shl 4, 41 shl 4 ), _
--     ( 17 shl 4, 62 shl 4 ), _
--     ( 60 shl 4, 51 shl 4 ), _
--     ( 44 shl 4, 26 shl 4 ), _
--     ( 65 shl 4, 16 shl 4 ) _
--   }
--
--   dim as integer randLoc
--   do
--
--     randLoc = int( rnd * 5 )
--
--
--     if v2_Cmp( this->coords, locs( randLoc ) ) then continue do
--     this->coords = locs( randLoc )
--
--   loop while 1 = 0
--
--   Function = 1
--
--
-- End Function
--
--
-- Function __seed_random_loc( this As char_type Ptr ) As Integer
--
--   '' 2/47, 2/61, 68/46, 33/19, and 66/2
--
--
--   static as vector locs( 4 ) => _
--   { _
--     ( 2  shl 4, 47 shl 4 ), _
--     ( 2  shl 4, 61 shl 4 ), _
--     ( 68 shl 4, 46 shl 4 ), _
--     ( 33 shl 4, 19 shl 4 ), _
--     ( 66 shl 4, 2  shl 4 ) _
--   }
--   dim as integer randLoc
--   do
--
--     randLoc = int( rnd * 5 )
--
--     if v2_Cmp( this->coords, locs( randLoc ) ) then continue do
--     this->coords = locs( randLoc )
--
--   loop while 1 = 0
--
--   Function = 1
--
--
-- End Function
--
--
-- Function __moth_random_proj( this As char_type Ptr ) As Integer
--
--   dim as integer chooseProjectile
--   chooseProjectile = int( rnd * 3 )
--
--
--   select case as const chooseProjectile
--
--     case 0
--       this->proj_style = PROJECTILE_SUN
--       this->projectile->strength = 3
--       this->projectile->projectiles = 128
--       this->proj_anim = 3
--
--     case 1
--       this->proj_style = PROJECTILE_TRACK
--       this->projectile->strength = 7
--       this->projectile->projectiles = 1
--       this->proj_anim = 4
--
--     case 2
--       this->proj_style = PROJECTILE_SPIRAL
--       this->projectile->strength = 5
--       this->projectile->projectiles = 16
--       this->proj_anim = 5
--
--   end select
--
--   Function = 1
--
--
-- End Function
