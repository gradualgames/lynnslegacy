declare sub writeQuoteScroll()

'' ___structors section


  Declare Function load_map Overload ( filename As String, As Integer = 0 ) As map_type Ptr
  
'  Declare Sub load_image( As image_header, As Integer = 0 ) 
  
  Declare Sub LLSystem_ImageSave( image_tag As LLSystem_ImageHeader )
  Declare Sub LLSystem_ImageSaveCollision( image_tag As LLSystem_ImageHeader )

  
  Declare Sub load_seq( ff As Integer, seqs As Integer, s As sequence_type Ptr, de As list_type Ptr )

  Declare Function load_mapV( buffer() As uByte, bypass_errors As Integer = 0 ) As map_type Ptr
  Declare Sub load_seqV( ff As Integer, seqs As Integer, s As sequence_type Ptr, de As list_type Ptr, t As String, i As Integer )

  Declare Sub save_seqV( ff As Integer, n As Integer, s As sequence_type Ptr )
  Declare Sub save_mapV ( filename As String, smap As map_type Ptr )

  Declare Sub seq_id( seqs As Integer, s As sequence_type Ptr, e As char_type Ptr )


  Declare Sub destroy_obj_anims( c As char_type Ptr )
  Declare Sub destroy_obj_funcs( c As char_type Ptr )
  Declare Sub initialize_enemy( e As char_type Ptr )
  Declare Sub clear_enemy_array( enemies As Integer, enemy As char_type Ptr )

  Declare Sub destroy_anim_array( anims As Integer, anim As LLSystem_ImageHeader Ptr )
  Declare Sub destroy_enemy_array( enemies As Integer, enemy As char_type Ptr )
  Declare Sub map_Destroy( m As map_type Ptr )
  
  Declare Sub sequence_Destroy( sequenceDestroy As sequence_type )
  
  Declare Sub reset_enemy( As char_type Ptr )


  Declare Function init_bin_obj( c As Integer = 0, isp As b_sub = 0, osp As b_sub = 0 ) As b_data
  
  
  Declare Sub load_entrypoint()
  
  Declare Sub check_for_unique( c As char_type Ptr )
  
  Declare Function ctor_hero( l As char_type Ptr = 0 ) As char_type Ptr
                                                                         
  Declare Sub load_status_images( t As load_savImage Ptr )
  Declare Sub load_hud( h As load_hudImage Ptr )
  
  Declare Sub Engine_init()
  
'' end ___structors section









'' save section


  Declare Sub save_seq( ff As Integer, n As Integer, s As sequence_type Ptr )
  Declare Sub save_map ( filename As String, smap As map_type Ptr )


'' end save section












'' special section


	'' binary objects
    Declare Sub bin_obj( b As b_data )


    
    Declare Sub act_key_in_sub( ip As Integer Ptr, op As Integer Ptr )
    Declare Sub act_key_out_sub( ip As Integer Ptr, op As Integer Ptr )
    
    Declare Sub atk_key_in_sub( ip As Integer Ptr, op As Integer Ptr )  
    Declare Sub atk_key_out_sub( ip As Integer Ptr, op As Integer Ptr ) 
    
    Declare Sub conf_key_out_sub( ip As Integer Ptr, op As Integer Ptr )
    Declare Sub conf_key_in_sub( ip As Integer Ptr, op As Integer Ptr )
    
    Declare Sub item_r_key_out_sub( ip As Integer Ptr, op As Integer Ptr )
    Declare Sub item_r_key_in_sub( ip As Integer Ptr, op As Integer Ptr )
    Declare Sub item_l_key_out_sub( ip As Integer Ptr, op As Integer Ptr )
    Declare Sub item_l_key_in_sub( ip As Integer Ptr, op As Integer Ptr )
    
    Declare Sub weap_switch_key_out_sub( ip As Integer Ptr, op As Integer Ptr )
    Declare Sub weap_switch_key_in_sub( ip As Integer Ptr, op As Integer Ptr )
    
  '' end binary objects 


  
'' end special section







Declare Sub enter_map ( _char As char_type Ptr, _m As map_type Ptr, desc As String, _entry As Integer )
Declare Sub act_enemies( _enemies As Integer, _enemy As char_type Ptr )
Declare Sub ll_main_entry()                                                                         

