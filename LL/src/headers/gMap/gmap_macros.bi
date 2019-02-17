#Define gmg(x) gmap_global.##x


#Define setup_bounds(y, x, s)                      _
                                                   _
  Locate y, x                                     :_
  ?  s                                            :_
                                                  :_
  Dim As mat_int tp_lf, bt_rt                     :_
    tp_lf = uplf_box_bound( y, x + 2 )            :_
    bt_rt = btrt_box_bound( y, x + Len( s ) - 1 ) 


#Define click_bounds(bndd)                               _
                                                      _
    If fb_Global.mouse.x > tp_lf.x Then                 :_
      If fb_Global.mouse.x < bt_rt.x Then               :_
        If fb_Global.mouse.y > tp_lf.y Then             :_
          If fb_Global.mouse.y < bt_rt.y Then           :_
            If fb_Global.mouse.b And sc_leftbutton Then :_
                                                     :_
              bndd                                    _
                                                     :_
            End If                                   :_
          End If                                     :_
        End If                                       :_
      End If                                         :_
    End If






#Define on_control(ctrr)                                                                                 _
                                                                                                      _
  ( fb_Global.mouse.x > ( gmg( control )[ctrr].real_x - 8 ) ) And                                           _
  ( fb_Global.mouse.y > ( gmg( control )[ctrr].real_y - 8 ) ) And                                           _
  ( fb_Global.mouse.x < ( ( gmg( control )[ctrr].real_x - 8 ) + Len( gmg( control )[ctrr].Name ) Shl 3 ) ) And _
  ( fb_Global.mouse.y < ( gmg( control )[ctrr].real_y ) ) 



#Define total_control_elements(x) *gmg( control )[x].e_num
#Define selected_control_element(x) *gmg( control )[x].e_sel


'#Define selected_sequence() active_sequence_address()[selected_control_element( s_sequence )]
#Define selected_sequence() gmg( seq_ptr )[gmg( seq ).sel]

#Define selected_command() selected_sequence().Command[gmg( ent_commands ).sel]

#Define selected_command_block() selected_command().ent[gmg( blocks ).sel]



#macro align_gcam(xx,yy,w,h)                                 
                                                              
  llg( this_room.cx ) = ( xx )                                
  llg( this_room.cy ) = ( yy )                                
                                                              
  llg( this_room.cx ) -= gmg( area_reflect.x ) Shr 1          
  llg( this_room.cy ) -= gmg( area_reflect.y ) Shr 1          
                                                              
  llg( this_room.cx ) += ( ( w ) Shr 1 )                      
  llg( this_room.cy ) += ( ( h ) Shr 1 )

  if ( llg( this_room.cx ) and 15 ) then
    llg( this_room.cx ) -= ( llg( this_room.cx ) and 15 )
    
  end if

  if ( llg( this_room.cy ) and 15 ) then
    llg( this_room.cy ) -= ( llg( this_room.cy ) and 15 )
    
  end if
  
#endmacro








#Define sc_shift() ( MultiKey( sc_rshift ) Or MultiKey( sc_lshift ) )

#Define z_factor iif( gmg( zooming ), 2, 1 )'-( gmg( zooming ) - 1 )



#Define active_state() gmg( state_addy )[gmg( _state )]
  
    
  
#Define gMap_Set_seq_ptr()                                                                          _
                                                                                                    _
Select Case gmg( _state )                                                                          :_
                                                                                                   :_
  Case s_enemies                                                                                   :_
    gmg( ent_ptr ) = Varptr( now_room().enemy[gmg( enem ).sel].seq_here )                          :_
    gmg( seq_ptr ) = now_room().enemy[gmg( enem ).sel].seq                                         :_
                                                                                                   :_
  Case s_entries                                                                                   :_
    gmg( ent_ptr ) = Varptr( llg( map )->entry[gmg( entr ).sel].seq_here )                         :_
    gmg( seq_ptr ) = llg( map )->entry[gmg( entr ).sel].seq                                        :_
                                                                                                   :_
  Case s_sequence_entities, s_sequence_commands, s_sequence_command_blocks, s_sequence, s_save_map :_
                                                                                                   :_
  Case Else                                                                                        :_
    gmg( ent_ptr ) = Varptr( now_room().seq_here )                                                 :_
    gmg( seq_ptr ) = now_room().seq                                                                :_
                                                                                                   :_
End Select

#macro gMap_SeqNum( res__ )                                                                        
                                                                                                   
  Select Case gmg( seq_ptr )                                                                          
                                                                                                     
    Case now_room().enemy[gmg( enem ).sel].seq 
      res__ = now_room().enemy[gmg( enem ).sel].seq_here
                                                                                                     
    Case llg( map )->entry[gmg( entr ).sel].seq 
      res__ = llg( map )->entry[gmg( entr ).sel].seq_here
                                                                                                     
    Case now_room().seq 
      res__ = now_room().seq_here 
                                                                                                     
  End Select
    
#endmacro





