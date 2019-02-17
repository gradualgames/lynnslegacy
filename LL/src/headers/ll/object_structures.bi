  Type LLObject_SoundHeader
    sound As Integer
    vol As Integer
    
  End Type


  Type LLSystem_ObjectHandle As uInteger


  Type LLObject_FrameConcurrent
  
    is_relative As Integer
    
    char As _char_type Ptr
    origin As vector
    
  End Type
  
  
  Type LLObject_FrameControl
  
    sound_lock As Integer
  
    concurrent As LLObject_FrameConcurrent Ptr
    concurrents As Integer
  
    As Double rate, rateMad
  
  End Type
  
  
  
  
  Type LLObject_ImageHeader
  
    As Integer x_off, y_off
  
    dir_frames As Integer
    cur_frame As Integer
  
    frame As LLObject_FrameControl Ptr

    As Double rate, rateMad
    
  
  End Type
  
  


  '' Projectile information struct(s) suggestion:
  ''
  '' Operates with:
  ''
  '' Projectile information is held inside this struct. this struct contains
  '' various information about the object's projectile's properties - speed, length, strength, etc.
  '' 
  '' 
     Type ll_entity_projectile
   
       refreshTime       As Double
       
       plock as byte
             
       projectiles   As Integer
       saveDirection As Integer     
       direction     As Integer     
       length        As Integer     
       travelled     As Integer     
       invisible     As Integer     
       overChar      As Integer     
       sound         As Integer     
       strength      As Integer     
       active        As Integer     
       coords        As Vector Ptr
       
       startVector As vector 
       flightPath as vector
       
     End Type


  '' Damage information struct:
  ''
  '' Operates with:
  '' Enum LL_DAMAGE_FLAGS
  '' 
  '' Damage information is held inside this struct. this struct contains
  '' various information about what the object was damaged by.
  ''
  Type ll_entity_damage
    
    '' description of damaging entity.
    '' ( Enum LL_DAMAGE_FLAGS )
    id As Integer
    ''
    '' the number of whatever type you hit. 
    '' e.g. equals 2 when object is damaged by room enemy #2
    index As Integer
    ''
    '' if id = DF_XXXX_ENEMY_PROJ, then "specific" equals the projectile number.
    '' elseif the enemy has multiple bounds, then "specific" is the bound touched.
    '' else "spcific" is undefined.
    specific As Integer
  
  End Type


  '' Spawn switch struct:
  '' 
  Type LLObject_SpawnSwitch

    '' LL_Global.Now[]
    code_index As uShort
    ''
    '' LL_Global.Now[code_index] <> 0
    code_state As Integer 
    
  End Type


  '' Spawn information struct:
  '' 
  '' Spawning info is held in this struct. This struct contains
  '' spawn "switches" to determine if a conditionally spawned
  '' object is due to be spawned/terminated. 
  '' 
  Type LLObject_ConditionalSpawn
  
    wait_n     As Integer
    wait_spawn As LLObject_SpawnSwitch Ptr
  
    kill_n     As Integer
    kill_spawn As LLObject_SpawnSwitch Ptr

    active_n     As Integer
    active_spawn As LLObject_SpawnSwitch Ptr
  
  End Type
  

'' In this system, instead of having full
'' structures and one elemnt of the structure unset if not active, 
'' the public structure only has one elemnt, a pointer
'' to the rest of the data, if link = 0 then inactive, else
'' access mem at link for more information.
''
'' ----------
''           \-/
                Type ll_saving_data
                
                  hp     As Integer
                  maxhp  As Integer  

                  gold   As Integer  
                  weapon As Integer  
                  item   As Integer
                  hasItem( 5 ) as integer  
                  bar    As Integer  

                  hasCostume( 8 ) As Byte
                  isWearing As Integer  

                  key    As Integer  
                  b_key  As Integer  


                  map    As String   
                  entry  As Integer  
                
                  happen( 4095 ) As uByte
                  
                  hasVisited as ubyte ptr 
                  rooms as integer
                
                End Type
                
                Type save_dat
                
                  link As ll_saving_data Ptr
                
                End Type
''           /-\
'' ----------



Type mat_expl

  As Integer x, y

  frame As Integer
  frame_hold As Double
  alive As Integer
  sound As Integer
  
End Type



Type dir_type
  
  i( 7 ) As Double

End Type



Type e_funcs
      
  active_state As Integer

  func As fp Ptr Ptr

  current_func As Integer Ptr 


  func_count   As Integer Ptr
  states As Integer
  
End Type



