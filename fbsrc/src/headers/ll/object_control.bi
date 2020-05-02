Type LLObject_CollisionType

  isColliding As Integer
  faces As vector_Integer
  
End Type



Declare Sub LLSystem_ObjectFromXML( ByVal x As xml_type Ptr, objectLoad As _char_type, concat As String = "" )
Declare Function LLObject_IgnoreDirectional( this As char_type Ptr ) As Integer


Declare Function LLSystem_ObjectLoad( objectLoad As _char_type ) As Integer



Declare Function out_proximity(  As _char_type Ptr ) As Integer
Declare Function in_proximity(  As _char_type Ptr ) As Integer






Declare Sub set_up_room_enemies( enemies As Integer, enemy As _char_type Ptr )










Declare Function __check_lynn_contact     ( As _char_type Ptr ) As Integer 


Declare Function __active_anim            ( As _char_type Ptr ) As Integer 
Declare Function __active_anim_0          ( As _char_type Ptr ) As Integer 
Declare Function __active_anim_1          ( As _char_type Ptr ) As Integer 
Declare Function __active_anim_2          ( As _char_type Ptr ) As Integer 
Declare Function __active_anim_3          ( As _char_type Ptr ) As Integer 
Declare Function __active_anim_4          ( As _char_type Ptr ) As Integer 
Declare Function __active_anim_5          ( As _char_type Ptr ) As Integer 
Declare Function __active_anim_6          ( As _char_type Ptr ) As Integer 
Declare Function __active_anim_7          ( As _char_type Ptr ) As Integer 
Declare Function __active_anim_8          ( As _char_type Ptr ) As Integer 
Declare Function __active_anim_9          ( As _char_type Ptr ) As Integer 
Declare Function __active_anim_10         ( As _char_type Ptr ) As Integer 
Declare Function __active_anim_dead       ( As _char_type Ptr ) As Integer
Declare Function __active_animate         ( As _char_type Ptr ) As Integer 
Declare Function __active_animate_x       ( As _char_type Ptr ) As Integer 


Declare Function __anger_fireball_circle  ( As _char_type Ptr ) As Integer
Declare Function __anger_fireball_lock    ( As _char_type Ptr ) As Integer
Declare Function __anger_flyback          ( As _char_type Ptr ) As Integer
Declare Function __anger_shoot            ( As _char_type Ptr ) As Integer
Declare Function __anger_teleport         ( As _char_type Ptr ) As Integer
Declare Function __anger_trigger          ( As _char_type Ptr ) As Integer
Declare Function __anger_fireball         ( As _char_type Ptr ) As Integer
Declare Function __anger_fireball2        ( As _char_type Ptr ) As Integer
Declare Function __anger_kill_fireball    ( As _char_type Ptr ) As Integer
Declare Function __anger_middle           ( As _char_type Ptr ) As Integer
Declare Function __anger_new_fireball     ( As _char_type Ptr ) As Integer
Declare Function __do_anger_proj          ( As _char_type Ptr ) As Integer



