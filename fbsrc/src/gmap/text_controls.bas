Option Explicit

#Include "..\headers\ll\headers.bi"


Function ctrl_X_click ( c As _control_type )

  If fb_Global.mouse.x > ((( c.x + ( c.ct_len ) - 2 ) - 1 ) Shl 3 ) Then
    If fb_Global.mouse.y > (( c.y + 1 ) Shl 3 ) Then
      If fb_Global.mouse.x < ((( c.x + ( c.ct_len ) - 2 ) - 1 ) Shl 3 + 8 ) Then
        If fb_Global.mouse.y < (( c.y + 1 ) Shl 3 + 8 ) Then
          If ( fb_Global.mouse.b And sc_leftbutton ) Then 
            Return Not 0
          End If
          
        End If
      End If
    End If
  End If
        

       

End Function       



Sub show_sel_elements ( c As _control_type, _element As Integer )


  Locate c.y + 1, c.x + ( c.ct_len ) - 1
  ? Trim ( Str ( _element ))


End Sub


Sub show_sel_ctrl ( c As _control_type )


  Dim As Integer clr

  clr = Color

  Color 6
    Locate c.y, c.x
    If ucase( c.Name ) <> "NULL" Then ? c.Name
    
  Color clr


End Sub


Sub show_ctrl_elements ( c As _control_type, _element As Integer )


  If Len( Str ( _element ) ) = 1 Then
    Locate c.y - 1, c.x + ( c.ct_len )
    ? Trim ( Str ( _element ))

  Else
    Locate c.y - 1, c.x + ( c.ct_len ) - 1
    ? Trim ( Str ( _element ))

  End If
  
End Sub


Sub show_ctrls ( iter As Integer, c As _control_type Ptr )

  Dim As Integer show_c                                                

  For show_c = 0 To iter - 1
 
    Dim As Integer show_paths
    show_paths = -1
    
    gmg( active_seq ) = active_sequence()
    
    #IfDef __gMap__
      '' all or nothing!!
      show_paths And= ucase( c[show_c].Name ) <> "NULL"
      show_paths And= ucase( c[show_c].Name ) <> "LOAD PARA IMAGE"
      show_paths And= ( ( gmg( _state ) = s_enemies ) Imp now_room().enemies <> 0 ) Or show_c <> s_sequence
      show_paths And= ( ( gmg( _state ) = s_entries ) Imp llg( map )->entries <> 0 ) Or show_c <> s_sequence
      show_paths And= ( ( ( gmg( _state ) = s_rooms ) Or ( gmg( _state ) = s_layer_0 ) Or ( gmg( _state ) = s_layer_1 ) Or ( gmg( _state ) = s_layer_2 ) ) Imp llg( map )->rooms <> 0 ) Or show_c <> s_sequence


      show_paths And= show_c = s_sequence_entities Imp active_sequence_count() <> 0
      show_paths And= show_c = s_sequence_commands Imp active_sequence_count() <> 0
      show_paths And= show_c = s_sequence_command_blocks Imp active_sequence_count() <> 0
      
      show_paths And= ( show_c = s_sequence_commands ) Imp ( gmg( _state ) = s_sequence ) Or ( gmg( _state ) = s_sequence_entities ) Or ( gmg( _state ) = s_sequence_commands ) Or ( gmg( _state ) = s_sequence_command_blocks )
      show_paths And= ( show_c = s_sequence_entities ) Imp ( gmg( _state ) = s_sequence ) Or ( gmg( _state ) = s_sequence_commands ) Or ( gmg( _state ) = s_sequence_entities ) Or ( gmg( _state ) = s_sequence_command_blocks )
      If gmg( seq_ptr ) <> 0 Then
        show_paths And= ( show_c = s_sequence_command_blocks ) Imp ( ( gmg( _state ) = s_sequence ) Or ( gmg( _state ) = s_sequence_commands ) Or ( gmg( _state ) = s_sequence_entities ) Or ( gmg( _state ) = s_sequence_command_blocks ) ) And ( selected_sequence().commands <> 0 )
        
      End If
      
      
      
      
    #EndIf
    
    
    
    
    
 
    Locate c[show_c].y, c[show_c].x

    If show_paths Then

      ? c[show_c].Name
      If c[show_c].lm Or c[show_c].ad Then 
        If c[show_c].e_num Then
          If Len( Str ( *c[show_c].e_num ) ) = 1 Then
            Locate c[show_c].y - 1, c[show_c].x + ( c[show_c].ct_len )
            ? Trim ( Str ( *c[show_c].e_num ) )
          
          Else
            Locate c[show_c].y - 1, c[show_c].x + ( c[show_c].ct_len ) - 1
            ? Trim ( Str ( *c[show_c].e_num ) )
            
          End If


        Else
          Locate c[show_c].y - 1, c[show_c].x + ( c[show_c].ct_len ) - 1
          ? Trim ( Str ( 0 ) )
          
        End If
        
      End If


    End If
    

  Next


