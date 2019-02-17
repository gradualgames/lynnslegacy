Option Explicit

#Include "..\headers\ll.bi"

Sub get_block_fade_input()


  Dim As Integer ene_ver
    Dim As String tmp_id

  
  Do
  
    Locate 66, 86
    ? space( 4 )

    ScreenSet 0, 0  
    Locate 66, 86, 1
    
  
    tmp_id = ""
    Input "", tmp_id
    
    
    ene_ver = -1
    
    If Val( tmp_id ) < 0 Then ene_ver = 0
    
  Loop Until ene_ver <> 0
  
  selected_command_block().fadeTime = Val( tmp_id )

  
  ScreenSet 0, 1  

  Do
    Sleep 1
  
  Loop While MultiKey( sc_enter )

  Scope
    
    Dim As String empty_key

    Do
      empty_key = Inkey
      
    Loop Until ( Len( empty_key ) = 0 ) And ( Not MultiKey( sc_enter ) )
    
  End Scope


End Sub



                           
Sub entity_box()


    If total_control_elements( gmg( _state ) ) = 0 Then Exit Sub
    
    Dim As String gMapCS
    
    gMapCS = "Sequence #" & selected_control_element( s_sequence ) & space( 3 - Len( Str( selected_control_element( s_sequence ) ) ) ) 

    Locate 58, 63
    ? gMapCS

    Locate 59, 62
    ? Chr( 195 ) & String( Len( gMapCS ) - 3 + Len( Str( selected_control_element( s_sequence ) ) ), 196 ) & Chr( 217 )


    Locate 61, 62
  
    Select Case active_sequence()
    
          
    
      Case seq_enemy
        ? Chr( 195 ) & " Enemy [" & gmg( enem ).sel & "]"
    
      Case seq_entry
        ? Chr( 195 ) & " Entry [" & gmg( entr ).sel & "]"
          
      Case seq_room
        ? Chr( 195 ) & " Room [" & llg( this_room ).i & "]"
          
    End Select
    


    Locate 64, 63
    ? " Entity[" & gmg( seq_ents ).sel & "]: "


  Scope
    
    Dim As String gMapCEnt
    gMapCEnt = Chr( 195 ) & " Gives orders to: "
    If selected_sequence().ent_code[gmg( seq_ents ).sel] = -1 Then

      gMapCEnt += "Main Char"
      
    Else

      gMapCEnt += "Enemy[" & selected_sequence().ent_code[gmg( seq_ents ).sel] & "]"
      
    End If 


    '' can't touch this...    
    setup_bounds( 66, 62, gMapCEnt )

    click_bounds( get_entity_code_input() )

    
  End Scope
  

End Sub               


Sub command_box()


    If total_control_elements( gmg( _state ) ) = 0 Then Exit Sub
    
    Dim As String gMapCS
    
    gMapCS = "Sequence #" & selected_control_element( s_sequence ) & space( 3 - Len( Str( selected_control_element( s_sequence ) ) ) ) 

    Locate 58, 63
    ? gMapCS;
    Select Case active_sequence()
    
          
    
      Case seq_enemy
        ? "Enemy [" & gmg( enem ).sel & "]"
    
      Case seq_entry
        ? "Entry [" & gmg( entr ).sel & "]"
          
      Case seq_room
        ? "Room [" & llg( this_room ).i & "]"
          
    End Select
    

    Locate 59, 62
    ? Chr( 195 ) & String( Len( gMapCS ) - 3 + Len( Str( selected_control_element( s_sequence ) ) ), 196 ) & Chr( 217 )

    Locate 61, 63
    ? " Command[" & gmg( ent_commands ).sel & "]: "


  Scope

    Dim As String gMapCEnt
    gMapCEnt = Chr( 195 ) & " Blocks: " & selected_sequence().Command[gmg( ent_commands ).sel].ents
    setup_bounds( 63, 62, gMapCEnt )

  End Scope
  

End Sub               


Sub command_block_box()


    If total_control_elements( gmg( _state ) ) = 0 Then Exit Sub
    
    Dim As String gMapCS
    gMapCS = "Sequence #" & selected_control_element( s_sequence ) & space( 3 - Len( Str( selected_control_element( s_sequence ) ) ) ) 

    Locate 58, 63
    ? gMapCS;

    Select Case active_sequence()
    
          
    
      Case seq_enemy
        ? "Enemy [" & gmg( enem ).sel & "]"
    
      Case seq_entry
        ? "Entry [" & gmg( entr ).sel & "]"
          
      Case seq_room
        ? "Room [" & llg( this_room ).i & "]"
          
    End Select
    

    Locate 59, 62
    ? Chr( 195 ) & String( Len( gMapCS ) - 3 + Len( Str( selected_control_element( s_sequence ) ) ), 196 ) & Chr( 217 )

    Locate 61, 63
    ? " Command[" & gmg( ent_commands ).sel & "], ";
    ? "Block[" & gmg( blocks ).sel & "]: "

  Scope

    Dim As String gMapPretty
    gMapPretty = Chr( 195 ) & " Slave: " 
    If selected_command_block().active_ent = 1024 Then
      gMapPretty += "txt"
      
    Else
      gMapPretty += Str( selected_command_block().active_ent )
      
    End If
    
    setup_bounds( 63, 62, gMapPretty )
    click_bounds( get_block_slave_input() )
    gMapPretty = ""

  End Scope
  
  Scope

    Dim As String gMapPretty
    If selected_command_block().active_ent <> ent_textbox Then
      gMapPretty = Chr( 195 ) & " Func : " & selected_command_block().ent_state
    End If

    setup_bounds( 64, 62, gMapPretty )
    click_bounds( get_block_func_input() )
    gMapPretty = ""

  End Scope
  
  Scope

    Dim As String gMapPretty
    If selected_command_block().active_ent = 1024 Then
    
      Dim As Integer t_blocks = Len( selected_command_block().text ) \ 20, i
      If t_blocks <> Len( selected_command_block().text ) / 20 Then
        t_blocks += 1 
        
      End If
      
'      Dim As String blck( t_blocks - 1 )
      
      For i = 0 To t_blocks - 1
        Locate 66 + i, 71
'        blck( i ) = Mid$( selected_command_block().text, ( i * 20 ) + 1, 20 )
        ? Mid$( selected_command_block().text, ( ( i + 1 ) * 20 ) + 1, 20 )
        If i = 5 Then
          Locate 66 + i, 91
          ? "[...]" 
          Exit For
          
        End If
        
      Next
      
      
        
    
      gMapPretty = Chr( 195 ) + " Text : " + Left( selected_command_block().text, 20 )
      
      
'      If Len( selected_command_block().text ) > 20 Then
'        gMapPretty += "..."
'        
'      End If
      
    End If
    
    setup_bounds( 65, 62, gMapPretty )
    click_bounds( get_block_text_input() )
    gMapPretty = ""

  End Scope
  
  Scope

    Dim As String gMapPretty
    If selected_command_block().active_ent <> ent_textbox Then
      gMapPretty = Chr( 195 ) & " Loop : " & selected_command_block().jump_count
    
    End If
    setup_bounds( 66, 62, gMapPretty )
    click_bounds( get_block_loop_input() )
    gMapPretty = ""

  End Scope
  
  Scope

    Dim As String gMapPretty
    If selected_command_block().active_ent <> ent_textbox Then
      gMapPretty = Chr( 195 ) & " Map  : " & selected_command_block().to_map
      
    End If
    setup_bounds( 67, 62, gMapPretty )
    click_bounds( get_block_map_input() )
    gMapPretty = ""

  End Scope
  
  Scope

    Dim As String gMapPretty
    If selected_command_block().active_ent <> ent_textbox Then
      gMapPretty = Chr( 195 ) & " Entry: " & selected_command_block().to_entry
      
    End If
    
    setup_bounds( 68, 62, gMapPretty )
    click_bounds( get_block_entry_input() )
    gMapPretty = ""

  End Scope
  
  Scope

    Dim As String gMapPretty
    If selected_command_block().active_ent <> ent_textbox Then
      If selected_command_block().display_hud = 0 Then
        gMapPretty = Chr( 195 ) & " HUD  : off"
        
      Else
        gMapPretty = Chr( 195 ) & " HUD  : on"
      
      End If
      
    End If
    
    setup_bounds( 69, 62, gMapPretty )
    click_bounds( get_block_hud_input() )
    gMapPretty = ""

  End Scope
  
  Scope

    Dim As String gMapPretty
    If selected_command_block().active_ent <> ent_textbox Then
      If selected_command_block().free_to_move = 0 Then
        gMapPretty = Chr( 195 ) & " Lock : on"
        
      Else
        gMapPretty = Chr( 195 ) & " Lock : off"
        
      End If
      
    End If
    setup_bounds( 70, 62, gMapPretty )
    click_bounds( get_block_lock_input() )
    gMapPretty = ""

  End Scope
  
'  Scope
'
'    Dim As String gMapPretty
'    gMapPretty = Chr( 195 ) & " des x: " & selected_command_block().dest_x
'    setup_bounds( 71, 62, gMapPretty )
'    gMapPretty = ""
'
'  End Scope
  


  Scope

    Dim As String gMapPretty
    gMapPretty = "Chap    : " & selected_command_block().chap
    setup_bounds( 63, 76, gMapPretty )
    tp_lf.x -= 16
    click_bounds( get_block_chap_input() )
    gMapPretty = ""

  End Scope
  
'  Scope
'
'    Dim As String gMapPretty
'    gMapPretty = "al (spd): " & selected_command_block().chap
'    setup_bounds( 64, 76, gMapPretty )
'    gMapPretty = ""
'
'  End Scope
  
  Scope

    Dim As String gMapPretty
    If selected_command_block().active_ent <> ent_textbox Then
      If selected_command_block().carries_all <> 0 Then
        gMapPretty = "Carries : yes"
        
      Else
        gMapPretty = "Carries : no"
        
      End If
        
        
      
    End If
    
    setup_bounds( 64, 76, gMapPretty )
    tp_lf.x -= 16
    click_bounds( get_block_carry_input() )
    gMapPretty = ""

  End Scope
  
  Scope

    Dim As String gMapPretty
    If selected_command_block().active_ent <> ent_textbox Then
      If selected_command_block().nocam = 0 Then
        gMapPretty = "No Cam  : no"
        
      Else
        gMapPretty = "No Cam  : yes"
        
      End If
      
    End If
    
    setup_bounds( 68, 76, gMapPretty )
    click_bounds( get_block_cam_input() )
    gMapPretty = ""

  End Scope
  
  Scope

    Dim As String gMapPretty
    If selected_command_block().active_ent <> ent_textbox Then
      gMapPretty = "Dir     : " & selected_command_block().modify_direction
      
    End If
    
    setup_bounds( 69, 76, gMapPretty )
    tp_lf.x -= 16
    click_bounds( get_block_dir_input() )
    gMapPretty = ""

  End Scope
  

  Scope

    Dim As String gMapPretty
    If selected_command_block().active_ent <> ent_textbox Then
      If selected_command_block().seq_pause = 0 Then
        gMapPretty = "Pause   : no"
        
      Else
        gMapPretty = "Pause   : yes"
        
      End If
      
      
    End If
    
    setup_bounds( 70, 76, gMapPretty )
    click_bounds( get_block_pause_input() )
    gMapPretty = ""

  End Scope
  
  Scope

    Dim As String gMapPretty
    gMapPretty = "->"
    setup_bounds( 66, 93, gMapPretty )
    
    tp_lf.x -= 16
    
    click_bounds( change_block_box )
    gMapPretty = ""

  End Scope
  

