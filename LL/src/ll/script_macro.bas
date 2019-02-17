Option Explicit

#Define LL_Minimal

#Include "..\headers\ll.bi"

'#UnDef LLSystem_ImageDeref

#Include "..\com\matrices.bas"
#Include "..\generic\fb_Global.bas"

#Include "..\com\xml.bas"
#Include "..\com\vfile.bas"
#Include "..\com\zfb.bas"

#Include "..\com\lists.bas"
#Include "..\com\utility.bas"
#Include "..\com\gfx.bas"
#Include "..\com\ll_build.bas"


#Include "..\com\engine--object.bas"
#Include "..\com\engine--images.bas"
#Include "..\com\engine--object_XML.bas"

Dim Shared As LL_SYSTEM LL_Global


Type enemytable

  e_room As Integer
  e_index As Integer
  
End Type


private sub hack_indexes( e_thang as enemytable )

  dim as integer j, k
    for j = 0 to llg( map )->room[e_thang.e_room].enemy[e_thang.e_index].seq->ents - 1
      if llg( map )->room[e_thang.e_room].enemy[e_thang.e_index].seq->ent_code[j] <> 1024 then
        llg( map )->room[e_thang.e_room].enemy[e_thang.e_index].seq->ent_code[j] = e_thang.e_index
        
      end if
    next

end sub

Sub write_object_info( f As String, o As String, e() As enemytable )

  Dim As Integer ff = FreeFile, i
  Dim As String b
  
  
  Open f For Append As #ff
    
    For i = 0 To UBound( e ) 
      
      b = o & " #" & i & " - Room[" & e( i ).e_room & "], Index[" & e( i ).e_index & "]"
      
      Print #ff, b
      
    Next
    
  Close #ff
  
  
End Sub
  



Sub spawn_customize( e As enemytable, address As Integer )
    
    

    With llg( map )->room[e.e_room].enemy[e.e_index]
    
      .spawn_cond = 1
      .spawn_info = CAllocate( Len( LLObject_ConditionalSpawn ) )
      
      .spawn_info->kill_n = 1
      .spawn_info->kill_spawn = CAllocate( Len( LLObject_SpawnSwitch ) )
      
      .spawn_info->kill_spawn[0].code_index = address
      .spawn_info->kill_spawn[0].code_state = 1
      
      
    End With
    

End Sub




Function build_enemy_table( e_table() As enemytable, id_Enemy As String ) As Integer


  Redim e_table( 0 )


  Dim As Integer i_Room, i_Enemy, high
  

  For i_Room = 0 To llg( map )->rooms - 1
  
    For i_Enemy = 0 To llg( map )->room[i_Room].enemies - 1
      
      If llg( map )->room[i_Room].enemy[i_Enemy].id = id_Enemy Then

        high = ubound( e_table )
        
        e_table( high ).e_room = i_Room
        e_table( high ).e_index = i_Enemy
        
        Redim Preserve e_table( high + 1 )
        
      End If
    
    Next 
  
  Next
  
  If high = 0 Then
    Return -1
   
  End If

  Redim Preserve e_table( high )


End Function


Function chest_script_construct() As sequence_type Ptr

  Dim As sequence_type Ptr res
  
  res = CAllocate( Len( sequence_type ) )
  
  With *( res )
    .ents = 1
    .ent_code = CAllocate( 4 )
    
    .commands = 2
    .Command = CAllocate( Len( command_type ) * .commands )
    
    .Command[0].ents = 1
    .Command[1].ents = 1

    .Command[0].ent = CAllocate( Len( command_data ) * .Command[0].ents )
    .Command[1].ent = CAllocate( Len( command_data ) * .Command[1].ents )
    
    With .Command[0].ent[0]
      .start_func = 1
      
    End With
    
    With .Command[1].ent[0]
      .active_ent = 1024
      .text = "Found a key!"
      
      .dest_x = 15
      .dest_y = 1
      
      .mod_y = 16
      
      .walk_speed = 2.5
      
    End With
    
    
     
    
  End With


  Return res

End Function


