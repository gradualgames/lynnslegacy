require("game.engine_enums")
require("game.utility")

-- Function __randomize_path ( this As _char_type Ptr ) As Integer
function __randomize_path(this)
--
--
--   Dim As Integer exit_cond, c
--
--   this->walk_buffer = this->walk_length - ( Int ( Rnd * ( this->walk_length + 1 )) - ( this->walk_length \ 2 ))
  this.walk_buffer = this.walk_length - (math.floor(math.random() * (this.walk_length + 1)) - math.floor(this.walk_length / 2))
--
--   If this->on_ice <> 0 Then
  if this.on_ice ~= 0 then
--
--     this->walk_buffer = this->walk_length
    this.walk_buffer = this.walk_length
--     this->walk_buffer = this->walk_buffer * ( Int( Rnd * 4 ) + 1.5 )
    this.walk_buffer = this.walk_buffer * (math.floor(math.random() * 4) + 1.5)
--
--   End If
  end
--
--
--
--   Do
--
--     Dim rand_dir As Integer = Int ( Rnd * 3 ) - 1
  local rand_dir = math.floor(math.random() * 3) - 1
--
--     this->direction += rand_dir
  this.direction = this.direction + rand_dir
--     If this->direction = -1 Then this->direction = 3
  if this.direction == -1 then this.direction = 3 end
--     this->direction = Abs( this->direction ) And 3
  this.direction = bit.band(math.abs(this.direction), 3)
--
--
--     If move_object( this, MO_JUST_CHECKING ) = 0 Then
  move_object(this, MO_JUST_CHECKING)
--     Else
--       exit_cond = -1
--
--     End If
--
--     c+= 1
--     If c = 20 Then
--       exit_cond = -1
--
--     End If
--
--
--   Loop While exit_cond = 0
--
--
--   Return 1
  return 1
--
-- End Function
end

-- Function __push ( this As _char_type Ptr ) As Integer
function __push(this)
--
--     Dim As Integer x_opt, y_opt
  local x_opt, y_opt = 0, 0
--
--
--       Select Case llg( hero ).direction
--
--         Case 0
  if ll_global.hero.direction == 0 then
--           y_opt = -1
    y_opt = -1
--
--         Case 1
  elseif ll_global.hero.direction == 1 then
--           x_opt = 1
    x_opt = 1
--
--         Case 2
  elseif ll_global.hero.direction == 2 then
--           y_opt = 1
    y_opt = 1
--
--         Case 3
  elseif ll_global.hero.direction == 3 then
--           x_opt = -1
    x_opt = -1
--
--
--       End Select
  end
--
--     Dim As vector_pair main_char, rock
  local main_char, rock = get_next_vector_pair(), get_next_vector_pair()
--
--     main_char.u.x = llg( hero ).coords.x + x_opt
  main_char.u.x = ll_global.hero.coords.x + x_opt
--     main_char.u.y = llg( hero ).coords.y + y_opt
  main_char.u.y = ll_global.hero.coords.y + y_opt
--     main_char.v.x = llg( hero ).perimeter.x
  main_char.v.x = ll_global.hero.perimeter.x
--     main_char.v.y = llg( hero ).perimeter.y
  main_char.v.y = ll_global.hero.perimeter.y
--
--     rock.u.x = this->coords.x
  rock.u.x = this.coords.x
--     rock.u.y = this->coords.y
  rock.u.y = this.coords.y
--     rock.v.x = this->perimeter.x
  rock.v.x = this.perimeter.x
--     rock.v.y = this->perimeter.y
  rock.v.y = this.perimeter.y
--
--     If check_bounds( main_char, rock ) = 0 Then
  if check_bounds(main_char, rock) == 0 then
--
--       If MultiKey( llg( dir_hint )[llg( hero ).direction] ) <> 0 Then
    if input:pressed(ll_global.dir_hint[ll_global.hero.direction]) then
--
--         llg( hero ).is_pushing = llg( hero.direction ) + 1
      ll_global.hero.is_pushing = ll_global.hero.direction + 1
--
--       End If
    end
--
--
--       If this->walk_hold = 0 Then
    if this.walk_hold == 0 then
--
--         this->direction = llg( hero ).direction
      this.direction = ll_global.hero.direction
--
--         If llg( hero.on_ice ) <> 0 Then
      if ll_global.hero.on_ice ~= 0 then
--           this->momentum.i( this->direction ) = 1
        this.momentum.i[this.direction] = 1
--
--         Else
      else
--           this->momentum.i( this->direction ) = 1
        this.momentum.i[this.direction] = 1
--
--         End If
      end
--
--
--         move_object( this )
      move_object(this)
--
--
--         this->walk_hold = Timer + this->walk_speed
      this.walk_hold = timer + this.walk_speed
--
--
--
--
--       End If
    end
--
--
--       If Timer >= this->walk_hold Then
    if timer >= this.walk_hold then
--
--
--         this->walk_hold = 0
      this.walk_hold = 0
--
--       End If
    end
--
--
--     Else
  else
--
--
--
--     End If
  end
--
--
--     Return 0
  return 0
--
--
--
-- End Function
end

-- Function __calc_slide ( this As _char_type Ptr ) As Integer
function __calc_slide(this)
--
--   Dim As Double  thingo
  local thingo = 0.0
