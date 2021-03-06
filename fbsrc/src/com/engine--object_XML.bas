#Include "..\headers\ll.bi"
Option Explicit

'#Define LL_OBJECTLOADPROGRESS

Sub LLSystem_ObjectFromXML( ByVal x As xml_type Ptr, objectLoad As _char_type, concat As String = "" )' Static
  
  #Define func_drop objectLoad.funcs.func[objectLoad.funcs.active_state][objectLoad.funcs.current_func[objectLoad.funcs.active_state]]
  #Define inc_func  objectLoad.funcs.current_func[objectLoad.funcs.active_state] += 1: If objectLoad.funcs.current_func[objectLoad.funcs.active_state] = objectLoad.funcs.func_count[objectLoad.funcs.active_state] Then objectLoad.funcs.current_func[objectLoad.funcs.active_state] = 0
  
  With objectLoad

    Select Case x->key
      
      Case "sprite"
        .anims += 1
  
        .anim        = Reallocate( .anim,        .anims * Len( LLSystem_ImageHeader Ptr ) )
        .animControl = Reallocate( .animControl, .anims * Len( LLObject_ImageHeader     ) )
  
        .current_anim = .anims - 1
        .anim[.current_anim] = 0
        
        MemSet( Varptr( .animControl[.current_anim] ), 0, Len( LLObject_ImageHeader ) )
        
      Case "snd"
        .sounds += 1
  
        .sound = Reallocate( .sound, .sounds * Len( Integer ) )
        .vol   = Reallocate( .vol,   .sounds * Len( Integer ) )
        
        .sound[.sounds - 1] = 0
        .vol[.sounds - 1] = 0
        
      Case "fp"
        .funcs.states += 1
        
        .funcs.func_count   = Reallocate( .funcs.func_count,   .funcs.states * Len( Integer ) )
        .funcs.current_func = Reallocate( .funcs.current_func, .funcs.states * Len( Integer ) )
  
        .funcs.func         = Reallocate( .funcs.func,         .funcs.states * Len( fp Ptr )  )
        
        .funcs.active_state = .funcs.states - 1
  
        .funcs.func_count[.funcs.active_state] = 0
        .funcs.current_func[.funcs.active_state] = 0
        
        .funcs.func[.funcs.active_state] = 0
        
        Dim As Integer cn, c2
        
        Dim As list_type Ptr cn_thr
        
        cn_thr = x->list
        c2 = 0
        
        For cn = 0 To length( x->list ) - 1
          
          If CPtr( xml_type Ptr, cn_thr->dat.pnt )->key = "block_macro" Then

            Select Case CPtr( xml_type Ptr, cn_thr->dat.pnt )->list->dat.s

              Case "dead_block"
                c2 = 6
                Exit For
                
              Case "dead_drop_block"
                c2 = 7
                Exit For
                
              Case "fire_block"
                c2 = 3
                Exit For
                
              Case "ice_block"
                c2 = 3
                Exit For
                
            End Select
            
          End If
          
          If CPtr( xml_type Ptr, cn_thr->dat.pnt )->key = "func" Then
            c2 += 1
            
          End If
          
          cn_thr = cn_thr->nxt
          
        Next
  
        .funcs.func_count[.funcs.active_state] = c2
        .funcs.func[.funcs.active_state] = CAllocate( .funcs.func_count[.funcs.active_state] * Len( fp ) ) 
        
    End Select
    
  End With

  Dim As list_type Ptr thr
  
  thr = x->list

  If x->eol <> 0 Then
    
    If Instr( concat, "sprite->" ) Then
      
      With objectLoad

        Select Case LCase( x->key )
  
          Case "anim_id"
            
            Select Case LCase( thr->dat.s )
              Case "dead_anim"
                .dead_anim = .current_anim
              Case "proj_anim"
                .proj_anim = .current_anim
              Case "expl_anim"
                .expl_anim = .current_anim
              
            End Select
  
          Case "filename"
            .anim[.current_anim] = LLSystem_ImageDeref( LLSystem_ImageDerefName( thr->dat.s ) )
            
            .animControl[.current_anim].frame = CAllocate( Len( LLObject_FrameControl ) * ( .anim[.current_anim]->frames ) )
  
          Case "dir_frames"
            .animControl[.current_anim].dir_frames = Val( thr->dat.s )
  
          Case "rate"
            .animControl[.current_anim].rate       = Val( thr->dat.s )
          Case "madrate"
            .animControl[.current_anim].rateMad    = Val( thr->dat.s )
          Case "x_off"
            .animControl[.current_anim].x_off      = Val( thr->dat.s )
          Case "y_off"
            .animControl[.current_anim].y_off      = Val( thr->dat.s )
  
        End Select
        
      End With
        
      If Instr( concat, "sound->" ) Then  

        Select Case LCase( x->key )
          
          Case "frame"
            objectLoad.frame = Val( thr->dat.s )
  
          Case "uni_sound"
            objectLoad.anim[objectLoad.current_anim]->frame[objectLoad.frame].uni_sound = Val( thr->dat.s )
            
          Case "index"
          
            With objectLoad.anim[objectLoad.current_anim]->frame[objectLoad.frame]
          
              #macro LLObject_FrameSoundLoad(__FrameSound__)

                Case ###__FrameSound__
                
                  dim as integer iterateSounds, holdFrame

                  holdFrame = objectLoad.frame

                  for iterateSounds = 0 to iif( objectLoad.anim[objectLoad.current_anim]->frame[objectLoad.frame].uni_sound, 3, 0 )

                    objectLoad.anim[objectLoad.current_anim]->frame[objectLoad.frame].sound = __FrameSound__
                    objectLoad.frame += objectLoad.animControl[objectLoad.current_anim].dir_frames
                    
                  next

                  objectLoad.frame = holdFrame
                    
              #endmacro
              
              Select Case LCase( thr->dat.s )
                
                
                '' FRAME SOUNDS
                LLObject_FrameSoundLoad( sound_crateting )
                LLObject_FrameSoundLoad( sound_explosion )
                LLObject_FrameSoundLoad( sound_flare     )
                LLObject_FrameSoundLoad( sound_ice       )
                LLObject_FrameSoundLoad( sound_treepull  )
                LLObject_FrameSoundLoad( sound_mace_0    )
                LLObject_FrameSoundLoad( sound_mace_1    )
                LLObject_FrameSoundLoad( sound_mace_2    )
                LLObject_FrameSoundLoad( sound_rayflap2  )
                LLObject_FrameSoundLoad( sound_flap      )
                LLObject_FrameSoundLoad( sound_ferusstep )
                LLObject_FrameSoundLoad( sound_gunfire   )    
                  
              End Select
              
            End With
          
          Case "vol"

           dim as integer iterateSounds, holdFrame

            holdFrame = objectLoad.frame

            for iterateSounds = 0 to iif( objectLoad.anim[objectLoad.current_anim]->frame[objectLoad.frame].uni_sound, 3, 0 )

              objectLoad.anim[objectLoad.current_anim]->frame[objectLoad.frame].vol = Val( thr->dat.s )  
              objectLoad.frame += objectLoad.animControl[objectLoad.current_anim].dir_frames
              
            next

            objectLoad.frame = holdFrame
              
            
        End Select  
      
      ElseIf Instr( concat, "concurrent->" ) Then  
      
        Select Case LCase( x->key )
        
          Case "frame"

            #IfDef LL_OBJECTLOADPROGRESS
              LLSystem_Log( "Setting up concurrent on frame " & thr->dat.s & ".", "objectload.txt" )
              
            #EndIf
            
            objectLoad.frame = Val( LCase( thr->dat.s ) ) 
            
            With objectLoad.animControl[objectLoad.current_anim].frame[objectLoad.frame]
              .concurrents += 1

              #IfDef LL_OBJECTLOADPROGRESS
                LLSystem_Log( "Reallocating concurrent array.", "objectload.txt" )
                
              #EndIf

              .concurrent = Reallocate( .concurrent, .concurrents * Len( LLObject_FrameConcurrent ) )

              #IfDef LL_OBJECTLOADPROGRESS
                If .concurrent = 0 Then
                  LLSystem_Log( "Concurrent array: No memory to form!", "objectload.txt" )
                
                End If
              
                LLSystem_Log( "Initializing concurrent array.", "objectload.txt" )
                
              #EndIf

              MemSet( @.concurrent[.concurrents - 1], 0, Len( LLObject_FrameConcurrent ) )

              #IfDef LL_OBJECTLOADPROGRESS
                LLSystem_Log( "Initialized concurrent array.", "objectload.txt" )
                
              #EndIf
              
            End With
            
          Case "x"

            #IfDef LL_OBJECTLOADPROGRESS
              LLSystem_Log( "Setting up concurrent's x.", "objectload.txt" )
              
            #EndIf

            With objectLoad.animControl[objectLoad.current_anim].frame[objectLoad.frame]
              .concurrent[.concurrents - 1].origin.x = Val( LCase( thr->dat.s ) ) 
              
            End With
            
          Case "y"

            #IfDef LL_OBJECTLOADPROGRESS
              LLSystem_Log( "Setting up concurrent's y.", "objectload.txt" )
              
            #EndIf

            With objectLoad.animControl[objectLoad.current_anim].frame[objectLoad.frame]
              .concurrent[.concurrents - 1].origin.y = Val( LCase( thr->dat.s ) ) 
              
            End With
            
          Case "id"

            #IfDef LL_OBJECTLOADPROGRESS
              LLSystem_Log( "Setting up concurrent's object.", "objectload.txt" )
              
            #EndIf

            With objectLoad.animControl[objectLoad.current_anim].frame[objectLoad.frame]
              .concurrent[.concurrents - 1].char = CAllocate( Len( char_type ) )
              .concurrent[.concurrents - 1].char->id = LCase( thr->dat.s )
              
            End With
          
        End Select
            
      End If      
        
    ElseIf Instr( concat, "snd->" ) Then

      Select Case LCase( x->key )

        Case "vol"
          objectLoad.vol[objectLoad.sounds - 1] =  Val( thr->dat.s )

        Case "index"
          
          #Define LLObject_SoundLoad(__Sound__) _
            Case ###__Sound__: objectLoad.sound[objectLoad.sounds - 1] = __Sound__
          
          Select Case LCase( thr->dat.s )

            LLObject_SoundLoad( sound_bassdrop      )
            LLObject_SoundLoad( sound_beam          )
            LLObject_SoundLoad( sound_bigchest      )
            LLObject_SoundLoad( sound_boss_hit      )
            LLObject_SoundLoad( sound_cashget       )
            LLObject_SoundLoad( sound_doorfkey      )
            LLObject_SoundLoad( sound_doorsmall     )
            LLObject_SoundLoad( sound_enemyhit      )
            LLObject_SoundLoad( sound_enemykill     )
            LLObject_SoundLoad( sound_explosion     )
            LLObject_SoundLoad( sound_flare         )
            LLObject_SoundLoad( sound_healthgrab    )
            LLObject_SoundLoad( sound_heart         )
            LLObject_SoundLoad( sound_ice           )
            LLObject_SoundLoad( sound_portal        )
            LLObject_SoundLoad( sound_smallchest    )
            LLObject_SoundLoad( sound_switch        )
            LLObject_SoundLoad( sound_treepull      )
            LLObject_SoundLoad( sound_lowhealth     )
            LLObject_SoundLoad( sound_bush          )
            LLObject_SoundLoad( sound_crateting     )
            LLObject_SoundLoad( sound_sea           )
            LLObject_SoundLoad( sound_lynn_attack_1 )
            LLObject_SoundLoad( sound_lynn_attack_2 )
            LLObject_SoundLoad( sound_lynn_attack_3 )
            LLObject_SoundLoad( sound_lynn_attack_4 )
            LLObject_SoundLoad( sound_lynn_hurt_1   )
            LLObject_SoundLoad( sound_lynn_hurt_2   )
            LLObject_SoundLoad( sound_lynn_hurt_3   )
            LLObject_SoundLoad( sound_mace_0        )
            LLObject_SoundLoad( sound_mace_1        )
            LLObject_SoundLoad( sound_mace_2        )
            LLObject_SoundLoad( sound_texttemp      )
            LLObject_SoundLoad( sound_torchlight    )
            LLObject_SoundLoad( sound_greystatic    )
            LLObject_SoundLoad( sound_crickets      )
            LLObject_SoundLoad( sound_gulls2        )
            LLObject_SoundLoad( sound_rayflap2      )
            LLObject_SoundLoad( sound_flap          )
            LLObject_SoundLoad( sound_camera        )
            LLObject_SoundLoad( sound_beamcharge    )
            LLObject_SoundLoad( sound_ferusgarbled  )
            LLObject_SoundLoad( sound_ferusbeep     )
            LLObject_SoundLoad( sound_corealarm     )
            LLObject_SoundLoad( sound_coreclunk     )
            LLObject_SoundLoad( sound_corealarm2    )
            LLObject_SoundLoad( sound_rumble        )
            LLObject_SoundLoad( sound_limboloop     )
            LLObject_SoundLoad( sound_build         )
            LLObject_SoundLoad( sound_mothdie         )
            
                      
          End Select
          
      End Select

    ElseIf Instr( concat, "fp->" ) Then
      
      Select Case LCase( x->key )

        Case "proc_id"
          
          #Define LLObject_ProcIDLoad(__Proc_ID__) _
            Case ###__Proc_ID__: objectLoad.##__Proc_ID__ = objectLoad.funcs.active_state          

          Select Case LCase( thr->dat.s )

            LLObject_ProcIDLoad( hit_state    )
            LLObject_ProcIDLoad( attack_state )
            LLObject_ProcIDLoad( death_state  )
            LLObject_ProcIDLoad( fire_state   )
            LLObject_ProcIDLoad( hit_state    )
            LLObject_ProcIDLoad( ice_state    )
            LLObject_ProcIDLoad( jump_state   )
            LLObject_ProcIDLoad( proj_state   )
            LLObject_ProcIDLoad( reset_state  )
            LLObject_ProcIDLoad( stun_state   )
            LLObject_ProcIDLoad( thaw_state   )
            LLObject_ProcIDLoad( thrust_state )

          End Select

        Case "block_macro"


          #IfNDef LL_Minimal

            Select Case LCase( thr->dat.s )
              
              Case "dead_block"
                func_drop = CPtr( Any Ptr, @__make_dead        ): inc_func
                func_drop = CPtr( Any Ptr, @__active_anim_dead ): inc_func
                func_drop = CPtr( Any Ptr, @__dead_animate     ): inc_func
                func_drop = CPtr( Any Ptr, @__cripple          ): inc_func
                func_drop = CPtr( Any Ptr, @__active_anim_0    ): inc_func
                func_drop = CPtr( Any Ptr, @__infinity         ): inc_func
                
              Case "dead_drop_block"
                func_drop = CPtr( Any Ptr, @__make_dead        ): inc_func
                func_drop = CPtr( Any Ptr, @__active_anim_dead ): inc_func
                func_drop = CPtr( Any Ptr, @__dead_animate     ): inc_func
                func_drop = CPtr( Any Ptr, @__cripple          ): inc_func
                func_drop = CPtr( Any Ptr, @__drop             ): inc_func
                func_drop = CPtr( Any Ptr, @__active_anim_0    ): inc_func
                func_drop = CPtr( Any Ptr, @__infinity         ): inc_func
                
              Case "fire_block"
                func_drop = CPtr( Any Ptr, @__do_flyback       ): inc_func
                func_drop = CPtr( Any Ptr, @__second_pause     ): inc_func
                func_drop = CPtr( Any Ptr, @__return_idle      ): inc_func
  
              Case "ice_block"
                func_drop = CPtr( Any Ptr, @__second_pause     ): inc_func
                func_drop = CPtr( Any Ptr, @__second_pause     ): inc_func
                func_drop = CPtr( Any Ptr, @__return_idle      ): inc_func
              
            End Select
            
          #EndIf '' LL_Minimal

        Case "func"
          
          #Define LLObject_FunctionLoad(___x) _
            Case ###___x: func_drop = CPtr( Any Ptr, ProcPtr( __##___x ) ): inc_func
            
          #IfNDef LL_Minimal
          
            Select Case LCase( thr->dat.s )
              
              LLObject_FunctionLoad( active_anim_0 )          
              LLObject_FunctionLoad( active_anim_1            )
              LLObject_FunctionLoad( active_anim_2            )
              LLObject_FunctionLoad( active_anim_3            )
              LLObject_FunctionLoad( active_anim_4            )
              LLObject_FunctionLoad( active_anim_5            )
              LLObject_FunctionLoad( active_anim_6            )
              LLObject_FunctionLoad( active_anim_7            )
              LLObject_FunctionLoad( active_anim_8            )
              LLObject_FunctionLoad( active_anim_9            )
              LLObject_FunctionLoad( active_anim_10           )
              LLObject_FunctionLoad( active_anim_dead         )
              LLObject_FunctionLoad( active_animate           )
              LLObject_FunctionLoad( active_animate_x         )
              LLObject_FunctionLoad( after_moenia_townspeople )
              LLObject_FunctionLoad( after_slime              )
              LLObject_FunctionLoad( anger_fireball_circle    )
              LLObject_FunctionLoad( anger_fireball_lock      )
              LLObject_FunctionLoad( anger_shoot              )
              LLObject_FunctionLoad( anger_trigger            )
              LLObject_FunctionLoad( anger_teleport           )
              LLObject_FunctionLoad( anger_fireball2          )
              LLObject_FunctionLoad( anger_flyback            )
              LLObject_FunctionLoad( anger_kill_fireball      )
              LLObject_FunctionLoad( anger_middle             )
              LLObject_FunctionLoad( anger_new_fireball       )
              LLObject_FunctionLoad( arx_bridge               )
              LLObject_FunctionLoad( do_anger_proj            )
              LLObject_FunctionLoad( back_3                   )
              LLObject_FunctionLoad( bandit_check             )
              LLObject_FunctionLoad( bat_path                 )
              LLObject_FunctionLoad( big_color_down           )
              LLObject_FunctionLoad( big_color_up             )
              LLObject_FunctionLoad( black_text_on            )
              LLObject_FunctionLoad( bridge_chasm             )
              LLObject_FunctionLoad( buy_health               )
              LLObject_FunctionLoad( calc_slide               )
              LLObject_FunctionLoad( cell_bounce              )
              LLObject_FunctionLoad( change_map               )
              LLObject_FunctionLoad( chapter_1_off            )
              LLObject_FunctionLoad( chapter_1_on             )
              LLObject_FunctionLoad( charger_charge           )
              LLObject_FunctionLoad( chase                    )
              LLObject_FunctionLoad( check_b_key              )
              LLObject_FunctionLoad( check_for_dead_faces     )
              LLObject_FunctionLoad( check_lynn_contact       )
              LLObject_FunctionLoad( check_key                )
              LLObject_FunctionLoad( check_trigger            )
              LLObject_FunctionLoad( color_down               )
              LLObject_FunctionLoad( color_off                )
              LLObject_FunctionLoad( color_on                 )
              LLObject_FunctionLoad( color_up                 )
              LLObject_FunctionLoad( cond_jump                )
              LLObject_FunctionLoad( cond_trigger_projectile  )
              LLObject_FunctionLoad( cool_down                )
              LLObject_FunctionLoad( copter_path              )
              LLObject_FunctionLoad( counted_jump             )
              LLObject_FunctionLoad( counted_jump_2           )
              LLObject_FunctionLoad( cripple                  )
              LLObject_FunctionLoad( dead_animate             )
              LLObject_FunctionLoad( dec_sel_seq              )
              LLObject_FunctionLoad( dir_down                 )
              LLObject_FunctionLoad( dir_left                 )
              LLObject_FunctionLoad( dir_right                )
              LLObject_FunctionLoad( dir_up                   )
              LLObject_FunctionLoad( directional_animate      )
              LLObject_FunctionLoad( directional_animate_x    )
              LLObject_FunctionLoad( divine_fireball          )
              LLObject_FunctionLoad( divine_ball_return       )
              LLObject_FunctionLoad( do_circle                )
              LLObject_FunctionLoad( do_flyback               )
              LLObject_FunctionLoad( do_grult_proj            )
              LLObject_FunctionLoad( do_menu                  )
              LLObject_FunctionLoad( do_menu_continue         )
              LLObject_FunctionLoad( do_menu_save             )
              LLObject_FunctionLoad( do_nothing               )
              LLObject_FunctionLoad( do_proj                  )
              LLObject_FunctionLoad( do_vol_fade              )
              LLObject_FunctionLoad( drop                     )
              LLObject_FunctionLoad( drop_b_key               )
              LLObject_FunctionLoad( dyssius_slide            )
              LLObject_FunctionLoad( do_dyssius_proj          )
              LLObject_FunctionLoad( dyssius_after_slide      )
              LLObject_FunctionLoad( dyssius_flyback          )
              LLObject_FunctionLoad( dyssius_idle_gate        )
              LLObject_FunctionLoad( dyssius_jump_slide       )
              LLObject_FunctionLoad( dyssius_patience         )
              LLObject_FunctionLoad( dyssius_full_explode     )
              LLObject_FunctionLoad( dyssius_eye_explode      )
              LLObject_FunctionLoad( eat_lynn_action          )
              LLObject_FunctionLoad( end                      )
              LLObject_FunctionLoad( explode                  )
              LLObject_FunctionLoad( explode_jump             )
              LLObject_FunctionLoad( explode_lynn             )
              LLObject_FunctionLoad( fade_music_out           )
              LLObject_FunctionLoad( fade_off                 )
              LLObject_FunctionLoad( fade_to_black            )
              LLObject_FunctionLoad( fade_to_red              )
              LLObject_FunctionLoad( fade_to_white            )
              LLObject_FunctionLoad( fade_down_to_color       )
              LLObject_FunctionLoad( fade_down_to_gray        )
              LLObject_FunctionLoad( fade_up_to_color         )
              LLObject_FunctionLoad( flash                    )
              LLObject_FunctionLoad( flash_down               )
              LLObject_FunctionLoad( flash_down_gray          )
              LLObject_FunctionLoad( flashy                   )
              LLObject_FunctionLoad( flicker                  )
              LLObject_FunctionLoad( full_heal                )
              LLObject_FunctionLoad( gen_frame                )
              LLObject_FunctionLoad( give_b_key               )
              LLObject_FunctionLoad( give_costume             )
              LLObject_FunctionLoad( give_item                )
              LLObject_FunctionLoad( give_key                 )
              LLObject_FunctionLoad( give_outfit              )
              LLObject_FunctionLoad( give_weapon              )
              LLObject_FunctionLoad( give_weapon2             )
              LLObject_FunctionLoad( give_100_gold            )
              LLObject_FunctionLoad( give_gold_amount         )
              LLObject_FunctionLoad( go_grip                  )
              LLObject_FunctionLoad( set_gray_fade            )
              LLObject_FunctionLoad( grult_fireball           )
              LLObject_FunctionLoad( half_second_pause        )
              LLObject_FunctionLoad( handle_menu              )
              LLObject_FunctionLoad( heal_lynn                )
              LLObject_FunctionLoad( healthguy_branch         )
              LLObject_FunctionLoad( home                     )
              LLObject_FunctionLoad( idle_animate             )
              LLObject_FunctionLoad( if_all_dead              )
              LLObject_FunctionLoad( inc_sel_seq              )
              LLObject_FunctionLoad( invis_entry              )
              Case "infinity": func_drop = CPtr( Any Ptr, ProcPtr( __infinity ) ): inc_func 
