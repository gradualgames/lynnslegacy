Option Explicit

#Include "..\headers\ll\headers.bi"



Sub redimension_room( arg As Integer = 0 )


  If llg( map )->rooms <> 0 Then
    
    Dim As Integer _ 
      new_x_size, _ 
      new_y_size
  

    ScreenSet 0, 0       

    Locate 40, 80
        ? "         (was " & now_room().x & ")"
    Locate 39, 80
    Input "New room X size: ", new_x_size


    Locate 43, 80
        ? "         (was " & now_room().y & ")"
    Locate 42, 80
    Input "New room Y size: ", new_y_size


    If new_x_size = 0 Then new_x_size = now_room().x
    If new_y_size = 0 Then new_y_size = now_room().y

    If new_x_size < 0 Then new_x_size = now_room().x
    If new_y_size < 0 Then new_y_size = now_room().y


    Dim As Integer _ 
      gank_x, _ 
      gank_y, _ 
      gank_size, _ 
      gank_layers, _ 
      gank_layer_2, _ 
      realloclayers, _
      old_gank_size


    gank_x = now_room().x
    gank_y = now_room().y
    old_gank_size = gank_x * ( gank_y + 1 )
    gank_size = new_x_size * ( new_y_size + 1 )

    If old_gank_size > 0 Then Redim ganked( 2, old_gank_size - 1 ) As Integer 


    For gank_layers = 0 To 2'(3 + llg( map )->room[ll_current_room].parallax) - 1

      For gank_layer_2 = 0 To old_gank_size - 1
        ganked(gank_layers, gank_layer_2) = now_room().layout[gank_layers][gank_layer_2]
        
      Next
      
    Next

    For realloclayers = 0 To 2

      d_alloc( now_room().manage_mem, now_room().layout[realloclayers] )
      now_room().layout[realloclayers] = CAllocate( Len( Integer ) * gank_size )

    Next


    now_room().x = new_x_size
    now_room().y = new_y_size
    

    Scope
    
      Dim As Integer _ 
        tilez
  
      Do
        Locate 45, 85: ? "                               "
        Locate 45, 85: ? "Fill tile"
        Locate 46, 87: ? "                               "
        Locate 46, 87: Input "(0-255) ", tilez
      
      Loop Until tilez > -1 And tilez < 256
  
  
  
      Dim As Integer _ 
        wlk_clr
  
      For wlk_clr = 0 To gank_size - 1
      
        *CPtr( uByte Ptr, @now_room().layout[gmg( layer )][wlk_clr] ) = tilez
        
      Next

    End Scope    

    
    Dim As Integer switchlayers,xput, yput 

    With now_room()

      If ( gank_x + gank_y > 0 ) Then 
  
        If gank_y > .y Then
  
          For switchlayers = 0 To 2
  
            If gank_x > .x Then
            
              For yput = 0 To .y * .x - .x Step .x
  
                For xput = 0 To .x - 1
                  .layout[switchlayers][yput + xput] = ganked( switchlayers, gank_x * ( yput \ .x ) + xput )
                
                Next
              
              Next
      
            Else
  
              For yput = 0 To .y * gank_x - gank_x Step gank_x
  
                For xput = 0 To gank_x - 1
                  .layout[switchlayers][.x * ( yput \ gank_x ) + xput] = ganked( switchlayers, yput + xput )
              
                Next
              
              Next
              
            End If
          
          Next
      
        Else
  
          For switchlayers = 0 To 2
  
            If gank_x > .x Then
            
              For yput = 0 To gank_y * .x - .x Step .x
  
                For xput = 0 To .x - 1
                  .layout[switchlayers][yput + xput] = ganked( switchlayers, gank_x * ( yput \ .x ) + xput )
                  
                Next
              
              Next
      
            Else
  
              For yput = 0 To gank_y * gank_x - gank_x Step gank_x
  
                For xput = 0 To gank_x - 1
                  .layout[switchlayers][.x * ( yput \ gank_x ) + xput] = ganked( switchlayers, yput + xput )
              
                Next
              
              Next
              
            End If
          
          Next
           
        End If
      
      End If

    End With

    ScreenSet 0, 1

    gmg( refresh ) = -1 

  End If      

  gmg( _state ) = s_null


End Sub



Sub gload_map( arg As Integer = 0 )


  Dim As list_type Ptr mappys
  Dim As Integer retty
  
  mappys = list_files( "data\map", "*.map" )
  
  
  retty = open_file_dialog( mappys, 3, 3 )
  If retty <> -1 Then
    map_Destroy( llg( map ) )

    llg( map ) = LLSystem_LoadMap( list_node_value( mappys, retty, "" ), -1 )

    
    new_map_init()
    
    Kill( "gmap.ini" )
    
    Dim As Integer _
      opn = FreeFile
      
    
    Open "gmap.ini" For Output As opn
    
      Print #opn, kfp( list_node_value( mappys, retty, "" ) )
      
    Close opn

    Palette Using fb_Global.display.pal
  
    gmg( refresh ) = -1
    
  End If

  gmg( _state ) = s_null
 
  
End Sub
    






Sub handle_rooms( arg As Integer = 0 )

  If fb_Global.mouse.w < gmg( wheel ).last_sel Then
    
    
    llg( this_room.i ) += Abs( fb_Global.mouse.w - gmg( wheel ).last_sel )

    If llg( this_room.i ) < llg( map )->rooms - 1 Then 
'      llg( this_room.i ) += 1
                            
    Else 
      llg( this_room.i ) = 0
      
    End If
    new_room_init()  
  

  ElseIf fb_Global.mouse.w > gmg( wheel ).last_sel Then


    llg( this_room.i ) -= Abs( fb_Global.mouse.w - gmg( wheel ).last_sel )
    If llg( this_room.i ) > 0 Then 
'      llg( this_room.i ) -= 1 
      
    Else 
      llg( this_room.i ) = llg( map )->rooms - 1
      
    End If
    new_room_init()  
    
  
  End If
  
  
  
  If gmg( room.last_num ) <> llg( map )->rooms Then
    '' the number of rooms changed
    
    If gmg( room.last_num ) > llg( map )->rooms Then
      '' there are less rooms now
  
      Dim As Integer _ 
        l_rot, _
        l_rot_2
        
        
      hackthoseentriesout:
      
      
    
      For l_rot = 0 To llg( map )->entries -1
        '' cycle out the selected room (it got deleted)
        