--   thingo = Abs( Log( .01 ) )
  thingo = math.abs(math.log(.01))
--   thingo /= 100
  thingo = thingo / 100
--   thingo *= 5
  thingo = thingo * 5
--
--   Dim As Double SLIDE_CONSTANT = .01 - ( .01 * thingo )
  local SLIDE_CONSTANT = .01 - (.01 * thingo)
--
--   If this->slide_hold = 0 Then
  if this.slide_hold == 0 then
--
--
--     Dim As Integer all_momentum
    local all_momentum = 0
--
--
--       For all_momentum = 0 To 7
    for all_momentum = 0, 7 do
--
--
--         this->momentum.i( all_momentum ) -= .01
      this.momentum.i[all_momentum] = this.momentum.i[all_momentum] - .01
--         If this->momentum.i( all_momentum ) < 0 Then this->momentum.i( all_momentum ) = 0
      if this.momentum.i[all_momentum] < 0 then this.momentum.i[all_momentum] = 0 end
--
--       Next

    end
--
--       this->slide_hold = Timer + SLIDE_CONSTANT '' !!!!
    this.slide_hold = timer + SLIDE_CONSTANT
--
--   End If
  end
--
--   If Timer >= this->slide_hold Then this->slide_hold = 0
  if timer >= this.slide_hold then this.slide_hold = 0 end
--
--   Return 0
  return 0
--
--
-- End Function
end

function __copter_path(this)
  local exit_cond, c = 0, 0
--
--   this->walk_buffer = this->walk_length
  this.walk_buffer = this.walk_length
--
--   Dim As Integer exit_cond, c
--
--
--   Do
  repeat
--
--     Dim rand_dir As Integer = Int ( Rnd * 8 ) - 1
    local rand_dir = math.floor(love.math.random() * 8) - 1
--
--     this->direction += rand_dir
    this.direction = this.direction + rand_dir
--     If this->direction = -1 Then this->direction = 7
    if this.direction == -1 then this.direction = 7 end
--     this->direction = Abs( this->direction ) And 7
    this.direction = bit.band(math.abs(this.direction), 7)
--
--
--     If move_object( this, MO_JUST_CHECKING ) = 0 Then
    if move_object(this, MO_JUST_CHECKING) == 0 then
--     Else
    else
--       exit_cond = -1
      exit_cond = -1
--
--     End If
    end
--
--     c+= 1
    c = c + 1
--     If c = 20 Then
    if c == 20 then
--       exit_cond = -1
      exit_cond = -1
--
--     End If
    end
--
--
--   Loop While exit_cond = 0
  until exit_cond ~= 0
--
-- '  this->direction = Int ( Rnd * 8 )
--
--
--   Return 1
  return 1
--
end

-- Function __make_align ( this As _char_type Ptr ) As Integer
function __make_align(this)
--
--   With *this
  local with0 = this
--
--     Dim As Integer dir_hold
  local dir_hold = 0
--
--     Dim As Integer hx, hy, ex, ey
  local hx, hy, ex, ey = 0, 0, 0, 0
--         hx = llg( hero.coords.x ) + ( llg( hero.perimeter.x ) \ 2 )
  hx = ll_global.hero.coords.x + math.floor(ll_global.hero.perimeter.x / 2)
--         hy = llg( hero.coords.y ) + ( llg( hero.perimeter.y ) \ 2 )
  hy = ll_global.hero.coords.y + math.floor(ll_global.hero.perimeter.y / 2)
--         ex = ( .coords.x ) + ( .perimeter.x ) \ 2
  ex = (with0.coords.x) + math.floor(with0.perimeter.x / 2)
--         ey = ( .coords.y ) + ( .perimeter.y ) \ 2
  ey = (with0.coords.y) + math.floor(with0.perimeter.y / 2)
--
--
--     If ( ( _
       if ((
--          ( Abs( _
            (math.abs(
--                 hy - ey _
                   hy - ey
--               ) < 48 _
                 ) < 48
--          ) _
            )
--          And _
            and
--          ( Abs( _
            (math.abs(
--                 hx - ex _
                   hx - ex
--               ) < 8 _
                 ) < 8
--          ) _
            )
--        ) _
          )
--        Or _
          or
--        ( _
          (
--          ( Abs( _
            (math.abs(
--                 hx - ex _
                   hx - ex
--               ) < 48 _
                 ) < 48
--          ) _
            )
--          And _
            and
--          ( Abs( _
            (math.abs(
--                 hy - ey _
                   hy - ey
--               ) < 8 _
                 ) < 8
--          ) _
            )
--        ) ) Then
          )) then
--
--
--     Else
  else
--
--       dir_hold = .direction
    dir_hold = with0.direction
--
--       If .walk_hold = 0 Then
    if with0.walk_hold == 0 then
--
--         If ( hx ) < ( ex ) Then
      if (hx) < (ex) then
--           .direction = 3
        with0.direction = 3
--           move_object( this )
        move_object(this)
--
--         ElseIf ( hx ) > ( ex ) Then
      elseif (hx) > (ex) then
--           .direction = 1
        with0.direction = 1
--           move_object( this )
        move_object(this)
--
--         End If
      end
--
--         If ( hy ) < ( ey ) Then
      if (hy) < (ey) then
--           .direction = 0
        with0.direction = 0