Sub chest_script_customize( e As enemytable, address As Integer )
    
    

    With llg( map )->room[e.e_room].enemy[e.e_index]
      .seq_here = 1
      .seq =  chest_script_construct()
      
      .seq->Command[0].ent[0].chap = address
      .seq->ent_code[0] = e.e_index
      
    End With
    

End Sub

Sub chest_script_macro( add_Base As Integer, add_Rel As Integer )


  Dim As String id_Enemy = "data\object\chest.xml"

  Redim As enemytable e_list( 0 )
  If build_enemy_table( e_list(), id_Enemy ) <> 0 Then
    Exit Sub
    
  End If
'  
'  
  Dim As Integer i, j, k
  
  For i = 0 To UBound( e_list )
'    hack_indexes( e_list( i ) ) 
    chest_script_customize( e_list( i ), add_Base + add_Rel + i )
    spawn_customize( e_list( i ), add_Base + add_Rel + i )
  next
        
      
  
    
  
  
  write_object_info( "dev\" & killfilepath( killfileext( llg( map )->filename ) ) + "_info.txt", "Chest", e_list() )
  ? "Wrote " & i & " chests total."

End Sub














'' Begin Keydoor Macro:













Function keydoor_script_construct() As sequence_type Ptr

  Dim As sequence_type Ptr res
  
  res = CAllocate( Len( sequence_type ) )
  
  With *( res )
    .ents = 1
    .ent_code = CAllocate( 4 )
    
    .commands = 1
    .Command = CAllocate( Len( command_type ) * .commands )
    
    .Command[0].ents = 1

    .Command[0].ent = CAllocate( Len( command_data ) * .Command[0].ents )
    
    With .Command[0].ent[0]
      .start_func = 1
      .display_hud = 1
      
    End With
    
  End With


  Return res

End Function

'
Sub keydoor_script_customize( e As enemytable, address As Integer )


  With llg( map )->room[e.e_room].enemy[e.e_index]
    .seq_here = 1
    .seq =  keydoor_script_construct()
    
    .seq->Command[0].ent[0].chap = address
    .seq->ent_code[0] = e.e_index
    
  End With


End Sub


Sub keydoor_script_macro( add_Base As Integer, add_Rel As Integer )

  Dim As String id_Enemy = "data\object\keydoor.xml"
  
  Redim As enemytable e_list( 0 )
  If build_enemy_table( e_list(), id_Enemy ) <> 0 Then
    Exit Sub
    
  End If
  
  
  Dim As Integer i '= UBound( e_list ) + 1
  For i = 0 To UBound( e_list )
        hack_indexes( e_list( i ) ) 

'    keydoor_script_customize( e_list( i ), add_Base + add_Rel + i )
'    spawn_customize( e_list( i ), llg( map )->room[e_list( i ).e_room].enemy[e_list( i ).e_index].seq[0].Command[0].ent[0].chap )
    
  Next
  
  write_object_info( "dev\" & killfilepath( killfileext( llg( map )->filename ) ) + "_info.txt", "Key Door", e_list() )
  ? "Wrote " & i & " keydoors total."

End Sub



Sub keydooro_script_macro( add_Base As Integer, add_Rel As Integer )

  Dim As String id_Enemy = "data\object\keydoor_offset.xml"
  
  Redim As enemytable e_list( 0 )
  If build_enemy_table( e_list(), id_Enemy ) <> 0 Then
    Exit Sub
    
  End If
  
  
  Dim As Integer i '= UBound( e_list ) + 1
  For i = 0 To UBound( e_list )

        hack_indexes( e_list( i ) ) 
'  
'    keydoor_script_customize( e_list( i ), add_Base + add_Rel + i )
'    
'
'    spawn_customize( e_list( i ), llg( map )->room[e_list( i ).e_room].enemy[e_list( i ).e_index].seq[0].Command[0].ent[0].chap )
    
  Next
  
  write_object_info( "dev\" & killfilepath( killfileext( llg( map )->filename ) ) + "_info.txt", "Key Door", e_list() )
  ? "Wrote " & i & " keydooros total."

End Sub



Sub keydooro2_script_macro( add_Base As Integer, add_Rel As Integer )

  Dim As String id_Enemy = "data\object\keydoor_offset2.xml"
  
  Redim As enemytable e_list( 0 )
  If build_enemy_table( e_list(), id_Enemy ) <> 0 Then
    Exit Sub
    
  End If
  
  
  Dim As Integer i '= UBound( e_list ) + 1
  For i = 0 To UBound( e_list )
  
        hack_indexes( e_list( i ) ) 
'    keydoor_script_customize( e_list( i ), add_Base + add_Rel + i )
'    spawn_customize( e_list( i ), llg( map )->room[e_list( i ).e_room].enemy[e_list( i ).e_index].seq[0].Command[0].ent[0].chap )
    
  Next
  
  write_object_info( "dev\" & killfilepath( killfileext( llg( map )->filename ) ) + "_info.txt", "Key Door", e_list() )
  ? "Wrote " & i & " keydooro2s total."

End Sub




Sub bluechest_script_macro( add_Base As Integer, add_Rel As Integer )

  Dim As String id_Enemy = "data\object\bluechest.xml"
  Dim As Integer i '= UBound( e_list ) + 1


  Redim As enemytable e_list( 0 )
  If build_enemy_table( e_list(), id_Enemy ) <> 0 Then
    Exit Sub
    
  End If
'  
  For i = 0 To UBound( e_list )
  
        hack_indexes( e_list( i ) ) 
'    keydoor_script_customize( e_list( i ), add_Base + add_Rel + i )
'    spawn_customize( e_list( i ), llg( map )->room[e_list( i ).e_room].enemy[e_list( i ).e_index].seq[0].Command[0].ent[0].chap )
    
  Next
  
'  Dim As Integer i = UBound( e_list ) + 1
  
  write_object_info( "dev\" & killfilepath( killfileext( llg( map )->filename ) ) + "_info.txt", "BlueChest", e_list() )
  ? "Wrote " & i & " bluechest total."

End Sub


Sub bluechestitem_script_macro( add_Base As Integer, add_Rel As Integer )

  Dim As String id_Enemy = "data\object\bluechestitem.xml"
  Dim As Integer i '= UBound( e_list ) + 1


  Redim As enemytable e_list( 0 )
  If build_enemy_table( e_list(), id_Enemy ) <> 0 Then
    Exit Sub
    
  End If
  
  For i = 0 To UBound( e_list )
  
        hack_indexes( e_list( i ) ) 
'    keydoor_script_customize( e_list( i ), add_Base + add_Rel + i )
'    spawn_customize( e_list( i ), llg( map )->room[e_list( i ).e_room].enemy[e_list( i ).e_index].seq[0].Command[0].ent[0].chap )
    
  Next
  
'  Dim As Integer i = UBound( e_list ) + 1
  
  write_object_info( "dev\" & killfilepath( killfileext( llg( map )->filename ) ) + "_info.txt", "BlueChestItem", e_list() )
  ? "Wrote " & i & " bluechests with items total."

End Sub


















Dim As String f
'
  Const base_addr As Integer = 600
'  
'
'
  f = "data\map\divius.map"
'  
  ChDir "..\.."

  LLSystem_CachePictureFiles( "data\pictures\" )
'  LLSystem_CacheObjectFiles( "data\object" )
'  
'  Kill "dev\" & killfileext( killfilepath( f ) ) & "_info.txt"
'  
  llg( map ) = LLSystem_LoadMap( f, -1 )
  
  
  
  chest_script_macro( base_addr, 0 )

'  keydoor_script_macro( base_addr, 30 )
'  keydooro_script_macro( base_addr, 30 )
'  keydooro2_script_macro( base_addr, 30 )

'  bluechest_script_macro( base_addr, 60 )
'  bluechestitem_script_macro( base_addr, 60 )

  f = killfilepath( f )
  f = "_" + f
  f = "data\map\" + f
  
  save_mapV( f, llg( map ) )
  



'engine_end()

Sub test_end() Destructor

'  map_Destroy( llg( map ) )

'  LLSystem_ClearObjectCache()
  LLSystem_ClearImageCache()


End Sub  
