Option Explicit


#Include "..\headers\utility.bi"
#Include "..\headers\ll\headers.bi"
#Include "..\headers\ll\object_control.bi"
#Include "..\headers\ll\gfx.bi"

Screen 19, , 2, 1
Width 100, 75

  Dim Shared As ll_system ll_global


      Sub change_map_picture_paths( l As list_type Ptr )
        
        Dim As String this_filename = l->dat.s, chop_filename
        
        
        llg( map ) = load_map( this_filename, -1 )
        ? llg( map )->tileset.filename
        
        chop_filename = Right( llg( map )->tileset.filename, Len( llg( map )->tileset.filename ) - 4 ) 
        chop_filename = "data\pictures" & chop_filename
        llg( map )->tileset.filename = chop_filename
        
        
        Dim As Integer i
        For i = 0 To llg( map )->rooms - 1
          If llg( map )->room[i].parallax <> 0 Then
          
            chop_filename = Right( llg( map )->room[i].para_img.filename, Len( llg( map )->room[i].para_img.filename ) - Len( "pics" ) ) 
            chop_filename = "data\pictures" & chop_filename
            llg( map )->room[i].para_img.filename = chop_filename
            
            
          End If
          
        Next
        
        save_map( this_filename, llg( map ) )
      
        destroy_map( llg( map ) )
        llg( map ) = 0
        
        
      End Sub

  '''''''''''''''''''''''''
  '''''''''''''''''''''''''
  '''''''''''''''''''''''''
  '''''''''''''''''''''''''
  '''''''''''''''''''''''''
  '''''''''''''''''''''''''
  '''''''''''''''''''''''''
  '''''''''''''''''''''''''
        
      Sub change_map_enemy_paths( l As list_type Ptr )
        
        Dim As String this_filename = l->dat.s, chop_filename
        
        
        llg( map ) = load_map( this_filename, -1 )
        
        
        Dim As Integer i, j
        For i = 0 To llg( map )->rooms - 1
        
          For j = 0 To llg( map )->room[i].enemies - 1


            chop_filename = Right( llg( map )->room[i].enemy[j].id, Len( llg( map )->room[i].enemy[j].id ) - Len( "modules\object\xmls" ) ) 
            chop_filename = "data\object" & chop_filename                                             
            llg( map )->room[i].enemy[j].id = chop_filename
            
          Next

        Next
        save_map( this_filename, llg( map ) )
      
        destroy_map( llg( map ) )
        llg( map ) = 0
        
        
      End Sub
        
  '''''''''''''''''''''''''
  '''''''''''''''''''''''''
  '''''''''''''''''''''''''
  '''''''''''''''''''''''''
  '''''''''''''''''''''''''
  '''''''''''''''''''''''''
  '''''''''''''''''''''''''
  '''''''''''''''''''''''''



  engine_init()

    
    
  Dim As list_type Ptr map_files, work_map
  Dim As Integer re
  Dim As Double t
  

  
    map_files = list_files( "data\map", "*.map" )
    re = open_file_dialog( map_files )
    
    t = Timer
'
'    If re = -1 Then
'    
'    Else
'
'      llg( map ) = load_map( list_node_value( map_files, re, "" ) )
'      save_map( list_node_value( map_files, re, "" ), llg( map ) ) 
'      
'    End If
    work_map = list_append( work_map, list_node_value( map_files, re, "" ) )
      
    
    iterate_through_list( work_map, @change_map_enemy_paths )
    iterate_through_list( work_map, @change_map_picture_paths )
  
    destroy( map_files, list_strlist )
    destroy( work_map, list_strlist )
    
    t = ( Timer - t )
    
    ? "Operation completed in " & t & " seconds."
    ?
    ? "Press Any Key to Exit."

    handle_refresh()
    Sleep
  


  engine_end( everythings_sweet )