--           move_object( this )
        move_object(this)
--
--         ElseIf ( hy ) > ( ey ) Then
      elseif (hy) > (ey) then
--           .direction = 2
        with0.direction = 2
--           move_object( this )
        move_object(this)
--
--         End If
      end
--
--         .walk_hold = Timer + ( .walk_speed )
      with0.walk_hold = timer + (with0.walk_speed)
--
--       End If
    end
--
--       If Timer >= .walk_hold Then .walk_hold = 0
    if timer >= with0.walk_hold then with0.walk_hold = 0 end
--       .direction = dir_hold
    with0.direction = dir_hold
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

-- Function __make_face ( this As _char_type Ptr ) As Integer
function __make_face(this)
--
--
--   Dim As vector more, move
  local more, move = get_next_vector(), get_next_vector()
--   Dim As vector_pair target, origin
  local target, origin = get_next_vector_pair(), get_next_vector_pair()
--
--   target = LLObject_VectorPair( @llg( hero ) )
  target = LLObject_VectorPair(ll_global.hero)
--   origin = LLObject_VectorPair( this )
  origin = LLObject_VectorPair(this)
--
--   more = V2_Absolute( V2_Subtract( V2_Midpoint( target ), V2_Midpoint( origin ) ) )
  more = V2_Absolute(V2_Subtract(V2_Midpoint(target), V2_Midpoint(origin)))
--
--
--
--   If more.x >= more.y Then
  if more.x >= more.y then
--
--     If target.u.x > origin.u.x Then
    if target.u.x > origin.u.x then
--       move.x = 1
      move.x = 1
--
--     ElseIf target.u.x < origin.u.x Then
    elseif target.u.x < origin.u.x then
--       move.x = -1
      move.x = -1
--
--     End If
    end
--
--     If move.x = -1 Then this->direction = 3
    if move.x == -1 then this.direction = 3 end
--     If move.x =  1 Then this->direction = 1
    if move.x == 1 then this.direction = 1 end
--
--   Else
  else
--
--     If target.u.y > origin.u.y Then
    if target.u.y > origin.u.y then
--       move.y = 1
      move.y = 1
--
--     ElseIf target.u.y < origin.u.y Then
    elseif target.u.y < origin.u.y then
--       move.y = -1
      move.y = -1
--
--     End If
    end
--
--     If move.y = -1 Then this->direction = 0
    if move.y == -1 then this.direction = 0 end
--     If move.y = 1 Then this->direction = 2
    if move.y == 1 then this.direction = 2 end
--
--   End If
  end
--
--   Return 1
  return 1
--
-- End Function
end

-- Function __bat_path ( this As _char_type Ptr ) As Integer
function __bat_path(this)
--
--   this->walk_buffer = this->walk_length
  this.walk_buffer = this.walk_length
--   this->direction = Int ( Rnd * 4 ) + 4
  this.direction = math.floor(math.random() * 4) + 4
--
--
--   Return 1
  return 1
--
-- End Function
end

-- Function __tile_up ( this As _char_type Ptr ) As Integer
function __tile_up(this)
--
--
--
--   If this->walk_hold = 0 Then
  if this.walk_hold == 0 then
--
--
--     this->direction = 0
    this.direction = 0
--
--     Dim As Integer p
    local p = 0
--
--     For p = 0 To 15
    for p = 0, 15 do
--       move_object( this )
      move_object(this)
--
--     Next
    end
--
--
--     this->walk_hold = Timer + this->walk_speed
    this.walk_hold = timer + this.walk_speed
--
--   End If
  end
--
--   If Timer >= this->walk_hold Then this->walk_hold = 0
  if timer >= this.walk_hold then this.walk_hold = 0 end
--
--   Return 1
  return 1
--
--
-- End Function
end

-- Function __cell_bounce ( this As _char_type Ptr ) As Integer
function __cell_bounce(this)
--
--
--   If this->walk_hold = 0 Then
  if this.walk_hold == 0 then
--
--     Dim As uInteger callback
    local callback = 0
--
--     callback = move_object( this )
    callback = move_object(this)
--
--     If ( callback Shr 16 ) = 0 Then
    if bit.rshift(callback, 16) == 0 then
--
--       If this->direction and 1 Then
      if bit.band(this.direction, 1) ~= 0 then
--
--         this->direction -= 1
        this.direction = this.direction - 1
--
--       Else
      else
--
--         this->direction += 1
        this.direction = this.direction + 1
--
--       End If
      end
--
--       this->direction = ( this->direction and 3 ) + 4
      this.direction = bit.band(this.direction, 3) + 4
--
--     ElseIf ( callback And &HFF ) = 0 Then
    elseif bit.band(callback, 0xff) == 0 then
--
--       If this->direction and 1 Then
      if bit.band(this.direction, 1) then
--
--         this->direction += 1
        this.direction = this.direction + 1
--
--       Else
      else
--
--         this->direction -= 1
        this.direction = this.direction - 1
--
--       End If
      end
--
--       this->direction = ( this->direction and 3 ) + 4
      this.direction = bit.band(this.direction, 3) + 4
--
--     End If
    end
--
--     If LLObject_IncrementFrame( this ) <> 0 Then
    if LLObject_IncrementFrame(this) ~= 0 then
--
--       this->frame = 0
      this.frame = 0