End Sub               


Sub command_block_box2()


    If total_control_elements( gmg( _state ) ) = 0 Then Exit Sub
    
    Dim As String gMapCS
    gMapCS = "Sequence #" & selected_control_element( s_sequence ) & space( 3 - Len( Str( selected_control_element( s_sequence ) ) ) ) 

    Locate 58, 63
    ? gMapCS;

    Select Case active_sequence()
    
          
    
      Case seq_enemy
        ? "Enemy [" & gmg( enem ).sel & "]"
    
      Case seq_entry
        ? "Entry [" & gmg( entr ).sel & "]"
          
      Case seq_room
        ? "Room [" & llg( this_room ).i & "]"
          
    End Select
    

    Locate 59, 62
    ? Chr( 195 ) & String( Len( gMapCS ) - 3 + Len( Str( selected_control_element( s_sequence ) ) ), 196 ) & Chr( 217 )

    Locate 61, 63
    ? " Command[" & gmg( ent_commands ).sel & "], ";
    ? "Block[" & gmg( blocks ).sel & "]: "


  Scope

    Dim As String gMapPretty
    If selected_command_block().active_ent <> ent_textbox Then
      gMapPretty = Chr( 195 ) & " abs x : " & selected_command_block().abs_x
      
    End If
    setup_bounds( 63, 62, gMapPretty )
    click_bounds( get_block_absx_input() )
    gMapPretty = ""

  End Scope

  Scope

    Dim As String gMapPretty
    If selected_command_block().active_ent <> ent_textbox Then
      gMapPretty = "abs y : " & selected_command_block().abs_y
      
    End If
    setup_bounds( 63, 76, gMapPretty )
    tp_lf.x -= 16
    click_bounds( get_block_absy_input() )
    gMapPretty = ""

  End Scope


  Scope

    Dim As String gMapPretty
    
    If selected_command_block().active_ent = ent_textbox Then
      gMapPretty = Chr( 195 ) & " txtclr  : " & selected_command_block().dest_x
      
    Else
      gMapPretty = Chr( 195 ) & " dest x  : " & selected_command_block().dest_x
      
    End If


    setup_bounds( 65, 62, gMapPretty )
    click_bounds( get_block_destx_input() )
    gMapPretty = ""

  End Scope

  Scope

    Dim As String gMapPretty
    If selected_command_block().active_ent = ent_textbox Then
      gMapPretty = Chr( 195 ) & " boxinvis: " & selected_command_block().dest_y
      
    Else
      gMapPretty = Chr( 195 ) & " dest y  : " & selected_command_block().dest_y
      
    End If


    setup_bounds( 66, 62, gMapPretty )
    click_bounds( get_block_desty_input() )
    gMapPretty = ""

  End Scope

  Scope

    Dim As String gMapPretty
    If selected_command_block().active_ent = ent_textbox Then
'      gMapPretty = Chr( 195 ) & " boxinvis: " & selected_command_block().dest_y
      
    Else
      gMapPretty = "Fade: " & selected_command_block().fadeTime
      
    End If


    setup_bounds( 66, 80, gMapPretty )
    click_bounds( get_block_fade_input() )
    gMapPretty = ""

  End Scope


  Scope

    Dim As String gMapPretty
    If selected_command_block().active_ent = ent_textbox Then
      gMapPretty = Chr( 195 ) & " box x   : " & selected_command_block().mod_x
      
'    Else
'      gMapPretty = Chr( 195 ) & " mod x : " & selected_command_block().mod_x
    
    End If
    
    setup_bounds( 68, 62, gMapPretty )
    click_bounds( get_block_boxx_input() )
    gMapPretty = ""

  End Scope

  Scope

    Dim As String gMapPretty
    If selected_command_block().active_ent = ent_textbox Then
      gMapPretty = "box y : " & selected_command_block().mod_y
      
    End If
    
    setup_bounds( 68, 79, gMapPretty )
    tp_lf.x -= 16
    click_bounds( get_block_boxy_input() )
    gMapPretty = ""

  End Scope


  Scope

    Dim As String gMapPretty

    If selected_command_block().active_ent = ent_textbox Then
      gMapPretty = Chr( 195 ) & " Auto Box  : " & selected_command_block().walk_speed
      
    Else
    
      gMapPretty = Chr( 195 ) & " Walk Speed: " & selected_command_block().walk_speed
      
    End If
    setup_bounds( 70, 62, gMapPretty )
    click_bounds( get_block_walkspeed_input() )
    gMapPretty = ""

  End Scope


  Scope

    Dim As String gMapPretty

    If selected_command_block().active_ent = ent_textbox Then
      gMapPretty = "Speed: " & selected_command_block().text_speed
      
    Else
    
      gMapPretty = "Align: " & selected_command_block().water_align
      
    End If
    setup_bounds( 70, 84, gMapPretty )

    tp_lf.x -= 16

    click_bounds( get_block_align_input() )
    gMapPretty = ""

  End Scope






  Scope

    Dim As String gMapPretty
    gMapPretty = "<-"
    setup_bounds( 66, 93, gMapPretty )
    
    tp_lf.x -= 16
    
    click_bounds( change_block_box )
    gMapPretty = ""

  End Scope
  

End Sub               


Sub change_block_box()
  
  
  Dim As Integer holdittogether
  
  hold_button( sc_leftbutton ) 
'  ? gmg( block_state )
'  ? gmg( block_boxes )[gmg( block_state )]
  gmg( block_state ) Xor = 1
'  ? gmg( block_state )
'  ? gmg( block_boxes )[gmg( block_state )]
'  reveal()
'  Sleep
  

End Sub



Sub sequence_box()

  dim as integer res
  gMap_SeqNum( res )
  
  if res = 0 then exit sub

    Locate 61, 62
  
    Select Case active_sequence()
    
          
    
      Case seq_enemy
        ? Chr( 195 ) & " Enemy [" & gmg( enem ).sel & "]"
    
      Case seq_entry
        ? Chr( 195 ) & " Entry [" & gmg( entr ).sel & "]"
          
      Case seq_room
        ? Chr( 195 ) & " Room [" & llg( this_room ).i & "]"
          
    End Select


    If total_control_elements( gmg( _state ) ) = 0 Then Exit Sub
    
    Dim As String gMapCS
    
    gMapCS = "Sequence #" & selected_control_element( s_sequence ) & space( 3 - Len( Str( selected_control_element( s_sequence ) ) ) ) 

    Locate 58, 63
    ? gMapCS

    Locate 59, 62
    ? Chr( 195 ) & String( Len( gMapCS ) - 3 + Len( Str( selected_control_element( s_sequence ) ) ), 196 ) & Chr( 217 )



    

'
    
    
    If active_sequence_address = 0 Then
      Cls
      
      ? gmg( _state )
      
      ? "There was an error :( fatal."
      reveal()
      Sleep
      End
'      engine_end()
      
    End If
    Locate 64, 63
    ? " Entities: " & selected_sequence().ents
    
    Locate 66, 63
    ? " Commands: " & selected_sequence().commands
    
'

End Sub               


Sub get_default_name_input()

  Do
    Sleep 1
  
  Loop While MultiKey(sc_enter)

  Scope
    
    Dim As String empty_key

    Do
      empty_key = Inkey
      
    Loop Until ( Len( empty_key ) = 0 ) And ( Not MultiKey( sc_enter ) )
    
  End Scope

  Dim ene_ver As Integer

  Do
  
    Locate 69, 79
    ? space( 12 )

    ScreenSet 0, 0  
    Locate 69, 79, 1
    
    Dim As String tmp_id

    tmp_id = ""
    Input "", tmp_id

    tmp_id = "data\object\" & tmp_id &  ".xml" '' "

    ene_ver = -1
    ene_ver And= tmp_id <> "data\object\.xml"
    ene_ver And= ( Dir( tmp_id ) <> "" )
    
    If ene_ver = 0 Then

      If tmp_id = "data\object\.xml" Then
        ene_ver = -1

      End If

    Else
    
      gmg( def_id ) = kfp( kfe( tmp_id ) )
        
    End If

    
  Loop Until ene_ver <> 0

  ScreenSet 0, 1  


  Do
    Sleep 1
  
  Loop While MultiKey(sc_enter)

  Scope
    
    Dim As String empty_key

    Do
      empty_key = Inkey
      
    Loop Until ( Len( empty_key ) = 0 ) And ( Not MultiKey( sc_enter ) )
    
  End Scope




End Sub

Sub get_room_changes_to()


  Dim As Integer ene_ver
  
  Dim As String tmp_id

  Do
  
    Locate 64, 76
    ? space( 8 )

    ScreenSet 0, 0  
    Locate 64, 76, 1
    

    tmp_id = ""
    Input "", tmp_id
    
    
    ene_ver = -1
    
    If Val( tmp_id ) < 0 Then ene_ver = 0
    
  Loop Until ene_ver <> 0

  now_room().changes_to = Val( tmp_id )

  
  ScreenSet 0, 1  

  Do
    Sleep 1
  
  Loop While MultiKey( sc_enter )

  Scope
    
    Dim As String empty_key

    Do
      empty_key = Inkey
      
    Loop Until ( Len( empty_key ) = 0 ) And ( Not MultiKey( sc_enter ) )
    
  End Scope


End Sub


Sub get_room_song_changes()


  Dim As Integer ene_ver

  Dim As String tmp_id
  
  Do
  
    Locate 62, 78
    ? space( 8 )

    ScreenSet 0, 0  
    Locate 62, 78, 1
    
    tmp_id = ""
    Input "", tmp_id
    
    
    ene_ver = -1
    
    If Val( tmp_id ) < 0 Then ene_ver = 0
    
  Loop Until ene_ver <> 0

  now_room().song_changes = Val( tmp_id )

  
  ScreenSet 0, 1  

  Do
    Sleep 1
  
  Loop While MultiKey( sc_enter )

  Scope
    
    Dim As String empty_key

    Do
      empty_key = Inkey
      
    Loop Until ( Len( empty_key ) = 0 ) And ( Not MultiKey( sc_enter ) )
    
  End Scope


