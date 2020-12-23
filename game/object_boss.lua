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
      local grultProjectile = create_vector_pair()
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
        this.fly = V2_CalcFlyback(V2_MidPoint(LLO_VP(ll_global.hero)), V2_MidPoint(grultProjectile))
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
    this.projectile.coords[0] = V2_Add(this.projectile.coords[0], this.fly)
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