Declare Function __bat_path               ( As _char_type Ptr ) As Integer 
Declare Function __big_color_down         ( As _char_type Ptr ) As Integer 
Declare Function __big_color_up           ( As _char_type Ptr ) As Integer 
Declare Sub       _blit                   ( As _char_type Ptr )
Declare Function __calc_slide             ( As _char_type Ptr ) As Integer
Declare Function __cell_bounce            ( As _char_type Ptr ) As Integer 
Declare Function __change_map             ( As _char_type Ptr ) As Integer 
Declare Function __chapter_1_off          ( As _char_type Ptr ) As Integer 
Declare Function __chapter_1_on           ( As _char_type Ptr ) As Integer 
Declare Function __chase                  ( As _char_type Ptr ) As Integer 
Declare Function __check_b_key            ( As _char_type Ptr ) As Integer 
Declare Function __check_key              ( As _char_type Ptr ) As Integer 
Declare Function __check_trigger          ( As _char_type Ptr ) As Integer 
Declare Function __color_down             ( As _char_type Ptr ) As Integer 
Declare Function __color_off              ( As _char_type Ptr ) As Integer 
Declare Function __color_on               ( As _char_type Ptr ) As Integer 
Declare Function __color_up               ( As _char_type Ptr ) As Integer 
Declare Function __cond_jump              ( As _char_type Ptr ) As Integer 
Declare Function __cond_trigger_projectile( As _char_type Ptr ) As Integer 
Declare Function __cool_down              ( As _char_type Ptr ) As Integer 
Declare Function __copter_path            ( As _char_type Ptr ) As Integer 
Declare Function __counted_jump           ( As _char_type Ptr ) As Integer 
Declare Function __counted_jump_2         ( As _char_type Ptr ) As Integer 
Declare Function __cripple                ( As _char_type Ptr ) As Integer 
Declare Function __dead_animate           ( As _char_type Ptr ) As Integer 
Declare Function __dir_down               ( As _char_type Ptr ) As Integer 
Declare Function __dir_left               ( As _char_type Ptr ) As Integer 
Declare Function __dir_right              ( As _char_type Ptr ) As Integer 
Declare Function __dir_up                 ( As _char_type Ptr ) As Integer 
Declare Function __directional_animate    ( As _char_type Ptr ) As Integer 
Declare Function __directional_animate_x  ( As _char_type Ptr ) As Integer 
Declare Function __do_circle              ( As _char_type Ptr ) As Integer 
Declare Function __do_flyback             ( As _char_type Ptr ) As Integer 
Declare Function __do_grult_proj          ( As _char_type Ptr ) As Integer 
Declare Function __do_menu                ( As _char_type Ptr ) As Integer 
Declare Function __do_menu_continue       ( As _char_type Ptr ) As Integer 
Declare Function __do_menu_save           ( As _char_type Ptr ) As Integer 
Declare Function __do_nothing             ( As _char_type Ptr ) As Integer 
Declare Function __do_proj                ( As _char_type Ptr ) As Integer 
Declare Function __do_vol_fade            ( As _char_type Ptr ) As Integer 
Declare Function __drop                   ( As _char_type Ptr ) As Integer 
Declare Function __dyssius_slide          ( As _char_type Ptr ) As Integer 
Declare Function __dyssius_after_slide    ( As _char_type Ptr ) As Integer 
Declare Function __dyssius_idle_gate      ( As _char_type Ptr ) As Integer
Declare Function __dyssius_jump_slide     ( As _char_type Ptr ) As Integer
Declare Function __dyssius_flyback        ( As _char_type Ptr ) As Integer
Declare Function __dyssius_patience       ( As _char_type Ptr ) As Integer
Declare Function __dyssius_eye_explode    ( As _char_type Ptr ) As Integer
Declare Function __dyssius_full_explode   ( As _char_type Ptr ) As Integer
Declare Function __do_dyssius_proj        ( As _char_type Ptr ) As Integer

