Option Explicit

#Include "..\headers\ll\headers.bi"



Function __randomize_path ( this As _char_type Ptr ) As Integer

  
  Dim As Integer exit_cond, c

  this->walk_buffer = this->walk_length - ( Int ( Rnd * ( this->walk_length + 1 )) - ( this->walk_length \ 2 ))
  
  If this->on_ice <> 0 Then

    this->walk_buffer = this->walk_length
    this->walk_buffer = this->walk_buffer * ( Int( Rnd * 4 ) + 1.5 )
        
  End If
  
  
  
  Do
  
    Dim rand_dir As Integer = Int ( Rnd * 3 ) - 1
  
    this->direction += rand_dir
    If this->direction = -1 Then this->direction = 3
    this->direction = Abs( this->direction ) And 3
    
    
    If move_object( this, MO_JUST_CHECKING ) = 0 Then 
    Else
      exit_cond = -1
      
    End If
    
    c+= 1
    If c = 20 Then 
      exit_cond = -1
      
    End If
    
    
  Loop While exit_cond = 0
      

  Return 1 
 
End Function


Function __push ( this As _char_type Ptr ) As Integer

    Dim As Integer x_opt, y_opt


      Select Case llg( hero ).direction
      
        Case 0
          y_opt = -1

        Case 1
          x_opt = 1

        Case 2
          y_opt = 1

        Case 3
          x_opt = -1

      
      End Select 

    Dim As vector_pair main_char, rock
    
    main_char.u.x = llg( hero ).coords.x + x_opt
    main_char.u.y = llg( hero ).coords.y + y_opt
    main_char.v.x = llg( hero ).perimeter.x
    main_char.v.y = llg( hero ).perimeter.y

    rock.u.x = this->coords.x
    rock.u.y = this->coords.y
    rock.v.x = this->perimeter.x
    rock.v.y = this->perimeter.y

    If check_bounds( main_char, rock ) = 0 Then
                   
      If MultiKey( llg( dir_hint )[llg( hero ).direction] ) <> 0 Then
        
        llg( hero ).is_pushing = llg( hero.direction ) + 1
        
      End If


      If this->walk_hold = 0 Then

        this->direction = llg( hero ).direction
        
        If llg( hero.on_ice ) <> 0 Then
          this->momentum.i( this->direction ) = 1
          
        Else
          this->momentum.i( this->direction ) = 1
        
        End If
        
        
        move_object( this )


        this->walk_hold = Timer + this->walk_speed


        
        
      End If
      

      If Timer >= this->walk_hold Then 


        this->walk_hold = 0
        
      End If
      
    
    Else
    

    
    End If

  
    Return 0

      

End Function



Function __calc_slide ( this As _char_type Ptr ) As Integer
  
  Dim As Double  thingo
  thingo = Abs( Log( .01 ) )
  thingo /= 100
  thingo *= 5

  Dim As Double SLIDE_CONSTANT = .01 - ( .01 * thingo )

  If this->slide_hold = 0 Then


    Dim As Integer all_momentum
    
  
      For all_momentum = 0 To 7
  
  
        this->momentum.i( all_momentum ) -= .01
        If this->momentum.i( all_momentum ) < 0 Then this->momentum.i( all_momentum ) = 0
        
      Next

      this->slide_hold = Timer + SLIDE_CONSTANT '' !!!!
    
  End If

  If Timer >= this->slide_hold Then this->slide_hold = 0
  
  Return 0
  
 
End Function



Function __copter_path ( this As _char_type Ptr ) As Integer

  this->walk_buffer = this->walk_length 

  Dim As Integer exit_cond, c

  
  Do
  
    Dim rand_dir As Integer = Int ( Rnd * 8 ) - 1
  
    this->direction += rand_dir
    If this->direction = -1 Then this->direction = 7
    this->direction = Abs( this->direction ) And 7
    
    
    If move_object( this, MO_JUST_CHECKING ) = 0 Then 
    Else
      exit_cond = -1
      
    End If
    
    c+= 1
    If c = 20 Then 
      exit_cond = -1
      
    End If
    
    
  Loop While exit_cond = 0

