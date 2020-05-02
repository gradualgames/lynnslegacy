Option Explicit

#Include "..\headers\ll.bi"




Function out_proximity( this As char_type Ptr ) As Integer
  
  With *this
    
    If .unique_id = u_charger Then
      Return .funcs.active_state
      
    End If
  
    Dim As mat_int hero_middle, this_middle, more
    
    hero_middle.x = llg( hero ).coords.x + ( llg( hero ).perimeter.x Shr 1 )
    hero_middle.y = llg( hero ).coords.y + ( llg( hero ).perimeter.y Shr 1 )
    
    this_middle.x = .coords.x + ( .perimeter.x Shr 1 )
    this_middle.y = .coords.y + ( .perimeter.y Shr 1 )
    
    more.x = Abs( hero_middle.x - this_middle.x )
    more.y = Abs( hero_middle.y - this_middle.y )
    
  
    If .must_align Then
    
      If ( ( more.x < IIf( .side_vision <> 0 , .side_vision, 4 ) ) And ( more.y < .vision_field ) ) Or ( ( more.x < .vision_field ) And ( more.y < IIf( .side_vision <> 0, .side_vision, 4 ) ) ) Then

        .reset_delay = Timer + .lose_time
        
      End If

      If Timer >= .reset_delay Then

        If ( ( more.x < IIf( .side_vision <> 0 , .side_vision, 4 ) ) Or ( more.y < .vision_field ) ) And ( ( more.x < .vision_field ) Or ( more.y < IIf( .side_vision <> 0, .side_vision, 4 ) ) ) Then
    
          .reset_delay = 0

          .sway = 0
          .degree = 0
          .mad = 0
          .funcs.current_func[.funcs.active_state] = 0
          
          Return .reset_state
        
        End If
        
      End If
    
      Return .funcs.active_state
      
    
    Else
      If ( more.x < .vision_field ) And ( more.y < .vision_field ) Then
        .reset_delay = Timer + .lose_time
        
      End If

      If Timer >= .reset_delay Then

        If ( more.x > .vision_field ) Or ( more.y > .vision_field ) Then

          .reset_delay = 0

          .sway = 0
          .degree = 0
          .mad = 0
          .funcs.current_func[.funcs.active_state] = 0

          Return .reset_state
          
        End If
        
      End If

    End If
  
  
    If .far_reset_delay = 0 Then
  
      If ( more.x > ( .vision_field * 2 ) ) Or ( more.y > ( .vision_field * 2 ) ) Then
        .far_reset_delay = Timer + 1
  
        Return .funcs.active_state
      
      
      End If
      
    Else
  
      If ( more.x < ( .vision_field * 2 ) ) Or ( more.y < ( .vision_field * 2 ) ) Then
        .far_reset_delay = 0
  
        Return .funcs.active_state
        
      Else
  
        If Timer >= .far_reset_delay Then
  
          .far_reset_delay = 0
          .reset_delay = 0
  
          If .thrust <> 0 Then .current_anim = 0

          .sway = 0
          .degree = 0
          .mad = 0
          .funcs.current_func[.funcs.active_state] = 0
  
          Return .reset_state
      
        End If
            
      End If
  
    End If

    Return .funcs.active_state
    
  End With

 
End Function



Function in_proximity( this As char_type Ptr ) As Integer

  Dim As Integer shifty_gen
  
  Dim As mat_int hero_middle, this_middle, more

  With *this
  
    hero_middle.x = llg( hero ).coords.x + ( llg( hero ).perimeter.x Shr 1 )
    hero_middle.y = llg( hero ).coords.y + ( llg( hero ).perimeter.y Shr 1 )
    
    this_middle.x = .coords.x + ( .perimeter.x Shr 1 )
    this_middle.y = .coords.y + ( .perimeter.y Shr 1 )
    
    more.x = Abs( hero_middle.x - this_middle.x )
    more.y = Abs( hero_middle.y - this_middle.y )
  

    If (more.x < .vision_field) Then
  
      If (more.y < .vision_field) Then
    
        
        If .shifty <> 0 Then

          If .shifty_lock = 0 Then
         
            .shifty_state = Int ( Rnd * 2 ) 
            .shifty_lock = 1
            
          End If
          
        End If 
  
        
        If ( .shifty <> 0 ) Imp ( .shifty_state = 0 ) Then
          '' this doesn't happen if( shifty <> 0 and shifty_state <> 0 )
        
          If .must_align Then
            
            If ( ( more.x < IIf( .side_vision <> 0 , .side_vision, 4 ) ) And ( more.y < .vision_field ) ) Or ( ( more.x < .vision_field ) And ( more.y < IIf( .side_vision <> 0, .side_vision, 4 ) ) ) Then

              .mad = 1 

              .reset_delay = 0
              .pause_hold = 0
  
              .funcs.current_func[.funcs.active_state] = 0
              Return .jump_state
            
            End If
          
            Return .funcs.active_state
            
          End If
  
          .mad = 1 

          .reset_delay = 0
          .pause_hold = 0
  
          .funcs.current_func[.funcs.active_state] = 0
  
          Return .jump_state
          
        Else
        
          Return .funcs.active_state
        
        End If
        
      Else
      
        .shifty_lock = 0    
        .shifty_state = 0    
      
      End If
  
    End If

    Return .funcs.active_state
    
  End With

 
End Function





Function LLObject_SpawnKill( o As char_type Ptr ) As Integer


    Dim As Integer op, res, i
    
    With *( o )
  
      If .spawn_kill_trig = 0 Then
    
        If .spawn_info->kill_n <> 0 Then
        
          res = -1
          For i = 0 To .spawn_info->kill_n - 1
          
            op = ( llg( now )[.spawn_info->kill_spawn[i].code_index] <> 0 )
    
            If .spawn_info->kill_spawn[i].code_state = 0 Then
              op = Not op
              
            End If 
            
            res And= op
          
          Next
          
          Return res
              
        End If 
        
      End If
      
    End With
    

            
            
End Function


Function LLObject_SpawnWait( o As char_type Ptr ) As Integer


    Dim As Integer op, res, i
    
    With *( o )
  
      If .spawn_wait_trig = 0 Then
    
        If .spawn_info->wait_n <> 0 Then
        
          res = -1
          For i = 0 To .spawn_info->wait_n - 1
          
            op = ( llg( now )[.spawn_info->wait_spawn[i].code_index] <> 0 )
    
            If .spawn_info->wait_spawn[i].code_state = 0 Then
              op = Not op
              
            End If 
            
            res And= op
          
          Next
          
          Return res
          
        End If 
        
      End If
      
    End With
    


End Function