Declare Function __eat_lynn_action        ( As _char_type Ptr ) As Integer
Declare Function __end                    ( As _char_type Ptr ) As Integer 
Declare Function __explode                ( As _char_type Ptr ) As Integer 
Declare Function __explode_jump           ( As _char_type Ptr ) As Integer 
Declare Function __fade_off               ( As _char_type Ptr ) As Integer 
Declare Function __fade_to_black          ( As _char_type Ptr ) As Integer 
Declare Function __fade_to_red            ( As _char_type Ptr ) As Integer 
Declare Function __fade_to_white          ( As _char_type Ptr ) As Integer 
Declare Function __fade_up_to_color       ( As _char_type Ptr ) As Integer 
Declare Function __far                    ( As _char_type Ptr ) As Integer 
Declare Function __flash                  ( As _char_type Ptr ) As Integer 
Declare Function __flash_down             ( As _char_type Ptr ) As Integer 
Declare Function __flashy                 ( As _char_type Ptr ) As Integer 
Declare Function __flicker                ( As _char_type Ptr ) As Integer 
Declare Function __full_heal              ( As _char_type Ptr ) As Integer 
Declare Function __gen_frame              ( As _char_type Ptr ) As Integer 
Declare Function __give_b_key             ( As _char_type Ptr ) As Integer 
Declare Function __give_item              ( As _char_type Ptr ) As Integer 
Declare Function __give_key               ( As _char_type Ptr ) As Integer 
Declare Function __give_weapon            ( As _char_type Ptr ) As Integer 
Declare Function __go_grip                ( As _char_type Ptr ) As Integer 
Declare Function __grult_fireball         ( As _char_type Ptr ) As Integer 
Declare Function __half_second_pause      ( As _char_type Ptr ) As Integer 
Declare Function __handle_menu            ( As _char_type Ptr ) As Integer
Declare Function __home                   ( As _char_type Ptr ) As Integer 
Declare Function __idle_animate           ( As _char_type Ptr ) As Integer 
Declare Function __if_all_dead            ( As _char_type Ptr ) As Integer 
Declare Function __inc_sel_seq            ( As _char_type Ptr ) As Integer 
Declare Function __infinity               ( As _char_type Ptr ) As Integer 
Declare Function __jump_2_back            ( As _char_type Ptr ) As Integer 
Declare Function __kill_song              ( As _char_type Ptr ) As Integer 
Declare Function __lunge                  ( As _char_type Ptr ) As Integer 
Declare Function __lunge_return           ( As _char_type Ptr ) As Integer 
Declare Function __make_align             ( As _char_type Ptr ) As Integer 
Declare Function __make_dead              ( As _char_type Ptr ) As Integer 
Declare Function __make_enemy             ( As _char_type Ptr ) As Integer 
Declare Function __make_face              ( As _char_type Ptr ) As Integer 
Declare Function __make_invincible        ( As _char_type Ptr ) As Integer 
Declare Function __make_invisible         ( As _char_type Ptr ) As Integer 
Declare Function __make_visible           ( As _char_type Ptr ) As Integer 
Declare Function __make_vulnerable        ( As _char_type Ptr ) As Integer 
Declare Function __melt                   ( As _char_type Ptr ) As Integer 
Declare Function __momentum_move          ( As _char_type Ptr ) As Integer 
Declare Function __move_down              ( As _char_type Ptr ) As Integer 
Declare Function __move_left              ( As _char_type Ptr ) As Integer 
Declare Function __move_right             ( As _char_type Ptr ) As Integer 
Declare Function __move_up                ( As _char_type Ptr ) As Integer 
Declare Function __move_upright           ( As _char_type Ptr ) As Integer 
Declare Function __near                   ( As _char_type Ptr ) As Integer 
Declare Function __off_happen             ( As _char_type Ptr ) As Integer 
Declare Function __play_dead_sound        ( As _char_type Ptr ) As Integer 
Declare Function __play_seq               ( As _char_type Ptr ) As Integer 
Declare Function __play_sound             ( As _char_type Ptr ) As Integer 
Declare Function __poll_action            ( As _char_type Ptr ) As Integer 
Declare Function __push                   ( As _char_type Ptr ) As Integer 
Declare Function __q_second_pause         ( As _char_type Ptr ) As Integer 
Declare Function __randomize_path         ( As _char_type Ptr ) As Integer 
Declare Function __release_seq            ( As _char_type Ptr ) As Integer 
Declare Function __reset_enemy            ( As _char_type Ptr ) As Integer
Declare Function __reset_frame            ( As _char_type Ptr ) As Integer 
Declare Function __return_idle            ( As _char_type Ptr ) As Integer 
Declare Function __return_reset           ( As _char_type Ptr ) As Integer
Declare Function __return_jump            ( As _char_type Ptr ) As Integer
Declare Function __return_jump_1          ( As _char_type Ptr ) As Integer 
Declare Function __return_jump_back       ( As _char_type Ptr ) As Integer 
Declare Function __return_trig            ( As _char_type Ptr ) As Integer 
Declare Function __second_pause           ( As _char_type Ptr ) As Integer 
Declare Function __set_fade               ( As _char_type Ptr ) As Integer 
Declare Function __set_func               ( As _char_type Ptr ) As Integer 
Declare Function __set_happen             ( As _char_type Ptr ) As Integer 
Declare Function __set_vol_fade           ( As _char_type Ptr ) As Integer 
Declare Function __stop_grip              ( As _char_type Ptr ) As Integer 
Declare Function __stop_sound             ( As _char_type Ptr ) As Integer 
Declare Function __sterach_call           ( As _char_type Ptr ) As Integer 
Declare Function __sword_angle            ( As _char_type Ptr ) As Integer
Declare Function __sword_fly              ( As _char_type Ptr ) As Integer
Declare Function __sword_glow             ( As _char_type Ptr ) As Integer
Declare Function __sword_jump             ( As _char_type Ptr ) As Integer
Declare Function __sword_return           ( As _char_type Ptr ) As Integer



Declare Function __tile_up                ( As _char_type Ptr ) As Integer 
Declare Function __timed_jump             ( As _char_type Ptr ) As Integer 
Declare Function __timed_jump_2           ( As _char_type Ptr ) As Integer 
Declare Function __trigger_projectile     ( As _char_type Ptr ) As Integer 
Declare Function __true_active_animate    ( As _char_type Ptr ) As Integer 
Declare Function __up_face                ( As _char_type Ptr ) As Integer 
Declare Function __walk                   ( As _char_type Ptr ) As Integer 
Declare Function __weapon_anim            ( As _char_type Ptr ) As Integer 


Declare Function __invis_entry ( this As _char_type Ptr ) As Integer