End Sub  


Sub set_ctrl ( c As _control_type, _x As Integer = -1, _y As Integer = -1, _name As String = "", _state As Integer = -1, _e_sel As Integer Ptr = 0, _e_num As Integer Ptr = 0, _lm As Integer = -1, _ad As Integer = -1 )

  
  With c
  

    If _x <> -1 Then
      .x = _x
      
    End If
    
    
    If _y <> -1 Then
      .y = _y
      
    End If
    
    .real_x = .x Shl 3 '' multiplied by text width
    .real_y = .y Shl 3 '' multiplied by text height

    If _name <> "" Then
      .Name = _name
      
    End If

    If _state <> -1 Then
      .state = _state
      
    End If
    

    If _e_sel <> 0 Then
      .e_sel = _e_sel
      
    End If
    
    If _e_num <> 0 Then
      .e_num = _e_num
      
    End If

    If _lm <> -1 Then
      .lm = _lm
      
    End If
    
    If _ad <> -1 Then
      .ad = _ad
      
    End If

    .d_delay = .2


    .ct_len = Len ( .Name )

    .ct_odd = ( ( .ct_len Shr 1 ) = ( .ct_len / 2 ) )
    .ct_len = .ct_len Shr 1
    

  End With
       

End Sub       


Sub sense_ctrls ( iter As Integer, c As _control_type Ptr )
                                                
  Dim As Integer sense_all                                                

  If fb_Global.mouse.x <> -1 Then


    For sense_all = 0 To iter - 1 
      
      conty:
    
      If (( gmg( _state ) <> 3 ) And ( gmg( _state ) <> 16 ) And ( gmg( _state ) <> 21 )) Or ( sense_all < 9 Or sense_all > 11 ) Then


        Dim As Integer show_paths
        show_paths = -1
        
        #IfDef __gMap__
          show_paths And= ucase( c[sense_all].Name ) <> "NULL"
          show_paths And= ucase( c[sense_all].Name ) <> "LOAD PARA IMAGE"
          show_paths And= ( ( gmg( _state ) = s_enemies ) Imp now_room().enemies <> 0 ) Or sense_all <> s_sequence
          show_paths And= ( ( gmg( _state ) = s_entries ) Imp llg( map )->entries <> 0 ) Or sense_all <> s_sequence
          show_paths And= ( ( ( gmg( _state ) = s_rooms ) Or ( gmg( _state ) = s_layer_0 ) Or ( gmg( _state ) = s_layer_1 ) Or ( gmg( _state ) = s_layer_2 ) ) Imp llg( map )->rooms <> 0 ) Or sense_all <> s_sequence
    
    
          show_paths And= sense_all = s_sequence_entities Imp active_sequence_count() <> 0
          show_paths And= sense_all = s_sequence_commands Imp active_sequence_count() <> 0
          show_paths And= sense_all = s_sequence_command_blocks Imp active_sequence_count() <> 0
          
          show_paths And= ( sense_all = s_sequence_commands ) Imp ( gmg( _state ) = s_sequence ) Or ( gmg( _state ) = s_sequence_entities ) Or ( gmg( _state ) = s_sequence_commands ) Or ( gmg( _state ) = s_sequence_command_blocks )
          show_paths And= ( sense_all = s_sequence_entities ) Imp ( gmg( _state ) = s_sequence ) Or ( gmg( _state ) = s_sequence_commands ) Or ( gmg( _state ) = s_sequence_entities ) Or ( gmg( _state ) = s_sequence_command_blocks )
          show_paths And= ( sense_all = s_sequence_command_blocks ) Imp ( gmg( _state ) = s_sequence ) Or ( gmg( _state ) = s_sequence_commands ) Or ( gmg( _state ) = s_sequence_entities ) Or ( gmg( _state ) = s_sequence_command_blocks )
          
          If gmg( seq_ptr ) <> 0 Then
            show_paths And= ( sense_all = s_sequence_command_blocks ) Imp ( ( gmg( _state ) = s_sequence ) Or ( gmg( _state ) = s_sequence_commands ) Or ( gmg( _state ) = s_sequence_entities ) Or ( gmg( _state ) = s_sequence_command_blocks ) ) And ( selected_sequence().commands <> 0 )
            
          End If
          
          
        #EndIf
        
        If show_paths Then 
           
          If         fb_Global.mouse.b And sc_leftbutton Then 
            If       fb_Global.mouse.x > ( ( c[sense_all].real_x - 8 ) ) Then  
              If     fb_Global.mouse.y > ( ( c[sense_all].real_y - 8 ) ) Then  
                If   fb_Global.mouse.x < ( ( c[sense_all].real_x - 8 ) + Len ( c[sense_all].Name ) Shl 3 ) Then 
                  If fb_Global.mouse.y < ( ( c[sense_all].real_y - 8 ) + 8 ) Then 
                  
                    If gmg( _state ) = s_walkables Or gmg( _state ) = s_macros Or gmg( _state ) = s_flood_fill Then
                      If sense_all = s_layer_0 Or sense_all = s_layer_1 Or sense_all = s_layer_2 Then
                        sense_all += 1
                        Goto conty
                        
                      End If
                      
                    End If
          
                     
                    gmg( _state ) = c[sense_all].state
                    Exit Sub
                    
                  End If
                End If
              End If
            End If
          End If

        End If
             
         
      End If
        
    Next

  End If