End Sub



Sub get_room_dark_input()


  Dim As Integer ene_ver
  
  Dim As String tmp_id

  Do
  
    Locate 60, 74
    ? space( 8 )

    ScreenSet 0, 0  
    Locate 60, 74, 1
    
    tmp_id = ""
    Input "", tmp_id
    
    
    ene_ver = -1
    
    If Val( tmp_id ) < 0 Then ene_ver = 0
    If Val( tmp_id ) > 4 Then ene_ver = 0

    
    
  Loop Until ene_ver <> 0

  now_room().dark = Val( tmp_id )

  
  ScreenSet 0, 1  

  Do
    Sleep 1
  
  Loop While MultiKey( sc_enter )

  Scope
    
    Dim As String empty_key

    Do
      empty_key = Inkey
      
    Loop Until ( Len( empty_key ) = 0 ) And ( Not MultiKey( sc_enter ) )
    
  End Scope


End Sub


Sub get_block_text_input()


  Dim As Integer ene_ver
  Dim As String tmp_id

  
  Do
  
    Locate 60, 74
    ? space( 8 )

    ScreenSet 0, 0  
    Locate 60, 74, 1
    
    tmp_id = ""
    Line Input "", tmp_id
    
    
    ene_ver = -1
    
    If tmp_id = "" Then Goto hah

    
    
  Loop Until ene_ver <> 0

  selected_command_block().text = tmp_id
  
  hah:

  
  ScreenSet 0, 1  

  Do
    Sleep 1
  
  Loop While MultiKey( sc_enter )

  Scope
    
    Dim As String empty_key

    Do
      empty_key = Inkey
      
    Loop Until ( Len( empty_key ) = 0 ) And ( Not MultiKey( sc_enter ) )
    
  End Scope


End Sub



Sub get_room_song_input()


  Dim As Integer ene_ver
  Dim As String tmp_id

  Do
  
    Locate 58, 70
    ? space( 8 )

    ScreenSet 0, 0  
    Locate 58, 70, 1
    
    tmp_id = ""
    Input "", tmp_id
    
    
    ene_ver = -1
    
    If Val( tmp_id ) < 0 Then ene_ver = 0

    
    
  Loop Until ene_ver <> 0

  now_room().song = Val( tmp_id )

  
  ScreenSet 0, 1  

  Do
    Sleep 1
  
  Loop While MultiKey( sc_enter )

  Scope
    
    Dim As String empty_key

    Do
      empty_key = Inkey
      
    Loop Until ( Len( empty_key ) = 0 ) And ( Not MultiKey( sc_enter ) )
    
  End Scope


End Sub



Sub regular_box()

  Scope
    
    Dim As String df

    df = Chr( 195 ) & " Song: "
    df += Str( now_room().song )
    

  
    
    setup_bounds( 58, 62, df )
                   
    click_bounds( get_room_song_input() )
    
  End Scope
  

  Scope
    
    Dim As String df

    df = Chr( 195 ) & " Darkness: "
    df += Str( now_room().dark )
    

  
    
    setup_bounds( 60, 62, df )
                   
    click_bounds( get_room_dark_input() )
    
  End Scope


  Scope
    
    Dim As String df

    df = Chr( 195 ) & " Changes song: "
    df += Str( now_room().song_changes )
    

  
    
    setup_bounds( 62, 62, df )
                   
    click_bounds( get_room_song_changes() )
    
  End Scope


  Scope
    
    Dim As String df

    df = Chr( 195 ) & " Changes to: "
    df += Str( now_room().changes_to )
    

  
    
    setup_bounds( 64, 62, df )
                   
    click_bounds( get_room_changes_to() )
    
  End Scope


  If now_room().parallax <> 0 Then
    Locate 62, 62
    ? Chr( 195 ) & " Parallax image: " & Right( now_room().para_img->filename, Len( now_room().para_img->filename ) -  14 )
    
  End If


End Sub



Sub entry_box()
  
  
  If llg( map )->entries > 0 Then
    Dim As String gMapCEn
    gMapCEn = "Entry #" & gmg( entr.sel ) & space( 3 - Len( Str( gmg( entr.sel ) ) ) ) 
  
    Locate 58, 63
    ? gMapCEn
  
    Locate 59, 62
    ? Chr( 195 ) & String( Len( gMapCEn ) - 3 + Len( Str( gmg( entr.sel ) ) ), 196 ) & Chr( 217 )
  
  
    Locate 58, 75
    ? "x: " & llg( map )->entry[gmg( entr.sel )].x
    
    Locate 58, 85
    ? "y: " & llg( map )->entry[gmg( entr.sel )].y 
    
    
  
  
    Scope
      
      Dim As String df
  
      df = " To Room: "
      df += Str( llg( map )->entry[gmg( entr.sel )].room )
      
      
      setup_bounds( 61, 62, Chr( 195 ) & df )
                     
      click_bounds( get_entry_room_input() )
      If MultiKey ( sc_enter ) And ( gmg( hotkey ) <> 0 ) Then 
        get_entry_room_input()
        
      End If
  
      
    End Scope
    
  
    Scope
      
      Dim As String df
  
      df = " Character will face: "
      Select Case llg( map )->entry[gmg( entr.sel )].direction
        Case 0
          df +=  "up"
      
        Case 1
          df +=  "right"
      
        Case 2
          df +=  "down"
      
        Case 3
          df +=  "left"
          
        Case 4
          df +=  "upleft"
      
        Case 5
          df +=  "upright"
      
        Case 6
          df +=  "downright"
      
        Case 7
          df +=  "downleft"
          
      End Select
  
      setup_bounds( 63, 62, Chr( 195 ) & df )
                     
      click_bounds( get_entry_dir_input )
  
      
    End Scope
  

  End If

End Sub



Sub get_entry_room_input()
  
  Do
    Sleep 1
  
  Loop While MultiKey(sc_enter)

  Scope
    
    Dim As String empty_key

    Do
      empty_key = Inkey
      
    Loop Until ( Len( empty_key ) = 0 ) And ( Not MultiKey( sc_enter ) )
    
  End Scope

  Dim ene_ver As Integer
    Dim As String tmp_id


  Do
  
    Locate 61, 73
    ? space( 8 )

    ScreenSet 0, 0  
    Locate 61, 73, 1
    
    tmp_id = ""
    Input "", tmp_id
'    tmp_id = Input$( 3 )
    
    
    ene_ver = -1
    
    If Val( tmp_id ) < 0 Then ene_ver = 0
    If Val( tmp_id ) > llg( map )->rooms - 1 Then ene_ver = 0

    
    
  Loop Until ene_ver <> 0
  llg( map )->entry[gmg( entr.sel )].room = Val( tmp_id )

  ScreenSet 0, 1  


  Do
    Sleep 1
  
  Loop While MultiKey(sc_enter)

  Scope
    
    Dim As String empty_key

    Do
      empty_key = Inkey
      
    Loop Until ( Len( empty_key ) = 0 ) And ( Not MultiKey( sc_enter ) )
    
  End Scope





  If llg( map )->entry[gmg( entr.sel )].room <> llg( this_room.i ) Then 
    '' room changed
    
    llg( map )->entry[gmg( entr.sel )].x = 0
    llg( map )->entry[gmg( entr.sel )].y = 0
    

    llg( this_room.i ) = llg( map )->entry[gmg( entr.sel )].room              

    new_room_init()

    
  End If


End Sub


Sub get_entry_dir_input()

  Do
    Sleep 1
  
  Loop While MultiKey(sc_enter)

  Scope
    
    Dim As String empty_key

    Do
      empty_key = Inkey
      
    Loop Until ( Len( empty_key ) = 0 ) And ( Not MultiKey( sc_enter ) )
    
  End Scope

  Dim ene_ver As Integer
    Dim As String tmp_id

  Do
  
    Locate 63, 85
    ? space( 5 )

    ScreenSet 0, 0  
    Locate 63, 85, 1
    

    tmp_id = ""
    Input "", tmp_id
    
    
    ene_ver = -1

    Select Case LCase( tmp_id )
    
      Case "u", "up", "0"
        llg( map )->entry[gmg( entr.sel )].direction = 0
        
      Case "d", "down", "2"
        llg( map )->entry[gmg( entr.sel )].direction = 2
        
      Case "r", "right", "1"
        llg( map )->entry[gmg( entr.sel )].direction = 1
        
      Case "l", "left", "3"
        llg( map )->entry[gmg( entr.sel )].direction = 3
      
      Case "ul", "upleft", "4"
        llg( map )->entry[gmg( entr.sel )].direction = 4
        
      Case "ur", "upright", "5"
        llg( map )->entry[gmg( entr.sel )].direction = 5
        
      Case "dr", "downright", "6"
        llg( map )->entry[gmg( entr.sel )].direction = 6
        
      Case "dl", "downleft", "7"
        llg( map )->entry[gmg( entr.sel )].direction = 7
      
      Case ""
        Exit Do
        
      Case Else
        ene_ver = 0
        
    End Select
    
    
  Loop Until ene_ver <> 0

  ScreenSet 0, 1  


  Do
    Sleep 1
  
  Loop While MultiKey(sc_enter)

  Scope
    
    Dim As String empty_key

    Do
      empty_key = Inkey
      
    Loop Until ( Len( empty_key ) = 0 ) And ( Not MultiKey( sc_enter ) )
    
  End Scope




End Sub





Sub macro_box()
  
  If gmg( macros ) = 0 Then Exit Sub
  
  Scope

    '' can't touch this...    
    setup_bounds( 58, 85, "Clear Macro" )

    Dim As Integer i                   
'    click_bounds( For i = 0 To 35                     :_
'                    macros( gmg( macr.sel ), i ) = 0  :_
'                                                      :_
'                  Next )

    click_bounds( For i = 0 To 35                         :_
                    gmg( macro )[gmg( macr.sel )][i] = 0  :_
                                                          :_
                  Next )

    
  End Scope
  


  Scope
    
    setup_bounds( 69, 72, "Wall Macro" )

    click_bounds( macro_wall() ) 


                  

    
  End Scope

End Sub