--       this->frame_hold = Timer + this->animControl[this->current_anim].rate
      this.frame_hold = timer + this.animControl[this.current_anim].rate
--
--       '' reset rate?
--     End If
    end
--
--     this->walk_hold = Timer + this->walk_speed
    this.walk_hold = timer + this.walk_speed
--
--   Else
  else
--
--     If Timer >= this->walk_hold Then this->walk_hold = 0
    if timer >= this.walk_hold then this_walk_hold = 0 end
--
--   End If
  end
--
--   Return 1
  return 1
--
-- End Function
end

function __walk(this)
--   If this->walk_hold = 0 Then
  if this.walk_hold == 0 then
--
--
--     this->momentum.i( this->direction ) += this->walk_speed * 2
    this.momentum.i[this.direction] = this.momentum.i[this.direction] + this.walk_speed * 2
--
--     If this->momentum.i( this->direction ) > 1 Then
    if this.momentum.i[this.direction] > 1 then
--       this->momentum.i( this->direction ) = 1
      this.momentum.i[this.direction] = 1
--
--     End If
    end
--
--
--     If this->on_ice = 0 Then
    if this.on_ice == 0 then
--       '' traction
--
      __go_grip( this )
--
--     End If
    end
--
--
--     If this->walk_buffer > this->walk_length Then
    if this.walk_buffer > this.walk_length then
--
--       If this->on_ice = 0 Then
      if this.on_ice == 0 then
--         ''coming off ice check... too much path
--
--         this->walk_buffer = this->walk_length
        this.walk_buffer = this.walk_length
--
--       End If
      end
--
--     End If
    end
--
--
--
--     If move_object( this, MO_JUST_CHECKING, this->momentum.i( this->direction ) ) = 0 Then
    if move_object(this, MO_JUST_CHECKING, this.momentum.i[this.direction]) == 0 then
--       this->walk_steps = this->walk_buffer' - 1
      this.walk_steps = this.walk_buffer
-- '      this->momentum.i( this->direction ) = 0
--
--     Else
    else
--
--       If this->momentum.i( this->direction ) = 0 Then
      if this.momentum.i[this.direction] == 0 then
--         this->walk_steps = this->walk_buffer' - 1
        this.walk_steps = this.walk_buffer
--
--       Else
      else
--         __momentum_move( this )
        __momentum_move(this)
--
--       End If
      end
--
--     End If
    end
--
--
--     If this->momentum.i( this->direction ) > 0 Then
    if this.momentum.i[this.direction] > 0 then
--       this->walk_steps +=  1
      this.walk_steps = this.walk_steps + 1
--
--     End If
    end
--
--
--     If this->walk_steps >= this->walk_buffer Then
    if this.walk_steps >= this.walk_buffer then
--       this->frame = 0
      this.frame = 0
--       this->walk_steps = 0
      this.walk_steps = 0
--
--       Return 1
      return 1
--
--     End If
    end
--
--
--     If LLObject_IncrementFrame( this ) <> 0 Then
    if LLObject_IncrementFrame(this) ~= 0 then
--
--       this->frame = 0
      this.frame = 0
--       this->frame_hold = Timer + this->animControl[this->current_anim].rate
      this.frame_hold = timer + this.animControl[this.current_anim].rate
--
--       '' reset rate?
--     End If
    end
--
--   End If
  end
--
--
--   If Timer >= this->walk_hold Then this->walk_hold = 0
  if timer >= this.walk_hold then this.walk_hold = 0 end

  return 0
--
end

-- Function __home ( this As _char_type Ptr ) As Integer
function __home(this)
--
--
--   #Macro back_move()
  local function back_move()
--
--     If this->moveBackwards <> 0 Then
    if this.moveBackwards ~= 0 then
--
--       this->direction += 2
      this.direction = this.direction + 2
--       this->direction And= 3
      this.direction = bit.band(this.direction, 3)
--
--     End If
    end
--
--   #EndMacro
  end
--
--   Dim As Integer x_home, y_home, x_move, y_move
  local x_home, y_home, x_move, y_move = 0, 0, 0, 0
--
--   this->moving = 0
  this.moving = 0
--
--   If this->walk_hold = 0 Then
  if this.walk_hold == 0 then
--
--     x_home = this->dest_x
    x_home = this.dest_x
--     y_home = this->dest_y
    y_home = this.dest_y
--
--     If ( y_home ) > ( this->coords.y ) Then y_move = 1 Else If  ( y_home ) < ( this->coords.y ) Then y_move = -1
    if (y_home) > (this.coords.y) then y_move = 1 elseif (y_home) < (this.coords.y) then y_move = -1 end
--
--     If y_move = -1 Then this->direction = 0
    if y_move == -1 then this.direction = 0 end
--     If y_move = 1 Then this->direction = 2
    if y_move == 1 then this.direction = 2 end
--
--     If y_move <> 0 Then
    if y_move ~= 0 then
--       move_object( this )
      move_object(this)
--       back_move()
      back_move()
--
--     End If
    end
--
--     If ( x_home ) > ( this->coords.x ) Then x_move = 1 Else If  ( x_home ) < ( this->coords.x ) Then x_move = -1
    if (x_home) > (this.coords.x) then x_move = 1 elseif (x_home) < (this.coords.x) then x_move = -1 end