Type char_type


  dmg As ll_entity_damage

  
  internalState as integer    

  animating             As Integer                        
  anims                 As Integer                        

  hp                    As Integer                        
  maxhp                 As Integer                        

  anim                  As LLSystem_ImageHeader Ptr Ptr 

  animControl           As LLObject_ImageHeader Ptr              

  current_anim          As Integer                        
  
  d_gold                As Integer                        
  d_health              As Integer                        
  d_silver              As Integer                        
  
  ice_weak              As Integer                        
  total_dead            As Integer                        
  dead_sound            As Integer                        
  dead_sound_vol        As Integer                        
  dead_hold             As Double

  degree                As Double
  sway                  As Double
  swaying               As Integer


  diag_chase            As Integer                        
  diag_thrust           As Integer                        
  direction             As Integer                        
  far_reset_delay       As Double                         

  '' needs a simple explosion display
  fireworks             As Integer

  fire_weak             As Integer                        


  frame                 As Integer                        
  frame_hold            As Double                         
  high_frame            As Double                         
  low_frame             As Double                         


  froggy                As Integer                        
  
  funcs                 As e_funcs                        

  thrust                As Integer                        

  switch_room           As Integer                        
  dead                  As Integer                        


  heal_me               As Integer                        
  
  
  
  isBoss As Integer
  lose_time             As Integer                        


  grult_proj_trig       As Integer                        
  anger_proj_trig       As Integer                        


    '' states!!
  
  attack_state          As Integer                        
  death_state           As Integer                        
  fire_state            As Integer                        
  hit_state             As Integer                        
  ice_state             As Integer                        
  jump_state            As Integer                        
  proj_state            As Integer                        
  reset_state           As Integer                        
  stun_state            As Integer                        
  thaw_state            As Integer                        
  thrust_state          As Integer                        
  
  
    '' anims
  
  dead_anim             As Integer                        
  expl_anim             As Integer                        
  proj_anim             As Integer                        




  hit                   As Integer

  hit_sound             As Integer                        
  hit_sound_vol         As Integer                        
  
  hurt                  As Integer                        



  id                    As String
  
  impassable            As Integer                        
  
  invincible            As Integer                        
  invisible             As Integer                        
  
  is_psfing             As Integer                        
  is_pushing            As Integer                        
  
  jump_count            As Integer                        
  jump_counter          As Integer                        
  jump_lock             As Integer                        
  jump_time             As Double                         
  jump_timer            As Double                         
  
  key                   As Integer                        
  key_door              As Integer                        
  
  last_cycle_ice         As Integer                        

  light_sensitive       As Integer                        
  
  line_lock             As Integer                        
  line_sight            As Integer                        
  
  mace_weak             As Integer                        
  
  mad                   As Integer                        
  mad_walk_speed        As Double                         

  mod_lock              As Integer                        
  momentum              As dir_type                       
  momentum_history      As dir_type                       
  
  money                 As Integer                        
  
  moveBackwards         As Integer
  
  moving                As Integer                        
  
  
  must_align            As Integer                        
  
  n_gold                As Integer                        
  n_silver              As Integer                        
  
  no_cam                As Integer                        
  
  num                   As Integer                        
  
  on_ice                As Integer                        

  ori_dir               As Integer                        
  
  pause                 As Single                         
  pause_hold            As Integer                        
  
  placed                As Integer                        '0 = norm, pos = top, neg = bottom
  
  pushable              As Integer                        
  
  radius                As Double
  


  

  return_trig           As Integer                        
  
  shifty                As Integer                        
  shifty_lock           As Integer                        
  shifty_state          As Integer                        
  
  slide_hold            As Double                         
  
  song_fade_count       As Integer                        

  sound                 As Integer Ptr
  sounds                As Integer                        
  
  spawn_x               As Integer                        
  spawn_y               As Integer                        
  
  spawn_h               As uShort                         
  is_h_set              As uShort                         
  
  spawn_d               As Integer                         
  is_d_set              As Integer                         
  
  spawns_id             As String

  star_weak             As Integer                        
  
  state_shift           As Integer                        
  
  sticky_chase          As Integer                        
  
  strength              As Integer                        
  
  
  
  to_entry              As Integer                        
  to_map                As String
  
  torch                 As Integer                        
  
  touch_sequence        As Integer                        
  
  trigger               As Integer                        
  
  uni_directional       As Integer                        
  unique_id             As Integer
  
  unstoppable_by_tile   As Integer                        
  unstoppable_by_object As Integer                        
  unstoppable_by_screen As Integer                        
  
  vision_field          As Integer                        
  side_vision As Integer
  

  vol_fade              As Integer                        
  vol_fade_lock         As Double                         
  vol_fade_time         As Double                         
  vol_fade_trig         As Integer                        
  
  walk_buffer           As Integer                        
  walk_hold             As Double                         
  walk_speed            As Double                         
  walk_length           As Integer                        
  walk_steps            As Double                         
  
  
  x_origin              As Integer                        
  y_origin              As Integer                        

  yet_spawned           As Integer                        
    


  vol As Integer Ptr
  sample_fade_lock As Integer
  sample_vol_store As Integer

  #IfDef ll_audio
    playing_handle As hchannel
    
  #Else
    playing_handle As uInteger
    
  #EndIf  



  '' sequence crap
  '' ==========================
    action_sequence       As Integer                        
    chap                  As Integer                        
    dest_x                As Integer                        
    dest_y                As Integer                        
    
    sel_seq               As Integer                        
    seq                   As sequence_type Ptr              
    seq_here              As Integer                        
    seq_paused            As Integer                        
    seq_release           As Integer                        
    


  '' ==========================
  '' Eliminate/change these.  
  '' ==========================

    elite                 As Integer                        
    frame_check           As Integer                        

    melt                  As Integer                        
    
    menu_lock             As Integer                        
    menu_sel              As Integer                        

    mini_boss             As Integer                        

    orb_hac               As Integer                        

    read_lock             As Integer                        
    
    reset_delay           As Double                         

    stun_return_trig      As Integer                        


  '' ==========================
  '' Eliminate/change these.  
  '' ==========================

    save                 ( 3 )   As save_dat  
    
    coords As Vector
    
    spawn_cond As Integer
    spawn_info As LLObject_ConditionalSpawn Ptr

    perimeter As Vector


  '' Flyback information struct(s) suggestion:
  ''
  '' Operates with:
  ''
  '' Flyback information is held inside this struct. this struct contains
  '' various information about the object's flyback properties, speed, length, etc.
  '' 
  '' 
  ''   Type ll_entity_flyback
  '' 
  ''     fly_count  As Integer                        
  ''     fly_hold   As Integer                        
  ''     fly_length As Integer                        
  ''     fly_speed  As Double                         
  ''     fly_timer  As Double                         
  ''     fly_vector as Vector
  ''     
  ''   End Type
  ''
    fly_count             As Integer                        
    fly_hold              As Integer                        
    fly_length            As Integer                        
    fly_speed             As Double                         
    fly_timer             As Double                         
    fly As vector



    spawn_wait_trig As Integer
    spawn_kill_trig As Integer
    spawn_active_trig As Integer

    
    proj_style As LLPROJECTILE_STYLES
    projectile As ll_entity_projectile Ptr
    
    


  '' ==========================


  
  drop                  As _char_type    Ptr              
  dropped               As Integer                        
  

  
  cur_expl              As Integer                        
  
  explosions            As Integer                        
  
  expl_delay            As Double                         
  expl_timer            As Double                         
  expl_x_off            As Integer                        
  expl_x_size           As Integer                        
  expl_y_off            As Integer                        
  expl_y_size           As Integer                        
  explosion( 63 )       As mat_expl  
  
  

  

  '' Explosion information struct(s) suggestion:
  ''
  '' Operates with:
  ''
  '' Explosion information is held inside this struct. this struct contains
  '' various information about the object's explosion dimensions, speed, size, etc.
  '' 
  '' 
  ''   Type ll_entity_explosion_properties 
  '' 
  ''     explosions  As Integer                        
  ''     
  ''     expl_delay  As Double                         
  ''     expl_timer  As Double                         
  ''     expl_offset As Vector
  ''     expl_size   As Vector
  ''     explosion   As mat_expl Ptr
  ''     
  ''   End Type
  ''
  ''
  ''   Type ll_entity_explosion
  ''
  ''     '' description of damaging entity.
  ''     '' 0 = no damage, 1 = room enemy, 2 = temporary room enemy, 3 = lynn
  ''     info As ll_entity_explosion_properties Ptr
  ''     
  ''   End Type
  







  '' gfx stuff....  
  '' ==========================
    fade_count            As Integer                        
    fade_out              As Integer                        
    fade_time             As Double                         
    fade_timer            As Double                         


    flash_count           As Integer                        
    flash_length          As Integer                        
    flash_time            As Double                         
    flash_timer           As Double                         


  '' ==========================


  psycho As Integer  

  
  
  reserved_2            As Integer                        
  reserved_3            As Integer                        
  reserved_4            As Integer                        
  reserved_5            As Integer                        
  reserved_6            As Integer                        
  
End Type



Declare sub LLSystem_CacheObjectFiles( pth As String     )

Declare Function LLSystem_ObjectDeref     ( index As Integer  ) As _char_type Ptr
Declare Function LLSystem_ObjectDerefName ( index As String   ) As LLSystem_ObjectHandle

Declare Sub      LLSystem_CopyNewObject   ( objectCopy     As char_type )
Declare Sub      LLSystem_ObjectRelease   ( objectDestroy As _char_type, debugString As String = "" )

Declare Sub      LLSystem_ObjectDeepCopy  ( d  As _char_type, s As _char_type )
                 
Declare Sub      LLSystem_ClearObjectCache()


Declare Sub LLSystem_ClearObjectStrings( objectClear As _char_type )
