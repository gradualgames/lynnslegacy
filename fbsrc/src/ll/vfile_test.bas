Option Explicit

#Include "..\headers\ll.bi"

#Include "..\com\xml.bas"
#Include "..\com\vfile.bas"
#Include "..\com\zfb.bas"

#Include "..\com\lists.bas"
#Include "..\com\utility.bas"
#Include "..\com\gfx.bas"
#Include "..\com\ll_build.bas"

Dim Shared As LL_SYSTEM LL_Global



Sub script_macro( add_Base As Integer, add_Rel As Integer, ptr_Script As sequence_type Ptr, id_Enemy As String )


  Dim As Integer i_Room, i_Enemy
  
  
  For i_Room = 0 To llg( map )->rooms - 1
  
    For i_Enemy = 0 To llg( map )->room[i_Room].enemies - 1
      
      If llg( map )->room[i_Room].enemy[i_Enemy].id = id_Enemy Then
        ? "hey there"
        
      End If
    
    
    
    
    
    Next 
  
  Next






End Sub



Dim As list_type Ptr maps

Dim As uByte buf()
Dim As String f

  f = "data\map\gelidus.map"
  
  ChDir "..\.."
  
  llg( map ) = LLSystem_LoadMap( f, -1 )
  script_macro( 200, 0, 0, "data\object\chest.xml" )
  





engine_end()

Sub test_end() Destructor

  destroy_map( llg( map ) )
  destroy( llg( f_mem ), list_dealloc )


End Sub  