End Sub                                                






Function ctrl_r_click ( c As _control_type )


    If ( fb_Global.mouse.b And sc_leftbutton ) Then 
      If fb_Global.mouse.x > (( c.x + ( c.ct_len ) + 2 + c.ct_odd - 1 ) Shl 3 ) Then
        If fb_Global.mouse.y > (( c.y ) Shl 3 ) Then
          If fb_Global.mouse.x < (( c.x + ( c.ct_len ) + 2 + c.ct_odd - 1 ) Shl 3 + 8 ) Then
            If fb_Global.mouse.y < (( c.y ) Shl 3 + 8 ) Then
              
                If gmg( _state ) = s_rooms Then
                  new_room_init()
                  
                End If
              
              
              
              Return Not 0
            
            End If
          End If
        End If
      End If
    End If


End Function       




Function ctrl_plus_click( c As _control_type )


    If ( fb_Global.mouse.b And sc_leftbutton ) Then 
      If fb_Global.mouse.x > (( c.x + ( c.ct_len ) + 2 + c.ct_odd - 1 ) Shl 3 ) Then
        If fb_Global.mouse.y > (( c.y + 1 ) Shl 3 ) Then
          If fb_Global.mouse.x < (( c.x + ( c.ct_len ) + 2 + c.ct_odd - 1 ) Shl 3 + 8 ) Then
            If fb_Global.mouse.y < (( c.y + 1 ) Shl 3 + 8 ) Then
              Return Not 0
              
            End If
          End If
        End If
      End If
    End If
       
     


End Function       


Function ctrl_plus_rclick( c As _control_type )


    If ( fb_Global.mouse.b And sc_rightbutton ) Then 
      If fb_Global.mouse.x > (( c.x + ( c.ct_len ) + 2 + c.ct_odd - 1 ) Shl 3 ) Then
        If fb_Global.mouse.y > (( c.y + 1 ) Shl 3 ) Then
          If fb_Global.mouse.x < (( c.x + ( c.ct_len ) + 2 + c.ct_odd - 1 ) Shl 3 + 8 ) Then
            If fb_Global.mouse.y < (( c.y + 1 ) Shl 3 + 8 ) Then
              Return Not 0
              
            End If
          End If
        End If
      End If
    End If
       
     


End Function       




Function ctrl_l_click ( c As _control_type )

    If ( fb_Global.mouse.b And sc_leftbutton ) Then 
      If fb_Global.mouse.y > (( c.y  ) Shl 3 ) Then 
        If fb_Global.mouse.x < ((( c.x + ( c.ct_len ) - 2 ) - 1 ) Shl 3 + 8 ) Then 
          If fb_Global.mouse.y < (( c.y  ) Shl 3 + 8 ) Then 
            If fb_Global.mouse.x > ((( c.x + ( c.ct_len ) - 2 ) - 1 ) Shl 3 ) Then
                If gmg( _state ) = s_rooms Then
                  new_room_init()
                  
                End If

              Return Not 0
                
            End If
          End If
        End If
      End If
    End If