'  this->direction = Int ( Rnd * 8 )
  

  Return 1 
 
End Function


Function __make_align ( this As _char_type Ptr ) As Integer

  With *this

    Dim As Integer dir_hold
    
    Dim As Integer hx, hy, ex, ey
        hx = llg( hero.coords.x ) + ( llg( hero.perimeter.x ) \ 2 )
        hy = llg( hero.coords.y ) + ( llg( hero.perimeter.y ) \ 2 )
        ex = ( .coords.x ) + ( .perimeter.x ) \ 2
        ey = ( .coords.y ) + ( .perimeter.y ) \ 2
    
    
    If ( ( _ 
         ( Abs( _ 
                hy - ey _
              ) < 48 _ 
         ) _ 
         And _ 
         ( Abs( _ 
                hx - ex _ 
              ) < 8 _ 
         ) _ 
       ) _ 
       Or _ 
       ( _ 
         ( Abs( _ 
                hx - ex _ 
              ) < 48 _ 
         ) _ 
         And _ 
         ( Abs( _ 
                hy - ey _ 
              ) < 8 _ 
         ) _ 
       ) ) Then
    
    
    Else
    
      dir_hold = .direction
    
      If .walk_hold = 0 Then
    
        If ( hx ) < ( ex ) Then 
          .direction = 3 
          move_object( this )

        ElseIf ( hx ) > ( ex ) Then 
          .direction = 1
          move_object( this )
          
        End If
    
        If ( hy ) < ( ey ) Then 
          .direction = 0 
          move_object( this )

        ElseIf ( hy ) > ( ey ) Then  
          .direction = 2     
          move_object( this )
          
        End If
        
        .walk_hold = Timer + ( .walk_speed )
    
      End If
    
      If Timer >= .walk_hold Then .walk_hold = 0
      .direction = dir_hold
    
    End If
    
  End With
  
  Return 1
    

End Function



Function __make_face ( this As _char_type Ptr ) As Integer


  Dim As vector more, move
  Dim As vector_pair target, origin
  
  target = LLObject_VectorPair( @llg( hero ) )
  origin = LLObject_VectorPair( this )

  more = V2_Absolute( V2_Subtract( V2_Midpoint( target ), V2_Midpoint( origin ) ) )



  If more.x >= more.y Then

    If target.u.x > origin.u.x Then 
      move.x = 1 

    ElseIf target.u.x < origin.u.x Then 
      move.x = -1
      
    End If
  
    If move.x = -1 Then this->direction = 3
    If move.x =  1 Then this->direction = 1
  
  Else
 
    If target.u.y > origin.u.y Then 
      move.y = 1 
      
    ElseIf target.u.y < origin.u.y Then 
      move.y = -1
      
    End If

    If move.y = -1 Then this->direction = 0
    If move.y = 1 Then this->direction = 2
  
  End If

  Return 1
 
End Function



Function __bat_path ( this As _char_type Ptr ) As Integer

  this->walk_buffer = this->walk_length 
  this->direction = Int ( Rnd * 4 ) + 4
  

  Return 1 
 
End Function


Function __tile_up ( this As _char_type Ptr ) As Integer



  If this->walk_hold = 0 Then


    this->direction = 0
    
    Dim As Integer p
    
    For p = 0 To 15
      move_object( this )
      
    Next


    this->walk_hold = Timer + this->walk_speed

  End If

  If Timer >= this->walk_hold Then this->walk_hold = 0

  Return 1  

  
End Function 