--
--     If x_move = -1 Then this->direction = 3
    if x_move == -1 then this.direction = 3 end
--     If x_move = 1 Then this->direction = 1
    if x_move == 1 then this.direction = 1 end
--
--     If x_move <> 0 Then
    if x_move ~= 0 then
--       move_object( this )
      move_object(this)
--       back_move()
      back_move()
--
--     End If
    end
--
--     If ( this->coords.x = x_home ) And ( this->coords.y = y_home ) Then
    if (this.coords.x == x_home) and (this.coords.y == y_home) then
--
--       this->walk_hold = 0
      this.walk_hold = 0
--
--       this->frame = 0
      this.frame = 0
--       this->moving = 0
      this.moving = 0
--       this->frame = 0
      this.frame = 0
--       Return 1
      return 1
--
--     End If
    end
--
--     this->walk_hold = Timer + this->walk_speed
    this.walk_hold = timer + this.walk_speed
--
--   End If
  end
--
--   If Timer >= this->walk_hold Then
  if timer >= this.walk_hold then
--
--     this->walk_hold = 0
    this.walk_hold = 0
--
--   End If
  end
--
--   If LLObject_IncrementFrame( this ) <> 0 Then
  if LLObject_IncrementFrame(this) ~= 0 then
--
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
  return 0
-- End Function
end

-- Function __charger_charge( this As _char_type Ptr ) As Integer
function __charger_charge(this)
--
--
--   If this->walk_hold = 0 Then
  if this.walk_hold == 0 then
--
--     Select Case this->internalState
--
--       Case 0
    if this.internalState == 0 then
--       '' charge
--         this->current_anim = 1
      this.current_anim = 1
--         If move_object( this ) = 0 Then
      if move_object(this) == 0 then
--           this->internalState += 1
        this.internalState = this.internalState + 1
--
--         End If
      end
--         this->walk_speed = .005
      this.walk_speed = .005
--
--       Case 1
    elseif this.internalState == 1 then
--       '' ow...
--         If this->sway = 0 Then
      if this.sway == 0 then
--           play_sample( llg( snd )[sound_explosion], 40 )
        ll_global.snd[sound_explosion]:setVolume(.4)
        ll_global.snd[sound_explosion]:play()
--           this->sway = -1
        this.sway = -1
--
--         End If
      end
--         this->internalState += __q_second_pause( this )
      this.internalState = this.internalState + __q_second_pause(this)
--
--       Case 2
    elseif this.internalState == 2 then
--       '' hit wall
--         this->sway = 0
      this.sway = 0
--         this->direction += 2
      this.direction = this.direction + 2
--         this->direction And = 3
      this.direction = bit.band(this.direction, 3)
--
--         this->internalState += 1
      this.internalState = this.internalState + 1
--
--         this->current_anim = 0
      this.current_anim = 0
--         this->walk_speed = .013
      this.walk_speed = .013
--
--
--       Case 3
    elseif this.internalState == 3 then
--       '' retreating
--
--         If move_object( this ) = 0 Then
      if move_object(this) == 0 then
--           this->internalState += 1
        this.internalState = this.internalState + 1
--
--         End If
      end
--
--       Case 4
    elseif this.internalState == 4 then
--       '' reset
--
--         this->direction += 2
      this.direction = this.direction + 2
--         this->direction And = 3
      this.direction = bit.band(this.direction, 3)
--
--         this->internalState = 0
      this.internalState = 0
--         play_sample( llg( snd )[sound_switch], 40 )
      ll_global.snd[sound_switch]:setVolume(.4)
      ll_global.snd[sound_switch]:play()
--         Function = 1
      return 1
--
--
--     End Select
    end
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
--
--   End If
  end
--
--
  return 0
-- End Function
end

-- Function __momentum_move ( this As _char_type Ptr ) As Integer
function __momentum_move(this)
--
--   With *this
--
--
--     Dim As Integer movement
--     Dim As Integer look_ahead
--
--     Dim As Integer all_momentum
  local movement, look_ahead, all_momentum = 0, 0, 0
--
--
--     For all_momentum = 0 To 7
  for all_momentum = 0, 7 do
--
--       look_ahead = 0
    look_ahead = 0
--
--
--
--
--       If .momentum.i( all_momentum ) <> 0 Then
    if this.momentum.i[all_momentum] ~= 0 then
--
--         Dim As Integer temp_dir
      local temp_dir = 0
--         temp_dir = .direction
      temp_dir = this.direction
--         .direction = all_momentum
      this.direction = all_momentum
--
--         look_ahead = move_object( this, , .momentum.i( .direction ) )
      look_ahead = move_object(this, 0, this.momentum.i[this.direction])
--
--         If look_ahead = 0 Then
      if look_ahead == 0 then
--           '' momentum dies on impact.
--
--           If ( .is_psfing = 0 ) And ( .is_pushing = 0 ) Then
        if this.is_psfing == 0 and this.is_pushing == 0 then
--
--             .momentum.i( .direction ) = 0
          this.momentum.i[this.direction] = 0
--
--           End If
        end
--
--         End If
      end
--
--         .direction = temp_dir
      this.direction = temp_dir
--
--       End If
    end
--
--       movement Or = .momentum.i( all_momentum ) <> 0
    movement = bit.bor(movement, (this.momentum.i[all_momentum] ~= 0) and 1 or 0)