'        gmg( skip_a_frame )= -1
        
        If llg( map )->entry[l_rot].room = gmg( room.last_sel ) Then 
          ''rotate out that entry
          
          
          For l_rot_2 = l_rot To llg( map )->entries -2
            MemCpy ( @llg( map )->entry[l_rot_2], @llg( map )->entry[l_rot_2 + 1], Len ( map_entry_type ) )
            
          Next
          
          llg( map )->entries -= 1
    
          llg( map )->entry = Reallocate( llg( map )->entry, ( llg( map )->entries + 1 ) * Len ( map_entry_type ) )
          
          Goto hackthoseentriesout
          
        
        End If
        
        
      Next
  
  
      For l_rot = 0 To llg( map )->entries -1
        '' decrement any entry room after the one deleted
  
        If llg( map )->entry[l_rot].room > gmg( room.last_sel ) Then 
        
          llg( map )->entry[l_rot].room -= 1
          
        End If
        
      Next
  
      For l_rot = gmg( room.last_sel ) To gmg( room.last_num ) -2
        '' cycle out the selected room (it got deleted)
  
        MemCpy ( @llg( map )->room[l_rot], @llg( map )->room[l_rot + 1], Len ( room_type ) )
        
      Next
      
    
      llg( map )->room = Reallocate( llg( map )->room , ( llg( map )->rooms + 1 ) * Len ( room_type ) )
      
      If llg( this_room ).i = llg( map )->rooms Then
        If llg( map )->rooms <> 0 Then
          llg( this_room ).i = llg( map )->rooms - 1
          new_room_init()
          
        End If 
        
      End If
      
      
    Else
      '' there's one more room now
      
      

      llg( map )->room = Reallocate( llg( map )->room, ( llg( map )->rooms + 1 ) * Len ( room_type ) )
        
      MemSet( @llg( map )->room[llg( map )->rooms - 1], 0, Len ( room_type ) )
      make_null_room( @llg( map )->room[llg( map )->rooms - 1], no_alloc )


      new_room_init()
        

  
    End If  
  
    gmg( refresh ) = -1
  
    
  End If  
  
  
  If gmg( room.last_sel ) <> llg( this_room.i ) Then
    '' room changed

'    new_room_init()  
    
  End If
  
  

End Sub



Sub handle_entries( arg As Integer = 0 )

  Static As Double n_t


  gmg( current_box ) = @entry_box
  
  wheel_change( gmg( entr.sel ) )

  manage_array( @( llg( map )->entry ),             _ 
              llg( map )->manage_mem,               _
              Len( map_entry_type ),                _ 
              gmg( entr ).last_num,                 _
              *gmg( control )[gmg( _state )].e_num, _ 
              gmg( entr ).last_sel ,                _
              @handle_more_entry,                   _ 
              @handle_less_entry )

                                          
                                          
  If llg( map )->entries = 0 Then Exit Sub


  View Screen ( 0, 0 )-( gmg( map_area.x ) - 1, gmg( map_area.y ) - 1 ) 
  
    If llg( map )->entry[gmg( entr.sel )].room = llg( this_room.i ) Then
    
      If cursor_on_map() Then
      
        If ( fb_Global.mouse.b And sc_leftbutton ) Then
          llg( map )->entry[gmg( entr.sel )].x = ( ( llg( this_room.cx ) + fb_Global.mouse.x \ z_factor ) Shr 3 ) Shl 3
          llg( map )->entry[gmg( entr.sel )].y = ( ( llg( this_room.cy ) + fb_Global.mouse.y \ z_factor ) Shr 3 ) Shl 3
'            llg( map )->entry[gmg( entr.sel )].x = ( ( llg( this_room.cx ) + fb_Global.mouse.x \ z_factor ) ) - ( ( ( llg( this_room.cx ) + fb_Global.mouse.x \ z_factor ) ) And 7 ) 
'            llg( map )->entry[gmg( entr.sel )].y = ( ( llg( this_room.cy ) + fb_Global.mouse.y \ z_factor ) ) - ( ( ( llg( this_room.cy ) + fb_Global.mouse.y \ z_factor ) ) And 7 )
         
        End If
        
      End If
                   
    End If

  View Screen ( 0, 0 )-( llg( sx ) - 1, llg( sy ) - 1 ) 

  

  If n_t = 0 Then
  
    n_t = Timer + .2
    
  End If
  
  If Timer > n_t Then
    gmg( entry_flash ) = Not gmg( entry_flash )
    n_t = 0
              
  End If
    
  
  If (gmg( entr.last_sel ) <> gmg( entr.sel )) Or MultiKey ( sc_l ) Then 
    If ( llg( map )->entry[gmg( entr.sel )].x <> 0 ) Or ( llg( map )->entry[gmg( entr.sel )].y <> 0 ) Then
        '' align tele with map
        
      If llg( map )->entry[gmg( entr.sel )].room <> llg( this_room ).i Then
        llg( this_room ).i = llg( map )->entry[gmg( entr.sel )].room
        new_room_init()
        
      End If
      
      With llg( map )->entry[gmg( entr.sel )]
        align_gcam( .x, .y, 16, 16 ) 
      
      End With
        
      update_cam_g()                        
  
      gmg( refresh ) = -1
        
    End If  
  End If  


  If llg( map )->rooms = 0 Then
    gmg( _state ) = 12
  Else
    If now_room().x = 0 Then
      gmg( _state ) = 12
    Else
      If now_room().y = 0 Then 
        gmg( _state ) = 12
      End If
    End If
  End If


End Sub




