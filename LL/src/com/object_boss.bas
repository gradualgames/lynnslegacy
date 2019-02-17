Option Explicit

#Include "..\headers\ll.bi"



''''''''''''''''''''''''''
''  Grult 
''::::::::::::::::::::::::

Function __grult_fireball ( this As _char_type Ptr ) As Integer

  
  With *this


    If .grult_proj_trig = 0 Then
    
      .projectile->coords[0].x = 52 + .coords.x '' it's coming out of his mouth
      .projectile->coords[0].y = 36 + .coords.y
'      .projectile->coords[0].x = 52 + .coords.x '' it's coming out of his mouth
'      .projectile->coords[0].y = 36 + .coords.y
      
      __do_grult_proj ( cptr( Any Ptr, 0 ) ) 

      .grult_proj_trig = 1 
    
    End If  

  End With    

  Return 1


End Function


Function __do_grult_proj ( this As _char_type Ptr ) As Integer

  Static As uByte projLock

  If this = 0 Then

    projLock = 0
    Return 0
    
  End If

  If this->fly_timer = 0 Then

    If ( this->projectile->travelled And 3 ) = 0 Then

      If ( Abs( this->projectile->coords[0].x - llg( hero ).coords.x ) < 48 ) Then

        If ( Abs( this->projectile->coords[0].y - llg( hero ).coords.y ) < 48 ) Then

          projLock = 1

        End If

      End If
      
      Dim As vector_pair grultProjectile
      With this->projectile->coords[0]

        grultProjectile.u.x = .x 
        grultProjectile.u.y = .y
        
        grultProjectile.v = Type <vector> ( 4, 4 )
        
        If projLock = 0 Then
          this->fly = V2_CalcFlyback( V2_MidPoint( LLO_VP( Varptr( llg( hero ) ) ) ), V2_MidPoint( grultProjectile ) )
          
        End If

      End With
        
    End If

    this->projectile->coords[0] = V2_Add( this->projectile->coords[0], this->fly )

    
    this->fly_timer = Timer + this->fly_speed
    this->projectile->travelled += 1
    
  End If
  
  If Timer >= this->fly_timer Then this->fly_timer = 0

  If this->projectile->travelled >= this->projectile->length Then
    
    LLObject_ClearProjectiles( *this )
    this->fly_timer = 0 
    
    this->grult_proj_trig = 0
    
    
  End If

  
End Function


Function __do_circle ( this As _char_type Ptr ) As Integer

  If this->walk_hold = 0 Then

    Dim As Double Radians = ( 3.14159 / 180 ) * this->Degree
    Dim As Single mov_x = this->radius * Sin( Radians )
    Dim As Single mov_y = this->radius * Cos( Radians )
  
  
    this->coords.x = this->x_origin + mov_x
    this->coords.y = this->y_origin - mov_y 
  

    If this->degree Mod 45 = 0 Then
      '' could shoot...

      If chance_Percent( 30 ) Then 
        this->funcs.current_func[this->funcs.active_state] = 0
        this->funcs.active_state = this->proj_state
        this->funcs.current_func[this->funcs.active_state] = 0
        
        Return
        
      End If
      
    End If

    If this->degree >= 360 Then this->degree = 0 Else this->degree += .75

    this->walk_hold = Timer + this->walk_speed
    
  End If

  If Timer >= this->walk_hold Then 
    this->walk_hold = 0
    
  End If

  If LLObject_IncrementFrame( this ) <> 0 Then
    this->animating = 0
    this->frame = 0
    this->frame_hold = Timer + this->animControl[this->current_anim].rate
    
  End If

  Return 1
  
    
End Function
    


''***************************************
''  dyssius
''***************************************

Function __dyssius_slide( this As _char_type Ptr ) As Integer
 
 
  Static slide_length As Integer = 100, slide_hold
  Dim As Double slideSpeed
  Dim As Integer i

  With *this
    
    If .walk_hold = 0 Then


      If slide_hold = 0 Then
        .frame = 1
        Do
          i += 1

          .direction = Int( Rnd * 8 )
          If move_object( this, MO_JUST_CHECKING ) <> 0 Then
            Exit Do
            
          End If
          If i = 20 Then Exit Do

        Loop
        
      End If

      
      If .unique_id = u_steelstrider Then
        slideSpeed = 4
      Else
        slideSpeed = .walk_speed * 2 
        
      End If
      .momentum.i( .direction ) += slideSpeed
  
      If move_object( this, MO_JUST_CHECKING, .momentum.i( .direction ) ) = 0 Then 
        slide_hold = slide_length - 1
      Else
        __momentum_move( this )
            
      End If
  
  
      
      slide_hold += 1
  
      If slide_hold = slide_length Then 
        slide_hold = 0
        Return 1
        
      End If
    
      .walk_hold = Timer + .walk_speed
      
    End If
    
    If Timer > .walk_hold Then .walk_hold = 0

  End With    


