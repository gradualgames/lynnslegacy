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


Type enemytable

  e_room As Integer
  e_index As Integer
  
End Type



Dim As String f
Dim As Integer i, j, k, l, m

  #Define this_object(x) _
    ( Right( .id, Len( x ) ) = x )

  f = "data\map\gelidus.map"
  
  ChDir "..\.."
  
  Kill "dev\" & killfileext( killfilepath( f ) ) & "_info.txt"
  
  llg( map ) = LLSystem_LoadMap( f, -1 )
  
  
  '' moenia room 22 = grult room
  
  For j = 0 To llg( map )->rooms - 1
    For i = 0 To llg( map )->room[j].enemies - 1
      With llg( map )->room[j].enemy[i]
        If this_object( "fkeydoor.xml" ) Then
          ? "room:  enemy:"
          ? j & "     " & i
          
        
        
        End If
        
      End With
      
    Next
    
  Next
      
    
  
  
  
'  f = killfilepath( f )
'  f = "_" + f
'  f = "data\map\" + f
'  
'  save_mapV( f, llg( map ) )
'  



engine_end()

Sub test_end() Destructor

  destroy_map( llg( map ) )
  destroy( llg( f_mem ), list_dealloc )


End Sub  