Sub handle_macros( arg As Integer = 0 )

  Static As Integer walk_state

  Static As Integer _ 
    held          , _ 
    last_x        , _ 
    last_y


  If arg <> 0 Then
    walk_state Xor= 1
    Exit Sub
    
  End If 
  
    

  Dim As Integer _ 
    l_rot

  Dim As Integer blitytiles, blitxtiles

  Static As Integer _ 
    x_ref_buff,     _ 
    y_ref_buff,     _ 
    ref_lock,       _ 
    x_cam_buff,     _ 
    y_cam_buff,     _ 
    x_tilegrasp2,    _ 
    y_tilegrasp2



  

  Dim As Integer _ 
    m_xtile = ( fb_Global.mouse.x \ z_factor ) \ 16, _
    m_ytile = ( fb_Global.mouse.y \ z_factor ) \ 16, _ 
    m_xoff  = ( fb_Global.mouse.x \ z_factor ) Mod 16, _ 
    m_yoff  = ( fb_Global.mouse.y \ z_factor ) Mod 16
  
  
  gmg( current_box ) = @macro_box
  
  
  If ( m_xtile <> x_ref_buff ) Then 
      ref_lock = 0
  Else
    If ( m_ytile <> y_ref_buff ) Then
        ref_lock = 0
    Else
      If ( x_cam_buff <> llg( this_room.cx ) ) Then 
          ref_lock = 0
      Else
        If ( y_cam_buff <> llg( this_room.cy ) ) Then
            ref_lock = 0
            
        End If
      End If
    End If
  End If

  wheel_change( gmg( macr ).sel )

  If gmg( macr.last_num ) <> gmg( macros ) Then
    '' the number of teleports changed
    
    If gmg( macr.last_num ) > gmg( macros ) Then
      '' there are less teleports now
  
      For l_rot = gmg( macr.last_sel ) To gmg( macr.last_num ) -2
        '' cycle out the selected teleport (it got deleted)
      
        MemCpy ( @gmg( macro[l_rot][0] ), @gmg( macro[l_rot + 1][0] ), Len ( Integer ) * 36 )
        
      Next
      
      clean_Deallocate( gmg( macro )[gmg( macros ) - 1] )
      gmg( macro ) = Reallocate( gmg( macro ), Len( Integer Ptr ) * gmg( macros ) )
      
      
    Else
      '' there's one more now
    
      gmg( macro ) = Reallocate( gmg( macro ), Len( Integer Ptr ) * gmg( macros ) )
      gmg( macro )[gmg( macros ) - 1] = CAllocate( 36 * Len( Integer ) )
      
    End If  
  
    
  End If  




  If gmg( macros ) = 0 Then Exit Sub

    

  If walk_state <> 0 Then
    Scope
      Dim As Integer clr
        Locate 53, 48
        clr = Color
        Color 6
        ? "Walkables"
        Color clr
        
    End Scope
    
  End If
   


  If cursor_on_tiles Then 

    If fb_Global.mouse.b And sc_leftbutton Then
      
      walk_state = 0

  
      If sc_shift() Then
      
        x_tilegrasp2 = ( fb_Global.mouse.x - gmg( tile_loc.x ) ) \ 16
        y_tilegrasp2 = ( fb_Global.mouse.y - gmg( tile_loc.y ) ) \ 16

  
        If gmg( shifted ) Then
          
          gmg( blockshift ) = -1
    
          If gmg( tile_grasp ).x <= x_tilegrasp2 Then 
            gmg( smaller ).x = gmg( tile_grasp ).x 
            gmg( bigger ).x = x_tilegrasp2
    
          Else 
            gmg( smaller ).x = x_tilegrasp2
            gmg( bigger ).x = gmg( tile_grasp ).x
    
          End If
    
          If gmg( tile_grasp ).y <= y_tilegrasp2 Then 
            gmg( smaller ).y = gmg( tile_grasp ).y 
            gmg( bigger ).y = y_tilegrasp2
    
          Else 
            gmg( smaller ).y = y_tilegrasp2
            gmg( bigger ).y = gmg( tile_grasp ).y
    
          End If
    
          
          
        Else
      
          gmg( shifted ) = -1
            
          gmg( tile_grasp ).x = ( fb_Global.mouse.x - gmg( tile_loc.x ) ) \ 16
          gmg( tile_grasp ).y = ( fb_Global.mouse.y - gmg( tile_loc.y ) ) \ 16

          x_tilegrasp2 = gmg( tile_grasp ).x
          y_tilegrasp2 = gmg( tile_grasp ).y
    
        
      
        End If
      
      Else
        
        gmg( tile ) = get_selected_tile
        
        gmg( shifted ) = 0
        gmg( blockshift ) = 0       
      End If
      
      
    End If
   
  End If

          
  Dim As Integer mac_x, mac_y, blit_mac 
  
  mac_x = fb_Global.mouse.x - gmg( mac_loc ).x
  mac_y = fb_Global.mouse.y - gmg( mac_loc ).y


  
  If ( mac_x \ ( llg( map )->tileset->x \ 2 ) <> last_x ) Or ( mac_y \ ( llg( map )->tileset->y \ 2 ) <> last_y ) Then held = 0
  


  If (fb_Global.mouse.b And sc_leftbutton) Then
    If fb_Global.mouse.x > gmg( mac_loc ).x And fb_Global.mouse.y > gmg( mac_loc ).y And fb_Global.mouse.x < ( gmg( mac_loc ).x + 96 ) And fb_Global.mouse.y < ( gmg( mac_loc ).y + 96 ) Then
  
      If walk_state <> 0 Then
        If held = 0 Then
          held = -1
        
          Scope
            Dim As Integer x_quad, y_quad, x_t, y_t
              x_quad = mac_x \ ( llg( map )->tileset->x \ 2 )
              y_quad = mac_y \ ( llg( map )->tileset->y \ 2 )
              x_t = mac_x \ llg( map )->tileset->x 
              y_t = mac_y \ llg( map )->tileset->y
              
              
              
'              macros( gmg( macr.sel ), ( y_t * 6 ) + x_t  ) Xor= ( 2 ^ ( 15 - ( ( Abs( x_quad And 1 ) ) + ( Abs( y_quad And 1 ) * 2 ) ) ) )
              gmg( macro )[gmg( macr.sel )][( y_t * 6 ) + x_t] Xor= ( 2 ^ ( 15 - ( ( Abs( x_quad And 1 ) ) + ( Abs( y_quad And 1 ) * 2 ) ) ) )
              
          End Scope
          
        End If
          
      
      Else
    
    
      
        If gmg( macros ) > 0 Then
      
          If ref_lock = 0 Then
      
            If gmg( blockshift ) Then
      
              For blitytiles = gmg( smaller ).y To gmg( bigger ).y
    
                Dim As Integer tile_calc_y = ( ( mac_y \ 16 ) + ( blitytiles - gmg( smaller ).y ) )
    
            
                If ( tile_calc_y >= ( 6 ) ) Then Exit For
    
                For blitxtiles = gmg( smaller ).x To gmg( bigger ).x
                  
                  Dim As Integer tile_calc_x = ( ( mac_x \ 16 ) + ( blitxtiles - gmg( smaller ).x ) ), _ 
                                 tile_calc
                  
                  
                  If ( tile_calc_x >= ( 6 ) ) Then Exit For
                  
                  tile_calc = ( tile_calc_y * 6 ) + tile_calc_x
                  
                  gmg( macro )[gmg( macr.sel )][tile_calc] = ( blitytiles * 16 ) + blitxtiles
      
                Next
      
                
                
                
              Next
      
            Else
      
              gmg( macro )[gmg( macr.sel )][( ( mac_y \ 16 ) * 6 ) + ( mac_x \ 16 )] = gmg( tile )
      
            End If
      
            gmg( refresh ) = -1
          
            x_ref_buff = m_xtile
            y_ref_buff = m_ytile
            x_cam_buff = llg( this_room.cx )
            y_cam_buff = llg( this_room.cy )
      
            ref_lock = 1
      
          End If
    
        End If
      End If
    
    End If
  
  End If

  
  If (fb_Global.mouse.b And sc_leftbutton) And cursor_on_map Then


    Scope

      Dim As Integer _
        x_opt = ( fb_Global.mouse.x \ z_factor \ 16 ), _ 
        y_opt = ( fb_Global.mouse.y \ z_factor \ 16 ), _ 
        cx_opt = ( llg( this_room.cx ) \ 16 ), _ 
        cy_opt = ( llg( this_room.cy ) \ 16 )
  
    
      For blit_mac = 0 To 35
      
        croikey:
  