End Function


Function __dyssius_after_slide( this As _char_type Ptr ) As Integer

  If this->momentum.i( this->direction ) = 0 Then
    this->frame = 0
    Return 1
    
  End If
  
End Function


Function __dyssius_idle_gate( this As _char_type Ptr ) As Integer
  

  If chance_Percent( 30 ) Then
    Return 1

  Else
    __return_idle( this )
    
  End If
  
  
End Function


Function __do_dyssius_proj( this As _char_type Ptr ) As Integer

  With *this

    If .projectile->refreshTime = 0 Then
    
      If .projectile->sound = 0 Then
    
        play_sample( llg( snd )[sound_beam] )
        .projectile->sound = -1
      
      End If
    
    
      If .projectile->travelled = 0 Then
        ''initing proj
        .projectile->coords[0].x = 120 + .coords.x
        .projectile->coords[0].y = 105 + .coords.y
    
        .projectile->coords[1].x = .projectile->coords[0].x 
        .projectile->coords[1].y = .projectile->coords[0].y + 16
                       
        .projectile->travelled += 1
    
      Else
    
        
        .projectile->coords[0].y += 16
        .projectile->coords[1].y += 16
    
        .projectile->travelled += 1
        
        If .projectile->travelled >= .projectile->length Then 

          LLObject_ClearProjectiles( *this )
          
          Return 1
            
        End If
        
      End If
  
      .projectile->refreshTime = Timer + .animControl[.proj_anim].rate
    
    Else
    
      If Timer >= .projectile->refreshTime Then .projectile->refreshTime = 0
      
    End If                       
  
  
  
  
  End With  

  
End Function


Function __dyssius_flyback ( this As _char_type Ptr ) As Integer
  
  
  
  With *this
  
  
    If .fly_timer = 0 Then
      .fly_timer = Timer + .fly_speed
      .fly_count += 1   
      
    End If
  
    If Timer >= .fly_timer Then .fly_timer = 0

    If ( .projectile->coords[0].x <> 0 ) Or ( .projectile->coords[0].y <> 0 ) Then
      .projectile->coords[0].x = 0
      .projectile->coords[0].y = 0
      .projectile->coords[1].x = 0
      .projectile->coords[1].y = 0
      .projectile->refreshTime = 0
      .projectile->travelled = 0
      .projectile->sound = 0
      
    End If
  
    If .fly_count >= 50 Then

      .fly_count = 0
      .fly_timer = 0 
      .invisible = 0
      
      LLObject_ClearDamage( this )

      __return_idle( this )

      
    End If
    
    
    
    Return 0

  End With

  
End Function
    
    





Function __dyssius_jump_slide( this As _char_type Ptr ) As Integer

  this->funcs.current_func[this->funcs.active_state] = 0
  this->funcs.active_state = 0
  this->funcs.current_func[this->funcs.active_state] = 2
  
  Return 0
  
End Function




Function __dyssius_patience( this As _char_type Ptr ) As Integer


  If this->sway = 0 Then
    this->sway = Timer + 4.5
    
  End If
  
  Return 1

  
End Function


Function __dyssius_eye_explode( this As _char_type Ptr ) As Integer

  this->expl_x_off = 117
  this->expl_y_off = 98
  
  this->expl_x_size = 16
  this->expl_y_size = 16
  
  this->explosions = 5
  
  Return 1

  
End Function


Function __dyssius_full_explode( this As _char_type Ptr ) As Integer

  this->expl_x_off = 0
  this->expl_y_off = 0

  this->expl_x_size = 0
  this->expl_y_size = 0
  
  this->explosions = 30

  Return 1
  
End Function