Declare Sub update_cam( mn As char_type Ptr = 0 ) 


Declare Function move_object( o As char_type Ptr, only_looking As Integer = 0, moment As Double = 1, recurring As Integer = 0 ) As uInteger
Declare Function check_walk ( o As char_type Ptr, d As Integer, psfing = 0 )
Declare Function check_against_entities( d As Integer = 0, o As char_type Ptr ) As Integer
Declare Function check_against( o As char_type Ptr, othr As char_type Ptr, check As Integer, d As Integer )





Declare Function check_collision( imp_x As Integer, imp_y As Integer, dead_x As Integer, dead_y As Integer, dead_anim_y As Integer, id_y As Integer ) As Integer
Declare Sub check_psf( o As char_type Ptr, d As Integer ) 
Declare Function quad_seek( t_in As tile_quad, d As Integer ) As tile_quad
Declare Function bigger( t As char_type Ptr, m As char_type Ptr ) As Integer


Declare Sub del_room_enemies( enemies As Integer, enemy As char_type Ptr )

Declare Sub change_room( o As char_type Ptr, _call As Byte = 0, t As Integer = 0 )
Declare Sub enemy_main()


Declare Function is_facing( o As _char_type Ptr, o2 As _char_type Ptr ) As Integer

Declare Sub dir_keys()
Declare Sub hero_main()



Declare Sub hero_attack( hr As _char_type Ptr )
Declare Sub attack_compare( _enemies As Integer, _enemy As _char_type Ptr, hr As _char_type Ptr )
Declare Sub hero_damages( hr As _char_type Ptr )

Declare Sub calc_hero_damage( _enemy As _char_type Ptr, h As _char_type Ptr )

Declare Sub hero_enemy_contact( _enemies As Integer, _enemy As _char_type Ptr, hr As _char_type Ptr )
Declare Sub hero_proj_contact( _enemies As Integer, _enemy As _char_type Ptr, h As _char_type Ptr )
Declare Sub decay_crazy()
Declare Sub hero_continue_movement( mn As _char_type Ptr )
Declare Sub play_sequence ( _seq As sequence_type Ptr )

'Declare Function destroy_box( b As boxcontrol_type Ptr ) As Integer
Declare Sub destroy_box( b As boxcontrol_type Ptr )

Declare Function make_box( txt As String, a_lock As Integer, clr As Short, invis As Short, auto As Double, x As Short, y As Short, spd As Integer ) As boxcontrol_type
Declare Sub init_box( ByVal text As String, b As boxcontrol_type Ptr ) 
Declare Sub maintain_temps( r As room_type Ptr )
Declare Sub mem_swap ( swap_1 As Any Ptr, swap_2 As Any Ptr, sz As uInteger )

Declare Sub echo_print( x As String, arg As Integer = 0 )












Declare Function play_sample( s As uInteger, v As Integer = 0 ) As uInteger



'Declare Sub calc_positions Overload ( obj As char_type Ptr, _imp As Integer, x As Integer, y As Integer, rx As Integer, ry As Integer, _face As Integer )
Declare Sub calc_positions( obj As char_type Ptr, v As vector_pair, _face As Integer )



Declare Function touched_frame_face( c As char_type Ptr, v As vector_pair ) As Integer
Declare Function touched_bound_box( c As char_type Ptr, v As vector_pair ) As Integer

Declare Function touched_bound_boxes( c As char_type Ptr, c2 As char_type Ptr ) As Integer


Declare Function object_vectors( o As char_type Ptr ) As vector_pair
'Declare Function llObject_SizeVector( o As char_type Ptr ) As vector
Declare Function llObject_LocationVector( o As char_type Ptr ) As vector

Declare Sub LLObject_MAINDamage( hr As _char_type Ptr )

Declare Sub LLObject_ShiftState( h As char_type Ptr, s As Integer )
Declare Sub LLObject_ClearDamage( h As char_type Ptr )