--
--     Next
  end
--
--
--
--     If movement <> 0 Then
  if movement ~= 0 then
--       .walk_hold = Timer + .walk_speed
    this.walk_hold = timer + this.walk_speed
--
--     End If
  end
--
--     Return 1
  return 1
--
--   End With
--
-- End Function
end

-- Function __move_up ( this As _char_type Ptr ) As Integer
function __move_up(this)
--
--
--
--   If this->walk_hold = 0 Then
  if this.walk_hold == 0 then
--
--
--     this->direction = 0
    this.direction = 0
--
--     move_object( this )
    move_object(this)
--
--     If LLObject_IncrementFrame( this ) <> 0 Then
    if LLObject_IncrementFrame(this) ~= 0 then
--
--       this->frame = 0
      this.frame = 0
--       this->frame_hold = Timer + this->animControl[this->current_anim].rate
      this.frame_hold = timer + this.animControl[this.current_anim].rate
--
--       '' reset rate?
--     End If
    end
--
--     this->walk_hold = Timer + this->walk_speed
    this.walk_hold = timer + this.walk_speed
--
--
--     Return 1
    return 1
--
--
--   Else
  else
--
--
--     If Timer >= this->walk_hold Then this->walk_hold = 0
    if timer >= this.walk_hold then this.walk_hold = 0 end
--
--
--   End If
  end
--
--
--
  return 0
-- End Function
end

-- Function __chase ( this As _char_type Ptr ) As Integer
function __chase(this)
--
--
--   Dim As Vector hero_middle, this_middle, more, polarity, axes
  local hero_middle, this_middle, more, polarity, axes =
    get_next_vector(), get_next_vector(), get_next_vector(), get_next_vector(), get_next_vector()
--   Dim As Integer tmp_dir
  local tmp_dir = 0
--   Dim As Double sway_calc
  local sway_calc = 0.0
--
--   hero_middle = V2_MidPoint( Type <vector_pair> ( llg( hero ).coords, llg( hero ).perimeter ) )
  local temp_vector_pair = get_next_vector_pair()
  temp_vector_pair.u.x = ll_global.hero.coords.x
  temp_vector_pair.u.y = ll_global.hero.coords.y
  temp_vector_pair.v.x = ll_global.hero.perimeter.x
  temp_vector_pair.v.y = ll_global.hero.perimeter.y
  hero_middle = V2_MidPoint(temp_vector_pair)
--   this_middle = V2_MidPoint( Type <vector_pair> ( this->coords, this->perimeter ) )
  temp_vector_pair.u.x = this.coords.x
  temp_vector_pair.u.y = this.coords.y
  temp_vector_pair.v.x = this.perimeter.x
  temp_vector_pair.v.y = this.perimeter.y
  this_middle = V2_MidPoint(temp_vector_pair)
--
--   With *this
  local with0 = this
--
--     If .sway = 0 Then
  if with0.sway == 0 then
--
--       .degree += 1
    with0.degree = with0.degree + 1
--       If .degree = 360 Then
    if with0.degree == 360 then
--         .degree = 0
      with0.degree = 0
--
--       End If
    end
--
--       .sway = Timer + .002
    with0.sway = timer + .002
--
--     End If
  end
--     If Timer > .sway Then .sway = 0
  if timer > with0.sway then with0.sway = 0 end
--
--     more = V2_Absolute( V2_Subtract( hero_middle, this_middle ) )
  more = V2_Absolute(V2_Subtract(hero_middle, this_middle))
--
--     If .walk_hold = 0 Then
  if with0.walk_hold == 0 then
--
--       If hero_middle.y > this_middle.y Then
    if hero_middle.y > this_middle.y then
--         polarity.y = 1
      polarity.y = 1
--
--       ElseIf hero_middle.y < this_middle.y Then
    elseif hero_middle.y < this_middle.y then
--         polarity.y = -1
      polarity.y = -1
--
--       End If
    end
--
--       If hero_middle.x > this_middle.x Then
    if hero_middle.x > this_middle.x then
--         polarity.x = 1
      polarity.x = 1
--
--       ElseIf hero_middle.x < this_middle.x Then
    elseif hero_middle.x < this_middle.x then
--         polarity.x = -1
      polarity.x = -1
--
--       End If
    end
--
--       If .swaying <> 0 Then Goto do_sway '' skip regular movement
    local goto_do_sway = false
    if with0.swaying ~= 0 then goto_do_sway = true end
--
--       Select Case polarity.x
--
--         Case 1
    if not goto_do_sway then
      if polarity.x == 1 then
  --
  --           Select Case polarity.y
  --
  --             Case 1
        if polarity.y == 1 then
  --               .direction = 6
          with0.direction = 6
  --
  --             Case 0
        elseif polarity.y == 0 then
  --               .direction = 1
          with0.direction = 1
  --
  --             Case -1
        elseif polarity.y == -1 then
  --               .direction = 5
          with0.direction = 5
  --
  --           End Select
        end
  --
  --         Case -1
      elseif polarity.x == -1 then
  --
  --           Select Case polarity.y
  --
  --             Case 1
        if polarity.y == 1 then
  --               .direction = 7
          with0.direction = 7
  --
  --             Case 0
        elseif polarity.y == 0 then
  --               .direction = 3
          with0.direction = 3
  --
  --             Case -1
        elseif polarity.y == -1 then
  --               .direction = 4
          with0.direction = 4
  --
  --           End Select
        end
  --
  --         Case 0
      elseif polarity.x == 0 then
  --
  --           Select Case polarity.y
  --
  --             Case 1
        if polarity.y == 1 then
  --               .direction = 2
          with0.direction = 2
  --
  --             Case -1
        elseif polarity.y == -1 then
  --               .direction = 0
          with0.direction = 0
  --
  --           End Select
        end
  --
  --       End Select
      end
    end