Function __anger_flyback( this As _char_type Ptr ) As Integer
  
  
  
  With *this
  
    If .slide_hold = 0 Then
      .slide_hold = Timer + .fly_speed
      .shifty_state += 1   
      
    End If
  
    If Timer >= .slide_hold Then .slide_hold = 0

    If .shifty_state >= 70 Then

      .shifty_state = 0
      .slide_hold   = 0 
      .invisible    = 0
      LLObject_ClearDamage( this )
      
      Return 1
      
    End If
    
    Return 0

  End With

  
End Function
    

Function __anger_fireball_lock( this As _char_type Ptr ) As Integer

  Static As Double h
  
  
  
  this->degree = h
  h += ( 360 / 8 )
  If Abs( h - 360 ) < 1 Then
    h = 0
    
  End If

  Return 0

End Function


Function __anger_fireball_circle( this As _char_type Ptr ) As Integer



  If this->walk_hold = 0 Then

  

    Dim As Double Radians = ( 3.14159 / 180 ) * this->Degree
    Dim As Single mov_x = this->radius * Sin( Radians )
    Dim As Single mov_y = this->radius * Cos( Radians )
  
    this->coords.x = this->x_origin + mov_x
    this->coords.y = this->y_origin - mov_y 
    
    If this->sway = 0 Then
      this->sway = .5
      
    End If

    If this->lose_time <> 0 Then
      this->sway = 1
      If ( this - 1 )->radius <> 0 Then

        If this->radius >= ( this - 1 )->radius Then 
          this->lose_time = 0

          ( this )->sway = ( this - 1 )->sway 
          If ( this - 1 )->radius <> 0 Then
            ( this )->radius = ( this - 1 )->radius
            
          End If
          
        End If
      Else
        If this->radius >= 32 Then 
          this->lose_time = 0

          ( this )->sway = ( this - 1 )->sway 
          If ( this - 1 )->radius <> 0 Then
            ( this )->radius = ( this - 1 )->radius
            
          End If
          
        End If
        
      End If
    
    Else
      
      If ( this->radius > 36 ) Or ( this->radius < 24 ) Then 
        this->sway = -this->sway
        
      End If
      
    End If

    this->radius += this->sway
    

    If this->degree >= 360 Then this->degree = 0 Else this->degree += 3



    this->walk_hold = Timer + this->walk_speed


    
  End If
  

  If Timer >= this->walk_hold Then 

  

    this->walk_hold = 0

    
  End If
  


  If LLObject_IncrementFrame( this ) <> 0 Then
    
    this->animating = 0
    this->frame = 0
    this->frame_hold = Timer + this->animControl[this->current_anim].rate
    
    '' reset rate?
  End If

  
  Return 1
  
    
End Function
    




Function __anger_kill_fireball( this As _char_type Ptr ) As Integer

  Dim As Integer c = 51, i
  
  For i = c To c + 7
    __make_Dead( @now_room().enemy[i] )
    __cripple( @now_room().enemy[i] )  
    
   
    
    
  Next
  
  Return 1

End Function


Function __anger_new_fireball( this As _char_type Ptr ) As Integer


  Static As Integer active_ball

  Dim As Integer c = active_ball + 1  + 50
  
  del_room_enemies( 1,  @now_room().enemy[c] ) 
  LLSystem_CopyNewObject( now_room().enemy[c] )

  now_room().enemy[c].lose_time = -1

  now_room().enemy[c].radius = 1
  now_room().enemy[c].degree = now_room().enemy[c - 1].degree + 45
  now_room().enemy[c].degree Mod= 360
  
  active_ball += 1
  If active_ball = 8 Then 
    active_ball = 0

    __return_idle( this )

    Return 0
    
  End If

  

  
  Return 1
  
  
End Function


Function __anger_middle( this As _char_type Ptr ) As Integer

  this->coords.x = 320
  this->coords.y = 320
  
  
  
  Return 1
  
  
End Function

Function __anger_teleport( this As _char_type Ptr ) As Integer

  this->coords.x = 256
  this->coords.y = 256
  
  this->coords.x += Int( Rnd * ( 416 - 256 ) )
  this->coords.y += Int( Rnd * ( 416 - 256 ) )
  
  
  
  this->sway = 0 
  
  Return 1
  
  
End Function

Function __explode_jump( this As _char_type Ptr ) As Integer
  
  this->jump_count = 20000
  
  Return 1
  
  
End Function