End Function       


Sub do_ctrl ( _ctrl As _control_type )


  Dim As String msgtext, msgcaption
  Dim As Integer msgresult
  Dim As Integer clr = Color

  If ucase( _ctrl.Name ) = "NULL" Then Exit Sub

           
  If _ctrl.lm Or _ctrl.ad Then 
    show_sel_elements ( _ctrl, *_ctrl.e_sel )
    show_ctrl_elements _ctrl, *_ctrl.e_num
    If *_ctrl.e_sel <> 0 Then If *_ctrl.e_num = 0 Then *_ctrl.e_sel = 0
    
  End If
  
  show_sel_ctrl _ctrl 


  If _ctrl .lm Then



    If *_ctrl.e_num < 2 Then '' gray them out.. can't move around on one 
    
      Color 7
        Locate _ctrl .y + 1, _ctrl .x + ( _ctrl.ct_len ) - 2
        ? "<"
        
        Locate _ctrl .y + 1, _ctrl .x + ( _ctrl.ct_len ) + 2 + _ctrl.ct_odd
        ? ">"
  
      Color clr

    Else
      Locate _ctrl .y + 1, _ctrl .x + ( _ctrl.ct_len ) - 2
      ? "<"                                      
      
      Locate _ctrl .y + 1, _ctrl .x + ( _ctrl.ct_len ) + 2 + _ctrl.ct_odd
      ? ">"

    End If

    
    If ctrl_l_click ( _ctrl ) Then

      If _ctrl.d_timer = 0 Then

        *_ctrl.e_sel -= 1
        If *_ctrl.e_sel < 0 Then *_ctrl.e_sel = *_ctrl.e_num - 1
        
        _ctrl.d_timer = Timer + _ctrl.d_delay
        
      Else
      
        If Timer >= _ctrl.d_timer Then _ctrl.d_timer = 0

      End If

    ElseIf ctrl_r_click ( _ctrl ) Then 
    

      If _ctrl.d_timer = 0 Then
            
        *_ctrl.e_sel += 1
        If *_ctrl.e_sel >= *_ctrl.e_num Then *_ctrl.e_sel = 0
        
        _ctrl.d_timer = Timer + _ctrl.d_delay
        
      Else
      
        If Timer >= _ctrl.d_timer Then _ctrl.d_timer = 0

      End If

    Else
      _ctrl.d_timer = 0
      
    End If
       

  End If

  If _ctrl .ad Then

    If *_ctrl.e_num < 1 Then '' gray it out... can't delete nothing  
    

      Color 7
        Locate _ctrl .y + 2, _ctrl .x + ( _ctrl.ct_len ) - 2
        ? "X"
        
      Color clr
      
      Locate _ctrl .y + 2, _ctrl .x + ( _ctrl.ct_len ) + 2 + _ctrl.ct_odd
      ? "+"

    Else
      Locate _ctrl .y + 2, _ctrl .x + ( _ctrl.ct_len ) - 2
      ? "X" 
      
      Locate _ctrl .y + 2, _ctrl .x + ( _ctrl.ct_len ) + 2 + _ctrl.ct_odd
      ? "+"
      
    End If
           
           
    If ctrl_X_click ( _ctrl ) And *_ctrl.e_num > 0 Then
      
      hold_button( sc_leftbutton )

      *_ctrl.e_num -= 1 
      If *_ctrl.e_sel >= *_ctrl.e_num Then *_ctrl.e_sel -= 1
      If *_ctrl.e_sel < 0 Then *_ctrl.e_sel = 0
      If *_ctrl.e_num = -1 Then *_ctrl.e_num = 0        


    End If

                 
    If ctrl_plus_click( _ctrl ) Then

      hold_button( sc_leftbutton )
      
      *_ctrl.e_num += 1 



    End If

    If ctrl_plus_rclick( _ctrl ) Then

      hold_button( sc_rightbutton )
      
      *_ctrl.e_num += 1 
      _ctrl.insertFlag = -1
      
      fb_Global.mouse.b = 0
      '' haha...

    End If

    

  End If



    

End Sub




