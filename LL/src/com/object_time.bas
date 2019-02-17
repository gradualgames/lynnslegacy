Option Explicit


#Include "..\headers\ll\headers.bi"


Function __poll_action ( this As _char_type Ptr ) As Integer

  
  'set_debug()
  
  If llg( hero ).switch_room = -1 Then
    If ( llg( hero )_only.action <> 0 ) Then Return 1
    
  End If

 
End Function


Function __check_key ( this As _char_type Ptr ) As Integer
  
  If llg( hero ).key = 0 Then

    this->return_trig = 1
    Return 1
    
  End If

  llg( hero ).key -= 1

  
  Return 1
  


End Function



Function __check_trigger ( this As _char_type Ptr ) As Integer


  


  If this->trigger <> 0 Then 
    
    this->invincible = 0
    LLObject_ShiftState( this, this->jump_state )

  End If
  
  Return 1
 
End Function



Function __half_second_pause ( this As _char_type Ptr ) As Integer

  this->frame = 0

  
  

  If this->pause = 0 Then

    this->pause = Timer + .5

    
  End If
  
  If Timer >= this->pause Then 
    this->pause = 0

    Return 1
    
  
  End If
  
 
End Function
                                                                       

Function __if_all_dead ( this As _char_type Ptr ) As Integer


  Dim As Integer prb, prbt, veri

  veri = -1

  For prb = 0 To llg( map )->room[llg( this )_room.i].enemies - 1
  
    With llg( map )->room[llg( this )_room.i].enemy[prb]
  
      veri = veri And ( .dead <> 0 Or ( _ 
                                        .unique_id = u_keydoor  Or _ 
                                        .unique_id = u_fkeydoor Or _ 
                                        .unique_id = u_ltorch   Or _ 
                                        .unique_id = u_torch    Or _ 
                                        .unique_id = u_bardoor     _ 
                                      ) _ 
                      )
    
    End With
    
    If veri = 0 Then Return -1
  

  Next

  For prb = 0 To llg( map )->room[llg( this )_room.i].temp_enemies - 1
  
    veri = veri And ( llg( map )->room[llg( this )_room.i].temp_enemy( prb ).dead <> 0 )
    
    If veri = 0 Then Return -1
  

  Next
  
  If this->chap <> 0 Then
    Return 1    
        
  End If
 
End Function
 


Function __check_b_key ( this As _char_type Ptr ) As Integer


 
  If llg( hero_only ).b_key = 0 Then

    this->return_trig = 1
    Return 0
    
  End If


  
  Return 1
  


End Function




Function __q_second_pause ( this As _char_type Ptr ) As Integer

  

  If this->pause = 0 Then

    this->pause = Timer + .25

    
  End If
  
  If Timer >= this->pause Then 
    this->pause = 0

    Return 1
    
  
  End If
  
 
End Function
                                                                       



 
Function __second_pause ( this As _char_type Ptr ) As Integer



  
  

  If this->pause = 0 Then

    this->pause = Timer + 1

    
  End If
  
  If Timer >= this->pause Then 
    this->pause = 0

    Return 1
  
  End If
  
 
End Function
                                                                       




Function __timed_jump_2 ( this As _char_type Ptr ) As Integer


  If this->jump_timer = 0 Then
    this->jump_timer += this->jump_time + Timer
    
  End If
  
  If Timer >= this->jump_timer Then
    this->jump_timer = 0
    Return 1
    
  End If
    
  
  Return -2
  


End Function



Function __back_3( this As _char_type Ptr ) As Integer
  
  Return -3

End Function





Function __counted_jump ( this As _char_type Ptr ) As Integer


  If this->jump_count = this->jump_counter Then 
  
    this->jump_counter = 0
    
    Return 1
    
  End If
  this->jump_counter += 1
  
  Return -1
  


End Function



Function __counted_jump_2 ( this As _char_type Ptr ) As Integer



  If this->jump_count = this->jump_counter Then

    this->jump_counter = 0
    
    Return 1
    
  End If
      
  this->jump_counter += 1
  
  Return -2
  


End Function



Function __jump_2_back ( this As _char_type Ptr ) As Integer

'  this->funcs.current_func[this->funcs.active_state] -= 1

  Return -1
 
End Function


Function __return_idle ( this As _char_type Ptr ) As Integer
  

  this->funcs.current_func[this->funcs.active_state] = 0
  this->funcs.active_state = 0
  this->funcs.current_func[this->funcs.active_state] = 0
  
  Return 0

 
End Function


Function __return_jump( this As _char_type Ptr ) As Integer

  this->funcs.current_func[this->funcs.active_state] = 0

  this->funcs.active_state = this->jump_state
  
  Return 0

 
End Function


Function __return_jump_1( this As _char_type Ptr ) As Integer

  this->funcs.current_func[this->funcs.active_state] = 0

  this->funcs.active_state = this->jump_state

  this->funcs.current_func[this->funcs.active_state] = 1
  
  Return 0

 
End Function


Function __return_jump_npc( this As _char_type Ptr ) As Integer

  this->funcs.current_func[this->funcs.active_state] = 0

  this->funcs.active_state = this->jump_state
  
  return 1


 
End Function


Function __return_jump_back ( this As _char_type Ptr ) As Integer

'  this->funcs.current_func = this->jumpstate + 2
  LLObject_ShiftState( this, this->jump_state )
  this->funcs.current_func[this->funcs.active_state] = 1
  Return 0
  
End Function


Function __return_reset ( this As _char_type Ptr ) As Integer
  

  this->funcs.current_func[this->funcs.active_state] = 0

  this->funcs.active_state = this->reset_state

  Return 0
 
End Function


Function __return_reset_npc ( this As _char_type Ptr ) As Integer
  

  this->funcs.current_func[this->funcs.active_state] = 0

  this->funcs.active_state = this->reset_state
  
  
  return 1


 
End Function


Function __timed_jump ( this As _char_type Ptr ) As Integer


  If this->jump_timer = 0 Then
    this->jump_timer += this->jump_time + Timer
    
  End If
  
  If Timer >= this->jump_timer Then
    this->jump_timer = 0
    Return 1
    
  End If
    
  
  Return -1
  


End Function



Function __cond_jump ( this As _char_type Ptr ) As Integer Static
  

  Return IIf( ( Int ( Rnd * 2 ) ) < 1, -1, 1 )

 
End Function