Function __anger_trigger( this As _char_type Ptr ) As Integer

  Static As Integer active_ball

  If this->sway = 0 Then  
    Dim As Integer c = active_ball + 1 + 50
    
    now_room().enemy[c].funcs.current_func[this->funcs.active_state] = 0  
    now_room().enemy[c].funcs.active_state = 1             
    now_room().enemy[c].funcs.current_func[this->funcs.active_state] = 0  
    
    active_ball += 1
    If active_ball = 8 Then 

      active_ball = 0
      this->sway = -1
      this->funcs.current_func[this->funcs.active_state] = 0  
      this->funcs.active_state = 2
      this->funcs.current_func[this->funcs.active_state] = 0  

      Return 0
      
    End If

  End If    
    
 
 Return 1 
  
  
End Function  


Function __anger_shoot( this As _char_type Ptr ) As Integer


  If this->fly_timer = 0 Then
  

    If this->projectile->travelled = 0 Then

      
      Dim As vector_pair origin, target
      
      origin.u = llg( hero ).coords
      origin.v = llg( hero ).perimeter
      
      target.u = this->coords
      target.v = this->perimeter
      
      this->fly = V2_CalcFlyback( V2_MidPoint( origin ), V2_MidPoint( target ) )

    End If

    this->coords.x += ( this->fly.x )
    this->coords.y += ( this->fly.y )

        
    
    this->fly_timer = Timer + this->fly_speed
    this->projectile->travelled += 1
    
  End If
  
  If Timer >= this->fly_timer Then this->fly_timer = 0

  If ( this->projectile->travelled >= this->projectile->length ) Then
  
    
    LLObject_ClearProjectiles( *this )

    '' keal it...
    __make_dead( this )
    __cripple( this ) 

    Return 1
    
    
  End If

  
End Function

Function __anger_fireball2 ( this As _char_type Ptr ) As Integer

  
  With *this


    If .anger_proj_trig = 0 Then
    
      .projectile->coords[0].x = 11 + .coords.x '' it's coming out of his .. whatever
      .projectile->coords[0].y = 24 + .coords.y
      
      __do_anger_proj ( cptr( Any Ptr, 0 ) ) 

      .anger_proj_trig = 1 
    
    End If  

  End With    

  Return 1


End Function


Function __do_anger_proj ( this As _char_type Ptr ) As Integer

  Static As uByte lock_x, lock_y
  If this = 0 Then
    lock_x = 0
    lock_y = 0
    Return 0
    
  End If

  Dim As vector DoingItRight
  Dim As vector_pair origin, target
  

  If this->fly_timer = 0 Then
  

    If this->projectile->travelled Mod 3 = 0 Then


      If ( Abs( this->projectile->coords[0].x - llg( hero ).coords.x ) < 48 ) Then
        If ( Abs( this->projectile->coords[0].y - llg( hero ).coords.y ) < 48 ) Then
          lock_x = 1
          lock_y = 1
          
        End If

      End If



      origin.u = llg( hero ).coords
      origin.v = llg( hero ).perimeter
      
      target.u.x = this->projectile->coords[0].x
      target.u.y = this->projectile->coords[0].y
      
      target.v.x = 16
      target.v.y = 16
      
      DoingItRight = V2_CalcFlyback( V2_MidPoint( origin ), V2_MidPoint( target ) )
    
      If lock_x = 0 Then 
        this->fly.x = DoingItRight.x
          
      End If
      
      If lock_y = 0 Then 
        this->fly.y = DoingItRight.y
        
      End If

      lock_x = 1
      lock_y = 1
      
    End If

    this->projectile->coords[0].x += this->fly.x
    this->projectile->coords[0].y += this->fly.y

        
    
    this->fly_timer = Timer + this->fly_speed
    this->projectile->travelled += 1
    
  End If
  
  If Timer >= this->fly_timer Then this->fly_timer = 0

  If this->projectile->travelled >= this->projectile->length Then
  
    LLObject_ClearProjectiles( *this )
    this->fly_timer = 0 
    
    this->anger_proj_trig = 0
    
    
  End If

  
End Function


Function __sword_angle( this As _char_type Ptr ) As Integer


  Dim As Double a = get_angle( V2_MidPoint( LLO_VP( this ) ), V2_MidPoint( LLO_VP( @llg( hero ) ) ) )


  '' hehehe...
  a += ( 22.5 ) / 4

  If a < 0 Then 
    a += 360

  ElseIf a >= 360 Then
    a -= 360

  End If
  

  a = a / ( 360 / 16 ) '' 16 Frames in sword anim!!! 
  a = Int( a )

  this->frame = a
  Return 1
  

