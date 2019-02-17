Enum ll_object_flags

  no_alloc = 1

End Enum



Enum _channels

  channel_static = 64

  
  channel_gulls = 69

  channel_sea = 70
  
  channel_crickets = 71
  
End Enum


Enum box_jumps

  box_kill_switch = 1
  box_jump_back = 0
  
End Enum


Enum ll_proc_error_codes

  _palette
  _map_load
  _map_save
  _play_seq


End Enum


Enum enemy_uniques

  u_null

  u_cell

  u_chest

  u_bluechest
  u_bluechestitem
  u_button
  u_gbutton

  u_bshape
  u_gshape
  
  u_bush

  u_tguard
  u_bguard
  u_eguard
  u_cguard

  u_torch
  u_ltorch
  u_gtorch

  u_ibug
  u_fbug
  
  u_gold
  u_silver
  u_health
  
  u_keydoor
  u_fkeydoor
  u_bardoor
  
  u_static
  u_statue
  
  u_pushrock
  
  u_menu
  u_savepoint
  
  u_crate
  u_crate_health

  u_grult
  u_ghut
  
  u_hotrock
  u_coldrock
  u_greyrock

  u_bombrock  
  u_mole
  
  u_sign
  
  u_dyssius
  
  u_anger        
  u_angerfireball
  
  u_charger
  u_sparkle
  u_sterach
  u_swordie
  u_slimeman

  u_beetle
  
  u_beamcrystal
  
  u_antiwall
  u_antiwall2
  
  u_pmouth

  u_boss5_right
  u_boss5_left
  u_boss5_down

  u_boss5_crystal
  
  u_pekkle_blue
  u_pekkle_bomb
  u_pekkle_red
  u_pekkle_grey
  
  u_pekkle_big
  
  u_goldblock

  u_divine
  u_divine_bug
  u_divine_ball
  
  u_kambot
  u_auto
  u_mech
  u_haywire
  u_healthguy
  u_godstat
  u_steelstrider
  
  
  u_ferus
  
  u_core

  u_biglarva
  
  u_battleseed
  
  u_lynn
  
  
  
  
  
  
End Enum
  

Enum MO_FLAGS

  MO_JUST_CHECKING = -1
  MO_NO_RECURSION  = -1
  
End Enum


Enum ll_error_codes

  everythings_sweet
  
  no_maps_to_load

  map_doesnt_exist
  map_file_empty
  
  map_has_no_rooms
  map_has_no_entries
  
  no_map_tileset
  map_tileset_not_found

  palette_is_missing
  palette_is_empty
  
  object_doesnt_exist
  
  loading_enemy_failed
  
  NUM_OF_LL_ERRORS
  
  
End Enum

Enum ll_entity_codes
  
  ent_textbox = 1024
  
End Enum


Enum ll_sound_fx
  
  sound_null
  
  sound_bassdrop             
  sound_beam                 
  sound_bigchest             
  sound_boss_hit             
  sound_cashget              
  sound_doorfkey             
  sound_doorsmall            
  sound_enemyhit             
  sound_enemykill            
  sound_explosion            
  sound_flare                
  sound_healthgrab           
  sound_heart                
  sound_ice                  
  sound_portal               
  sound_smallchest           
  sound_switch               
  sound_treepull             
  sound_lowhealth            
  sound_bush                 
  sound_crateting            
  sound_sea                  


  sound_lynn_attack_1        
  sound_lynn_attack_2        
  sound_lynn_attack_3        
  sound_lynn_attack_4  '' Attacks & hurts must be grouped! 

  sound_lynn_hurt_1          
  sound_lynn_hurt_2          
  sound_lynn_hurt_3          


  sound_lynn_die
  sound_mace_0                
  sound_mace_1                
  sound_mace_2                
  sound_texttemp             
  sound_torchlight           
  sound_greystatic           
  sound_crickets             
  sound_gulls2               
  sound_rayflap2             
  sound_flap                 
  sound_sploosh
  
  sound_camera
  sound_ferusstep
  sound_ferusbeep 
  
  sound_ferusgarbled
  
  sound_beamcharge

  sound_corealarm
  sound_corealarm2
  sound_rumble
  sound_coreclunk

  sound_gunfire
  sound_limboloop
  
  sound_podopen
  
  sound_turret
  sound_heal
  
  sound_build
  
  sound_mothdie
  
  NUM_OF_SOUNDS
  
End Enum


Enum sound_manage

  sound_loop = 1
  
End Enum

Enum LL_DAMAGE_FLAGS

  DF_NO_DAMAGE
  DF_ROOM_ENEMY = 1
  DF_TEMP_ENEMY = 2
  DF_MAIN_CHAR  = 4

  DF_PROJ       = 65536

End Enum  


Enum LL_OBJVECTOR_FLAGS
  
  OV_ONEBOX
  OV_FACE
  
End Enum


Enum LL_SEQUENCE_FLAGS

  SF_BOX = 1024
  
End Enum

Enum LLOBJECT_SPAWN_OPS

  SO_NOT = 1
  SO_AND = 2
  SO_OR  = 4
  
End Enum






Enum ll_menu_gfx

  menu_blankspace     
  menu_bridge         
  menu_bridge_select  
  menu_bridge2         
  menu_bridge2_select  
  menu_bridge3         
  menu_bridge3_select  
  menu_blank
  menu_blank_select  
  menu_flare          
  menu_flare_select   
  menu_full_background
  menu_heal           
  menu_heal_select    
  menu_ice            
  menu_ice_select     
  menu_idol           
  menu_idol_select    
  menu_mace           
  menu_mace_select    
  menu_menu_select    
  menu_regen          
  menu_regen_select   
  menu_resume_select  
  menu_sapling        
  menu_sapling_select 
  menu_square_cursor  
  menu_star           
  menu_star_select    
  menu_cougar
  menu_lynnity
  menu_ninja
  menu_standard    
  menu_cougar_select
  menu_lynnity_select
  menu_ninja_select
  menu_standard_select
  menu_bikini
  menu_bikini_select
  menu_rknight
  menu_rknight_select
  menu_MAX    
  
End Enum

Enum LLMINI_DOORTYPES

  DOOR_OPEN
  DOOR_LOCKED
  DOOR_BARRED
  DOOR_FKEYLOCKED
  DOOR_STAIR

End Enum


Enum LLFADE_FADETYPES


  LLFADE_NORMAL = 0
  LLFADE_WHITE  = 1
  LLFADE_GRAY   = 2
  
  
End Enum

Enum LLPROJECTILE_STYLES
  
  PROJECTILE_NONE
  PROJECTILE_ORB
  PROJECTILE_BEAM
  PROJECTILE_DIAGONAL
  PROJECTILE_CROSS
  PROJECTILE_8WAY
  PROJECTILE_FIREBALL
  PROJECTILE_SCHIZO
  PROJECTILE_SPIRAL
  PROJECTILE_SUN
  PROJECTILE_TRACK
  
End Enum


enum BOXSTUFF

  TEXTBOX_REGULAR
  TEXTBOX_CONFIRMATION
  TEXTBOX_SHUTDOWN
  
end enum