Function __chase ( this As _char_type Ptr ) As Integer


  Dim As Vector hero_middle, this_middle, more, polarity, axes
  Dim As Integer tmp_dir
  Dim As Double sway_calc

  hero_middle = V2_MidPoint( Type <vector_pair> ( llg( hero ).coords, llg( hero ).perimeter ) )
  this_middle = V2_MidPoint( Type <vector_pair> ( this->coords, this->perimeter ) )
  
  With *this

    If .sway = 0 Then
    
      .degree += 1
      If .degree = 360 Then 
        .degree = 0
        
      End If
      
      .sway = Timer + .002
      
    End If
    If Timer > .sway Then .sway = 0
    
    more = V2_Absolute( V2_Subtract( hero_middle, this_middle ) )

    If .walk_hold = 0 Then

      If hero_middle.y > this_middle.y Then
        polarity.y = 1

      ElseIf hero_middle.y < this_middle.y Then
        polarity.y = -1

      End If

      If hero_middle.x > this_middle.x Then
        polarity.x = 1

      ElseIf hero_middle.x < this_middle.x Then
        polarity.x = -1

      End If
      
      If .swaying <> 0 Then Goto do_sway '' skip regular movement

      Select Case polarity.x
        
        Case 1
          
          Select Case polarity.y
            
            Case 1
              .direction = 6
          
            Case 0
              .direction = 1
              
            Case -1
              .direction = 5
              
          End Select

        Case -1
          
          Select Case polarity.y
            
            Case 1
              .direction = 7
          
            Case 0
              .direction = 3
              
            Case -1
              .direction = 4
              
          End Select
          
        Case 0
        
          Select Case polarity.y
            
            Case 1
              .direction = 2
          
            Case -1
              .direction = 0
              
          End Select
          
      End Select
      
      If ( polarity.x = 0 ) And ( polarity.y = 0 ) Then        
      Else

        If move_object( this ) = 0 Then

          do_sway:
          
          tmp_dir = .direction 
          
          sway_calc = Sin( deg_2_rad( .degree ) )

          If sway_calc > 0 Then 
            .direction += 1

          ElseIf sway_calc < 0 Then
            .direction -= 1
            
          End If
          in_dir_small( .direction )
'          .direction And= 3

          move_object( this )
          .direction = tmp_dir
          
          .swaying = -1
          
          If move_object( this ) <> 0 Then
           .swaying = 0

          End If

        End If
          
      
      End If


      in_dir_small( .direction )
      '.direction And= 3

      .walk_hold = Timer + .mad_walk_speed
      
       __make_face( this )
      
      If LLObject_IncrementFrame( this ) <> 0 Then

        this->frame = 0
        this->frame_hold = Timer + this->animControl[this->current_anim].rateMad
        
        '' reset rate?
      End If
      
    End If
    
    If Timer > .walk_hold Then .walk_hold = 0


    If .thrust <> 0 Then

      If .diag_thrust <> 0 Then

    
        If ( ( more.x <= 16 ) And ( more.y <= 16 ) ) Then
        
          .funcs.current_func[.funcs.active_state] = 0
          .funcs.active_state = .thrust_state

          .frame_hold = 0

          Exit Function
          
        End If

      ElseIf ( ( more.x <= 16 ) And ( more.y <= 8 ) ) Or ( ( more.x <= 8 ) And ( more.y <= 16 ) ) Then
        

        .funcs.current_func[.funcs.active_state] = 0
        .funcs.active_state = .thrust_state

        .frame_hold = 0

        Exit Function

      End If
        
    End If

  End With
  
  Return 0

 
End Function



Function __do_flyback ( this As _char_type Ptr ) As Integer
  
  With *this
  
    Dim As Integer moveback
  
  
    If ( .unique_id = u_grult ) Then
    
      If .fly_timer = 0 Then
      
        
        
        .fly_timer = Timer + .fly_speed
        .fly_count += 1   
        
      End If
    
      If Timer >= .fly_timer Then .fly_timer = 0
    
      If .fly_count >= 50 Then
      
        .fly_count = 0
        .fly_timer = 0 
        .flash_timer = 0 
        .invisible = 0
        .mad =  0
    
        Return 1
        
      End If
      
      Return 0
  
    End If
  
  
    If .fly_length = 0 Then

      If .fly_timer = 0 Then
        .fly_timer = Timer + .2
        
      End If
      If Timer > .fly_timer Then .fly_timer = 0
      
      If .fly_timer = 0 Then
  
        .fly_count = 0
        .fly_timer = 0 
        .flash_timer = 0 
        .invisible = 0
        .mad =  0