'        If macros( gmg( macr.sel ), blit_mac ) <> 0 Then 
        If gmg( macro )[gmg( macr.sel )][blit_mac] <> 0 Then 
        
          Dim As Integer _ 
            x_tile_to_blit = x_opt + cx_opt + ( blit_mac Mod 6 ), _ 
            y_tile_to_blit = ( y_opt + cy_opt + ( blit_mac \ 6 ) ), _
            tile_to_blit = y_tile_to_blit * ( now_room().x ) + x_tile_to_blit
            
            If y_tile_to_blit >= now_room().y Then 
              blit_mac += 1
              Goto croikey
              
            End If

            If x_tile_to_blit >= now_room().x Then 
              blit_mac += 1
              Goto croikey

            End If

        
          now_room().layout[gmg( layer )][tile_to_blit] = gmg( macro )[gmg( macr.sel )][blit_mac]

          
        End If
       
      Next
    
      gmg( refresh ) = -1
      
    End Scope
  
  End If



  

  last_x = mac_x \ ( llg( map )->tileset->x \ 2 )
  last_y = mac_y \ ( llg( map )->tileset->y \ 2 )
  


  get_selected_layer()
       
       
End Sub




Sub handle_walkable( arg As Integer = 0 )

      
  If llg( map )->rooms = 0 Then
    gmg( _state ) = 12
  Else
    If now_room().x = 0 Then
      gmg( _state ) = 12
    Else
      If now_room().y = 0 Then 
        gmg( _state ) = 12
      End If
    End If
  End If

  
  Static As Integer _ 
    held          , _ 
    last_x        , _ 
    last_y        , _
                    _
    line_chk, clck_chk

    Dim As Integer                                   _
      m_xoff8 = ( fb_Global.mouse.x \ z_factor ) Shr 3, _
      m_yoff8 = ( fb_Global.mouse.y \ z_factor ) Shr 3
      


  
  
  If ( m_xoff8 <> last_x ) Or ( m_yoff8 <> last_y ) Then held = 0

  If cursor_on_map Then

    If fb_Global.mouse.b And sc_leftbutton Then


      If Not held Then
        held = -1
        map_ToggleQuad( m_xoff8 + ( llg( this_room ).cx \ 8 ), m_yoff8 + ( llg( this_room ).cy \ 8 ) )
      
      Else
      
        
      End If
      
    Else
      held = 0         

    End If
    
  End If
  
  If fb_Global.mouse.b And sc_middlebutton Then

    If line_chk = 0 Then
      gmg( line_hold ) Xor= 1

      gmg( ln ).x = m_xoff8 + ( llg( this_room ).cx \ 8 )
      gmg( ln ).y = m_yoff8 + ( llg( this_room ).cy \ 8 ) 
      
      line_chk = -1
      
    End If
      
  Else
    line_chk = 0
    
  End If
  

  If gmg( line_hold ) <> 0 Then
    
    If fb_Global.mouse.b And sc_leftbutton Then
      If clck_chk = 0 Then
        toggle_walkable_line()
        clck_chk = -1
        gmg( line_hold ) Xor= 1
        
      Else
        clck_chk = 0
        
      End If
      
    Else
      clck_chk = 0
      
    End If
    
    
  
  
  End If



  last_x = m_xoff8
  last_y = m_yoff8



  Select Case gmg( layer )
    Case 0
      do_ctrl ( gmg( control )[s_layer_0] )

    Case 1
      do_ctrl ( gmg( control )[s_layer_1] )

    Case 2
      do_ctrl ( gmg( control )[s_layer_2] )
      
  End Select


  get_selected_layer()

  
End Sub


Sub handle_enemies( arg As Integer = 0 )

  Static As Double t


  If gmg( enemy_box_state ) = 0 Then
    gmg( current_box ) = @enemy_box
    
  ElseIf gmg( enemy_box_state ) = 1 Then  
    gmg( current_box ) = @enemy_spawn_box
    
  End If
  wheel_change( gmg( enem.sel ) )
  manage_array( @( now_room().enemy ),              _ 
              now_room().manage_mem,               _
              Len( char_type ),                     _ 
              gmg( enem ).last_num,                 _
              *gmg( control )[gmg( _state )].e_num, _ 
              gmg( enem ).last_sel ,                _
              @handle_neW_enemy,                    _ 
              @handle_less_enemy )
  

  If now_room().enemies = 0 Then Exit Sub
    
  If cursor_on_map() Then
    If ( fb_Global.mouse.b And sc_leftbutton ) Then
      If MultiKey( sc_lshift ) Or MultiKey( sc_rshift ) Then
        now_room().enemy[gmg( enem.sel )].coords.x = ( ( llg( this_room.cx ) + fb_Global.mouse.x \ z_factor ) )
        now_room().enemy[gmg( enem.sel )].coords.y = ( ( llg( this_room.cy ) + fb_Global.mouse.y \ z_factor ) )
       
      Else                                               
        now_room().enemy[gmg( enem.sel )].coords.x = ( ( llg( this_room.cx ) + fb_Global.mouse.x \ z_factor ) \ 8 ) * 8
        now_room().enemy[gmg( enem.sel )].coords.y = ( ( llg( this_room.cy ) + fb_Global.mouse.y \ z_factor ) \ 8 ) * 8

      End If
     
    End If

  End If

  If t = 0 Then
    t = Timer + .2
    
  End If

  If Timer > t Then

    gmg( enemy_flash ) = Not gmg( enemy_flash )
    t = 0
    
  End If


  If ( ( ( gmg( enem.last_sel ) <> gmg( enem.sel ) ) Or MultiKey ( sc_l ) ) And ( now_room().enemy[gmg( enem.sel )].coords.x <> 0 Or now_room().enemy[gmg( enem.sel )].coords.y <> 0 ) ) Then
  

    With now_room().enemy[gmg( enem.sel )]
      align_gcam( .coords.x, .coords.y, .perimeter.x, .perimeter.y )
      
    End With

    update_cam_g()                        

    gmg( refresh ) = -1
    
  End If  

  now_room().enemy[gmg( enem.sel )].x_origin = now_room().enemy[gmg( enem.sel )].coords.x
  now_room().enemy[gmg( enem.sel )].y_origin = now_room().enemy[gmg( enem.sel )].coords.y


  If llg( map )->rooms = 0 Then
    gmg( _state ) = 12
  Else
    If now_room().x = 0 Then
      gmg( _state ) = 12
    Else
      If now_room().y = 0 Then 
        gmg( _state ) = 12
      End If
    End If
  End If


