Option Explicit

#Include "..\headers\ll\headers.bi"

#ifdef ll_main 
  Sub act_key_in_sub( ip As Integer Ptr, op As Integer Ptr )
  
  
  
    '' note: this is only utilized if item is 1 or 2
  
  
  
    llg( hero_only ).attacking = -1
  
    
    
    '' decide which func to play
  
    Select Case llg( hero_only ).selected_item
  
  
  
      Case 1
        '' flare powder func 
        llg( hero ).attack_state = 8
        llg( hero_only ).powder = llg( hero_only ).selected_item
  
  
      Case 2 
        '' ice powder func 
        llg( hero ).attack_state = 9
        llg( hero_only ).powder = llg( hero_only ).selected_item
  
  
      Case 3, 4
        '' bridge, idol      
        llg( seq ) = llg( hero_only ).specialSequence
        llg( hero_only ).attacking = 0
  
      Case 5
        '' adrenaline boost
        if llg( hero_only ).adrenaline = 0 then
          if llg( hero ).hp > 3 then
            llg( hero_only ).adrenaline = timer + 6
            llg( hero ).hp -= 3
            antiHackASSIGN( LL_Global.hero_only.healthDummy, LL_Global.hero.hp )
            
          end if
          
        end if
          
        llg( hero_only ).attacking = 0
  
  
      Case 6
        '' healage
        if llg( hero_only ).healing = 0 then
          if llg( hero ).hp < llg( hero ).maxhp then
            if llg( hero ).money > 1 then
              llg( hero ).hp += 1
              llg( hero ).money -= 2
              antiHackASSIGN( LL_Global.hero_only.moneyDummy, LL_Global.hero.money )
              antiHackASSIGN( LL_Global.hero_only.healthDummy, LL_Global.hero.hp )
              
              llg( hero_only ).healing = -1
              play_sample( llg( snd )[sound_heal], 80 )
              
            end if
          end if
        end if
          
        llg( hero_only ).attacking = 0
  
      Case Else 
        '' return quietly
        llg( hero_only ).attacking = 0
  
    End Select
  
  End Sub
        
  
  Sub act_key_out_sub( ip As Integer Ptr, op As Integer Ptr )
  
  
    llg( hero_only ).powder = 0
  
  
  End Sub
  
  
  
  
  Sub weap_switch_key_in_sub( ip As Integer Ptr, op As Integer Ptr )
  
    If llg( hero_only ).has_weapon <> -1 Then
    
  
      llg( hero_only ).weapon += 1 
  
  
      If llg( hero_only ).weapon > llg( hero_only ).has_weapon Then llg( hero_only ).weapon = 0
  
  
      If llg( hero_only ).weapon < 0 Then llg( hero_only ).weapon = llg( hero_only ).has_weapon
  
      
    End If
  
  End Sub
        
  
  Sub weap_switch_key_out_sub( ip As Integer Ptr, op As Integer Ptr )
  End Sub
  
  
  Sub item_l_key_in_sub( ip As Integer Ptr, op As Integer Ptr )
   
  
    dim as integer lastSelected
    
    lastSelected = llg( hero_only ).selected_item
    
    do
      
      llg( hero_only ).selected_item -= 1
      
      if llg( hero_only ).selected_item = -1 then llg( hero_only ).selected_item = 6
        
      if llg( hero_only ).selected_item = lastSelected then exit do
      if llg( hero_only ).hasItem( llg( hero_only ).selected_item - 1 ) then exit do
      
    loop
    
    
  End Sub
  
  
  Sub item_l_key_out_sub( ip As Integer Ptr, op As Integer Ptr )
  End Sub
  
  
  Sub item_r_key_in_sub( ip As Integer Ptr, op As Integer Ptr )
  
    dim as integer lastSelected
    
    lastSelected = llg( hero_only ).selected_item
    
    do
      
      llg( hero_only ).selected_item += 1
      
      if llg( hero_only ).selected_item = 7 then llg( hero_only ).selected_item = 0
      
      if llg( hero_only ).selected_item = lastSelected then exit do
      if llg( hero_only ).hasItem( llg( hero_only ).selected_item - 1 ) then exit do
      
    loop
  
  End Sub
  
  
  Sub item_r_key_out_sub( ip As Integer Ptr, op As Integer Ptr )
  End Sub
  
  
  
  Sub conf_key_in_sub( ip As Integer Ptr, op As Integer Ptr )
  
  
    llg( hero )_only.action = 1
  
  
  End Sub
        
  
  Sub conf_key_out_sub( ip As Integer Ptr, op As Integer Ptr )
  
  
  
    llg( hero )_only.action = 0
  
  
  
  End Sub
  
  
  
  Sub atk_key_in_sub( ip As Integer Ptr, op As Integer Ptr )
    
    If llg( hero_only ).isWearing = 1 Then Exit Sub
    If llg( hero_only ).isWearing = 5 Then Exit Sub
  
    If llg( hero_only ).weapon <> -1 Then
  
  
  
      llg( hero_only ).attacking = -1
  
      
      
      If llg( hero_only ).crazy_points >= 99 Then
        
        
        llg( hero_only ).crazy_points = 0
        llg( hero ).attack_state = 37
        llg( hero ).psycho = -1
        
      Else
      
        llg( hero ).attack_state = 6
      
        
      End If
      
  
      Dim lynn_yell As Integer
  
      lynn_yell = Int( Rnd * 4 )
      lynn_yell += sound_lynn_attack_1
      
  
      play_sample( llg( snd )[lynn_yell], 30 )
          
  
    End If
    
  
  End Sub
  
  
  Sub atk_key_out_sub( ip As Integer Ptr, op As Integer Ptr )
  End Sub
