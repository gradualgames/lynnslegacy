option explicit

#Include "..\headers\ll\headers.bi"



Function __up_face ( this As _char_type Ptr ) As Integer

  this->direction = 0
  
  Return 1
 
End Function  


Function __set_func ( this As _char_type Ptr ) As Integer

  this->funcs.func[this->funcs.active_state] = 0
  this->funcs.active_state = this->chap
  
  Return 1
 
 
End Function
                                                                       

Function __release_seq ( this As _char_type Ptr ) As Integer

  this->seq_release = 1
  
  Return 1
 
 
End Function
                                                                       

Function __set_white_fade( this As _char_type Ptr ) As Integer

  llg( hero_only ).fadeStyle Or= LLFADE_WHITE
  
  Return 1
 
 
End Function
                                                                       

Function __set_gray_fade( this As _char_type Ptr ) As Integer

  llg( hero_only ).fadeStyle Or= LLFADE_GRAY
  
  Return 1
 
 
End Function
                                                                       

Function __make_vulnerable ( this As _char_type Ptr ) As Integer


  this->invincible = 0
  
  Return 1


End Function


Function __make_visible ( this As _char_type Ptr ) As Integer

  this->invisible = 0
  
  Return 1


End Function


Function __make_invisible ( this As _char_type Ptr ) As Integer


  this->invisible = 1
  
  Return 1


End Function


Function __make_invincible ( this As _char_type Ptr ) As Integer


  this->invincible = 1
  
  Return 1


End Function


Function __make_dead ( this As _char_type Ptr ) As Integer

  With *this
    
    If ( .unique_id <> u_charger ) And ( .unique_id <> u_ferus ) Then
      .direction = 0
      .animating = 1   
      
    End If
    
    .hurt        = 0   
    LLObject_ClearDamage( this )

    .flash_timer = 0   
    .flash_count = 0   
    .invisible   = 0   
    .dead        = -1  
    
    If ( .unique_id = u_pekkle_bomb ) Or ( .unique_id = u_kambot ) Then
      
      play_sample( llg( snd )[sound_explosion], 80 )
    
      .coords.x -= 24
      .coords.y -= 24
      
      .perimeter.x = 64
      .perimeter.y = 64
      
      .strength    = 3
      
    Else
    
      .strength    = 0   
      
    End If

    .fly = Type <vector> ( 0, 0 )
    
    If ( Not ( .unique_id = u_ibug ) ) And ( Not ( .unique_id = u_fbug ) ) And ( Not ( .unique_id = u_boss5_down ) ) And ( Not ( .unique_id = u_boss5_left ) ) And ( Not ( .unique_id = u_boss5_right ) ) Then
      .proj_style = 0
      
    End If
    
    Select Case .unique_id


      Case u_sterach
        '' hack; kill swordie :'(
        now_room().enemy[0].hp = 0
        If llg( now )[1203] Then
        
          LLObject_ShiftState( this, 5 )
        
        
        End If
        
      Case u_divine
        
        '' kill ball.
        now_room().enemy[21].hp = 0
        LLObject_ShiftState( Varptr( now_room().enemy[22] ), 1 )
        now_room().enemy[22].invisible = 0
      
      Case u_divine_bug
        Dim As Integer i

        For i = 0 To 5
          now_room().enemy[i].hp = 0
        
        Next
        
        For i = 7 To 19
          now_room().enemy[i].hp = 0
        
        Next
        
      Case u_boss5_right, u_boss5_left, u_boss5_down, u_boss5_crystal

        If llg( now )[598] Then
          '' boss 5 hack
        
          LLObject_ShiftState( this, 4 )
        
        
        End If
      
    End Select
    
  End With
    

  Return 1

 
End Function


Function __inc_sel_seq ( this As _char_type Ptr ) As Integer

  this->sel_seq += 1

  Return 1

 
End Function


Function __set_explosions( this As _char_type Ptr ) As Integer

  this->explosions = this->chap

  Return 1

 
End Function


Function __set_anim( this As _char_type Ptr ) As Integer

  this->frame = 0
  this->frame_hold = NULL
  this->current_anim = this->chap

  Return 1

 
End Function



Function __full_heal ( this As _char_type Ptr ) As Integer

  this->hp = this->maxhp
  
  Return 1
  
 
End Function
                                                                       

Function __dir_up ( this As _char_type Ptr ) As Integer

  this->direction = 0

  Return 1

 
End Function



Function __dir_right ( this As _char_type Ptr ) As Integer

  this->direction = 1

  Return 1

 
End Function


 
Function __dir_left ( this As _char_type Ptr ) As Integer

  this->direction = 3

  Return 1

 
End Function


 
Function __dir_down ( this As _char_type Ptr ) As Integer

  this->direction = 2

  Return 1

 
End Function


 
Function __chapter_1_off ( this As _char_type Ptr ) As Integer


  llg( do_chap ) = 0

  Return 1
  


End Function



Function __cool_down ( this As _char_type Ptr ) As Integer


  this->mad = 0
  
  Return 1
 
End Function



 
Function __chapter_1_on ( this As _char_type Ptr ) As Integer


  llg( do_chap ) = 1


  
  Return 1
  


End Function




Function __cripple ( this As _char_type Ptr ) As Integer


  Select Case this->unique_id
  
    Case u_ghut, u_chest, u_bluechest, u_bluechestitem, u_hotrock, u_coldrock, u_greyrock, u_button, u_gbutton
      this->invisible = 0
      
    Case Else
      this->invisible = -1
      
  End Select
  
  If this->dead_hold = 0 Then
    this->dead_hold = Timer + .1
    
  End If
  
  If Timer > this->dead_hold Then
    this->dead_hold = 0
    
    Return 1
    
  End If
    
          
  this->strength = 0 '' clean up after the pekkle hack.
  this->impassable = 0
  this->animating = 0
  this->total_dead = -1 

 
End Function



Function __gen_frame ( this As _char_type Ptr ) As Integer Static

  this->animControl[this->current_anim].rate = ( Rnd * ( this->high_frame - this->low_frame ) ) + this->low_frame
  
  Return 1
  
End Function