End Sub



Sub handle_teleports( flg As Integer = 0 )


  Dim As Integer last_tele

  Static As Integer _ 
    prev_to_room, _ 
    prev_x, _ 
    prev_y, _ 
    room_lock

  If flg = 69 Then
    flg = gmg( tel_state )
    
    Exit Sub
    
  End If
  
  If flg <> 0 Then
    If gmg( tel_state ) <> 0 Then

      gmg( tel_state ) = 0
      llg( this_room.i ) = gmg( prev_room )
      last_tele = gmg( tele ).sel 
      new_room_init()
      gmg( tele ).sel = last_tele

      now_room().teleport[gmg( tele ).sel].to_room = prev_to_room      
      now_room().teleport[gmg( tele ).sel].dx = prev_x
      now_room().teleport[gmg( tele ).sel].dy = prev_y

      room_lock = 0
      
    End If
    
    Exit Sub
    
  End If
  

'  If gmg( tel_state ) = 2 Then
'
'    If llg( map )->room[gmg( prev_room )].teleports = 0 Then Exit Sub
'    
'  Else
  If gmg( tel_state ) <> 2 Then


    wheel_change( gmg( tele ).sel )
  
    manage_array( @( now_room().teleport ), _ 
                now_room().manage_mem,     _
                Len( teleport_type ),       _
                gmg( tele ).last_num,        _
                *gmg( control )[gmg( _state )].e_num,    _ 
                gmg( tele ).last_sel )
  
  

    If llg( map )->rooms = 0 Then
      gmg( _state ) = 12

    Else
      If now_room().x = 0 Then
        gmg( _state ) = 12

      Else
        If now_room().y = 0 Then 
          gmg( _state ) = 12

        End If
      End If
    End If

    If now_room().teleports = 0 Then Exit Sub

  End If

  gmg( current_box ) = @teleport_box


  If gmg( tel_state ) > 1 Then

    If MultiKey( sc_enter ) And ( gmg( hotkey ) <> 0 ) Then
      '' hit enter
    
      gmg( tel_state ) += 1
      
      hold_key( sc_enter )
      
    End If

  Else
  
    If now_room().teleports > 0 Then 
  
    
      If MultiKey( sc_enter ) And ( gmg( hotkey ) <> 0 ) Then
        '' hit enter
      
        gmg( tel_state ) += 1
        
        hold_key( sc_enter )
        
      End If
  
    End If                
    
  End If

  If gmg( tel_state ) = 0 Then


    If cursor_on_map Then
      If ( fb_Global.mouse.b And sc_leftbutton ) Then
        If Not MultiKey ( sc_control ) Then
           
           now_room().teleport[gmg( tele ).sel].x = llg( this_room.cx ) + fb_Global.mouse.x \ z_factor
           now_room().teleport[gmg( tele ).sel].y = llg( this_room.cy ) + fb_Global.mouse.y \ z_factor
           
        End If
      End If
    End If
  
    If ( sc_shift() ) Then
      timedmodify now_room().teleport[gmg( tele ).sel].x, now_room().teleport[gmg( tele ).sel].y

      If Not ( fb_Global.mouse.b And sc_leftbutton ) Then SetMouse( now_room().teleport[gmg( tele ).sel].x - ( llg( this_room.cx ) )) * z_factor, ( now_room().teleport[gmg( tele ).sel].y - ( llg( this_room.cy ) )) * z_factor 
  
    End If
  


    If cursor_on_map Then
      If ( fb_Global.mouse.b And sc_leftbutton ) Then
        If MultiKey ( sc_control ) Then 
           
          now_room().teleport[gmg( tele ).sel].w = llg( this_room.cx ) + fb_Global.mouse.x \ z_factor - now_room().teleport[gmg( tele ).sel].x
          now_room().teleport[gmg( tele ).sel].h = llg( this_room.cy ) + fb_Global.mouse.y \ z_factor - now_room().teleport[gmg( tele ).sel].y
            
           
        End If
        
      Else

        If MultiKey ( sc_control ) Then
          timedmodify now_room().teleport[gmg( tele ).sel].w, now_room().teleport[gmg( tele ).sel].h
  
          With now_room().teleport[gmg( tele ).sel]
            
            SetMouse( ( ( .x - llg( this_room.cx ) ) + .w ) * z_factor, ( ( .y - llg( this_room.cy ) ) + .h ) * z_factor )
          
          End With
          
        End If
      
      End If
    End If

  ElseIf gmg( tel_state ) = 1 Then


    

    Do
    
      ScreenSet 0, 0
      Locate 68, 71
      Input "",  prev_to_room


    Loop Until ( ( prev_to_room > -1 ) And ( prev_to_room < llg( map )->rooms ) ) Or now_room().teleport[gmg( tele ).sel].to_map <> ""
    
    Scope
      Dim As Integer bla = prev_to_room
      prev_to_room = now_room().teleport[gmg( tele ).sel].to_room
      now_room().teleport[gmg( tele ).sel].to_room  = bla
      
    End Scope 
      
    
    prev_x = now_room().teleport[gmg( tele ).sel].dx
    prev_y = now_room().teleport[gmg( tele ).sel].dy



    ScreenSet 0,1


  ElseIf gmg( tel_state ) = 2 Then 

    If room_lock  = 0 Then     

      If now_room().teleport[gmg( tele ).sel].to_map = "" Then 

    
        gmg( prev_room ) = llg( this_room.i )
        llg( this_room.i ) = now_room().teleport[gmg( tele ).sel].to_room     