Sub enemy_spawn_box()

  If now_room().enemies = 0 Then Exit Sub


  Dim As String gMapCE
  gMapCE = "Enemy #" & gmg( enem.sel ) & space( 3 - Len( Str( gmg( enem.sel ) ) ) ) 

  Locate 58, 63
  ? gMapCE

  Locate 59, 62
  ? Chr( 195 ) & String( Len( gMapCE ) - 3 + Len( Str( gmg( enem.sel ) ) ), 196 ) & Chr( 217 )
  


  Scope
  
    setup_bounds( 70, 92, "<-" )
                
    tp_lf.x -= 16
    click_bounds( gmg( enemy_box_state ) = 0 )
    
  End Scope
    
    
  
  Scope
  
    Dim As Integer mem = now_room().enemy[gmg( enem.sel )].spawn_cond, i, j
    
    Dim As String cond
    
    If mem <> 0 Then 
      cond = "yes"
      
    Else
      cond = "no"
      
    End If
     

    setup_bounds( 58, _
                  74, _ 
                  "Conditional: " & cond _
                )
    tp_lf.x -= 16                
                
    click_bounds( toggle_enemy_spawn_cond() )
    
    

    
    With now_room().enemy[gmg( enem.sel )]
    
      If mem <> .spawn_cond Then
    
        If mem = 0 Then
          '' now on
          
          .spawn_info = CAllocate( Len( LLObject_ConditionalSpawn ) )
          
        Else
          '' now off
          clean_Deallocate( .spawn_info->wait_spawn )
          clean_Deallocate( .spawn_info->kill_spawn )
          clean_Deallocate( .spawn_info->active_spawn )

          clean_Deallocate( .spawn_info )
          
          
        End If
        
      End If
      

      If .spawn_cond <> 0 Then
  
        Scope    
          
          Dim As Integer wait_mem = .spawn_info->wait_n
          
          setup_bounds( 61, 62, _ 
                        Chr( 195 ) & _ 
                        " # of waits: " & .spawn_info->wait_n _
                      )
                      
                      
          click_bounds( get_entity_spawn_wait() ) '' modify .spawn_info->wait_n
          If wait_mem <> .spawn_info->wait_n Then
            .spawn_info->wait_spawn = Reallocate( .spawn_info->wait_spawn, .spawn_info->wait_n * Len( LLObject_SpawnSwitch ) )
            
            If .spawn_info->wait_n > wait_mem Then
              '' more now, clear new ones
              
              MemSet( Varptr( .spawn_info->wait_spawn[wait_mem] ), 0, ( .spawn_info->wait_n - wait_mem ) * Len( LLObject_SpawnSwitch ) )
            Else
              gmg( spawn_wait ).sel = 0  
              
            End If
            
          End If
          
          
        End Scope
      
        Scope    
          
          Dim As Integer kill_mem = .spawn_info->kill_n
          
          setup_bounds( 61, 81, _ 
                        "# of kills: " & .spawn_info->kill_n _
                      )
                      
          
          tp_lf.x -= 16            
          click_bounds( get_entity_spawn_kill() ) '' modify .spawn_info->wait_n
          If kill_mem <> .spawn_info->kill_n Then
            .spawn_info->kill_spawn = Reallocate( .spawn_info->kill_spawn, .spawn_info->kill_n * Len( LLObject_SpawnSwitch ) )
            
            If .spawn_info->kill_n > kill_mem Then
              '' more now, clear new ones
              
              MemSet( Varptr( .spawn_info->kill_spawn[kill_mem] ), 0, ( .spawn_info->kill_n - kill_mem ) * Len( LLObject_SpawnSwitch ) )
            
            Else
              gmg( spawn_kill ).sel = 0  
            End If
            
          End If
          
          
        End Scope

        
        Scope    
          
          Dim As Integer active_mem = .spawn_info->active_n
          
          setup_bounds( 68, 62, _ 
                        Chr( 195 ) & _ 
                        " # of actives: " & .spawn_info->active_n _
                      )
                      
                      
          click_bounds( get_entity_spawn_active() ) '' modify .spawn_info->wait_n
          If active_mem <> .spawn_info->active_n Then
            .spawn_info->active_spawn = Reallocate( .spawn_info->active_spawn, .spawn_info->active_n * Len( LLObject_SpawnSwitch ) )
            
            If .spawn_info->active_n > active_mem Then
              '' more now, clear new ones
              
              MemSet( Varptr( .spawn_info->active_spawn[active_mem] ), 0, ( .spawn_info->active_n - active_mem ) * Len( LLObject_SpawnSwitch ) )
            Else
              gmg( spawn_active ).sel = 0  
              
            End If
            
          End If
          
          
        End Scope
        
        If .spawn_info->wait_n <> 0 Then


          Scope    
            
            setup_bounds( 63, 64, _ 
                          "<" _
                        )
                        
            tp_lf.x -= 16            
            click_bounds( enemy_wait_down() )
            
            
          End Scope

            Locate 63, 66
            ? "Wait(" & gmg( spawn_wait ).sel & ")"

          Scope    
            
            setup_bounds( 63, 74, _ 
                          ">" _
                        )
                        
            tp_lf.x -= 16            
                        
            click_bounds( enemy_wait_up() )
            
            
          End Scope





        
          Scope    
            
            setup_bounds( 65, 62, _ 
                          Chr( 195 ) & _ 
                          " index: " & .spawn_info->wait_spawn[gmg( spawn_wait ).sel].code_index _
                        )
                        
                        
            click_bounds( get_entity_wait_code_index() )
            
            
          End Scope
          Scope    
            
            setup_bounds( 66, 62, _ 
                          Chr( 195 ) & _ 
                          " state: " & .spawn_info->wait_spawn[gmg( spawn_wait ).sel].code_state _
                        )
                        
                        
            click_bounds( toggle_entity_wait_code_state() )
            
            
          End Scope
        
        
        End If       
        
        
        If .spawn_info->kill_n <> 0 Then


          Scope    
            
            setup_bounds( 63, 81, _ 
                          "<" _
                        )
                        
            tp_lf.x -= 16            
            click_bounds( enemy_kill_down() )
            
            
          End Scope

            Locate 63, 83
            ? "Kill(" & gmg( spawn_kill ).sel & ")"

          Scope    
            
            setup_bounds( 63, 91, _ 
                          ">" _
                        )
                        
            tp_lf.x -= 16            
                        
            click_bounds( enemy_kill_up() )
            
            
          End Scope



          Scope    
            
            setup_bounds( 65, 81, _ 
                          "index: " & .spawn_info->kill_spawn[gmg( spawn_kill ).sel].code_index _
                        )
                        
            
            tp_lf.x -= 16            
            click_bounds( get_entity_kill_code_index() )
            
            
          End Scope
          Scope    
            
            setup_bounds( 66, 81, _ 
                          "state: " & .spawn_info->kill_spawn[gmg( spawn_kill ).sel].code_state _
                        )
                        
                        
            tp_lf.x -= 16            
            click_bounds( toggle_entity_kill_code_state() )
            
            
          End Scope
        
        End If       
        
        
        If .spawn_info->active_n <> 0 Then
        
          Scope    
            
            setup_bounds( 68, 81, _ 
                          "<" _
                        )
                        
            tp_lf.x -= 16            
            click_bounds( enemy_active_down() )
            
            
          End Scope

            Locate 68, 83
            ? "Active(" & gmg( spawn_active ).sel & ")"

          Scope    
            
            setup_bounds( 68, 93, _ 
                          ">" _
                        )
                        
            tp_lf.x -= 16            
                        
            click_bounds( enemy_active_up() )
            
            
          End Scope


          Scope    
            
            setup_bounds( 70, 64, _ 
                          "index: " & .spawn_info->active_spawn[gmg( spawn_active ).sel].code_index _
                        )
                        
            
            tp_lf.x -= 16            
            click_bounds( get_entity_active_code_index() )
            
            
          End Scope
          Scope    
            
            setup_bounds( 70, 76, _ 
                          "state: " & .spawn_info->active_spawn[gmg( spawn_active ).sel].code_state _
                        )
                        
                        
            tp_lf.x -= 16            
            click_bounds( toggle_entity_active_code_state() )
            
            
          End Scope


        End If
        
        
        
        
        
      
      End If
    
    End With
    
    
    
    
    
    
    
    
  End Scope
  


End Sub



Sub enemy_box()

  If now_room().enemies = 0 Then Exit Sub


  Dim As String gMapCE
  gMapCE = "Enemy #" & gmg( enem.sel ) & space( 3 - Len( Str( gmg( enem.sel ) ) ) ) 

  Locate 58, 63
  ? gMapCE

  Locate 59, 62
  ? Chr( 195 ) & String( Len( gMapCE ) - 3 + Len( Str( gmg( enem.sel ) ) ), 196 ) & Chr( 217 )
  

  
  Scope

    setup_bounds( 61, _
                  62, _ 
                  Chr( 195 ) & _ 
                  " Name: " & _ 
                            kfp( _ 
                            kfe(  _
                                           now_room().enemy[gmg( enem.sel )].id _ 
                                       ) _ 
                                        ) _ 
                )
                
                
    If MultiKey( sc_enter ) And ( gmg( hotkey ) <> 0 ) Then
      get_enemy_name_input
      
    End If
                
    click_bounds( get_enemy_name_input )

    
  End Scope


  Locate 58, 75
  ? "x: " & now_room().enemy[gmg( enem.sel )].coords.x
  
  Locate 58, 85
  ? "y: " & now_room().enemy[gmg( enem.sel )].coords.y 


  Scope
    
    Dim As Integer y = 63, x = 62
    Dim As String di
    
    
    If now_room().enemy[gmg( enem.sel )].uni_directional <> 0 Then

      di = "n/a"
                    
    Else
    
      Select Case now_room().enemy[gmg( enem.sel )].direction
      
        Case 0 
          di = "up"
      
        Case 1
          di =  "right" 

        Case 2
          di =  "down" 

        Case 3
          di =  "left" 
                      
        Case Else
          di = Str( now_room().enemy[gmg( enem.sel )].direction ) 
                      
      End Select

    End If
    setup_bounds( y, x, Chr( 195 ) & " Direction: " & di )
                   
    If now_room().enemy[gmg( enem.sel )].uni_directional = 0 Then
      click_bounds( get_enemy_dir_input )
      
    End If
    
  End Scope