Declare Function __move_backwards( this As _char_type Ptr ) As Integer
Declare Function __move_normal( this As _char_type Ptr ) As Integer
Declare Function __after_moenia_townspeople( this As char_type Ptr ) As Integer 

Declare Function __set_camera( this As char_type Ptr ) As Integer 


Declare Function LLObject_IncrementFrame( this As char_type Ptr ) As Integer
Declare Function __explode_lynn( this As _char_type Ptr ) As Integer
Declare Function __push_lynn_back( this As char_type Ptr ) As Integer

Declare Function __drop_b_key ( this As _char_type Ptr ) As Integer
Declare Function __bridge_chasm ( this As _char_type Ptr ) As Integer

Declare Function __fade_down_to_color( this As _char_type Ptr ) As Integer

Declare Function __make_black_and_white ( this As _char_type Ptr ) As Integer
'Declare Function LLObject_IsWithin( this As char_type Ptr ) As Integer 

declare Function __black_text_on ( this As _char_type Ptr ) As Integer
declare Function __give_weapon2 ( this As _char_type Ptr ) As Integer

declare Function __return_jump_npc( this As _char_type Ptr ) As Integer

declare Function __return_reset_npc ( this As _char_type Ptr ) As Integer

Declare Function __kill_all_temps ( this As _char_type Ptr ) As Integer

Declare Function __give_100_gold ( this As _char_type Ptr ) As Integer

Declare Function __after_slime( this As char_type Ptr ) As Integer 
Declare Function __play_song ( this As _char_type Ptr ) As Integer


Declare Function LLObject_Collision( o As char_type, o2 As char_type ) As LLObject_CollisionType
Declare Sub LLObject_VectorPosition( obj As char_type, vecPair As vector_pair, faceIndex As Integer )
Declare Function __charger_charge( this As _char_type Ptr ) As Integer


Declare Function __set_white_fade( this As _char_type Ptr ) As Integer




Declare Function __set_gray_fade( this As _char_type Ptr ) As Integer
Declare Function __fade_down_to_gray( this As _char_type Ptr ) As Integer
Declare Function __flash_down_gray( this As _char_type Ptr ) As Integer
declare Function __templewood_bridge( this As char_type Ptr ) As Integer 


Declare Function __arx_bridge( this As char_type Ptr ) As Integer 
Declare Function __check_for_dead_faces( this As char_type Ptr ) As Integer 

Declare Function __bandit_check( this As char_type Ptr ) As Integer 
Declare Function __give_gold_amount( this As char_type Ptr ) As Integer 
Declare Function __heal_lynn( this As char_type Ptr ) As Integer 
Declare Function __divine_ball_return( this As char_type Ptr ) As Integer 
declare Function __divine_fireball( this As char_type Ptr ) As Integer 

Declare Function __turn_on_tiles( this As char_type Ptr ) As Integer 
Declare Function __turn_off_tiles( this As char_type Ptr ) As Integer 


Declare Function __logosta_console( this As char_type Ptr ) As Integer 
Declare Function __quake( this As char_type Ptr ) As Integer 
Declare Function __steel_slide( this As _char_type Ptr ) As Integer

Declare Function __back_3( this As _char_type Ptr ) As Integer


Declare Function __set_explosions( this As _char_type Ptr ) As Integer
Declare Function __red_tint( this As _char_type Ptr ) As Integer
Declare Function __set_anim( this As _char_type Ptr ) As Integer



declare Function __set_font_fg( this As char_type Ptr ) As Integer 
declare Function __set_font_bg( this As char_type Ptr ) As Integer 
declare Function __translate_result( this As char_type Ptr ) As Integer 
declare Function __buy_health( this As char_type Ptr ) As Integer 
declare Function __healthguy_branch( this As char_type Ptr ) As Integer 

Declare Function __give_costume( this As char_type Ptr ) As Integer 
Declare Function __fade_music_out( this As char_type Ptr ) As Integer 

declare Function __outfit_branch( this As char_type Ptr ) As Integer 
declare Function __give_outfit( this As char_type Ptr ) As Integer 


declare Function __dec_sel_seq( this As char_type Ptr ) As Integer 
declare Function __poondodge_branch( this As char_type Ptr ) As Integer 

declare Function __moth_random_loc( this As char_type Ptr ) As Integer 
declare Function __seed_random_loc( this As char_type Ptr ) As Integer 

declare Function __moth_random_proj( this As char_type Ptr ) As Integer 

declare Function __set_finish( this As char_type Ptr ) As Integer 

declare Function __outfit_swap( this As char_type Ptr ) As Integer 
declare Function __set_song( this As char_type Ptr ) As Integer 