'        quick_text( gmg( tele ).sel )        
        last_tele = gmg( tele ).sel
        new_room_init()
        gmg( tele ).sel = last_tele


        set_ctrl gmg( control )[s_teleports], , , , , , @llg( map )->room[gmg( prev_room )].teleports
 
        With llg( map )->room[gmg( prev_room )].teleport[gmg( tele ).sel]
        
          If ( .dx = 0 ) And ( .dy = 0 ) Then
  
            .dx = gmg( grid_mat.x ) Shl 3
            .dy = gmg( grid_mat.y ) Shl 3
  
            SetMouse gmg( grid_mat.x ) Shl 3, gmg( grid_mat.y ) Shl 3
          
          Else
          
            Dim As Integer _
              zoom_to_x = ( .dx ) Shr 4, _
              zoom_to_y = ( .dy ) Shr 4
            
            llg( this_room.cx ) = ( zoom_to_x - ( 12 \ z_factor )) Shl 4
            llg( this_room.cy ) = ( zoom_to_y - ( 10 \ z_factor )) Shl 4
        
          
          End If
          
        End With

        room_lock = -1

      Else
      
        gmg( tel_state ) = 0
        
      End If


      gmg( refresh ) = -1
      
    End If
    

    If cursor_on_map Then

      If ( fb_Global.mouse.b And sc_leftbutton ) Then
        
        With llg( map )->room[gmg( prev_room )].teleport[gmg( tele ).sel]
        
          .dx = ( ( llg( this_room.cx ) + fb_Global.mouse.x \ z_factor ) Shr 3 ) Shl 3
          .dy = ( ( llg( this_room.cy ) + fb_Global.mouse.y \ z_factor ) Shr 3 ) Shl 3
        
        End With
           
      End If

    End If

    If ( sc_shift() ) Then
      
      With llg( map )->room[gmg( prev_room )].teleport[gmg( tele ).sel]

        timedmodify .dx, .dy
  
        If Not (fb_Global.mouse.b And sc_leftbutton ) Then 
          SetMouse ( .dx - ( llg( this_room.cx ) )) * z_factor, ( .dy - ( llg( this_room.cy ) )) * z_factor 
          
        End If
        
      End With
  
    End If
  
  
  ElseIf gmg( tel_state ) = 3 Then 
    llg( this_room.i ) = gmg( prev_room )
 
    last_tele = gmg( tele ).sel
    new_room_init()
    gmg( tele ).sel = last_tele

    gmg( tel_state ) = 0
    room_lock = 0
    
    With now_room().teleport[gmg( tele ).sel]
      align_gcam( .x, .y, .w, .h )
      
    End With

    update_cam_g()                        
    gmg( refresh ) = -1
      
  End If


  If ((gmg( tele ).last_sel <> gmg( tele ).sel) Or MultiKey ( sc_l )) And Not ( now_room().teleport[gmg( tele ).sel].x = 0 And now_room().teleport[gmg( tele ).sel].y = 0 )  Then 

    With now_room().teleport[gmg( tele ).sel]
      align_gcam( .x, .y, .w, .h )
      
    End With

    update_cam_g()                        

    gmg( refresh ) = -1

  End If
       

       
End Sub


Sub handle_ice( arg As Integer = 0 )

  
  Static As Integer _ 
    held          , _ 
    last_x        , _ 
    last_y

    Dim As Integer                                    _
      m_xtile = ( gmg( mouse.x ) \ z_factor ) Shr 4, _
      m_ytile = ( gmg( mouse.y ) \ z_factor ) Shr 4
      
      
   
  
  If ( m_xtile <> last_x ) Then 
    held = 0
  Else
    If ( m_ytile <> last_y ) Then 
      held = 0
      
    End If
    
  End If


  If cursor_on_map Then

    If fb_Global.mouse.b And sc_leftbutton Then


      If Not held Then
        held = -1
        
        now_room().layout[0][( ( ( llg( this_room.cy ) Shr 4 ) + m_ytile  ) * now_room().x  ) + m_xtile + ( llg( this_room.cx ) Shr 4  )] Xor= tile_ice
        
      End If
      
    Else
      held = 0         

    End If
    
  End If




  last_x = m_xtile
  last_y = m_ytile


      
  If llg( map )->rooms = 0 Then
    gmg( _state ) = 12
  Else
    If now_room().x = 0 Then
      gmg( _state ) = 12
    Else
      If now_room().y = 0 Then 
        gmg( _state ) = 12
      End If
    End If
  End If


  
End Sub


Sub handle_save ( arg As Integer = 0 )

  Dim As String cover
  Dim As Integer f
  
  Static As Integer last_state
  
  If last_state = 0 Then
    last_state = gmg( state ).last_sel
    
  End If
  
  If arg <> 0 Then 
    
    If arg = 69 Then
'      If Dir( llg( map )->filename ) <> "" Then
        f = Len( llg( map )->filename )
        
        cover = Left( llg( map )->filename, f - 4 ) & "_saved.map"
'        cover =  cover & "_.map"
        
        f = FreeFile
        
        Open cover For Binary As #f
        Close

'        cover = llg( map )->filename
        save_mapV( cover, llg( map ) )
        
        Exit Sub
        
'      End If
    Else

      If Dir( llg( map )->filename ) <> "" Then
        cover = llg( map )->filename
        Goto hiddenjump
        
      End If
    End If

  End If
  
  
  Locate 68,48
  ScreenSet 0, 0

    Cls
    ? "Leave blank to save as current name"
    Input "Save map as: "; cover
    If cover = "" Then 
      'gmg( _state ) = s_null
      'Exit Sub
      cover = kfp( llg( map )->filename )
      
    End If
    If Instr( cover, ".map" ) = 0 Then cover += ".map"
    cover = "data\map\" & cover
    
    hiddenjump:
    save_mapV( cover, llg( map ) )
    
    If arg = 69 Then Exit Sub
    
    llg( map )->filename = cover
    

    
    Kill( "gmap.ini" )
    
    Dim As Integer _
      opn = FreeFile
      
    
    Open "gmap.ini" For Output As opn
    
      Print #opn, kfp( cover )
      
    Close opn

  
  Palette Using fb_Global.display.pal

  gmg( _state ) = last_state
  last_state = 0
  

End Sub