#endif


#IfDef __gMap__

  Sub zoom_key_in_sub( ip As Integer Ptr, op As Integer Ptr )
  
  
    gmg( zooming ) = Not gmg( zooming )
    gmg( refresh ) = 1
  
  
  End Sub
        
  
  
  Sub flood_key_in_sub( ip As Integer Ptr, op As Integer Ptr )
  
  
    gmg( _state ) = s_flood_fill
    gmg( refresh ) = 1
  
  
  End Sub
        
  Sub solo_key_in_sub( ip As Integer Ptr, op As Integer Ptr )
  
  
    gmg( solo ) = Not gmg( solo )
    gmg( refresh ) = 1
  
  
  End Sub
        
  
  Sub room_up_key_in_sub( ip As Integer Ptr, op As Integer Ptr )
    
    If gmg( _state ) = s_sequence_command_blocks Then
    
      gmg( ent_commands ).sel += 1
      If gmg( ent_commands ).sel > selected_sequence().commands - 1 Then gmg( ent_commands ).sel = 0
      gmg( blocks ).sel = 0
      gmg( blocks ).last_sel = 0

      gmg( blocks ).last_num = selected_sequence().Command[gmg( ent_commands ).sel].ents
    
    Else
      
      llg( this_room.i ) += 1
      If llg( this_room.i ) > llg( map )->rooms - 1 Then llg( this_room.i ) = 0
      new_room_init()
      
      
    End If
    
  
  
  End Sub
        
  
  Sub room_down_key_in_sub( ip As Integer Ptr, op As Integer Ptr )
  
  
    If gmg( _state ) = s_sequence_command_blocks Then
    
      gmg( ent_commands ).sel -= 1
      If gmg( ent_commands ).sel < 0 Then gmg( ent_commands ).sel = selected_sequence().commands - 1

      gmg( blocks ).sel = 0
      gmg( blocks ).last_sel = 0

      gmg( blocks ).last_num = selected_sequence().Command[gmg( ent_commands ).sel].ents
    
    Else
      llg( this_room.i ) -= 1
      If llg( this_room.i ) < 0 Then llg( this_room.i ) = llg( map )->rooms - 1
      new_room_init()
      
    End If
  
  
  End Sub
        
  
  Sub redim_key_in_sub( ip As Integer Ptr, op As Integer Ptr )
  
  
    gmg( _state ) = s_redimension
    gmg( refresh ) = 1
  
  
  End Sub
        
  
  Sub grid_key_in_sub( ip As Integer Ptr, op As Integer Ptr )
  
  
    gmg( grid ) = Not gmg( grid )
    gmg( refresh ) = 1
  
  
  End Sub
        
  
  Sub w_grid_key_in_sub( ip As Integer Ptr, op As Integer Ptr )
  
  
    gmg( w_grid ) = Not gmg( w_grid )
    gmg( refresh ) = 1
  
  
  End Sub


  Sub hide_key_in_sub( ip As Integer Ptr, op As Integer Ptr )
  
  
    gmg( hide ) Xor= 1
    gmg( refresh ) = 1
  
  
  End Sub
        
  
        

#EndIf  