--
--       If ( polarity.x = 0 ) And ( polarity.y = 0 ) Then
    if (not goto_do_sway) and ((polarity.x == 0) and (polarity.y == 0)) then
--       Else
    else
--
--         If move_object( this ) = 0 Then
      if goto_do_sway or (move_object(this) == 0) then
--
--           do_sway:
        ::do_sway::
--
--           tmp_dir = .direction
        tmp_dir = with0.direction
--
--           sway_calc = Sin( deg_2_rad( .degree ) )
        sway_calc = math.sin(deg_2_rad(with0.degree))
--
--           If sway_calc > 0 Then
        if sway_calc > 0 then
--             .direction += 1
          with0.direction = with0.direction + 1
--
--           ElseIf sway_calc < 0 Then
        elseif sway_calc < 0 then
--             .direction -= 1
          with0.direction = with0.direction - 1
--
--           End If
        end
--           in_dir_small( .direction )
        with0.direction = in_dir_small(with0.direction)
-- '          .direction And= 3
--
--           move_object( this )
        move_object(this)
--           .direction = tmp_dir
        with0.direction = tmp_dir
--
--           .swaying = -1
        with0.swaying = -1
--
--           If move_object( this ) <> 0 Then
        if move_object(this) ~= 0 then
--            .swaying = 0
          with0.swaying = 0
--
--           End If
        end
--
--         End If
      end
--
--
--       End If
    end
--
--
--       in_dir_small( .direction )
    with0.direction = in_dir_small(with0.direction)
--       '.direction And= 3
--
--       .walk_hold = Timer + .mad_walk_speed
    with0.walk_hold = timer + with0.mad_walk_speed
--
--        __make_face( this )
    __make_face(this)
--
--       If LLObject_IncrementFrame( this ) <> 0 Then
    if LLObject_IncrementFrame(this) ~= 0 then
--
--         this->frame = 0
      this.frame = 0
--         this->frame_hold = Timer + this->animControl[this->current_anim].rateMad
      this.frame_hold = timer + this.animControl[this.current_anim].rateMad
--
--         '' reset rate?
--       End If
    end
--
--     End If
  end
--
--     If Timer > .walk_hold Then .walk_hold = 0
  if timer > with0.walk_hold then with0.walk_hold = 0 end
--
--
--     If .thrust <> 0 Then
  if with0.thrust ~= 0 then
--
--       If .diag_thrust <> 0 Then
    if with0.diag_thrust ~= 0 then
--
--
--         If ( ( more.x <= 16 ) And ( more.y <= 16 ) ) Then
      if ((more.x <= 16) and (more.y <= 16)) then
--
--           .funcs.current_func[.funcs.active_state] = 0
        with0.funcs.current_func[with0.funcs.active_state] = 0
--           .funcs.active_state = .thrust_state
        with0.funcs.active_state = with0.thrust_state
--
--           .frame_hold = 0
        with0.frame_hold = 0
--
--           Exit Function
        return 0
--
--         End If
      end
--
--       ElseIf ( ( more.x <= 16 ) And ( more.y <= 8 ) ) Or ( ( more.x <= 8 ) And ( more.y <= 16 ) ) Then
    elseif ((more.x <= 16) and (more.y <= 8)) or ((more.x <= 8) and (more.y <= 16)) then
--
--
--         .funcs.current_func[.funcs.active_state] = 0
      with0.funcs.current_func[with0.funcs.active_state] = 0
--         .funcs.active_state = .thrust_state
      with0.funcs.active_state = with0.thrust_state
--
--         .frame_hold = 0
      with0.frame_hold = 0
--
--         Exit Function
      return 0
--
--       End If
    end
--
--     End If
  end
--
--   End With
--
--   Return 0
  return 0
--
--
-- End Function
end

-- Function __do_flyback ( this As _char_type Ptr ) As Integer
function __do_flyback(this)
--
--   With *this
--
--     Dim As Integer moveback
  local moveback = 0
--
--
--     If ( .unique_id = u_grult ) Then
  if (this.unique_id == u_grult) then
--
--       If .fly_timer = 0 Then
    if this.fly_timer == 0 then
--
--
--
--         .fly_timer = Timer + .fly_speed
      this.fly_timer = timer + this.fly_speed
--         .fly_count += 1
      this.fly_count = this.fly_count + 1
--
--       End If
    end
--
--       If Timer >= .fly_timer Then .fly_timer = 0
    if timer >= this.fly_timer then this.fly_timer = 0 end
--
--       If .fly_count >= 50 Then
    if this.fly_count >= 50 then
--
--         .fly_count = 0
      this.fly_count = 0
--         .fly_timer = 0
      this.fly_timer = 0