'        .return_trig = -1
        
        Return 1
    
      
      End If
      
      Return 0
      
    End If
    
    If .fly_timer = 0 Then
    
      .fly_hold = .direction
  
  
      Select Case .fly.y
  
        Case Is < 0
  
          .direction = 0                  
            move_object( this, , Abs( .fly.y ) )
  
        Case Is > 0
  
          .direction = 2                  
            move_object( this, , Abs( .fly.y ) )
                    
        Case 0
       
  
  
      End Select
  
      Select Case .fly.x
      
        Case Is < 0
  
          .direction = 3                  
  
            move_object( this, , Abs( .fly.x ) )
  
        Case Is > 0
        
          .direction = 1                  
  
            move_object( this, , Abs( .fly.x ) )
  
  
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
      .flash_timer = 0 
      .invisible = 0
      .mad =  0
  
      Return 1
      
    End If
    
  End With
  
  
End Function
    
    

Function __go_grip ( this As _char_type Ptr ) As Integer


  Dim As Integer all_momentum

  For all_momentum = 0 To 7
    
    If this->momentum.i( all_momentum ) <> 0 Then
    
      this->momentum.i( all_momentum ) = 1
      
    End If
    
  Next

  Return 1    
  

 
End Function
 


Function __home ( this As _char_type Ptr ) As Integer
 
  
  #Macro back_move()                 

    If this->moveBackwards <> 0 Then 

      this->direction += 2           
      this->direction And= 3         

    End If
    
  #EndMacro

  Dim As Integer x_home, y_home, x_move, y_move

  this->moving = 0

  If this->walk_hold = 0 Then

    x_home = this->dest_x
    y_home = this->dest_y

    If ( y_home ) > ( this->coords.y ) Then y_move = 1 Else If  ( y_home ) < ( this->coords.y ) Then y_move = -1

    If y_move = -1 Then this->direction = 0
    If y_move = 1 Then this->direction = 2

    If y_move <> 0 Then  
      move_object( this )
      back_move()
      
    End If

    If ( x_home ) > ( this->coords.x ) Then x_move = 1 Else If  ( x_home ) < ( this->coords.x ) Then x_move = -1
  
    If x_move = -1 Then this->direction = 3
    If x_move = 1 Then this->direction = 1

    If x_move <> 0 Then 
      move_object( this )
      back_move()
      
    End If

    If ( this->coords.x = x_home ) And ( this->coords.y = y_home ) Then 

      this->walk_hold = 0

      this->frame = 0
      this->moving = 0
      this->frame = 0
      Return 1
      
    End If

    this->walk_hold = Timer + this->walk_speed

  End If

  If Timer >= this->walk_hold Then 

    this->walk_hold = 0

  End If

  If LLObject_IncrementFrame( this ) <> 0 Then

    this->frame = 0
    this->frame_hold = Timer + this->animControl[this->current_anim].rate
    
    '' reset rate?
  End If


End Function