Declare Sub LLObject_DeriveHurt( h As char_type Ptr )
Declare Sub LLObject_ProcessHurt( h As char_type Ptr )
Declare Sub LLObject_DamageCalc( h As _char_type Ptr )
Declare Sub LLObject_ProjectileDamage( _objects As Integer, _object As _char_type Ptr, h As _char_type Ptr )
Declare Sub LLObject_ObjectDamage( _enemies As Integer, _enemy As _char_type Ptr, hr As _char_type Ptr, e_type As Integer = DF_ROOM_ENEMY )

Declare Sub LLObject_MAINAttack( _enemies As Integer, _enemy As _char_type Ptr, hr As _char_type Ptr )

Declare Sub destroy_status_images( t As load_savImage Ptr )
Declare Sub destroy_hud( h As load_hudImage Ptr )
Declare Function LLObject_VectorPair( o As char_type Ptr ) As vector_pair

Declare Function LLObject_VectorPairEx( o As char_type Ptr, op As Integer = 0, par As Integer = 0 ) As vector_pair



Declare Sub LLEngine_ExecuteConcurrents( o As char_type Ptr )
Declare Sub LLObject_TorchModify( o As char_type Ptr )
Declare Sub LLObject_GrabItems( o As char_type Ptr )
Declare Sub LLObject_TouchSequence( o As char_type Ptr )
Declare Sub LLObject_ActionSequence( o As char_type Ptr )
declare Sub LLObject_CheckSpawn( o As char_type Ptr )




Declare Function LLObject_SpawnKill( o As char_type Ptr ) As Integer
Declare Function LLObject_SpawnWait( o As char_type Ptr ) As Integer
          
                                                                                  


Declare Function LLSystem_LoadMap( s As String, a As Integer = 0 ) As map_type Ptr

Declare Function LLSystem_ReadSaveFile ( saveName As String ) As ll_saving_data Ptr
Declare Sub      LLSystem_WriteSaveFile( saveName As String, entry As Integer )

Declare Sub blit_object_ex( this As char_type Ptr )
Declare Sub hud_BlitMain( this As char_type Ptr )
Declare Function hud_IsShowing( this As char_type Ptr ) As Integer
Declare Sub hud_BlitEnemy( this As char_type Ptr, ctr As Integer )
Declare Sub hud_BlitEnemies()
Declare Sub LLObject_CheckGTorchLit( this As char_type Ptr )


Declare Sub BinObj_destroy( BinObjDestroy As b_data )






Declare Sub LLSystem_Log( x As String, f As String = "log.txt" )

Declare Sub cache_crazy()
Declare Sub load_menu()
Declare Sub menu_Blit()
Declare Function menu_Input()
Declare Sub menu_StringInit()
Declare Sub jump_to_title()

Declare Sub handle_pause_menu()
Declare Sub wanna_quit()

Declare Sub check_env_sounds()



Declare Sub init_splash()


Declare Function LLMiniMap_SizeX()
Declare Function LLMiniMap_SizeY()


Declare Sub LLSystem_LoadMiniMap( map_Active As map_type Ptr, minimap_Filename As String )
Declare Sub minimap_Blit()
Declare Sub LLScreenFlip()
Declare Sub handle_MiniMap()

Declare Sub minimap_destroy( minimap_local As LL_MiniMapType )


Declare Sub      LLMiniMap_SaveMiniMap( minimap_Local As LL_MiniMapType, fileName As String )
Declare Function LLMiniMap_LoadMiniMap( fileName As String, rooms As Integer ) As LL_MiniMapType

Declare Sub LLMiniMap_UpdateCam( minimap_Local As LL_MiniMapType ) 



Declare Sub LLObject_ClearProjectiles( char As char_type )
Declare Sub LLObject_IncrementProjectiles( char As char_type )
Declare Sub LLObject_InitializeProjectiles( char As char_type )

Declare Sub sequence_FullReset( resetSequence As sequence_type ) 
Declare Sub screenQuake()

Declare Sub LLMusic_SetVolume( volumeDesired As Integer )
Declare Sub LLMusic_Stop()
Declare Sub LLMusic_Start( songName As String )

Declare Sub LLMusic_Fade()



declare sub LL_RollCredits()
declare sub graphicalString( printString as string, byval x as integer, byval y as integer, byval col as integer = 15 )
