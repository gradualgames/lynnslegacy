Option Explicit

#Include "..\headers\ll.bi"


Sub gMapEngine_BlitLayer( lyr As Integer, holder As Any Ptr = 0, flag As Integer = -1, rs_x As Integer = 0, rs_y As Integer = 0 )
  
  
  Dim As mat_int tile_put, on_tile, on_offset, optimization_matrix_1, optimization_matrix_2
  

'    on_tile.x   = llg( this_room ).cx  \  llg( map )->tileset->x
'    on_tile.y   = llg( this_room ).cy  \  llg( map )->tileset->y
'    on_offset.x = llg( this_room ).cx Mod llg( map )->tileset->x
'    on_offset.y = llg( this_room ).cy Mod llg( map )->tileset->y


    '' um.. ll uses 16x16...

    on_tile.x   = llg( this_room ).cx  Shr 4
    on_tile.y   = llg( this_room ).cy  Shr 4
    on_offset.x = llg( this_room ).cx And &hf
    on_offset.y = llg( this_room ).cy And &hf


      
  Dim As Integer _ 
    save_room_calcs = ( now_room().x * now_room().y ), _ 
    save_tile_calcs,                                                                                       _
    save_y_calcs,                                                                                          _
    tile_blit_x, tile_blit_y

  
  If rs_x = 0 Then
    rs_x = llg( sx )
    
  End If

  If rs_y = 0 Then
    rs_y = llg( sy )
    
  End If


  If holder <> 0 Then
  
    Dim sh As uShort Ptr
    sh = CPtr ( uShort Ptr, holder)
    
    sh[0] = rs_x * 8
    sh[1] = rs_y
    
  End If
  
  Dim As Integer aa, bb
  
  
  
  bb = ( rs_x + llg( map )->tileset->x )
  
'  optimization_matrix_1.x = ( now_room().x * llg( map )->tileset->x ) - 1
'  optimization_matrix_1.y = ( now_room().y * llg( map )->tileset->y ) - 1

  optimization_matrix_1.x = ( now_room().x Shl 4 ) - 1
  optimization_matrix_1.y = ( now_room().y Shl 4 ) - 1
  
  tile_put.y = on_tile.y * now_room().x
                         
  For tile_blit_y = 0 To ( rs_y + llg( map )->tileset->y ) - 1 Step llg( map )->tileset->y

    If tile_blit_y >= optimization_matrix_1.y Then Exit For
  
    tile_put.x = on_tile.x
    
    save_y_calcs = tile_blit_y - on_offset.y

    For tile_blit_x = 0 To bb - 1 Step llg( map )->tileset->x
      
      If tile_blit_x >= optimization_matrix_1.x Then Exit For

      save_tile_calcs = tile_put.y + tile_put.x

      If holder = 0 Then

        If save_tile_calcs <= save_room_calcs Then

          If ( now_room().layout[ lyr ][ save_tile_calcs ] <> 0 ) Then 

'            optimization_matrix_2.y = ( now_room().layout[lyr][save_tile_calcs] And &Hff ) 
            optimization_matrix_2.y = CPtr( uByte Ptr, Varptr( now_room().layout[lyr][save_tile_calcs] ) )[0]
            optimization_matrix_2.x = ( optimization_matrix_2.y Shl 7 ) + ( optimization_matrix_2.y Shl 1 )
            Put( tile_blit_x - on_offset.x, save_y_calcs ), @llg( map )->tileset->image[optimization_matrix_2.x], Trans


          End If
        
        Else
          
        End If

      Else
      
        If flag And  ( lyr = 0 Or  ( now_room().layout[lyr][save_tile_calcs] <> 0 ) ) Then Put holder, ( tile_blit_x - on_offset.x, tile_blit_y - on_offset.y ) , @llg( map )->tileset->image[  ( now_room().layout[ lyr ][ save_tile_calcs ] And 255 ) * llg( map )->tileset->arraysize ], Trans

      End If

      tile_put.x += 1

    Next

    tile_put.y +=  ( now_room().x ) 

  Next

    
End Sub





'Sub LLScreenFlip()
'
'  llg( a_page ) Xor= 1           
'  llg( v_page ) Xor= 1
'
'  ScreenSet llg( a_page ), llg( v_page )
'  llg( scrn_ptr ) = ScreenPtr
'  
'  ScreenLock
'    MemSet( llg( scrn_ptr ), 0, ( llg( sx ) * llg( sy ) ) )
'
'  ScreenUnlock
'
'
'End Sub
'
'
'Sub handle_refresh()
'
'  If llg( fps_lock ) = 0 Then
'    llg( fps_lock ) = Timer + 0.015625 '' 1 / 64
'    
'  End If
'  
'  If Timer > llg( fps_lock ) Then
'    llg( fps_hold ) = llg( fps ) Shl 6
'    If llg( fps_hold ) > llg( fps_top ) Then
'      llg( fps_top ) = llg( fps_hold )
'      
'    End If
'    
'    llg( fps ) = 0
'    llg( fps_lock ) = 0
'    
'  End If
'    
'  llg( fps ) += 1
'  
'  LLScreenFlip()
'
'End Sub
