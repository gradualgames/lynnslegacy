




 

Enum gmap_control_enum
  
  s_null
  s_rooms
  s_teleports
  s_enemies
  s_entries
  s_parallax
  s_parallax_image
  s_walkables
  s_ice
  s_load_map
  s_save_map
  s_quit
  s_load_tiles
  s_layer_0
  s_layer_1
  s_layer_2
  s_macros
  s_tile_pick
  s_redimension
  s_zoom
  s_walk_grid
  s_layer_fill
  s_solo
  s_flood_fill
  s_tile_grid
  s_sequence
  s_sequence_entities
  s_sequence_commands
  s_sequence_command_blocks
  
  
  s_NUM_OF_STATES
  
End Enum

Enum seq_enum
  
  seq_NULL

  seq_enemy
  seq_entry
  seq_room
  
End Enum
  
 

Const tile_ice   As Integer = ( 2 ^ 8 )  '' 256



Const lowerright As Integer = ( 2 ^ 12 ) '' 4096
Const lowerleft  As Integer = ( 2 ^ 13 ) '' 8192
Const upperright As Integer = ( 2 ^ 14 ) '' 16384
Const upperleft  As Integer = ( 2 ^ 15 ) '' 32768

Const max_file As Integer = 4096
