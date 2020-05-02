Type command_data


  active_ent  As Integer   
  ent_func    As Integer   
  ent_state  As Integer
  hold_state  As Integer
  
  
  text        As String    
  
  chap        As Integer   
  jump_count  As Integer   

  mod_x As Short  
  mod_y As Short  

'  to_map      As Integer   
  to_map      As String
    
  
  
  
  to_entry    As Integer   
  Union
    walk_speed As Double    
    auto_box   As Double    
    
  End Union
      
  Union
    water_align As Integer   
    text_speed As Integer
    
  End Union
  
  dest_xy     As uInteger  
  Union
    dest_x     As Short
    text_color As Short
  End Union
  Union
    dest_y    As Short
    box_invis As Short
  End Union
  
  nocam       As Integer   
  
  carries_all As Integer   

  abs_x As Short
  abs_y As Short
  Union
    reserved_1       As Integer ''direction...
    modify_direction As Integer
    
  End Union
  
  Union
    reserved_2 As Integer '' paused  
    seq_pause  As Integer '' paused  
    
  End Union 
  
  reserved_3 As Integer '' affect in
  reserved_4 As Integer '' affect out
  

  Union   
    reserved_5 As Integer '' action-lock
    free_to_move As Integer
  End Union 
  Union
    reserved_6 As Integer '' hud display
    display_hud As Integer
  End Union
  
  fadeTime as double
    
'  reserved_7 As Integer
'  reserved_8 As Integer
  
  reserved_9 As Integer
  reserved_10 As Integer


  reserved_11 As Integer ' don't touch 


End Type


Type command_type

  ents As Integer
  ent As command_data Ptr
   
  
End Type


Type sequence_type

  ents As Integer
  ent_code As Integer Ptr
  ent As _char_type Ptr Ptr
  
  commands As Integer
  Command As command_type Ptr
  current_command As Integer 
  
  seq_type As String
  seq_index As Integer
  
End Type