Sub handle_layer( arg As Integer = 0 )




  Static As Integer _ 
    x_ref_buff,     _ 
    y_ref_buff,     _ 
    ref_lock,       _ 
    x_cam_buff,     _ 
    y_cam_buff,     _ 
    x_tilegrasp2,    _ 
    y_tilegrasp2


  Select Case gmg( _state )
    Case s_layer_0
      do_ctrl ( gmg( control )[s_layer_0] )
      If gmg( layer ) <> 0 Then
        gmg( layer ) = 0
        gmg( refresh ) = -1
        
      End If

    Case s_layer_1
      do_ctrl ( gmg( control )[s_layer_1] )
      If gmg( layer ) <> 1 Then
        gmg( layer ) = 1
        gmg( refresh ) = -1
        
      End If

    Case s_layer_2
      do_ctrl ( gmg( control )[s_layer_2] )
      If gmg( layer ) <> 2 Then
        gmg( layer ) = 2
        gmg( refresh ) = -1
        
      End If
      
  End Select
  
  


  Dim As Integer _ 
    m_xtile = ( fb_Global.mouse.x \ z_factor ) \ 16, _
    m_ytile = ( fb_Global.mouse.y \ z_factor ) \ 16, _ 
    m_xoff  = ( fb_Global.mouse.x \ z_factor ) Mod 16, _ 
    m_yoff  = ( fb_Global.mouse.y \ z_factor ) Mod 16



  If gmg( shifted ) Then

    If gmg( blockshift ) Then 
      Line( ( ( gmg( smaller ).x ) * 16 ) +      gmg( tile_loc.x ), ( ( gmg( smaller ).y ) * 16 ) +      gmg( tile_loc.y ) )-_
          ( ( ( gmg( bigger ).x )  * 16 ) + 15 + gmg( tile_loc.x ), ( ( gmg( bigger ).y )  * 16 ) + 15 + gmg( tile_loc.y ) ), 15, b

    Else
      Line( ( ( gmg( tile_grasp ).x ) * 16 ) +      gmg( tile_loc.x ), ( ( gmg( tile_grasp ).y ) * 16 ) +      gmg( tile_loc.y ) )-_
          ( ( ( gmg( tile_grasp ).x ) * 16 ) + 15 + gmg( tile_loc.x ), ( ( gmg( tile_grasp ).y ) * 16 ) + 15 + gmg( tile_loc.y ) ), 15, b

    End If

  Else
    show_selected_tile

  End If

  '' short-circuit or!
  If ( m_xtile <> x_ref_buff ) Then 
      ref_lock = 0
  Else
    If ( m_ytile <> y_ref_buff ) Then
        ref_lock = 0
    Else
      If ( x_cam_buff <> llg( this_room.cx ) ) Then 
          ref_lock = 0
      Else
        If ( y_cam_buff <> llg( this_room.cy ) ) Then
            ref_lock = 0
            
        End If
      End If
    End If
  End If
    
  
  
  Dim As Integer blitytiles, blitxtiles

  If cursor_on_tiles Then 

    If fb_Global.mouse.b And sc_leftbutton Then

  
      If sc_shift() Then
      
        x_tilegrasp2 = ( fb_Global.mouse.x - gmg( tile_loc.x ) ) \ 16
        y_tilegrasp2 = ( fb_Global.mouse.y - gmg( tile_loc.y ) ) \ 16

  
        If gmg( shifted ) Then
          
          gmg( blockshift ) = -1
    
          If gmg( tile_grasp ).x <= x_tilegrasp2 Then 
            gmg( smaller ).x = gmg( tile_grasp ).x 
            gmg( bigger ).x = x_tilegrasp2
    
          Else 
            gmg( smaller ).x = x_tilegrasp2
            gmg( bigger ).x = gmg( tile_grasp ).x
    
          End If
    
          If gmg( tile_grasp ).y <= y_tilegrasp2 Then 
            gmg( smaller ).y = gmg( tile_grasp ).y 
            gmg( bigger ).y = y_tilegrasp2
    
          Else 
            gmg( smaller ).y = y_tilegrasp2
            gmg( bigger ).y = gmg( tile_grasp ).y
    
          End If
    
          
          
        Else
      
          gmg( shifted ) = -1
            
          gmg( tile_grasp ).x = ( fb_Global.mouse.x - gmg( tile_loc.x ) ) \ 16
          gmg( tile_grasp ).y = ( fb_Global.mouse.y - gmg( tile_loc.y ) ) \ 16

          x_tilegrasp2 = gmg( tile_grasp ).x
          y_tilegrasp2 = gmg( tile_grasp ).y
    
        
      
        End If
      
      Else
        
        gmg( tile ) = get_selected_tile
        
        gmg( shifted ) = 0
        gmg( blockshift ) = 0       
      End If
      
      
    End If
   
  End If
  
  If llg( map )->rooms = 0 Then Exit Sub
  

  If cursor_on_map And (fb_Global.mouse.b And sc_leftbutton) Then


    If ref_lock = 0 Then

      Dim As Integer _
      y_opt = ( llg( this_room.cy ) \ llg( map )->tileset->y ), _
      x_opt = ( llg( this_room.cx ) \ llg( map )->tileset->x ) 

      Dim As Integer tile_calc_x, tile_calc_y, tile_calc

      If gmg( blockshift ) Then

        For blitytiles = gmg( smaller ).y To gmg( bigger ).y
      
          For blitxtiles = gmg( smaller ).x To gmg( bigger ).x
            
            tile_calc_x = ( ( m_xtile + x_opt ) + ( blitxtiles - gmg( smaller ).x ) )
            tile_calc_y = ( ( m_ytile + y_opt ) + ( blitytiles - gmg( smaller ).y ) )
            
            If ( tile_calc_x >= ( now_room().x ) ) Then Exit For
            
            tile_calc = ( tile_calc_y * now_room().x ) + tile_calc_x
            
            now_room().layout[gmg( layer )][tile_calc] = ( blitytiles * 16 ) + blitxtiles

          Next

          If ( tile_calc_y >= ( now_room().y ) ) Then Exit For
          
          
          
        Next

      Else
        
        now_room().layout[gmg( layer )] [((m_ytile + ( llg( this_room.cy ) \ llg( map )->tileset->y)) * now_room().x) + (m_xtile + ( llg( this_room.cx ) \ llg( map )->tileset->x))] = gmg( tile )

      End If

      gmg( refresh ) = -1
    
      x_ref_buff = m_xtile
      y_ref_buff = m_ytile
      x_cam_buff = llg( this_room.cx )
      y_cam_buff = llg( this_room.cy )

      ref_lock = 1

    End If

  End If



End Sub


Sub handle_parallax( arg As Integer = 0 )

  Dim As Integer ah

  now_room().parallax Xor = 1
  hold_button( sc_leftbutton )

  gmg( _state ) = s_null
  

End Sub

Sub handle_zoom( arg As Integer = 0 )

  Dim As Integer ah

  gmg( zooming ) = Not gmg( zooming )
  hold_button( sc_leftbutton )

  gmg( refresh ) = -1
  gmg( _state ) = s_null

    
End Sub

Sub handle_walk_grid( arg As Integer = 0 )

  Dim As Integer ah

  gmg( w_grid ) Xor = 1
  hold_button( sc_leftbutton )

  gmg( _state ) = s_null

  
End Sub


Sub handle_grid( arg As Integer = 0 )

  Dim As Integer ah

  gmg( grid ) Xor = 1
  hold_button( sc_leftbutton )

  gmg( _state ) = s_null

  
End Sub

Sub handle_solo( arg As Integer = 0 )
  
  Dim As Integer ah

  gmg( solo ) = Not gmg( solo )
  hold_button( sc_leftbutton )

  gmg( refresh ) = -1
  gmg( _state ) = s_null

  
End Sub