'  Scope
'    
'    Dim As String tp
'    If now_room().enemy[gmg( enem.sel )].spawn_h = 0 Then
'      tp = " Spawn: always"  
'      
'    Else
'
'      tp = " Spawn: " & now_room().enemy[gmg( enem.sel )].spawn_h 
'      
'    End If
'    
'    setup_bounds( 65, 62, Chr( 195 ) & tp )
'    click_bounds( get_enemy_spawn_input )
'
'    If now_room().enemy[gmg( enem.sel )].spawn_h <> 0 Then 
'
'      Dim As String tm
'      tm = "If code is: " 
'
'      If now_room().enemy[gmg( enem.sel )].is_h_set = 0 Then
'        tm += "off"
'      Else
'        tm += "on"
'        
'      End If
'
'      Scope
'        setup_bounds( 65, 80, tm )
'        tp_lf.x -= 16
'        click_bounds( _
'                      Do While gmg( mouse.b ) And sc_leftbutton                                          :_ 
'                      GetMouse(fb_Global.mouse.x, fb_Global.mouse.y, fb_Global.mouse.w, fb_Global.mouse.b):_
'                      Loop                                                                            :_
'                      If now_room().enemy[gmg( enem.sel )].is_h_set = 0 Then         :_
'                        now_room().enemy[gmg( enem.sel )].is_h_set = 1               :_
'                      Else                                                                            :_
'                        now_room().enemy[gmg( enem.sel )].is_h_set = 0               :_
'                      End If                                                                           _
'                    )
'      End Scope
'      
'    Else 
'
'      
'    End If
'    
'  End Scope

  Scope
    
    Dim As String tp
    
    setup_bounds( 65, 62, Chr( 195 ) & " Spawn..." )
    click_bounds( toggle_spawn_box() )

    
  End Scope

  Scope
    
    Dim As String df

    df = " Extra Info: "
    If now_room().enemy[gmg( enem.sel )].chap = 0 Then
      df +=  "none"
    Else
      df += Str( now_room().enemy[gmg( enem.sel )].chap )
      
    End If 
    
    
    setup_bounds( 67, 62, Chr( 195 ) & df )
                   
    click_bounds( get_enemy_flux_input )

    
  End Scope
  

  Scope

    Dim As Integer y = 69, x = 62
    Dim As String di

    setup_bounds( y, _
                  x, _ 
                  Chr( 195 ) & _ 
                  " Default Enemy: " & _ 
                  kfp( _ 
                  kfe(  _
                                gmg( def_id ) _ 
                             ) _ 
                              ) _ 
                )
                
                
    click_bounds( get_default_name_input() )

    
  End Scope


End Sub



Sub get_enemy_dir_input()

  Do
    Sleep 1
  
  Loop While MultiKey(sc_enter)

  Scope
    
    Dim As String empty_key

    Do
      empty_key = Inkey
      
    Loop Until ( Len( empty_key ) = 0 ) And ( Not MultiKey( sc_enter ) )
    
  End Scope

  Dim ene_ver As Integer
    Dim As String tmp_id


  Do
  
    Locate 63, 75
    ? space( 5 )

    ScreenSet 0, 0  
    Locate 63, 75, 1
    
    Dim As Integer reser
      reser = now_room().enemy[gmg( enem.sel )].direction
  
    tmp_id = ""
    Input "", tmp_id
    
    
    ene_ver = -1

    Select Case LCase( tmp_id )
    
      Case "u", "up", "0"
        now_room().enemy[gmg( enem.sel )].direction = 0
        
      Case "d", "down", "2"
        now_room().enemy[gmg( enem.sel )].direction = 2
        
      Case "r", "right", "1"
        now_room().enemy[gmg( enem.sel )].direction = 1
        
      Case "l", "left", "3"
        now_room().enemy[gmg( enem.sel )].direction = 3
      
      Case ""
        Exit Do
        
      Case Else
        ene_ver = 0
        
    End Select
    
    
  Loop Until ene_ver <> 0


  now_room().enemy[gmg( enem.sel )].ori_dir = now_room().enemy[gmg( enem.sel )].direction
  ScreenSet 0, 1  


  Do
    Sleep 1
  
  Loop While MultiKey(sc_enter)

  Scope
    
    Dim As String empty_key

    Do
      empty_key = Inkey
      
    Loop Until ( Len( empty_key ) = 0 ) And ( Not MultiKey( sc_enter ) )
    
  End Scope




End Sub


Sub get_enemy_name_input()

  Do
    Sleep 1
  
  Loop While MultiKey(sc_enter)

  Scope
    
    Dim As String empty_key

    Do
      empty_key = Inkey
      
    Loop Until ( Len( empty_key ) = 0 ) And ( Not MultiKey( sc_enter ) )
    
  End Scope

  Dim ene_ver As Integer
    Dim As String tmp_id


  Do
  
    Locate 61, 70
    ? space( 12 )

    ScreenSet 0, 0  
    Locate 61, 70, 1
    
    Dim As String reser
      reser = now_room().enemy[gmg( enem.sel )].id
  
    tmp_id = ""
    Input "", tmp_id

    tmp_id = "data\object\" & tmp_id &  ".xml"

    ene_ver = -1
    ene_ver And= tmp_id <> "data\object\.xml"
    ene_ver And= ( Dir( tmp_id ) <> "" )
    
    If ene_ver = 0 Then
'      Scope
'        Dim As String chk
'        Dim As String  Ptr chk2
'        Dim As Integer c, check_hehe
'        c = 0
'        
'        chk = Dir( tmp_id )
'        
        If tmp_id = "data\object\.xml" Then
'        
          ene_ver = -1