Function __charger_charge( this As _char_type Ptr ) As Integer
 

  If this->walk_hold = 0 Then
  
    Select Case this->internalState
    
      Case 0
      '' charge
        this->current_anim = 1
        If move_object( this ) = 0 Then
          this->internalState += 1
          
        End If  
        this->walk_speed = .005
      
      Case 1
      '' ow...
        If this->sway = 0 Then
          play_sample( llg( snd )[sound_explosion], 40 )
          this->sway = -1
          
        End If
        this->internalState += __q_second_pause( this )
        
      Case 2
      '' hit wall
        this->sway = 0 
        this->direction += 2
        this->direction And = 3
        
        this->internalState += 1
      
        this->current_anim = 0
        this->walk_speed = .013
        
        
      Case 3
      '' retreating

        If move_object( this ) = 0 Then
          this->internalState += 1
          
        End If  
        
      Case 4
      '' reset
      
        this->direction += 2
        this->direction And = 3

        this->internalState = 0
        play_sample( llg( snd )[sound_switch], 40 )
        Function = 1
      
      
    End Select

    this->walk_hold = Timer + this->walk_speed
    
  End If

  If Timer >= this->walk_hold Then 
    this->walk_hold = 0

    
  End If
  

End Function



Function __momentum_move ( this As _char_type Ptr ) As Integer

  With *this


    Dim As Integer movement
    Dim As Integer look_ahead
    
    Dim As Integer all_momentum
    
  
    For all_momentum = 0 To 7
    
      look_ahead = 0
        
      
      
      
      If .momentum.i( all_momentum ) <> 0 Then

        Dim As Integer temp_dir
        temp_dir = .direction
        .direction = all_momentum
        
        look_ahead = move_object( this, , .momentum.i( .direction ) )
        
        If look_ahead = 0 Then
          '' momentum dies on impact.
          
          If ( .is_psfing = 0 ) And ( .is_pushing = 0 ) Then
            
            .momentum.i( .direction ) = 0 
            
          End If
          
        End If
        
        .direction = temp_dir
        
      End If
      
      movement Or = .momentum.i( all_momentum ) <> 0 
      
    Next
    
    
    
    If movement <> 0 Then
      .walk_hold = Timer + .walk_speed
  
    End If
    
    Return 1    
  
  End With
 
End Function
 


Function __move_down ( this As _char_type Ptr ) As Integer



  If this->walk_hold = 0 Then


    this->direction = 2
    move_object( this )

    If LLObject_IncrementFrame( this ) <> 0 Then

      this->frame = 0
      this->frame_hold = Timer + this->animControl[this->current_anim].rate
      
      '' reset rate?
    End If

    this->walk_hold = Timer + this->walk_speed

    Return 1  
    
  
  Else
  
    If Timer >= this->walk_hold Then this->walk_hold = 0

    
  End If
  
End Function 


Function __move_left ( this As _char_type Ptr ) As Integer


  If this->walk_hold = 0 Then


    this->direction = 3
    move_object( this )



    If LLObject_IncrementFrame( this ) <> 0 Then

      this->frame = 0
      this->frame_hold = Timer + this->animControl[this->current_anim].rate
      
      '' reset rate?
    End If

      
    this->walk_hold = Timer + this->walk_speed

    Return 1  
    
  
  Else
    If Timer >= this->walk_hold Then this->walk_hold = 0
    
  End If
  
End Function 


Function __move_right ( this As _char_type Ptr ) As Integer


  If this->walk_hold = 0 Then


    this->direction = 1
    
    move_object( this )



    If LLObject_IncrementFrame( this ) <> 0 Then

      this->frame = 0
      this->frame_hold = Timer + this->animControl[this->current_anim].rate
      
      '' reset rate?
    End If


    this->walk_hold = Timer + this->walk_speed
    Return 1  
  
  Else
    If Timer >= this->walk_hold Then this->walk_hold = 0
    
  End If
  
  
End Function 


Function __move_up ( this As _char_type Ptr ) As Integer



  If this->walk_hold = 0 Then


    this->direction = 0

    move_object( this )

    If LLObject_IncrementFrame( this ) <> 0 Then

      this->frame = 0
      this->frame_hold = Timer + this->animControl[this->current_anim].rate
      
      '' reset rate?
    End If

    this->walk_hold = Timer + this->walk_speed


    Return 1  
    
  
  Else
  

    If Timer >= this->walk_hold Then this->walk_hold = 0

    
  End If
  

  
End Function 


