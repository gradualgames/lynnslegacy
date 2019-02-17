Option Explicit

#Include "..\headers\ll.bi"

#Include "..\com\xml.bas"
#Include "..\com\vfile.bas"
#Include "..\com\zfb.bas"

#Include "..\com\lists.bas"
#Include "..\com\utility.bas"
#Include "..\com\ll_build.bas"



#Include "..\com\gfx.bas"                   
#Include "..\com\engine--gfx_LL.bas"        
#Include "..\com\object--gfx.bas"           
#Include "..\com\object--gfx_animation.bas" 
#Include "..\com\object--gfx_frame.bas"     
#Include "..\com\object--gfx_palette.bas"   
#Include "..\com\engine--object.bas"


#Include "..\com\engine--images.bas" 
#Include "..\com\engine--etc.bas"    

Dim Shared As LL_SYSTEM LL_Global


Type enemytable

  e_room As Integer
  e_index As Integer
  
End Type



Dim As String f
Dim As Integer i, j, k, l, m, room_no

room_no = 29

  #Define find_an_object(x) _
    ( Right( .id, Len( x ) ) = x )

  f = "data\map\gelidus.map"
  
  ChDir "..\.."
  
  Kill "dev\" & killfileext( killfilepath( f ) ) & "_info.txt"
  
  llg( map ) = LLSystem_LoadMap( f, -1 )
  
  
  '' moenia room 22 = grult room
  '' forest_fall room 12 = come back from gelidus room
  
  For i = 0 To llg( map )->room[room_no].enemies - 1
    With llg( map )->room[room_no].enemy[i]
      If find_an_object( "gold.xml" ) Then
        .spawn_cond = 1
        .spawn_info = CAllocate( Len( LLObject_ConditionalSpawn ) )
        .spawn_info->wait_n = 1
        .spawn_info->wait_spawn = CAllocate( Len( LLObject_SpawnSwitch ) )
        .spawn_info->wait_spawn[0].code_index = 297
        .spawn_info->wait_spawn[0].code_state = 1
      
      
      End If
      
    End With
    
  Next
      
    
  
  
  
  f = killfilepath( f )
  f = "_" + f
  f = "data\map\" + f
  
  save_mapV( f, llg( map ) )
  



engine_end()

Sub test_end() Destructor

  map_Destroy( llg( map ) )
  list_Destroy( llg( f_mem ), list_dealloc )


End Sub  