End Function



Function __sword_fly( this As _char_type Ptr ) As Integer
  
  With *this
    If .fly_count = 0 Then
      
      this->fly = V2_CalcFlyback( V2_MidPoint( LLO_VP( this ) ), V2_MidPoint( LLO_VP( @llg( hero ) ) ) )
      
    End If
      
    If .fly_timer = 0 Then
    
      .fly_hold = .direction
  
      Select Case .fly.y
  
        Case Is > 0
  
          .direction = 0                  
            If move_object( this, , Abs( .fly.y ) * 2 ) = 0 Then
              .fly_count = .fly_length - 1
              
            End If
              
  
        Case Is < 0
  
          .direction = 2                  
            If move_object( this, , Abs( .fly.y ) * 2 ) = 0 Then
              .fly_count = .fly_length - 1
              
            End If
                    
        Case 0
          '' nothin
  
      End Select

  
      Select Case .fly.x
      
        Case Is > 0
  
          .direction = 3                  
  
            If move_object( this, , Abs( .fly.x ) * 2 ) = 0 Then
              .fly_count = .fly_length - 1
              
            End If
  
        Case Is < 0
        
          .direction = 1                  
  
            If move_object( this, , Abs( .fly.x ) * 2 ) = 0 Then
              .fly_count = .fly_length - 1
              
            End If
  
  
        Case 0
  
      End Select 

      
      .fly_timer = Timer + .fly_speed
      .fly_count += 1   
      .direction = .fly_hold
      
    End If
    
    If Timer >= .fly_timer Then .fly_timer = 0
  
    If .fly_count >= .fly_length Then
    
      .fly_count = 0
      .fly_timer = 0 
  
      Return 1
      
    End If
    
  End With


  
  
End Function
    


Function __sword_jump( this As _char_type Ptr ) As Integer


  LLObject_ShiftState( now_room().enemy, 1 )
  
  Return 1
  

End Function
    


Function __sterach_call( this As _char_type Ptr ) As Integer


  now_room().enemy[1].current_anim = 3
  now_room().enemy[1].frame = 0 
  
  Return 1
  

End Function
    


Function __sword_glow( this As _char_type Ptr ) As Integer


  now_room().enemy->current_anim Xor= 1
  
  Return 1
  

End Function
    


Function __sword_return( this As _char_type Ptr ) As Integer


  Dim As vector flyback
  
  With *this


    this->fly = V2_CalcFlyback( V2_MidPoint( LLO_VP( this ) ), V2_MidPoint( LLO_VP( @now_room().enemy[1] ) ) )

    If .fly_timer = 0 Then
    
      .fly_hold = .direction
  
      Select Case .fly.y
  
        Case Is > 0
  
          .direction = 0                  
            move_object( this, , Abs( .fly.y ) )
  
        Case Is < 0
  
          .direction = 2                  
            move_object( this, , Abs( .fly.y ) )
                    
        Case 0
          '' nothin
  
      End Select

  
      Select Case .fly.x
      
        Case Is > 0
  
          .direction = 3                  
  
            move_object( this, , Abs( .fly.x ) )
  
        Case Is < 0
        
          .direction = 1                  
  
            move_object( this, , Abs( .fly.x ) )
  
  
        Case 0
  
      End Select 

      
      .fly_timer = Timer + .fly_speed
      .direction = .fly_hold
      
    End If
    
    If Timer >= .fly_timer Then .fly_timer = 0

    If now_room().enemy[1].funcs.active_state <> 1 Then

      If check_bounds( LLO_VP( this ), LLO_VP( @now_room().enemy[1] ) ) = 0 Then
        LLObject_ShiftState( @now_room().enemy[1], 1 )
        
      End If
      
    Else

        Dim As vector res
        res = v2_Absolute( v2_Subtract( v2_MidPoint( LLO_VP( @now_room().enemy[1] ) ), v2_MidPoint( LLO_VP( this ) ) ) )
    
      If res.x < 1 And _ 
         res.y < 1     _ 
                                                                                              _
      Then
        
        '' sword is really close to him, just reset.
        LLObject_ShiftState( this, 0 )
        
      
      End If
    
      
    End If
        
    
    
  End With

  Return 0
  
  
End Function
    