Sub handle_flood_fill( arg As Integer = 0 )      

  Redim As Integer indices_checked( 0, 0 ) 


  If cursor_on_tiles Then 

    If fb_Global.mouse.b And sc_leftbutton Then

      gmg( tile ) = get_selected_tile()

                                
    End If
   
  End If
  
  show_selected_tile()

  If cursor_on_map() Then 

    If fb_Global.mouse.b And sc_leftbutton Then


        Dim As mat_int tile_calc, s
        

        s.x = ( fb_Global.mouse.x \ z_factor ) \ 16
        s.y = ( fb_Global.mouse.y \ z_factor ) \ 16
  
        tile_calc.x = s.y + ( ( llg( this_room.cx ) ) \ 16 )
        tile_calc.y = s.y + ( ( llg( this_room.cy ) ) \ 16 )
                             
  
        With now_room()
  
          Redim indices_checked( .x, .y )
          
          gmg( start_color ) = .layout[gmg( layer )][tile_calc.y * .x + tile_calc.x]
          
        End With
        
        flood_fill( tile_calc.x, tile_calc.y, gmg( tile ), indices_checked() )
        
        gmg( refresh ) = -1
        
    End If
    
  End If
  

  Select Case gmg( layer )
    Case 0
      do_ctrl ( gmg( control )[s_layer_0] )

    Case 1
      do_ctrl ( gmg( control )[s_layer_1] )

    Case 2
      do_ctrl ( gmg( control )[s_layer_2] )
      
  End Select

  
  If fb_Global.mouse.x <> -1 Then
    get_selected_layer()

  End If
       
       
End Sub


Sub handle_fill( arg As Integer = 0 )

  Dim As Integer wlk_clr

    With now_room()

      For wlk_clr = 0 To ( ( ( .x ) * ( .y + 1 ) ) + 1 ) - 1
      
        *CPtr( uByte Ptr, @.layout[gmg( layer )][wlk_clr] ) = gmg( tile )
        
        
      Next
      
    End With
    
    
    gmg( _state ) = s_null
    gmg( refresh ) = -1
       
       
End Sub


Sub handle_quit( arg As Integer = 0 )
  
'  engine_end()
  
End Sub



Sub handle_sequences( arg As Integer = 0 )


  
  
  gmg( current_box ) = @sequence_box
  wheel_change( gmg( seq ).sel )


  If gmg( seq ).sel <> gmg( seq ).last_sel Then
    gmg( seq_ents ).sel = 0
    gmg( seq_ents ).last_sel = 0
  
    gmg( ent_commands ).sel = 0
    gmg( ent_commands ).last_sel = 0

  End If

  
  Dim As Any Ptr Ptr transfer 
  
  







  gMap_Set_seq_ptr()
  Select Case gmg( seq_ptr )
    Case now_room().seq
      transfer = @now_room().seq

    Case llg( map )->entry[gmg( entr ).sel].seq
      transfer = @llg( map )->entry[gmg( entr ).sel].seq
          
    Case now_room().enemy[gmg( enem ).sel].seq
      transfer = @now_room().enemy[gmg( enem ).sel].seq
      
  End Select
  
  If transfer = 0 Then Exit Sub
  
  manage_array( transfer,                                 _ 
                llg( map )->manage_mem,                   _
                Len( sequence_type ),                     _
                gmg( seq ).last_num,                      _
                total_control_elements( gmg( _state ) ),  _ 
                gmg( seq ).last_sel,                      _
                @allocate_sequence_nodes )

  
                

End Sub



Sub handle_sequence_entities( arg As Integer = 0 )

  dim as integer res
  gMap_SeqNum( res )
  if res = 0 then exit sub

  
  gmg( current_box ) = @entity_box
  wheel_change( gmg( seq_ents ).sel )
  
  manage_array( @( selected_sequence().ent_code ), _ 
                llg( map )->manage_mem,            _
                Len( char_type Ptr ),              _
                gmg( seq_ents ).last_num,          _
                selected_sequence().ents,          _ 
                gmg( seq_ents ).last_sel )

  manage_array( @( selected_sequence().ent ), _ 
                llg( map )->manage_mem,       _
                Len( Integer ),               _
                gmg( seq_ents ).last_num,     _
                selected_sequence().ents,     _ 
                gmg( seq_ents ).last_sel )
  

End Sub


Sub handle_sequence_commands( arg As Integer = 0 )

  dim as integer res
  gMap_SeqNum( res )
  if res = 0 then exit sub
  
  If gmg( ent_commands ).sel <> gmg( ent_commands ).last_sel Then
    gmg( blocks ).sel = 0
    gmg( blocks ).last_sel = 0
    
  End If
  
  If gmg( blocks ).sel >= gmg( blocks ).last_num Then
    gmg( blocks ).sel = 0
    gmg( blocks ).last_sel = 0
    
  End If
    
  
  gmg( current_box ) = @command_box
  wheel_change( gmg( ent_commands ).sel )

  manage_array( @( selected_sequence().Command ), _ 
                llg( map )->manage_mem,           _
                Len( command_type ),              _
                gmg( ent_commands ).last_num,     _
                selected_sequence().commands,     _ 
                gmg( ent_commands ).last_sel,     _
                @allocate_command_blocks )

End Sub



Sub handle_sequence_command_blocks( arg As Integer = 0 )

  dim as integer res
  gMap_SeqNum( res )
  if res = 0 then exit sub
  
  gmg( current_box ) = gmg( block_boxes )[gmg( block_state )]
  wheel_change( gmg( blocks ).sel )

  manage_array( @( selected_command().ent ), _ 
                llg( map )->manage_mem,      _
                Len( command_data ),         _
                gmg( blocks ).last_num,      _
                selected_command().ents,     _ 
                gmg( blocks ).last_sel )


End Sub



Sub handle_parallax_image( arg As Integer = 0 )
  

  Dim As Integer ene_ver, re
  
  Dim As list_type Ptr map_files
  
  
  map_files = list_files( "data\pictures", "*.spr" )

  re = open_file_dialog( map_files )
  
  If re <> -1 Then
  
    now_room().para_img = LLSystem_ImageDeref( LLSystem_ImageDerefName( list_node_value( map_files, re, "" ) ) )
    now_room().parallax = 1
    hold_button( sc_leftbutton )
  
  Else

    now_room().parallax = 0
  
  End If
  
  list_Destroy( map_files, list_strlist )
  
  gmg( _state ) = s_null


End Sub



Sub handle_tileset_load( arg As Integer = 0 )


  Dim As list_type Ptr tiles
  Dim As Integer retty
  
  tiles = list_files( "data\pictures\tiles", "*.spr" )
  
  
  retty = open_file_dialog( tiles, 3, 3 )
  If retty <> -1 Then
    
    llg( map )->tileset = LLSystem_ImageDeref( LLSystem_ImageDerefName( list_node_value( tiles, retty, "" ) ) )
    
    gmg( refresh ) = -1
    
  End If

  gmg( _state ) = s_null
 
  
End Sub
