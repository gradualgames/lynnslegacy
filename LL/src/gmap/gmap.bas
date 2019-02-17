Option Explicit

#Include "..\headers\ll\headers.bi"
'#Include "..\generic\fb_global.bi"


ChDir ExePath
Screen 19, , 2', 1



Randomize Timer

On Error Goto heh
    
Dim Shared As ll_system ll_global
Dim Shared As gmap_system gmap_global


fb_StartGlobal()

  LLSystem_CachePictureFiles( "data\pictures" )
  LLSystem_CacheObjectFiles( "data\object" )
  

  gmap_init() 

  Do


    gmap_history()
    gmap_input()


    If active_state() <> 0 Then
      active_state()() 
                  '\/
    End If

    
    
    gmap_gfx()

    
    If fb_MouseOffScreen() Then
    
      Do

        Sleep 10

        fb_GetMouse()   
        fb_GetKey()   

        If fb_windowkill() Then 
          Exit Do
          
        End If
        
      Loop While fb_Global.mouse.x < 0

    End If  
    
    Sleep 3
    
    handle_fps()
    fb_ScreenRefresh()
    
  Loop Until ( MultiKey ( sc_escape ) And ( gmg( hotkey ) <> 0 ) ) Or ( fb_windowkill() )
  

End


heh:

handle_save( 69 )

Sleep 500, 1

#If __FB_ERR__ and 2
  Resume Next
  
#EndIf


End




Sub gmap_end() Destructor
  
  Dim As Integer i

  clean_Deallocate( llg( dir_hint ) )

  
  BinObj_Destroy( gmg( room_down_key ) )
  BinObj_Destroy( gmg( room_up_key )   )
  BinObj_Destroy( gmg( zoom_key )      )
  BinObj_Destroy( gmg( solo_key )      )
  BinObj_Destroy( gmg( grid_key )      )
  BinObj_Destroy( gmg( w_grid_key )    )
  BinObj_Destroy( gmg( redim_key )     )
  BinObj_Destroy( gmg( flood_key )     )
  
  clean_Deallocate( gmg( r_img[0] ) )
  clean_Deallocate( gmg( r_img[1] ) )
  clean_Deallocate( gmg( r_img[2] ) )

  clean_Deallocate( gmg( b_img[0] ) )
  clean_Deallocate( gmg( b_img[1] ) )
  clean_Deallocate( gmg( b_img[2] ) )

  clean_Deallocate( gmg( r_img ) )
  clean_Deallocate( gmg( b_img ) )
  
  For i = 0 To gmg( macros ) - 1
    clean_Deallocate( gmg( macro )[i] )
  
  Next
  clean_Deallocate( gmg( macro ) )
  
  clean_Deallocate( gmg( state_addy ) )
  
  clean_Deallocate( gmg( block_boxes ) )
  
  For i = 0 To s_NUM_OF_STATES - 1
  
    TextControl_Destroy( gmg( control )[i] )
    
  Next
  
  clean_Deallocate( gmg( control ) )
  
  
  LLSystem_ClearObjectCache()
  LLSystem_ClearImageCache()
  

End Sub  
  
  

  
  