'              LLObject_FunctionLoad( infinity                 )
'              LLObject_FunctionLoad( infinity                 )
              LLObject_FunctionLoad( jump_2_back              )
              LLObject_FunctionLoad( kill_song                )
              LLObject_FunctionLoad( kill_all_temps           )
              LLObject_FunctionLoad( logosta_console          )
              LLObject_FunctionLoad( lunge                    )
              LLObject_FunctionLoad( lunge_return             )
              LLObject_FunctionLoad( make_align               )
              LLObject_FunctionLoad( make_dead                )
              LLObject_FunctionLoad( make_black_and_white     )
              LLObject_FunctionLoad( make_enemy               )
              LLObject_FunctionLoad( make_face                )
              LLObject_FunctionLoad( make_invincible          )
              LLObject_FunctionLoad( make_invisible           )
              LLObject_FunctionLoad( make_visible             )
              LLObject_FunctionLoad( make_vulnerable          )
              LLObject_FunctionLoad( melt                     )
              LLObject_FunctionLoad( momentum_move            )
              LLObject_FunctionLoad( moth_random_loc          )
              LLObject_FunctionLoad( moth_random_proj         )
              LLObject_FunctionLoad( move_down                )
              LLObject_FunctionLoad( move_backwards           )
              LLObject_FunctionLoad( move_normal              )
              LLObject_FunctionLoad( move_left                )
              LLObject_FunctionLoad( move_right               )
              LLObject_FunctionLoad( move_up                  )
              LLObject_FunctionLoad( move_upright             )
              LLObject_FunctionLoad( off_happen               )
              LLObject_FunctionLoad( outfit_branch            )
              LLObject_FunctionLoad( outfit_swap              )
              LLObject_FunctionLoad( play_dead_sound          )
              LLObject_FunctionLoad( play_seq                 )
              LLObject_FunctionLoad( play_song                )
              LLObject_FunctionLoad( play_sound               )
              LLObject_FunctionLoad( poll_action              )
              LLObject_FunctionLoad( poondodge_branch         )
              LLObject_FunctionLoad( push                     )
              LLObject_FunctionLoad( push_lynn_back           )
              LLObject_FunctionLoad( quake                    )
              LLObject_FunctionLoad( q_second_pause           )
              LLObject_FunctionLoad( randomize_path           )
              LLObject_FunctionLoad( red_tint                 )
              LLObject_FunctionLoad( release_seq              )
              LLObject_FunctionLoad( reset_frame              )
              LLObject_FunctionLoad( return_idle              )
              LLObject_FunctionLoad( return_reset             )
              LLObject_FunctionLoad( return_reset_npc         )
              LLObject_FunctionLoad( return_jump              )
              LLObject_FunctionLoad( return_jump_1            )
              LLObject_FunctionLoad( return_jump_npc          )
              LLObject_FunctionLoad( return_jump_back         )
              LLObject_FunctionLoad( return_trig              )
              LLObject_FunctionLoad( second_pause             )
              LLObject_FunctionLoad( seed_random_loc          )
              LLObject_FunctionLoad( set_anim                 )
              LLObject_FunctionLoad( set_camera               )
              LLObject_FunctionLoad( set_explosions           )
              LLObject_FunctionLoad( set_fade                 )
              LLObject_FunctionLoad( set_finish               )
              LLObject_FunctionLoad( set_font_bg              )
              LLObject_FunctionLoad( set_font_fg              )
              LLObject_FunctionLoad( set_func                 )
              LLObject_FunctionLoad( set_happen               )
              LLObject_FunctionLoad( set_song                 )
              LLObject_FunctionLoad( set_vol_fade             )
              LLObject_FunctionLoad( set_gray_fade            )
              LLObject_FunctionLoad( set_white_fade           )
              LLObject_FunctionLoad( sterach_call             )
              LLObject_FunctionLoad( stop_grip                )
              LLObject_FunctionLoad( stop_sound               )
              LLObject_FunctionLoad( sword_angle              )
              LLObject_FunctionLoad( sword_fly                )
              LLObject_FunctionLoad( sword_glow               )
              LLObject_FunctionLoad( sword_jump               )
              LLObject_FunctionLoad( sword_return             )
              LLObject_FunctionLoad( templewood_bridge        )
              LLObject_FunctionLoad( tile_up                  )
              LLObject_FunctionLoad( timed_jump               )
              LLObject_FunctionLoad( timed_jump_2             )
              LLObject_FunctionLoad( translate_result         )
              LLObject_FunctionLoad( trigger_projectile       )
              LLObject_FunctionLoad( true_active_animate      )
              LLObject_FunctionLoad( turn_off_tiles           )
              LLObject_FunctionLoad( turn_on_tiles            )
              LLObject_FunctionLoad( up_face                  )
              LLObject_FunctionLoad( walk                     )
              LLObject_FunctionLoad( weapon_anim              )
                
            End Select
            
          #EndIf '' LL_Minimal
          
      End Select
        
    Else
      
      #Define LLObject_AttributeLoad(__attribute__) _ 
        Case ###__attribute__: objectLoad.##__attribute__ = Val( thr->dat.s )

      Select Case LCase( x->key )

        LLObject_AttributeLoad( action_sequence )  
        LLObject_AttributeLoad( anims           )  
        LLObject_AttributeLoad( current_anim    )  
        LLObject_AttributeLoad( animating       )  
        LLObject_AttributeLoad( chap            )  
        LLObject_AttributeLoad( cur_expl        )  
        LLObject_AttributeLoad( d_gold          )  
        LLObject_AttributeLoad( d_health        )  
        LLObject_AttributeLoad( d_silver        )  
        LLObject_AttributeLoad( dead            )  

        Case "dead_sound"
          
          #Define LLObject_DeadSoundLoad(__dead_sound__) _
            Case ###__dead_sound__: objectLoad.dead_sound = __dead_sound__ 
          
          Select Case LCase( thr->dat.s )
            
            LLObject_DeadSoundLoad( sound_bassdrop      )
            LLObject_DeadSoundLoad( sound_beam          )
            LLObject_DeadSoundLoad( sound_bigchest      )
            LLObject_DeadSoundLoad( sound_boss_hit      )
            LLObject_DeadSoundLoad( sound_cashget       )
            LLObject_DeadSoundLoad( sound_doorfkey      )
            LLObject_DeadSoundLoad( sound_doorsmall     )
            LLObject_DeadSoundLoad( sound_enemyhit      )
            LLObject_DeadSoundLoad( sound_enemykill     )
            LLObject_DeadSoundLoad( sound_explosion     )
            LLObject_DeadSoundLoad( sound_flare         )
            LLObject_DeadSoundLoad( sound_healthgrab    )
            LLObject_DeadSoundLoad( sound_heart         )
            LLObject_DeadSoundLoad( sound_ice           )
            LLObject_DeadSoundLoad( sound_portal        )
            LLObject_DeadSoundLoad( sound_smallchest    )
            LLObject_DeadSoundLoad( sound_switch        )
            LLObject_DeadSoundLoad( sound_treepull      )
            LLObject_DeadSoundLoad( sound_lowhealth     )
            LLObject_DeadSoundLoad( sound_bush          )
            LLObject_DeadSoundLoad( sound_crateting     )
            LLObject_DeadSoundLoad( sound_sea           )
            LLObject_DeadSoundLoad( sound_lynn_attack_1 )
            LLObject_DeadSoundLoad( sound_lynn_attack_2 )
            LLObject_DeadSoundLoad( sound_lynn_attack_3 )
            LLObject_DeadSoundLoad( sound_lynn_attack_4 )
            LLObject_DeadSoundLoad( sound_lynn_hurt_1   )
            LLObject_DeadSoundLoad( sound_lynn_hurt_2   )
            LLObject_DeadSoundLoad( sound_lynn_hurt_3   )
            LLObject_DeadSoundLoad( sound_mace_0        )
            LLObject_DeadSoundLoad( sound_mace_1        )
            LLObject_DeadSoundLoad( sound_mace_2        )
            LLObject_DeadSoundLoad( sound_texttemp      )
            LLObject_DeadSoundLoad( sound_torchlight    )
            LLObject_DeadSoundLoad( sound_greystatic    )
            LLObject_DeadSoundLoad( sound_crickets      )
            LLObject_DeadSoundLoad( sound_gulls2        )
            LLObject_DeadSoundLoad( sound_rayflap2      )
            LLObject_DeadSoundLoad( sound_flap          )
            LLObject_DeadSoundLoad( sound_sploosh       )

            Case "none"         
              objectLoad.dead_sound = 0
                  
          End Select      

        LLObject_AttributeLoad( total_dead      )  
        LLObject_AttributeLoad( degree          )  
        LLObject_AttributeLoad( dest_x          )  
        LLObject_AttributeLoad( dest_y          )  
        LLObject_AttributeLoad( diag_chase      )  
        LLObject_AttributeLoad( diag_thrust     )  
        LLObject_AttributeLoad( direction       )  
        LLObject_AttributeLoad( dropped         )  
        LLObject_AttributeLoad( elite           )  
        LLObject_AttributeLoad( explosions      )  
        LLObject_AttributeLoad( expl_delay      )  
        LLObject_AttributeLoad( expl_timer      )  
        LLObject_AttributeLoad( expl_x_off      )  
        LLObject_AttributeLoad( expl_x_size     )  
        LLObject_AttributeLoad( expl_y_off      )  
        LLObject_AttributeLoad( expl_y_size     )  
        LLObject_AttributeLoad( fade_count      )  
        LLObject_AttributeLoad( fade_out        )  
        LLObject_AttributeLoad( fade_time       )  
        LLObject_AttributeLoad( fade_timer      )  
        LLObject_AttributeLoad( far_reset_delay )  
        LLObject_AttributeLoad( lose_time       )  
        LLObject_AttributeLoad( fire_weak       )  
        LLObject_AttributeLoad( fireworks       )  
        LLObject_AttributeLoad( ice_weak        )  
        LLObject_AttributeLoad( flash_count     )  
        LLObject_AttributeLoad( flash_length    )  
        LLObject_AttributeLoad( flash_time      )  
        LLObject_AttributeLoad( flash_timer     )  
        LLObject_AttributeLoad( fly_count       )  
        LLObject_AttributeLoad( fly_hold        )  
        LLObject_AttributeLoad( fly_length      )  
        LLObject_AttributeLoad( fly_speed       )  
        LLObject_AttributeLoad( fly_timer       )  
        LLObject_AttributeLoad( frame           )  
        LLObject_AttributeLoad( frame_hold      )  
        LLObject_AttributeLoad( froggy          )  
        LLObject_AttributeLoad( grult_proj_trig )  
        LLObject_AttributeLoad( heal_me         )  
        LLObject_AttributeLoad( high_frame      )
        LLObject_AttributeLoad( isboss          )
            
        LLObject_AttributeLoad( low_frame       )  
        Case "hit_sound"

          #Define LLObject_HitSoundLoad(__hit_sound__) _
            Case ###__hit_sound__: objectLoad.hit_sound = __hit_sound__ 
        
          Select Case LCase( thr->dat.s )
          
            LLObject_HitSoundLoad( sound_bassdrop      )
            LLObject_HitSoundLoad( sound_beam          )
            LLObject_HitSoundLoad( sound_bigchest      )
            LLObject_HitSoundLoad( sound_boss_hit      )
            LLObject_HitSoundLoad( sound_cashget       )
            LLObject_HitSoundLoad( sound_doorfkey      )
            LLObject_HitSoundLoad( sound_doorsmall     )
            LLObject_HitSoundLoad( sound_enemyhit      )
            LLObject_HitSoundLoad( sound_enemykill     )
            LLObject_HitSoundLoad( sound_explosion     )
            LLObject_HitSoundLoad( sound_flare         )
            LLObject_HitSoundLoad( sound_healthgrab    )
            LLObject_HitSoundLoad( sound_heart         )
            LLObject_HitSoundLoad( sound_ice           )
            LLObject_HitSoundLoad( sound_portal        )
            LLObject_HitSoundLoad( sound_smallchest    )
            LLObject_HitSoundLoad( sound_switch        )
            LLObject_HitSoundLoad( sound_treepull      )
            LLObject_HitSoundLoad( sound_lowhealth     )
            LLObject_HitSoundLoad( sound_bush          )
            LLObject_HitSoundLoad( sound_crateting     )
            LLObject_HitSoundLoad( sound_sea           )
            LLObject_HitSoundLoad( sound_lynn_attack_1 )
            LLObject_HitSoundLoad( sound_lynn_attack_2 )
            LLObject_HitSoundLoad( sound_lynn_attack_3 )
            LLObject_HitSoundLoad( sound_lynn_attack_4 )
            LLObject_HitSoundLoad( sound_lynn_hurt_1   )
            LLObject_HitSoundLoad( sound_lynn_hurt_2   )
            LLObject_HitSoundLoad( sound_lynn_hurt_3   )
            LLObject_HitSoundLoad( sound_mace_0        )
            LLObject_HitSoundLoad( sound_mace_1        )
            LLObject_HitSoundLoad( sound_mace_2        )
            LLObject_HitSoundLoad( sound_texttemp      )
            LLObject_HitSoundLoad( sound_torchlight    )
            LLObject_HitSoundLoad( sound_greystatic    )
            LLObject_HitSoundLoad( sound_crickets      )
            LLObject_HitSoundLoad( sound_gulls2        )
            LLObject_HitSoundLoad( sound_rayflap2      )
            LLObject_HitSoundLoad( sound_flap          )
            Case "none"         
              objectLoad.hit_sound = 0
                  
          End Select      
        
        LLObject_AttributeLoad( hit_sound_vol   )  
        LLObject_AttributeLoad( hp              )  
        LLObject_AttributeLoad( maxhp           )  
        LLObject_AttributeLoad( hurt            )  
        LLObject_AttributeLoad( impassable      )  
        LLObject_AttributeLoad( invincible      )  
        LLObject_AttributeLoad( invisible       )  
        LLObject_AttributeLoad( is_psfing       )  
        LLObject_AttributeLoad( is_pushing      )  
        LLObject_AttributeLoad( jump_count      )  
        LLObject_AttributeLoad( jump_counter    )  
        LLObject_AttributeLoad( jump_lock       )  
        LLObject_AttributeLoad( jump_time       )  
        LLObject_AttributeLoad( jump_timer      )  
        LLObject_AttributeLoad( key             )  
        LLObject_AttributeLoad( key_door        )  
        LLObject_AttributeLoad( light_sensitive )  
        LLObject_AttributeLoad( line_lock       )  
        LLObject_AttributeLoad( line_sight      )  
        LLObject_AttributeLoad( mace_weak       )  
        LLObject_AttributeLoad( mad             )  
        LLObject_AttributeLoad( mad_walk_speed  )  
        LLObject_AttributeLoad( melt            )  
        LLObject_AttributeLoad( menu_lock       )  
        LLObject_AttributeLoad( mod_lock        )  
        LLObject_AttributeLoad( money           )  
        LLObject_AttributeLoad( moving          )  
        LLObject_AttributeLoad( must_align      )  
        LLObject_AttributeLoad( n_gold          )  
        LLObject_AttributeLoad( n_silver        )  
        LLObject_AttributeLoad( no_cam          )  
        LLObject_AttributeLoad( num             )  
        LLObject_AttributeLoad( on_ice          )  
        LLObject_AttributeLoad( ori_dir         )  
        LLObject_AttributeLoad( pause           )  
        LLObject_AttributeLoad( pause_hold      )  
        LLObject_AttributeLoad( placed          )  
        
        Case "proj_style"
          
          #Define projectileShorthand(__X__) _
            Case ###__X__ :_
              objectLoad.proj_style = __X__
            
          objectLoad.projectile = CAllocate( Len( ll_entity_projectile ) )
          
          
          Select Case thr->dat.s
            
            projectileShorthand( PROJECTILE_FIREBALL )
              objectLoad.projectile->projectiles = 1
            
            projectileShorthand( PROJECTILE_ORB      )
              objectLoad.projectile->projectiles = 2
            
            projectileShorthand( PROJECTILE_BEAM     )
              objectLoad.projectile->projectiles = 2
            
            projectileShorthand( PROJECTILE_DIAGONAL )
             objectLoad.projectile->projectiles  = 4
            
            projectileShorthand( PROJECTILE_CROSS    )
              objectLoad.projectile->projectiles = 4
            
            projectileShorthand( PROJECTILE_8WAY     )
              objectLoad.projectile->projectiles = 8
            
            projectileShorthand( PROJECTILE_SCHIZO   )
              objectLoad.projectile->projectiles = 24
            
            projectileShorthand( PROJECTILE_SPIRAL   )
              objectLoad.projectile->projectiles = 8
            
            projectileShorthand( PROJECTILE_SUN   )
              objectLoad.projectile->projectiles = 128
            
            projectileShorthand( PROJECTILE_TRACK   )
              objectLoad.projectile->projectiles = 1 
            
            
          End Select

          objectLoad.projectile->coords = CAllocate( Len( vector ) * objectLoad.projectile->projectiles )
          
        Case "proj_invis"
          objectLoad.projectile->invisible = Val( thr->dat.s ) 

        Case "proj_dur"
          objectLoad.projectile->length    = Val( thr->dat.s ) 

        Case "proj_over"  
          objectLoad.projectile->overChar  = Val( thr->dat.s ) 

        Case "proj_sound"           
          objectLoad.projectile->sound     = Val( thr->dat.s ) 

        Case "proj_str"               
          objectLoad.projectile->strength  = Val( thr->dat.s ) 


        LLObject_AttributeLoad( pushable        )  
        LLObject_AttributeLoad( radius          )  
        LLObject_AttributeLoad( read_lock       )  

        Case "real_x": objectLoad.perimeter.x = Val( thr->dat.s )
        Case "real_y": objectLoad.perimeter.y = Val( thr->dat.s )

        LLObject_AttributeLoad( reserved_2      )  
        LLObject_AttributeLoad( reserved_3      )  
        LLObject_AttributeLoad( reserved_4      )  
        LLObject_AttributeLoad( reserved_5      )  
        LLObject_AttributeLoad( reserved_6      )  
        LLObject_AttributeLoad( reset_delay     )  
        LLObject_AttributeLoad( return_trig     )  
        LLObject_AttributeLoad( sel_seq         )  
        LLObject_AttributeLoad( seq_here        )  
        LLObject_AttributeLoad( seq_paused      )  
        LLObject_AttributeLoad( seq_release     )  
        LLObject_AttributeLoad( shifty          )  
        LLObject_AttributeLoad( shifty_lock     )  
        LLObject_AttributeLoad( shifty_state    )  
        LLObject_AttributeLoad( side_vision     )  
        LLObject_AttributeLoad( slide_hold      )  
        LLObject_AttributeLoad( song_fade_count )  
        LLObject_AttributeLoad( sounds          )  
        LLObject_AttributeLoad( spawn_x         )  
        LLObject_AttributeLoad( spawn_y         )  
        LLObject_AttributeLoad( star_weak       )  
        LLObject_AttributeLoad( state_shift     )  
        LLObject_AttributeLoad( sticky_chase    )  
        LLObject_AttributeLoad( strength        )  
        LLObject_AttributeLoad( switch_room     )  
        LLObject_AttributeLoad( thrust          )  
        LLObject_AttributeLoad( to_entry        )  

        Case "to_map": objectLoad.to_map = thr->dat.s

        LLObject_AttributeLoad( torch                 )  
        LLObject_AttributeLoad( touch_sequence        )  
        LLObject_AttributeLoad( trigger               )  
        LLObject_AttributeLoad( uni_directional       )  
        LLObject_AttributeLoad( unstoppable_by_tile   )  
        LLObject_AttributeLoad( unstoppable_by_object )  
        LLObject_AttributeLoad( unstoppable_by_screen )  
        LLObject_AttributeLoad( vision_field          )  
        LLObject_AttributeLoad( vol_fade              )  
        LLObject_AttributeLoad( vol_fade_lock         )  
        LLObject_AttributeLoad( vol_fade_time         )  
        LLObject_AttributeLoad( vol_fade_trig         )  
        LLObject_AttributeLoad( walk_buffer           )  
        LLObject_AttributeLoad( walk_hold             )  
        LLObject_AttributeLoad( walk_speed            )  
        LLObject_AttributeLoad( walk_length           )  
        LLObject_AttributeLoad( walk_steps            )  
        LLObject_AttributeLoad( x_origin              )  
        LLObject_AttributeLoad( y_origin              )  
        LLObject_AttributeLoad( yet_spawned           )  

        Case "spawns_id": objectLoad.spawns_id = thr->dat.s

        Case "generic_sounds": objectLoad.dead_sound = sound_enemykill: objectLoad.hit_sound  = sound_enemyhit

      End Select
      
    End If

    Exit Sub
    
  End If

  Dim As Integer i
  For i = 0 To  length( thr ) - 1

    LLSystem_ObjectFromXML( CPtr( xml_type Ptr, thr->dat.pnt ), objectLoad, concat & x->key & "->" )  
    thr = thr->nxt
      
  Next
  
  
End Sub