'          
'        
'        Else
'        
'          chk2 = CAllocate( Len( String ) )
'          chk2[c] = Dir( "data\object\*.xml" )
'          
'          If chk2[c] <> "" Then 
'            c += 1
'            
'
'            Do While chk2[c - 1] <> ""
'              chk2 = Reallocate( chk2, ( c + 1 ) * Len( String ) )                ''
'              chk2[c] = Dir( "" )                                                 ''
'              c += 1                                                              ''
'                                                                                  ''
'            Loop                                                                  ''   you have to make something here...!
'                                                                                  ''
'            Reallocate( chk2, ( c ) * Len( String ) )                             ''
'            c -= 1                                                                ''
'                                                                                  ''
'          Else                                                                    ''''''''''''''''''''''''''''''''''''
'            
'            
'            
'
'          End If
'          
'          
'          Dim As Integer least_one, num
'          
'          For check_hehe = 0 To c - 1
'            If Instr( chk2[check_hehe], killfileext( killfilepath( tmp_id ) ) ) <> 0 Then
'            
'          
'              num = MessageBox( GetForegroundWindow, "Did you mean """ & killfileext( chk2[check_hehe] ) & """?", "Question", MB_YESNO )
'              If num = IDYES Then
'              
'                
'                chk2[check_hehe] = "data\object\" & chk2[check_hehe]
'                now_room().enemy[gmg( enem.sel )].id = chk2[check_hehe]
'                least_one = -1
'                ene_ver = -1
'                Exit For
'                
'              End If
'              
'              
'
'
'
'            End If
'
'
'
'          Next
'
'          If least_one = 0 Then
'          
'            MessageBox( GetForegroundWindow, "XML file does not exist.", "File Not Found", MB_OK )
'            
'          End If
'
'
'
'
'            
'          For check_hehe = 0 To c - 1
'            chk2[check_hehe] = ""
'
'          Next
'          
'          Deallocate( chk2 )
'          
'        
'          
        End If
'        
'      End Scope
'
    Else
'    
      now_room().enemy[gmg( enem.sel )].id = tmp_id
'        
    End If

    
  Loop Until ene_ver <> 0

  ScreenSet 0, 1  
  
  LLSystem_ObjectRelease( now_room().enemy[gmg( enem.sel )] )
  LLSystem_CopyNewObject( now_room().enemy[gmg( enem.sel )] )


  Do
    Sleep 1
  
  Loop While MultiKey(sc_enter)

  Scope
    
    Dim As String empty_key

    Do
      empty_key = Inkey
      
    Loop Until ( Len( empty_key ) = 0 ) And ( Not MultiKey( sc_enter ) )
    
  End Scope




End Sub



Sub get_enemy_spawn_input()

  Do
    Sleep 1
  
  Loop While MultiKey(sc_enter)

  Scope
    
    Dim As String empty_key

    Do
      empty_key = Inkey
      
    Loop Until ( Len( empty_key ) = 0 ) And ( Not MultiKey( sc_enter ) )
    
  End Scope

  Dim ene_ver As Integer
    Dim As uShort tmp_id

  Do
  
    Locate 65, 71
    ? space( 10 )

    ScreenSet 0, 0  
    Locate 65, 71, 1
    

    tmp_id = 0
    Input "", tmp_id
    
    
    ene_ver = -1
    
    If tmp_id < 0 Then ene_ver = 0

    
    
  Loop Until ene_ver <> 0
  now_room().enemy[gmg( enem.sel )].spawn_h = tmp_id

  ScreenSet 0, 1  


  Do
    Sleep 1
  
  Loop While MultiKey(sc_enter)

  Scope
    
    Dim As String empty_key

    Do
      empty_key = Inkey
      
    Loop Until ( Len( empty_key ) = 0 ) And ( Not MultiKey( sc_enter ) )
    
  End Scope




End Sub


Sub get_enemy_flux_input()
  
  Do
    Sleep 1
  
  Loop While MultiKey(sc_enter)

  Scope
    
    Dim As String empty_key

    Do
      empty_key = Inkey
      
    Loop Until ( Len( empty_key ) = 0 ) And ( Not MultiKey( sc_enter ) )
    
  End Scope

  Dim ene_ver As Integer
    Dim As String tmp_id


  Do
  
    Locate 67, 76
    ? space( 8 )

    ScreenSet 0, 0  
    Locate 67, 76, 1
    
    tmp_id = ""
    Input "", tmp_id
    
    
    ene_ver = -1
    
    If Val( tmp_id ) < 0 Then ene_ver = 0

    
    
  Loop Until ene_ver <> 0
  now_room().enemy[gmg( enem.sel )].chap = Val( tmp_id )

  ScreenSet 0, 1  


  Do
    Sleep 1
  
  Loop While MultiKey(sc_enter)

  Scope
    
    Dim As String empty_key

    Do
      empty_key = Inkey
      
    Loop Until ( Len( empty_key ) = 0 ) And ( Not MultiKey( sc_enter ) )
    
  End Scope




End Sub


Sub teleport_box()
    
    
    If gmg( tel_state ) = 2 Then Swap gmg( prev_room ), llg( this_room ).i
    

    Dim As String gMapCT
    gMapCT = "Tele #" & gmg( tele.sel ) & space( 3 - Len( Str( gmg( tele.sel ) ) ) ) 

    Locate 58, 63
    ? gMapCT

    Locate 59, 62
    ? Chr( 195 ) & String( Len( gMapCT ) - 3 + Len( Str( gmg( tele.sel ) ) ), 196 ) & Chr( 217 )


    Locate 57, 80
    ? "[Start]"

    Locate 59, 75
    ? "x: " & now_room().teleport[gmg( tele ).sel].x
    
    Locate 59, 86
    ? "y: " & now_room().teleport[gmg( tele ).sel].y 

    Locate 61, 75
    ? "w: " & now_room().teleport[gmg( tele ).sel].w
    
    Locate 61, 86
    ? "h: " & now_room().teleport[gmg( tele ).sel].h


    Locate 64, 70
    ? "[Destination]"


    Locate 66, 68
    ? "x: " & now_room().teleport[gmg( tele ).sel].dx
    
    Locate 66, 80
    ? "y: " & now_room().teleport[gmg( tele ).sel].dy 
    

      
      
      If now_room().teleport[gmg( tele ).sel].to_map <> "" Then

        Scope
          
          Dim As String df
            df = "Entry: "
            df += Str( now_room().teleport[gmg( tele ).sel].to_room )
    
    
            setup_bounds( 68, 65, df )
            Scope
              
              Dim As String df
        
              df = "Map: "
              df += now_room().teleport[gmg( tele ).sel].to_map
              
              setup_bounds( 70, 65, df )
              tp_lf.x -= 16               
              click_bounds( get_tele_map_input() )
                             
            End Scope
          
        End Scope
    
      Else
      
        Scope
          
          Dim As String df
            df = "Room: "
            df += Str( now_room().teleport[gmg( tele ).sel].to_room )
    
            setup_bounds( 68, 65, df )
            Scope
              
              Dim As String df
        
              df = "Map: here"
    
              setup_bounds( 70, 65, df )
              tp_lf.x -= 16               
              click_bounds( get_tele_map_input() )
                             
            End Scope
            
          
        End Scope
      End If
  
    
    Scope
      
      Dim As String df

      df = "Song: "
      df += Str( now_room().teleport[gmg( tele ).sel].to_song )
      

    
      
      setup_bounds( 68, 77, df )
      tp_lf.x -= 16               
      click_bounds( get_tele_song_input() )
      
    End Scope
    
    If gmg( tel_state ) = 2 Then Swap gmg( prev_room ), llg( this_room ).i


End Sub               



Sub old_teleport_box()
    

    Dim As String gMapCT
    gMapCT = "Tele #" & gmg( tele.sel ) & space( 3 - Len( Str( gmg( tele.sel ) ) ) ) 

    Locate 58, 63
    ? gMapCT

    Locate 59, 62
    ? Chr( 195 ) & String( Len( gMapCT ) - 3 + Len( Str( gmg( tele.sel ) ) ), 196 ) & Chr( 217 )


    Locate 57, 80
    ? "[Start]"

    Locate 59, 75
    ? "x: " & now_room().teleport[gmg( tele ).sel].x
    
    Locate 59, 86
    ? "y: " & now_room().teleport[gmg( tele ).sel].y 

    Locate 61, 75
    ? "w: " & now_room().teleport[gmg( tele ).sel].w
    
    Locate 61, 86
    ? "h: " & now_room().teleport[gmg( tele ).sel].h


    Locate 64, 70
    ? "[Destination]"


    Locate 66, 68
    ? "x: " & now_room().teleport[gmg( tele ).sel].dx
    
    Locate 66, 80
    ? "y: " & now_room().teleport[gmg( tele ).sel].dy 
    

      
      
      If now_room().teleport[gmg( tele ).sel].to_map <> "" Then

        Scope
          
          Dim As String df
            df = "Entry: "
            df += Str( now_room().teleport[gmg( tele ).sel].to_room )
    
    
            setup_bounds( 68, 65, df )
            Scope
              
              Dim As String df
        
              df = "Map: "
              df += now_room().teleport[gmg( tele ).sel].to_map
              
              setup_bounds( 70, 65, df )
              tp_lf.x -= 16               
              click_bounds( get_tele_map_input() )
                             
            End Scope
          
        End Scope
    
      Else
      
        Scope
          
          Dim As String df
            df = "Room: "
            df += Str( now_room().teleport[gmg( tele ).sel].to_room )
    
            setup_bounds( 68, 65, df )
            Scope
              
              Dim As String df
        
              df = "Map: here"
    
              setup_bounds( 70, 65, df )
              tp_lf.x -= 16               
              click_bounds( get_tele_map_input() )
                             
            End Scope
            
          
        End Scope
      End If
  
    
    Scope
      
      Dim As String df

      df = "Song: "
      df += Str( now_room().teleport[gmg( tele ).sel].to_song )
      

    
      
      setup_bounds( 68, 77, df )
      tp_lf.x -= 16               
      click_bounds( get_tele_song_input() )
      
    End Scope
    


End Sub               



Sub get_tele_map_input()


  
  Dim As Integer ene_ver, re
  
  Dim As list_type Ptr map_files
  
  
  Locate 70, 70
  ScreenSet 0, 0  
  
  map_files = list_files( "data\map", "*.map" )

  re = open_file_dialog( map_files )
  
  If re <> -1 Then
  
    now_room().teleport[gmg( tele ).sel].to_map = kfp( list_node_value( map_files, re, "" ) )
  
  Else
    now_room().teleport[gmg( tele ).sel].to_map = ""
  
  End If
  
  list_Destroy( map_files, list_strlist )
  
  

End Sub



Sub get_tele_song_input()


  Dim As Integer ene_ver
    Dim As String tmp_id

  
  Do
  
    Locate 70, 78
    ? space( 8 )

    ScreenSet 0, 0  
    Locate 70, 78, 1
    
  
    tmp_id = ""
    Input "", tmp_id
    
    
    ene_ver = -1
    
    If Val( tmp_id ) < 0 Then ene_ver = 0

    
    
  Loop Until ene_ver <> 0

  now_room().teleport[gmg( tele ).sel].to_song = Val( tmp_id )

  
  ScreenSet 0, 1  

  Do
    Sleep 1
  
  Loop While MultiKey( sc_enter )

  Scope
    
    Dim As String empty_key

    Do
      empty_key = Inkey
      
    Loop Until ( Len( empty_key ) = 0 ) And ( Not MultiKey( sc_enter ) )
    
  End Scope


End Sub







Sub get_block_slave_input()


  Dim As Integer ene_ver
    Dim As String tmp_id

  
  Do
  
    Locate 63, 71
    ? space( 4 )

    ScreenSet 0, 0  
    Locate 63, 71, 1
    
  
    tmp_id = ""
    Input "", tmp_id
    
    
    ene_ver = -1
    
    If Val( tmp_id ) < 0 Then ene_ver = 0
    If tmp_id = "txt" Then ene_ver = -1

    
    
  Loop Until ene_ver <> 0

  If tmp_id = "txt" Then 
    selected_command_block().active_ent = ent_textbox
  Else

    selected_command_block().active_ent = Val( tmp_id )
    
  End If

  
  ScreenSet 0, 1  

  Do
    Sleep 1
  
  Loop While MultiKey( sc_enter )

  Scope
    
    Dim As String empty_key

    Do
      empty_key = Inkey
      
    Loop Until ( Len( empty_key ) = 0 ) And ( Not MultiKey( sc_enter ) )
    
  End Scope


End Sub



Sub get_block_func_input()


  Dim As Integer ene_ver
    Dim As String tmp_id

  
  Do
  
    Locate 64, 71
    ? space( 4 )

    ScreenSet 0, 0  
    Locate 64, 71, 1
    
  
    tmp_id = ""
    Input "", tmp_id
    
    
    ene_ver = -1
    
    If Val( tmp_id ) < 0 Then ene_ver = 0

    
    
  Loop Until ene_ver <> 0

  selected_command_block().ent_state = Val( tmp_id )

  
  ScreenSet 0, 1  

  Do
    Sleep 1
  
  Loop While MultiKey( sc_enter )

  Scope
    
    Dim As String empty_key

    Do
      empty_key = Inkey
      
    Loop Until ( Len( empty_key ) = 0 ) And ( Not MultiKey( sc_enter ) )
    
  End Scope


End Sub



Sub get_block_loop_input()


  Dim As Integer ene_ver
    Dim As String tmp_id

  
  Do
  
    Locate 66, 71
    ? space( 4 )

    ScreenSet 0, 0  
    Locate 66, 71, 1
    
  
    tmp_id = ""
    Input "", tmp_id
    
    
    ene_ver = -1
    
    If Val( tmp_id ) < 0 Then ene_ver = 0

    
    
  Loop Until ene_ver <> 0

  selected_command_block().jump_count = Val( tmp_id )

  
  ScreenSet 0, 1  

  Do
    Sleep 1
  
  Loop While MultiKey( sc_enter )

  Scope
    
    Dim As String empty_key

    Do
      empty_key = Inkey
      
    Loop Until ( Len( empty_key ) = 0 ) And ( Not MultiKey( sc_enter ) )
    
  End Scope


End Sub



Sub get_block_map_input()


  Dim As Integer ene_ver, re
  
  Dim As list_type Ptr map_files
  
  
  map_files = list_files( "data\map", "*.map" )

  re = open_file_dialog( map_files )
  
  If re <> -1 Then
  
    selected_command_block().to_map = kfp( list_node_value( map_files, re, "" ) )
  
  Else
    selected_command_block().to_map = ""
  
  End If
  
  list_Destroy( map_files, list_strlist )
  


End Sub




Sub get_block_entry_input()


  Dim As Integer ene_ver
    Dim As String tmp_id

  
  Do
  
    Locate 68, 71
    ? space( 4 )

    ScreenSet 0, 0  
    Locate 68, 71, 1
    
  
    tmp_id = ""
    Input "", tmp_id
    
    
    ene_ver = -1
    
    If Val( tmp_id ) < 0 Then ene_ver = 0

    
    
  Loop Until ene_ver <> 0

  selected_command_block().to_entry = Val( tmp_id )

  
  ScreenSet 0, 1  

  Do
    Sleep 1
  
  Loop While MultiKey( sc_enter )

  Scope
    
    Dim As String empty_key

    Do
      empty_key = Inkey
      
    Loop Until ( Len( empty_key ) = 0 ) And ( Not MultiKey( sc_enter ) )
    
  End Scope


End Sub






Sub get_block_hud_input()


  Dim As Integer ene_ver
  
    Dim As String tmp_id

  Do
  
    Locate 69, 71
    ? space( 4 )

    ScreenSet 0, 0  
    Locate 69, 71, 1
    
  
    tmp_id = ""
    Input "", tmp_id
    
    
    ene_ver = -1
    
    If Val( tmp_id ) < 0 Then ene_ver = 0

    
    
  Loop Until ene_ver <> 0
  
  If Val( tmp_id ) = 0 Then
    selected_command_block().display_hud = 0
    
  Else
    selected_command_block().display_hud = 1

  End If
  
  ScreenSet 0, 1  

  Do
    Sleep 1
  
  Loop While MultiKey( sc_enter )

  Scope
    
    Dim As String empty_key

    Do
      empty_key = Inkey
      
    Loop Until ( Len( empty_key ) = 0 ) And ( Not MultiKey( sc_enter ) )
    
  End Scope


End Sub





Sub get_block_lock_input()


  Dim As Integer ene_ver
    Dim As String tmp_id

  
  Do
  
    Locate 70, 71
    ? space( 4 )

    ScreenSet 0, 0  
    Locate 70, 71, 1
    
  
    tmp_id = ""
    Input "", tmp_id
    
    
    ene_ver = -1
    
    If Val( tmp_id ) < 0 Then ene_ver = 0

    
    
  Loop Until ene_ver <> 0
  
  If Val( tmp_id ) = 0 Then
    selected_command_block().free_to_move = 0
    
  Else
    selected_command_block().free_to_move = 1

  End If
  
  ScreenSet 0, 1  

  Do
    Sleep 1
  
  Loop While MultiKey( sc_enter )

  Scope
    
    Dim As String empty_key

    Do
      empty_key = Inkey
      
    Loop Until ( Len( empty_key ) = 0 ) And ( Not MultiKey( sc_enter ) )
    
  End Scope


End Sub





Sub get_block_chap_input()


  Dim As Integer ene_ver
    Dim As String tmp_id
  
  Do
  
    Locate 63, 86
    ? space( 4 )

    ScreenSet 0, 0  
    Locate 63, 86, 1
    
  

    tmp_id = ""
    Input "", tmp_id
    
    
    ene_ver = -1
    
    'If Val( tmp_id ) < 0 Then ene_ver = 0

    
    
  Loop Until ene_ver <> 0
  
  selected_command_block().chap = Val( tmp_id )
  
  ScreenSet 0, 1  

  Do
    Sleep 1
  
  Loop While MultiKey( sc_enter )

  Scope
    
    Dim As String empty_key

    Do
      empty_key = Inkey
      
    Loop Until ( Len( empty_key ) = 0 ) And ( Not MultiKey( sc_enter ) )
    
  End Scope


End Sub



Sub get_block_carry_input()


  Dim As Integer ene_ver
    Dim As String tmp_id
  
  Do
  
    Locate 64, 86
    ? space( 4 )

    ScreenSet 0, 0  
    Locate 64, 86, 1
    
  

    tmp_id = ""
    Input "", tmp_id
    
    
    ene_ver = -1
    
    If Val( tmp_id ) < 0 Then ene_ver = 0

    
    
  Loop Until ene_ver <> 0
  
  If Val( tmp_id ) = 0 Then
    selected_command_block().carries_all = 0
    
  Else
    selected_command_block().carries_all = 1

  End If
  
  ScreenSet 0, 1  

  Do
    Sleep 1
  
  Loop While MultiKey( sc_enter )

  Scope
    
    Dim As String empty_key

    Do
      empty_key = Inkey
      
    Loop Until ( Len( empty_key ) = 0 ) And ( Not MultiKey( sc_enter ) )
    
  End Scope


End Sub


Sub get_block_cam_input()


  Dim As Integer ene_ver
    Dim As String tmp_id
  
  Do
  
    Locate 68, 86
    ? space( 4 )

    ScreenSet 0, 0  
    Locate 68, 86, 1
    
  

    tmp_id = ""
    Input "", tmp_id
    
    
    ene_ver = -1
    
    If Val( tmp_id ) < 0 Then ene_ver = 0

    
    
  Loop Until ene_ver <> 0
  
  selected_command_block().nocam = Val( tmp_id )

  
  ScreenSet 0, 1  

  Do
    Sleep 1
  
  Loop While MultiKey( sc_enter )

  Scope
    
    Dim As String empty_key

    Do
      empty_key = Inkey
      
    Loop Until ( Len( empty_key ) = 0 ) And ( Not MultiKey( sc_enter ) )
    
  End Scope


End Sub


Sub get_block_dir_input()


  Dim As Integer ene_ver
    Dim As String tmp_id
  
  Do
  
    Locate 69, 86
    ? space( 4 )

    ScreenSet 0, 0  
    Locate 69, 86, 1
    
  

    tmp_id = ""
    Input "", tmp_id
    
    
    ene_ver = -1
    
    If Val( tmp_id ) < 0 Then ene_ver = 0
    If Val( tmp_id ) > 4 Then ene_ver = 0

    
    
  Loop Until ene_ver <> 0
  
  selected_command_block().modify_direction = Val( tmp_id )

  
  ScreenSet 0, 1  

  Do
    Sleep 1
  
  Loop While MultiKey( sc_enter )

  Scope
    
    Dim As String empty_key

    Do
      empty_key = Inkey
      
    Loop Until ( Len( empty_key ) = 0 ) And ( Not MultiKey( sc_enter ) )
    
  End Scope


End Sub


Sub get_block_pause_input()


  Dim As Integer ene_ver
    Dim As String tmp_id
  
  Do
  
    Locate 70, 86
    ? space( 4 )

    ScreenSet 0, 0  
    Locate 70, 86, 1
    
  

    tmp_id = ""
    Input "", tmp_id
    
    
    ene_ver = -1
    
    If Val( tmp_id ) < 0 Then ene_ver = 0
    
  Loop Until ene_ver <> 0
  
  If Val( tmp_id ) = 0 Then
    selected_command_block().seq_pause = 0
    
  Else
    selected_command_block().seq_pause = 1

  End If

  
  ScreenSet 0, 1  

  Do
    Sleep 1
  
  Loop While MultiKey( sc_enter )

  Scope
    
    Dim As String empty_key

    Do
      empty_key = Inkey
      
    Loop Until ( Len( empty_key ) = 0 ) And ( Not MultiKey( sc_enter ) )
    
  End Scope


End Sub



Sub get_block_absx_input()


  Dim As Integer ene_ver
    Dim As String tmp_id
  
  Do
  
    Locate 63, 72
    ? space( 4 )

    ScreenSet 0, 0  
    Locate 63, 72, 1
    
  

    tmp_id = ""
    Input "", tmp_id
    
    
    ene_ver = -1
    
    If Val( tmp_id ) < 0 Then ene_ver = 0
    
  Loop Until ene_ver <> 0
  
  selected_command_block().abs_x = Val( tmp_id )

  
  ScreenSet 0, 1  

  Do
    Sleep 1
  
  Loop While MultiKey( sc_enter )

  Scope
    
    Dim As String empty_key

    Do
      empty_key = Inkey
      
    Loop Until ( Len( empty_key ) = 0 ) And ( Not MultiKey( sc_enter ) )
    
  End Scope


End Sub

Sub get_block_absy_input()


  Dim As Integer ene_ver
    Dim As String tmp_id
  
  Do
  
    Locate 63, 84
    ? space( 4 )

    ScreenSet 0, 0  
    Locate 63, 84, 1
    
  

    tmp_id = ""
    Input "", tmp_id
    
    
    ene_ver = -1
    
    If Val( tmp_id ) < 0 Then ene_ver = 0
    
  Loop Until ene_ver <> 0
  
  selected_command_block().abs_y = Val( tmp_id )

  
  ScreenSet 0, 1  

  Do
    Sleep 1
  
  Loop While MultiKey( sc_enter )

  Scope
    
    Dim As String empty_key

    Do
      empty_key = Inkey
      
    Loop Until ( Len( empty_key ) = 0 ) And ( Not MultiKey( sc_enter ) )
    
  End Scope


End Sub


Sub get_block_destx_input()


  Dim As Integer ene_ver
    Dim As String tmp_id
  
  Do
  
    Locate 65, 74
    ? space( 4 )

    ScreenSet 0, 0  
    Locate 65, 74, 1
    
  

    tmp_id = ""
    Input "", tmp_id
    
    
    ene_ver = -1
    
    If Val( tmp_id ) < 0 Then ene_ver = 0
    
  Loop Until ene_ver <> 0
  
  selected_command_block().dest_x = Val( tmp_id )

  
  ScreenSet 0, 1  

  Do
    Sleep 1
  
  Loop While MultiKey( sc_enter )

  Scope
    
    Dim As String empty_key

    Do
      empty_key = Inkey
      
    Loop Until ( Len( empty_key ) = 0 ) And ( Not MultiKey( sc_enter ) )
    
  End Scope


End Sub

Sub get_block_desty_input()


  Dim As Integer ene_ver
    Dim As String tmp_id

  
  Do
  
    Locate 66, 74
    ? space( 4 )

    ScreenSet 0, 0  
    Locate 66, 74, 1
    
  
    tmp_id = ""
    Input "", tmp_id
    
    
    ene_ver = -1
    
    If Val( tmp_id ) < 0 Then ene_ver = 0
    
  Loop Until ene_ver <> 0
  
  selected_command_block().dest_y = Val( tmp_id )

  
  ScreenSet 0, 1  

  Do
    Sleep 1
  
  Loop While MultiKey( sc_enter )

  Scope
    
    Dim As String empty_key

    Do
      empty_key = Inkey
      
    Loop Until ( Len( empty_key ) = 0 ) And ( Not MultiKey( sc_enter ) )
    
  End Scope


End Sub

Sub get_block_boxx_input()


  Dim As Integer ene_ver
    Dim As String tmp_id
  
  Do
  
    Locate 68, 74
    ? space( 4 )

    ScreenSet 0, 0  
    Locate 68, 74, 1
    
  

    tmp_id = ""
    Input "", tmp_id
    
    
    ene_ver = -1
    
    If Val( tmp_id ) < 0 Then ene_ver = 0
    
  Loop Until ene_ver <> 0
  
  selected_command_block().mod_x = Val( tmp_id )

  
  ScreenSet 0, 1  

  Do
    Sleep 1
  
  Loop While MultiKey( sc_enter )

  Scope
    
    Dim As String empty_key

    Do
      empty_key = Inkey
      
    Loop Until ( Len( empty_key ) = 0 ) And ( Not MultiKey( sc_enter ) )
    
  End Scope


End Sub


Sub get_block_boxy_input()


  Dim As Integer ene_ver
    Dim As String tmp_id
  
  Do
  
    Locate 68, 87
    ? space( 4 )

    ScreenSet 0, 0  
    Locate 68, 87, 1
    
  

    tmp_id = ""
    Input "", tmp_id
    
    
    ene_ver = -1
    
    If Val( tmp_id ) < 0 Then ene_ver = 0
    
  Loop Until ene_ver <> 0
  
  selected_command_block().mod_y = Val( tmp_id )

  
  ScreenSet 0, 1  

  Do
    Sleep 1
  
  Loop While MultiKey( sc_enter )

  Scope
    
    Dim As String empty_key

    Do
      empty_key = Inkey
      
    Loop Until ( Len( empty_key ) = 0 ) And ( Not MultiKey( sc_enter ) )
    
  End Scope


End Sub



Sub get_block_walkspeed_input()


  Dim As Integer ene_ver
    Dim As String tmp_id
  
  Do
  
    Locate 70, 76
    ? space( 4 )

    ScreenSet 0, 0  
    Locate 70, 76, 1
    
  

    tmp_id = ""
    Input "", tmp_id
    
    
    ene_ver = -1
    
    If Val( tmp_id ) < 0 Then ene_ver = 0
    
  Loop Until ene_ver <> 0
  
  selected_command_block().walk_speed = Val( tmp_id )

  
  ScreenSet 0, 1  

  Do
    Sleep 1
  
  Loop While MultiKey( sc_enter )

  Scope
    
    Dim As String empty_key

    Do
      empty_key = Inkey
      
    Loop Until ( Len( empty_key ) = 0 ) And ( Not MultiKey( sc_enter ) )
    
  End Scope


End Sub


Sub get_block_align_input()


  Dim As Integer ene_ver
  
    Dim As String tmp_id
  Do
  
    Locate 70, 91 
    ? space( 4 )

    ScreenSet 0, 0  
    Locate 70, 91, 1
    
  

    tmp_id = ""
    Input "", tmp_id
    
    
    ene_ver = -1
    
    If Val( tmp_id ) < 0 Then ene_ver = 0
    
  Loop Until ene_ver <> 0
  
  selected_command_block().water_align = Val( tmp_id )

  
  ScreenSet 0, 1  

  Do
    Sleep 1
  
  Loop While MultiKey( sc_enter )

  Scope
    
    Dim As String empty_key

    Do
      empty_key = Inkey
      
    Loop Until ( Len( empty_key ) = 0 ) And ( Not MultiKey( sc_enter ) )
    
  End Scope


End Sub


Sub get_entity_code_input()


  Dim As Integer ene_ver
    Dim As String tmp_id
  
  Do
  
    Locate 66, 81
    ? space( 10 )

    ScreenSet 0, 0  
    Locate 66, 81, 1
    
  

    tmp_id = ""
    Input "", tmp_id
    
    
    ene_ver = -1
    
    If Val( tmp_id ) < -1 Then ene_ver = 0
    If Val( tmp_id ) > now_room().enemies - 1 Then ene_ver = 0
    
  Loop Until ene_ver <> 0
  
  selected_sequence().ent_code[gmg( seq_ents ).sel] = Val( tmp_id )

  
  ScreenSet 0, 1  

  Do
    Sleep 1
  
  Loop While MultiKey( sc_enter )

  Scope
    
    Dim As String empty_key

    Do
      empty_key = Inkey
      
    Loop Until ( Len( empty_key ) = 0 ) And ( Not MultiKey( sc_enter ) )
    
  End Scope


End Sub

Sub toggle_enemy_spawn_cond()

  now_room().enemy[gmg( enem.sel )].spawn_cond Xor= 1
  hold_button( sc_leftbutton )
  
End Sub


Sub get_entity_spawn_wait()


  Dim As Integer ene_ver
    Dim As String tmp_id
  
  Do
  
    Locate 61, 76
    ? space( 10 )

    ScreenSet 0, 0  
    Locate 61, 76, 1
    
  
    tmp_id = ""
    Input "", tmp_id
    
    
    ene_ver = -1
    
    If Val( tmp_id ) < -1 Then ene_ver = 0
'    If Val( tmp_id ) > now_room().enemies - 1 Then ene_ver = 0
    
  Loop Until ene_ver <> 0
  
  now_room().enemy[gmg( enem ).sel].spawn_info->wait_n = Val( tmp_id )

  
  ScreenSet 0, 1  

  Do
    Sleep 1
  
  Loop While MultiKey( sc_enter )

  Scope
    
    Dim As String empty_key

    Do
      empty_key = Inkey
      
    Loop Until ( Len( empty_key ) = 0 ) And ( Not MultiKey( sc_enter ) )
    
  End Scope


End Sub


Sub get_entity_spawn_kill()


  Dim As Integer ene_ver
    Dim As String tmp_id
  
  Do
  
    Locate 61, 93
    ? space( 3 )

    ScreenSet 0, 0  
    Locate 61, 93, 1
    
  
    tmp_id = ""
    Input "", tmp_id
    
    
    ene_ver = -1
    
    If Val( tmp_id ) < -1 Then ene_ver = 0
    
  Loop Until ene_ver <> 0
  
  now_room().enemy[gmg( enem ).sel].spawn_info->kill_n = Val( tmp_id )

  
  ScreenSet 0, 1  

  Do
    Sleep 1
  
  Loop While MultiKey( sc_enter )

  Scope
    
    Dim As String empty_key

    Do
      empty_key = Inkey
      
    Loop Until ( Len( empty_key ) = 0 ) And ( Not MultiKey( sc_enter ) )
    
  End Scope


End Sub

Sub get_entity_spawn_active()


  Dim As Integer ene_ver
  Dim As String tmp_id
  
  Do
  
    Locate 68, 78
    ? space( 3 )

    ScreenSet 0, 0  
    Locate 68, 78, 1
    
  
    tmp_id = ""
    Input "", tmp_id
    
    
    ene_ver = -1
    
    If Val( tmp_id ) < -1 Then ene_ver = 0
    
  Loop Until ene_ver <> 0
  
  now_room().enemy[gmg( enem ).sel].spawn_info->active_n = Val( tmp_id )

  
  ScreenSet 0, 1  

  Do
    Sleep 1
  
  Loop While MultiKey( sc_enter )

  Scope
    
    Dim As String empty_key

    Do
      empty_key = Inkey
      
    Loop Until ( Len( empty_key ) = 0 ) And ( Not MultiKey( sc_enter ) )
    
  End Scope


End Sub


Sub enemy_wait_up()

  gmg( spawn_wait ).sel += 1
  gmg( spawn_wait ).sel Mod= now_room().enemy[gmg( enem ).sel].spawn_info->wait_n
  hold_button( sc_leftbutton )
  
End Sub

Sub enemy_wait_down()

  gmg( spawn_wait ).sel -= 1
  If gmg( spawn_wait ).sel = -1 Then 
    gmg( spawn_wait ).sel = now_room().enemy[gmg( enem ).sel].spawn_info->wait_n - 1
    
  End If
  hold_button( sc_leftbutton )
  
End Sub


Sub enemy_kill_up()

  gmg( spawn_kill ).sel += 1
  gmg( spawn_kill ).sel Mod= now_room().enemy[gmg( enem ).sel].spawn_info->kill_n
  hold_button( sc_leftbutton )
  
End Sub

Sub enemy_kill_down()

  gmg( spawn_kill ).sel -= 1
  If gmg( spawn_kill ).sel = -1 Then 
    gmg( spawn_kill ).sel = now_room().enemy[gmg( enem ).sel].spawn_info->kill_n - 1
    
  End If
  hold_button( sc_leftbutton )
  
End Sub


Sub enemy_active_up()

  gmg( spawn_active ).sel += 1
  gmg( spawn_active ).sel Mod= now_room().enemy[gmg( enem ).sel].spawn_info->active_n
  hold_button( sc_leftbutton )
  
End Sub

Sub enemy_active_down()

  gmg( spawn_active ).sel -= 1
  If gmg( spawn_active ).sel = -1 Then 
    gmg( spawn_active ).sel = now_room().enemy[gmg( enem ).sel].spawn_info->active_n - 1
    
  End If
  hold_button( sc_leftbutton )
  
End Sub





Sub get_entity_wait_code_index()


  Dim As Integer ene_ver
  Dim As String tmp_id
  
  Do
  
    Locate 65, 71
    ? space( 3 )

    ScreenSet 0, 0  
    Locate 65, 71, 1
    
  
    tmp_id = ""
    Input "", tmp_id
    
    
    ene_ver = -1
    
    If Val( tmp_id ) < -1 Then ene_ver = 0
    If Val( tmp_id ) > 65535 Then ene_ver = 0
    
  Loop Until ene_ver <> 0
  
  now_room().enemy[gmg( enem ).sel].spawn_info->wait_spawn[gmg( spawn_wait ).sel].code_index = Val( tmp_id )

  
  ScreenSet 0, 1  

  Do
    Sleep 1
  
  Loop While MultiKey( sc_enter )

  Scope
    
    Dim As String empty_key

    Do
      empty_key = Inkey
      
    Loop Until ( Len( empty_key ) = 0 ) And ( Not MultiKey( sc_enter ) )
    
  End Scope


End Sub


Sub get_entity_kill_code_index()


  Dim As Integer ene_ver
  Dim As String tmp_id
  
  Do
  
    Locate 65, 88
    ? space( 3 )

    ScreenSet 0, 0  
    Locate 65, 88, 1
    
  
    tmp_id = ""
    Input "", tmp_id
    
    
    ene_ver = -1
    
    If Val( tmp_id ) < -1 Then ene_ver = 0
    If Val( tmp_id ) > 65535 Then ene_ver = 0
    
  Loop Until ene_ver <> 0
  
  now_room().enemy[gmg( enem ).sel].spawn_info->kill_spawn[gmg( spawn_kill ).sel].code_index = Val( tmp_id )

  
  ScreenSet 0, 1  

  Do
    Sleep 1
  
  Loop While MultiKey( sc_enter )

  Scope
    
    Dim As String empty_key

    Do
      empty_key = Inkey
      
    Loop Until ( Len( empty_key ) = 0 ) And ( Not MultiKey( sc_enter ) )
    
  End Scope


End Sub




Sub get_entity_active_code_index()


  Dim As Integer ene_ver
  Dim As String tmp_id
  
  Do
  
    Locate 70, 71
    ? space( 3 )

    ScreenSet 0, 0  
    Locate 70, 71, 1
    
  
    tmp_id = ""
    Input "", tmp_id
    
    
    ene_ver = -1
    
    If Val( tmp_id ) < -1 Then ene_ver = 0
    If Val( tmp_id ) > 65535 Then ene_ver = 0
    
  Loop Until ene_ver <> 0
  
  now_room().enemy[gmg( enem ).sel].spawn_info->active_spawn[gmg( spawn_active ).sel].code_index = Val( tmp_id )

  
  ScreenSet 0, 1  

  Do
    Sleep 1
  
  Loop While MultiKey( sc_enter )

  Scope
    
    Dim As String empty_key

    Do
      empty_key = Inkey
      
    Loop Until ( Len( empty_key ) = 0 ) And ( Not MultiKey( sc_enter ) )
    
  End Scope


End Sub




Sub toggle_entity_wait_code_state()

  now_room().enemy[gmg( enem ).sel].spawn_info->wait_spawn[gmg( spawn_wait ).sel].code_state Xor= 1
  hold_button( sc_leftbutton )

End Sub

Sub toggle_entity_kill_code_state()

  now_room().enemy[gmg( enem ).sel].spawn_info->kill_spawn[gmg( spawn_kill ).sel].code_state Xor= 1
  hold_button( sc_leftbutton )

End Sub

Sub toggle_entity_active_code_state()

  now_room().enemy[gmg( enem ).sel].spawn_info->active_spawn[gmg( spawn_active ).sel].code_state Xor= 1
  hold_button( sc_leftbutton )

End Sub





Sub toggle_spawn_box()


  gmg( enemy_box_state ) = 1
  hold_button( sc_leftbutton )
  

End Sub