Function __push_lynn_back( this As char_type Ptr ) As Integer

  
  Dim As vector flyback

  flyback = V2_CalcFlyback( _ 
                            V2_MidPoint( LLObject_VectorPair( Varptr( llg( hero ) ) ) ), _ 
                            V2_MidPoint( LLObject_VectorPair( this ) ) _ 
                          )
  
  llg( hero ).fly = V2_Scale( flyback, 3 )

  Return 1
  

End Function


Function __check_for_dead_faces( this As char_type Ptr ) As Integer

  Dim As Integer deadFace, iterate
  
  For iterate = 0 To now_room().enemies - 1
    
    With now_room().enemy[iterate]
    
      Select Case .unique_id
      
        Case u_boss5_left, u_boss5_right, u_boss5_down
          If .dead Then
            deadFace += 1
            
          End If
          
        Case Else
        
      End Select
      
    End With
    
  Next
  
  If deadFace = 3 Then
    '' boss defeated
    
    LLObject_ShiftState( this, 3 )
    
  End If
    
  Return 0
  

End Function


Function __divine_fireball( this As char_type Ptr ) As Integer 
  
  '' 152 24
  LLObject_ShiftState( Varptr( now_room().enemy[21] ), 1 )
  
  now_room().enemy[21].walk_buffer = now_room().enemy[21].walk_length
  now_room().enemy[21].direction = IIf( ( llg( hero ).coords.x Shr 4 ) > ( now_room().x Shr 1 ), 6, 7 ) ''hehehhe

  Dim As Integer i
  
  For i = 0 To now_room().enemy[20].anim[0]->frame[0].faces - 1
    now_room().enemy[20].anim[0]->frame[0].face[i].invincible = -1
    
  Next
  
  Function = 1


End Function

Function __divine_ball_return( this As char_type Ptr ) As Integer 
  
  '' 152 24
  
  this->coords.x = 152
  this->coords.y = 24
  


  Function = 1


End Function   

#define v2_Cmp(__U__,__V__) ( ( __U__.x = __V__.x ) and ( __U__.y = __V__.y ) )
Function __moth_random_loc( this As char_type Ptr ) As Integer 
  
  '' 13/41, 17/62, 60/51, 44/26, and 65/16
  
  static as vector locs( 4 ) => _
  { _
    ( 13 shl 4, 41 shl 4 ), _
    ( 17 shl 4, 62 shl 4 ), _
    ( 60 shl 4, 51 shl 4 ), _
    ( 44 shl 4, 26 shl 4 ), _
    ( 65 shl 4, 16 shl 4 ) _
  }
    
  dim as integer randLoc
  do
      
    randLoc = int( rnd * 5 )
    
    
    if v2_Cmp( this->coords, locs( randLoc ) ) then continue do
    this->coords = locs( randLoc )
    
  loop while 1 = 0

  Function = 1


End Function   


Function __seed_random_loc( this As char_type Ptr ) As Integer 
  
  '' 2/47, 2/61, 68/46, 33/19, and 66/2
  
  
  static as vector locs( 4 ) => _
  { _
    ( 2  shl 4, 47 shl 4 ), _
    ( 2  shl 4, 61 shl 4 ), _
    ( 68 shl 4, 46 shl 4 ), _
    ( 33 shl 4, 19 shl 4 ), _
    ( 66 shl 4, 2  shl 4 ) _
  }
  dim as integer randLoc
  do
      
    randLoc = int( rnd * 5 )
    
    if v2_Cmp( this->coords, locs( randLoc ) ) then continue do
    this->coords = locs( randLoc )
    
  loop while 1 = 0

  Function = 1


End Function   


Function __moth_random_proj( this As char_type Ptr ) As Integer 
  
  dim as integer chooseProjectile
  chooseProjectile = int( rnd * 3 )
  
  
  select case as const chooseProjectile
    
    case 0
      this->proj_style = PROJECTILE_SUN
      this->projectile->strength = 3
      this->projectile->projectiles = 128
      this->proj_anim = 3

    case 1
      this->proj_style = PROJECTILE_TRACK
      this->projectile->strength = 7
      this->projectile->projectiles = 1
      this->proj_anim = 4

    case 2
      this->proj_style = PROJECTILE_SPIRAL
      this->projectile->strength = 5
      this->projectile->projectiles = 16
      this->proj_anim = 5
    
  end select

  Function = 1


End Function   