Function __move_upright ( this As _char_type Ptr ) As Integer



  If this->walk_hold = 0 Then


    this->direction = 5
    
    move_object( this )

    If LLObject_IncrementFrame( this ) <> 0 Then
  
      this->frame = 0
      this->frame_hold = Timer + this->animControl[this->current_anim].rate
      
      '' reset rate?
    End If

    


    this->walk_hold = Timer + this->walk_speed


  Return 1  
    
  
  Else
  

    If Timer >= this->walk_hold Then this->walk_hold = 0

    
  End If
  

  
  
End Function 


Function __stop_grip ( this As _char_type Ptr ) As Integer


  Scope

    Dim As Integer all_momentum
  
      For all_momentum = 0 To 7

        this->momentum_history.i( all_momentum ) = this->momentum.i( all_momentum )
        
        If this->momentum.i( all_momentum ) <> 0 Then
        
          this->momentum.i( all_momentum ) = 0
          
        End If
        
      Next
  
  End Scope

  Return 1    
 

End Function
 


Function __cell_bounce ( this As _char_type Ptr ) As Integer


  If this->walk_hold = 0 Then

    Dim As uInteger callback
    
    callback = move_object( this )

    If ( callback Shr 16 ) = 0 Then
  
      If this->direction and 1 Then 

        this->direction -= 1
      
      Else
      
        this->direction += 1

      End If
    
      this->direction = ( this->direction and 3 ) + 4
    
    ElseIf ( callback And &HFF ) = 0 Then

      If this->direction and 1 Then 

        this->direction += 1
      
      Else
      
        this->direction -= 1

      End If
      
      this->direction = ( this->direction and 3 ) + 4
      
    End If

    If LLObject_IncrementFrame( this ) <> 0 Then
  
      this->frame = 0
      this->frame_hold = Timer + this->animControl[this->current_anim].rate
      
      '' reset rate?
    End If

    this->walk_hold = Timer + this->walk_speed
  
  Else
  
    If Timer >= this->walk_hold Then this->walk_hold = 0
    
  End If

  Return 1 
 
End Function


Function __walk ( this As _char_type Ptr ) As Integer
  

  If this->walk_hold = 0 Then

  
    this->momentum.i( this->direction ) += this->walk_speed * 2

    If this->momentum.i( this->direction ) > 1 Then 
      this->momentum.i( this->direction ) = 1
      
    End If
    

    If this->on_ice = 0 Then
      '' traction
      
      __go_grip( this )      
      
    End If
    

    If this->walk_buffer > this->walk_length Then
    
      If this->on_ice = 0 Then
        ''coming off ice check... too much path
      
        this->walk_buffer = this->walk_length
        
      End If
      
    End If
      

    
    If move_object( this, MO_JUST_CHECKING, this->momentum.i( this->direction ) ) = 0 Then 
      this->walk_steps = this->walk_buffer' - 1
'      this->momentum.i( this->direction ) = 0
      
    Else
      
      If this->momentum.i( this->direction ) = 0 Then
        this->walk_steps = this->walk_buffer' - 1
      
      Else
        __momentum_move( this )
       
      End If
      
    End If
    

    If this->momentum.i( this->direction ) > 0 Then
      this->walk_steps +=  1
     
    End If

    
    If this->walk_steps >= this->walk_buffer Then
      this->frame = 0 
      this->walk_steps = 0

      Return 1
      
    End If


    If LLObject_IncrementFrame( this ) <> 0 Then
  
      this->frame = 0
      this->frame_hold = Timer + this->animControl[this->current_anim].rate
      
      '' reset rate?
    End If

  End If
  

  If Timer >= this->walk_hold Then this->walk_hold = 0



 
End Function



Function __move_backwards( this As _char_type Ptr ) As Integer
  
  this->moveBackwards = -1
  Return 1

End Function

Function __move_normal( this As _char_type Ptr ) As Integer

  this->moveBackwards = 0
  Return 1

End Function