--         .flash_timer = 0
      this.flash_timer = 0
--         .invisible = 0
      this.invisible = 0
--         .mad =  0
      this.mad = 0
--
--         Return 1
      return 1
--
--       End If
    end
--
--       Return 0
    return 0
--
--     End If
  end
--
--
--     If .fly_length = 0 Then
  if this.fly_length == 0 then
--
--       If .fly_timer = 0 Then
    if this.fly_timer == 0 then
--         .fly_timer = Timer + .2
      this.fly_timer = timer + .2
--
--       End If
    end
--       If Timer > .fly_timer Then .fly_timer = 0
    if timer > this.fly_timer then this.fly_timer = 0 end
--
--       If .fly_timer = 0 Then
    if this.fly_timer == 0 then
--
--         .fly_count = 0
      this.fly_count = 0
--         .fly_timer = 0
      this.fly_timer = 0
--         .flash_timer = 0
      this.flash_timer = 0
--         .invisible = 0
      this.invisible = 0
--         .mad =  0
      this.mad = 0
-- '        .return_trig = -1
--
--         Return 1
      return 1
--
--
--       End If
    end
--
--       Return 0
    return 0
--
--     End If
  end
--
--     If .fly_timer = 0 Then
  if this.fly_timer == 0 then
--
--       .fly_hold = .direction
    this.fly_hold = this.direction
--
--
--       Select Case .fly.y
--
--         Case Is < 0
    if this.fly.y < 0 then
--
--           .direction = 0
      this.direction = 0
--             move_object( this, , Abs( .fly.y ) )
      move_object(this, nil, math.abs(this.fly.y))
--
--         Case Is > 0
    elseif this.fly.y > 0 then
--
--           .direction = 2
      this.direction = 2
--             move_object( this, , Abs( .fly.y ) )
      move_object(this, nil, math.abs(this.fly.y))
--
--         Case 0
    elseif this.fly.y == 0 then
--
--
--
--       End Select
    end
--
--       Select Case .fly.x
--
--         Case Is < 0
    if this.fly.x < 0 then
--
--           .direction = 3
      this.direction = 3
--
--             move_object( this, , Abs( .fly.x ) )
      move_object(this, nil, math.abs(this.fly.x))
--
--         Case Is > 0
    elseif this.fly.x > 0 then
--
--           .direction = 1
      this.direction = 1
--
--             move_object( this, , Abs( .fly.x ) )
      move_object(this, nil, math.abs(this.fly.x))
--
--
--         Case 0
    elseif this.fly.x == 0 then
--
--
--
--
--       End Select
    end
--
--
--       .fly_timer = Timer + .fly_speed
    this.fly_timer = timer + this.fly_speed
--       .fly_count += 1
    this.fly_count = this.fly_count + 1
--       .direction = .fly_hold
    this.direction = this.fly_hold
--
--     End If
  end
--
--     If Timer >= .fly_timer Then .fly_timer = 0
  if timer >= this.fly_timer then this.fly_timer = 0 end
--
--     If .fly_count >= .fly_length Then
  if this.fly_count >= this.fly_length then
--
--       .fly_count = 0
    this.fly_count = 0
--       .fly_timer = 0
    this.fly_timer = 0
--       .flash_timer = 0
    this.flash_timer = 0
--       .invisible = 0
    this.invisible = 0
--       .mad =  0
    this.mad = 0
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
  return 0
-- End Function
end

-- Function __go_grip ( this As _char_type Ptr ) As Integer
function __go_grip(this)
--
--
--   Dim As Integer all_momentum
  local all_momentum = 0
--
--   For all_momentum = 0 To 7
  for all_momentum = 0, 7 do
--
--     If this->momentum.i( all_momentum ) <> 0 Then
    if this.momentum.i[all_momentum] ~= 0 then
--
--       this->momentum.i( all_momentum ) = 1
      this.momentum.i[all_momentum] = 1
--
--     End If
    end
--
--   Next
  end
--
--   Return 1
  return 1
--
--
--
-- End Function
end

-- Function __stop_grip ( this As _char_type Ptr ) As Integer
function __stop_grip(this)
--
--
--   Scope
--
--     Dim As Integer all_momentum
  local all_momentum = 0
--
--       For all_momentum = 0 To 7
  for all_momentum = 0, 7 do
--
--         this->momentum_history.i( all_momentum ) = this->momentum.i( all_momentum )
    this.momentum_history.i[all_momentum] = this.momentum.i[all_momentum]
--
--         If this->momentum.i( all_momentum ) <> 0 Then
    if this.momentum.i[all_momentum] ~= 0 then
--
--           this->momentum.i( all_momentum ) = 0
      this.momentum.i[all_momentum] = 0
--
--         End If
    end
--
--       Next
  end
--
--   End Scope
--
--   Return 1
  return 1
--
--
-- End Function
--
end

-- Function __move_backwards( this As _char_type Ptr ) As Integer
function __move_backwards(this)
--
--   this->moveBackwards = -1
  this.moveBackwards = -1
--   Return 1
  return 1
--
-- End Function
end
--
-- Function __move_normal( this As _char_type Ptr ) As Integer
function __move_normal(this)
--
--   this->moveBackwards = 0
  this.moveBackwards = 0
--   Return 1
  return 1
--
-- End Function
end
