Option Explicit

#Include "..\headers\ll\headers.bi"

'#Define LL_LOGROOMCHANGE
'#Define LL_LOGRoomEnemySetup


#macro hUniSound(__CHAR__,__ANIM__,__FRAME__,__SOUND__)

  scope
      
    dim as integer frameCrawl, frameIter
    frameCrawl = __FRAME__
  
    for frameIter = 0 to 3  
    
      __CHAR__##.anim[__ANIM__]->frame[frameCrawl].sound = __SOUND__
      
      frameCrawl += __CHAR__##.animControl[__ANIM__].dir_frames
      
    next
    
  end scope
  
#endmacro

#macro hUniVol(__CHAR__,__ANIM__,__FRAME__,__VOL__)

  scope
      
    dim as integer frameCrawl, frameIter
    frameCrawl = __FRAME__
  
    for frameIter = 0 to 3  
    
      __CHAR__##.anim[__ANIM__]->frame[frameCrawl].vol = __VOL__
      
      frameCrawl += __CHAR__##.animControl[__ANIM__].dir_frames
      
    next
    
  end scope
  
#endmacro


Private Sub set_regular()

  llg( hero ).anim[0] = LLImage_FromName( "data\pictures\char\lynn24.spr"         )   
  llg( hero ).animControl[0].rate = .08
  llg( hero ).anim[3] = LLImage_FromName( "data\pictures\char\lynnattack_NEW.spr" )   
  llg( hero ).animControl[3].rate = .07
  llg( hero ).anim[4] = LLImage_FromName( "data\pictures\char\lynnattack_2.spr"   )  
  llg( hero ).animControl[4].rate = .1                                                                          
  llg( hero ).anim[5] = LLImage_FromName( "data\pictures\char\lynnattack_3.spr"   )  
  llg( hero ).animControl[5].rate = .13                                                                         
  llg( hero ).anim[6] = LLImage_FromName( "data\pictures\char\lynn_flare.spr"     )  
  llg( hero ).animControl[6].rate = .07                                                                         
  llg( hero ).anim[7] = LLImage_FromName( "data\pictures\char\lynn_ice.spr"       )  
  llg( hero ).animControl[7].rate = .07                                                                         
  llg( hero ).anim[8] = LLImage_FromName( "data\pictures\char\lynnfall.spr"       )  
  llg( hero ).animControl[8].rate = .18
  llg( hero ).anim[12] = LLImage_FromName( "data\pictures\char\lynngetup.spr"       )  
  llg( hero ).animControl[12].rate = .18

End Sub

Private Sub set_cougar()

  llg( hero ).anim[0] = LLImage_FromName( "data\pictures\char\outfits\cougar\walk.spr"   )   
  llg( hero ).animControl[0].rate = .05
  llg( hero ).anim[6] = LLImage_FromName( "data\pictures\char\outfits\cougar\flare.spr"  )  
  llg( hero ).animControl[6].rate = .07                                                                         
  llg( hero ).anim[7] = LLImage_FromName( "data\pictures\char\outfits\cougar\ice.spr"    )  
  llg( hero ).animControl[7].rate = .07                                                                         
  llg( hero ).anim[8] = LLImage_FromName( "data\pictures\char\outfits\cougar\die.spr"    )  
  llg( hero ).animControl[8].rate = .18
  llg( hero ).anim[12] = LLImage_FromName( "data\pictures\char\outfits\cougar\getup.spr" )  
  llg( hero ).animControl[12].rate = .18
  
  hUniSound( llg( hero ), 6, 0, sound_flare )
  hUniSound( llg( hero ), 7, 0, sound_ice )
      

End Sub

Private Sub set_lynnity()

  llg( hero ).anim[0] = LLImage_FromName( "data\pictures\char\outfits\lynnity\walk.spr"     )   
  llg( hero ).animControl[0].rate = .08
  llg( hero ).anim[3] = LLImage_FromName( "data\pictures\char\outfits\lynnity\attack_1.spr" )   
  llg( hero ).animControl[3].rate = .07
  llg( hero ).anim[4] = LLImage_FromName( "data\pictures\char\outfits\lynnity\attack_2.spr" )  
  llg( hero ).animControl[4].rate = .1                                                                          
  llg( hero ).anim[5] = LLImage_FromName( "data\pictures\char\outfits\lynnity\attack_3.spr" )  
  llg( hero ).animControl[5].rate = .13                                                                         
  llg( hero ).anim[6] = LLImage_FromName( "data\pictures\char\outfits\lynnity\flare.spr"    )  
  llg( hero ).animControl[6].rate = .07                                                                         
  llg( hero ).anim[7] = LLImage_FromName( "data\pictures\char\outfits\lynnity\ice.spr"      )  
  llg( hero ).animControl[7].rate = .07                                                                         
  llg( hero ).anim[8] = LLImage_FromName( "data\pictures\char\outfits\lynnity\die.spr"      )  
  llg( hero ).animControl[8].rate = .18
  llg( hero ).anim[12] = LLImage_FromName( "data\pictures\char\outfits\lynnity\getup.spr"   )  
  llg( hero ).animControl[12].rate = .18


  hUniSound( llg( hero ), 3, 0, sound_mace_0 )
  hUniSound( llg( hero ), 4, 0, sound_mace_1 )
  hUniSound( llg( hero ), 5, 0, sound_mace_2 )
  hUniSound( llg( hero ), 6, 0, sound_flare  )
  hUniSound( llg( hero ), 7, 0, sound_ice    )

  hUniVol( llg( hero ), 3, 0, 50 )
  hUniVol( llg( hero ), 4, 0, 50 )
  hUniVol( llg( hero ), 5, 0, 50 )


End Sub    

Private Sub set_ninja()

  llg( hero ).anim[0] = LLImage_FromName( "data\pictures\char\outfits\ninja\walk.spr"     )   
  llg( hero ).animControl[0].rate = .08
  llg( hero ).anim[3] = LLImage_FromName( "data\pictures\char\outfits\ninja\attack_1.spr" )   
  llg( hero ).animControl[3].rate = .04
  llg( hero ).anim[4] = LLImage_FromName( "data\pictures\char\outfits\ninja\attack_2.spr" )  
  llg( hero ).animControl[4].rate = .07                                                                          
  llg( hero ).anim[5] = LLImage_FromName( "data\pictures\char\outfits\ninja\attack_3.spr" )  
  llg( hero ).animControl[5].rate = .1                                                                         
  llg( hero ).anim[6] = LLImage_FromName( "data\pictures\char\outfits\ninja\flare.spr"    )  
  llg( hero ).animControl[6].rate = .07                                                                         
  llg( hero ).anim[7] = LLImage_FromName( "data\pictures\char\outfits\ninja\ice.spr"      )  
  llg( hero ).animControl[7].rate = .07                                                                         
  llg( hero ).anim[8] = LLImage_FromName( "data\pictures\char\outfits\ninja\die.spr"      )  
  llg( hero ).animControl[8].rate = .18
  llg( hero ).anim[12] = LLImage_FromName( "data\pictures\char\outfits\ninja\getup.spr"   )  
  llg( hero ).animControl[12].rate = .18

  hUniSound( llg( hero ), 3, 0, sound_mace_0 )
  hUniSound( llg( hero ), 4, 0, sound_mace_1 )
  hUniSound( llg( hero ), 5, 0, sound_mace_2 )
  hUniSound( llg( hero ), 6, 0, sound_flare  )
  hUniSound( llg( hero ), 7, 0, sound_ice    )

  hUniVol( llg( hero ), 3, 0, 50 )
  hUniVol( llg( hero ), 4, 0, 50 )
  hUniVol( llg( hero ), 5, 0, 50 )


End Sub

Private Sub set_bikini()

  llg( hero ).anim[0] = LLImage_FromName( "data\pictures\char\outfits\swimsuit\walk.spr"     )   
  llg( hero ).animControl[0].rate = .08
  llg( hero ).anim[3] = LLImage_FromName( "data\pictures\char\outfits\swimsuit\attack_1.spr" )   
  llg( hero ).animControl[3].rate = .07
  llg( hero ).anim[4] = LLImage_FromName( "data\pictures\char\outfits\swimsuit\attack_2.spr" )  
  llg( hero ).animControl[4].rate = .1                                                                          
  llg( hero ).anim[5] = LLImage_FromName( "data\pictures\char\outfits\swimsuit\attack_3.spr" )  
  llg( hero ).animControl[5].rate = .13                                                                         
  llg( hero ).anim[6] = LLImage_FromName( "data\pictures\char\outfits\swimsuit\flare.spr"    )  
  llg( hero ).animControl[6].rate = .07                                                                         
  llg( hero ).anim[7] = LLImage_FromName( "data\pictures\char\outfits\swimsuit\ice.spr"      )  
  llg( hero ).animControl[7].rate = .07                                                                         
  llg( hero ).anim[8] = LLImage_FromName( "data\pictures\char\outfits\swimsuit\die.spr"      )  
  llg( hero ).animControl[8].rate = .18
  llg( hero ).anim[12] = LLImage_FromName( "data\pictures\char\outfits\swimsuit\getup.spr"   )  
  llg( hero ).animControl[12].rate = .18

  hUniSound( llg( hero ), 3, 0, sound_mace_0 )
  hUniSound( llg( hero ), 4, 0, sound_mace_1 )
  hUniSound( llg( hero ), 5, 0, sound_mace_2 )
  hUniSound( llg( hero ), 6, 0, sound_flare  )
  hUniSound( llg( hero ), 7, 0, sound_ice    )

  hUniVol( llg( hero ), 3, 0, 50 )
  hUniVol( llg( hero ), 4, 0, 50 )
  hUniVol( llg( hero ), 5, 0, 50 )


End Sub

Private Sub set_rknight()

  llg( hero ).anim[0] = LLImage_FromName( "data\pictures\char\outfits\redknight\walk.spr"     )   
  llg( hero ).animControl[0].rate = .12
'  llg( hero ).anim[3] = LLImage_FromName( "data\pictures\char\outfits\redknight\attack_1.spr" )   
'  llg( hero ).animControl[3].rate = .07
'  llg( hero ).anim[4] = LLImage_FromName( "data\pictures\char\outfits\redknight\attack_2.spr" )  
'  llg( hero ).animControl[4].rate = .1                                                                          
'  llg( hero ).anim[5] = LLImage_FromName( "data\pictures\char\outfits\redknight\attack_3.spr" )  
'  llg( hero ).animControl[5].rate = .13                                                                         
  llg( hero ).anim[6] = LLImage_FromName( "data\pictures\char\outfits\redknight\flare.spr"    )  
  llg( hero ).animControl[6].rate = .07                                                                         
  llg( hero ).anim[7] = LLImage_FromName( "data\pictures\char\outfits\redknight\ice.spr"      )  
  llg( hero ).animControl[7].rate = .07                                                                         
  llg( hero ).anim[8] = LLImage_FromName( "data\pictures\char\outfits\redknight\die.spr"      )  
  llg( hero ).animControl[8].rate = .18
  llg( hero ).anim[12] = LLImage_FromName( "data\pictures\char\outfits\redknight\getup.spr"   )  
  llg( hero ).animControl[12].rate = .18

  hUniSound( llg( hero ), 6, 0, sound_flare  )
  hUniSound( llg( hero ), 7, 0, sound_ice    )

  hUniVol( llg( hero ), 3, 0, 50 )
  hUniVol( llg( hero ), 4, 0, 50 )
  hUniVol( llg( hero ), 5, 0, 50 )


End Sub


Sub set_up_room_enemies( enemies As Integer, enemy As _char_type Ptr )

  
  Dim As Integer setup

  
  For setup = 0 To enemies - 1
    '' cycle thru these enemies
    
    With enemy[setup]    
      
      If .spawn_cond <> 0 Then
        
        If .spawn_info->wait_n > 0 Then

          If LLObject_SpawnWait( Varptr( enemy[setup] ) ) <> 0 Then
  
            '' done waiting
  
            LLSystem_CopyNewObject( enemy[setup] )
    
          Else
            Dim As String oldid
            
            oldid = enemy[setup].id 

            LLSystem_ObjectDeepCopy( enemy[setup], *LLSystem_ObjectDeref( LLSystem_ObjectDerefName( "data\object\null.xml" ) ) )
            enemy[setup].id = oldid
  
          End If
          
        Else
  
          LLSystem_CopyNewObject( enemy[setup] )
          
        End If
        
      Else
      
      '' if regular then spawn
        LLSystem_CopyNewObject( enemy[setup] )
        
      End If
  
      '' setting a couple last vars
      .num = setup
      
      If .spawn_cond <> 0 Then

        If LLObject_SpawnKill( Varptr( enemy[setup] ) ) <> 0 Then
          '' all conditions met to kill
          
          __make_dead  ( Varptr( enemy[setup] ) )
          __cripple  ( Varptr( enemy[setup] ) )
          
          If(                                     _ 
              ( .unique_id = u_chest         ) Or _ 
              ( .unique_id = u_bluechest     ) Or _ 
              ( .unique_id = u_bluechestitem ) Or _ 
              ( .unique_id = u_ghut          ) Or _ 
              ( .unique_id = u_button        ) Or _ 
              ( .unique_id = u_gbutton       )    _ 
            ) Then 
            .current_anim = 1
            
          End If


          .seq_release = 0
  
          .spawn_kill_trig = -1


          if .unique_id = u_biglarva then
            LLObject_ShiftState( Varptr( enemy[setup] ), 3 )
            
          end if
          
          if .unique_id = u_ghut then
            LLObject_ShiftState( Varptr( enemy[setup] ), 3 )
            
          end if
          
        End If

      End If

    End With
    
    #IfDef LL_LOGRoomEnemySetup
      LLSystem_Log( "Initialized room["& llg( this_room ).i &"] enemy " & setup, "set_up_room_enemies.txt" )
      
    #EndIf
    
  Next
  
       
End Sub



Sub enter_map( _char As char_type Ptr, _m As map_type Ptr, desc As String, _entry As Integer )

  Dim As Integer _ 
    _fade, _ 
    _song, _ 
    _wait, _ 
    cary
 
  
  If _m <> 0 Then                                                               
    cary = Not 0
    _fade = llg( song_fade )
    _song = llg( song )
    _wait = llg( song_wait )
    
  End If
  map_Destroy( _m )
  
  _m = LLSystem_LoadMap( desc )
  
  '' if flag ptr set, access it.
  if llg( hero_only ).roomVisited then
    dim as integer iRoom
    
    for iRoom = 0 to _m->rooms - 1
      
      llg( miniMap ).room[iRoom].hasVisited = llg( hero_only ).roomVisited[iRoom]
      
    next
    
    clean_Deallocate( llg( hero_only ).roomVisited )
    
  end if
  
    
  If cary <> 0 Then
    llg( song_fade ) = _fade
    llg( song ) = _song
    llg( song_wait ) = _wait
    
  End If

  _char->coords.x         = _m->entry[_entry].x         
  _char->coords.y         = _m->entry[_entry].y         
                      
  _char->direction = _m->entry[_entry].direction 
                      
  llg( this_room.i )  = _m->entry[_entry].room      
  
  '' active sequence
  llg( hero ).seq = _m->entry[_entry].seq
  
  llg( dark ) = now_room().dark 
  
  
End Sub



Private Sub hero_attack( hr As _char_type Ptr )

  
  With *hr
  
    '' increment this function loop
    .funcs.current_func[.attack_state] += .funcs.func[.attack_state][.funcs.current_func[.attack_state]] ( hr )
  
  
    Dim As Integer call_back
    call_back = ( .funcs.current_func[.attack_state] >= .funcs.func_count[.attack_state] )
    
    If call_back Then
      '' lynn called back 
      
      .funcs.current_func[.attack_state] = 0  
      llg( hero_only ).attacking = 0
      llg( hero ).psycho = 0
      
      
    End If
    
  End With


End Sub




Sub act_enemies( _enemies As Integer, _enemy As char_type Ptr )

  
  Dim As Integer do_stuff

  For do_stuff = 0 To _enemies - 1

  
    With _enemy[do_stuff]
      
      If LLObject_IsWithin( Varptr( _enemy[do_stuff] ) ) Then

        If ( .seq_paused <> 0 ) And ( llg( seq ) <> 0 ) Then
        
        Else 


          .seq_paused = 0
            

          if .unique_id = u_healthguy then
            __healthguy_branch( Varptr( _enemy[do_stuff] ) )
            
          end if
      

          If .unique_id <> u_sparkle Then

            Dim As vector_pair target, origin
    
            If .unique_id = u_slimeman Then
              If .chap = 255 Then
                .mad = 1
                
              End If
              
            End If
            
            If llg( hero ).menu_sel <> 0 Then

              If ( .unique_id <> u_savepoint ) And ( .unique_id <> u_menu ) Then

                Continue For
                
              End If
              
            End If
            
            
            .last_cycle_ice = .on_ice
            .on_ice = 0    
      
            check_ice( _enemy[do_stuff] )
    
    
            If .unique_id = u_core Then
              '' Hack Fest!!!!!!!!!!!!
            
              If llg( now )[725] Then
              
                Dim As Integer enemyIterate, stateConfirm
                stateConfirm = -1
                Select Case .shifty_state
                '' if wave dead then advance
                  Case 0
                    .shifty_state += 1
                    For enemyIterate = 5 To 10
                      now_room().enemy[enemyIterate].trigger = TRUE
                      
                    Next
                    play_sample( sound_turret, 80 )
                    .unstoppable_by_object = 0
  
                  Case 1
                    '' 5- 10
                    For enemyIterate = 5 To 10
                      stateConfirm And= ( now_room().enemy[enemyIterate].dead )
                    Next
                    If stateConfirm Then
                      .shifty_state += 1
                      For enemyIterate = 11 To 18
                        now_room().enemy[enemyIterate].trigger = TRUE
                        
                      Next
                      play_sample( sound_turret, 80 )
                    
                    End If
                  
                  Case 2
                    '' 11 - 18
                    For enemyIterate = 11 To 18
                      stateConfirm And= ( now_room().enemy[enemyIterate].dead )
                    Next
                    If stateConfirm Then
                      .shifty_state += 1
                      For enemyIterate = 19 To 28
                        now_room().enemy[enemyIterate].trigger = TRUE
                        
                      Next
                      play_sample( sound_turret, 80 )
                    
                    End If
                    
                  Case 3
                    '' 19 - 28
                    For enemyIterate = 19 To 28
                      stateConfirm And= ( now_room().enemy[enemyIterate].dead )
                    Next
                    If stateConfirm Then
                      .shifty_state += 1
                      For enemyIterate = 29 To 48
                        now_room().enemy[enemyIterate].trigger = TRUE
                        
                      Next
                      play_sample( sound_turret, 80 )
                    
                    End If
                    
                  Case 4
                    '' 29 - 48
                    For enemyIterate = 29 To 48
                      stateConfirm And= ( now_room().enemy[enemyIterate].dead )
                    Next
                    If stateConfirm Then
                      .shifty_state += 1
                      For enemyIterate = 0 To 7
                        .anim[.current_anim]->frame[0].face[enemyIterate].invincible = 0
                      
                      Next
                      .invincible = 0
                      LLObject_ShiftState( Varptr( _enemy[do_stuff] ), .jump_state )
                    
                    End If
                    
                  Case 5
                    '' core vulnerable
                  
                End Select
              
              End If
            
            End If
            
            

            If llg( hero_only ).attacking <> 0 Then
              LLObject_MAINAttack( 1, Varptr( _enemy[do_stuff] ), Varptr( llg( hero ) ) )
              
            End If
          
  
            If ( .unique_id = u_anger ) Or ( .unique_id = u_sterach ) Then
            
              If .hit <> 0 Then
                '' This is how all hit state shifts should be handled. 
                '' This runs parallel to any running state.
                If __anger_flyback( Varptr( _enemy[do_stuff] ) ) <> 0 Then
                
                  .hit = 0
                
                End If
              
              End If
            
            End If
            
            If ( .unique_id = u_beamcrystal ) Or _ 
               ( .unique_id = u_boss5_right ) Or _ 
               ( .unique_id = u_boss5_down ) Or _ 
               ( .unique_id = u_boss5_left ) Or _ 
               ( .unique_id = u_boss5_crystal ) Then

              LLObject_ProjectileDamage( now_room().enemies, now_room().enemy, Varptr( _enemy[do_stuff] ) )
              
            End If
  
  
            If ( .on_ice <> 0 ) Then
              
              __calc_slide( Varptr( _enemy[do_stuff] ) )      
  
            End If
              
            If .on_ice = 0 Then
              __stop_grip( Varptr( _enemy[do_stuff] ) )      
              
            End If
              
  
            If .walk_hold = 0 Then
  
              If .walk_steps = 0 Then
                __momentum_move ( Varptr( _enemy[do_stuff] ) )
              
              End If
            
            End If
          
              
            
            If  .hurt <> 0 Then
              '' this enemy is showing damage effects
              
              If ( .unique_id = u_dyssius ) Or ( .unique_id = u_steelstrider ) Then
              
              Else
              
                If  .funcs.current_func[.funcs.active_state] = .funcs.func_count[.funcs.active_state] Then
                  '' the enemy called back (damage is done)
                  
                  LLObject_ShiftState( Varptr( _enemy[do_stuff] ), .reset_state )
                  
                  If .unique_id = u_ferus Then
                    
                    LLObject_ClearProjectiles( _enemy[do_stuff] )
                    .radius = Timer
                  
                  
                  End If

                  If .unique_id = u_grult Then
  
                    LLObject_ShiftState( Varptr( _enemy[do_stuff] ), .stun_state )
                    .funcs.current_func[.funcs.active_state] = 2
                    
                  End If
                  
                  LLObject_ClearDamage( Varptr( _enemy[do_stuff] ) )
                  .flash_count = 0
                  .flash_timer = 0 
                  .invisible = 0
                  
                  
                End If
                
              End If
              
            End If
            
            If .funcs.current_func[.funcs.active_state] = .funcs.func_count[.funcs.active_state] Then 
              '' if function block reaches end, return to beginning.
              
              .funcs.current_func[.funcs.active_state] = 0
              
            End If
      
      
            If .dead = 0 Then
              '' entity is not dead
               
              If .hp <= 0 Then 
                '' entity is below the hp limit (marked for death)
  
  
  
                If .dead_sound <> 0 Then
                  play_sample( llg( snd )[.dead_sound] )
                  
                End If
                
                LLObject_ShiftState( Varptr( _enemy[do_stuff] ), _enemy[do_stuff].death_state )  
                
              End If
    
              If .dead = 0 Then
                If .froggy <> 0 Then 
                  '' this entity can become mad
                  

                  If ( .mad = 0 ) Then 
                    '' entity is not mad
    
                    If ( .funcs.active_state < .reset_state ) Then 
    
                      '' entity is not resetting
                      
                      '' implicit proximity detection
                      .funcs.active_state = in_proximity( Varptr( _enemy[do_stuff] ) )
          
                    End If
          
                  End If
          
                End If
               
                If .mad <> 0 Then 
                  '' entity is mad
                  
                  '' see if its far enough to get a reset
                  .funcs.active_state = out_proximity( Varptr( _enemy[do_stuff] ) ) 
                  
                End If
                
              End If
              
            End If
    
            
            If .projectile Then
              If .projectile->active <> 0 Then 
                '' projectile triggered 
                
                __do_proj ( Varptr( _enemy[do_stuff] ) ) 
              
              End If
              
            End If
            
            If .unique_id = u_ferus Then
              
              if .radius = 0 then
                .radius = Timer + 3 + ( Rnd * 3 )
                
              end if
                
              If Timer > .radius Then
              
                .radius = 0
                __trigger_projectile( Varptr( _enemy[do_stuff] ) ) 
              
              
              End If
            
            
            
            End If
            
            
            If .pushable <> 0 Then 
              '' the entity is pushable
              
              __push ( Varptr( _enemy[do_stuff] ) ) 
              
            End If
      
            If .vol_fade_trig <> 0 Then 
              '' projectile triggered 
              
              __do_vol_fade ( Varptr( _enemy[do_stuff] ) ) 
            
            End If
            
  
            If llg( seq ) = 0 Then
              '' no sequence happening already
              
              
              If llg( hero ).switch_room = -1 Then
              
                If .action_sequence <> 0 Then 
                  '' ths entity loads a sequence when you action it
                  
                  If llg( hero_only ).action <> 0 Then
                  
                    LLObject_ActionSequence( Varptr( _enemy[do_stuff] ) )
                    
                  End If
            
  
                End If
                
  
                
                
                If .touch_sequence <> 0 Then 
                  '' ths entity loads a sequence when you touch it
                  
                  LLObject_TouchSequence( Varptr( _enemy[do_stuff] ) )
                    
                End If
                
              End If
              
            End If          
  
            
            If .grult_proj_trig <> 0 Then 
  
  
              '' projectile triggered (concurrent functionality)
              __do_grult_proj ( Varptr( _enemy[do_stuff] ) ) 
              
              LLObject_CheckGTorchLit( Varptr( _enemy[do_stuff] ) ) 
            
            End If
            
  
            If .anger_proj_trig <> 0 Then 
              __do_anger_proj ( Varptr( _enemy[do_stuff] ) ) 
              
            End If
            
            If .unique_id = u_grult Then 
              
  '              If .funcs.active_state <> .stun_state Then
              If .funcs.active_state = 0 Or ( .funcs.active_state = .proj_state )Then
                
  
                If llg( dark ) <> 4 Then
                  '' stunned
                  
                  .stun_return_trig = 0
                  LLObject_ClearProjectiles( _enemy[do_stuff] )
                  .fly_timer = 0 
                  .fly_count = 0 
                  .grult_proj_trig = 0
    
    
                  .jump_counter = 0    
                  
                  LLObject_ShiftState( Varptr( _enemy[do_stuff] ), .stun_state )
                  
                End If
                
              Else'If (.funcs.active_state = .stun_state) Or (.funcs.active_state = .hit_state) Then
  
      
                If (.stun_return_trig = 0) Then
                
  '                    If now_room().dark = 4 Then
                  If llg( dark ) = 4 Then
                    .stun_return_trig = 1
                    
                  End If
                    '' un-stunned!
                  
                  If .stun_return_trig = 1 Then
                    
                    If .dead = 0 Then
                     
                      .jump_counter = 0    
  
                      .hurt = 0
  
  
                      LLObject_ClearDamage( Varptr( _enemy[do_stuff] ) )
  
                      .fly_count = 0
                      .fly_timer = 0 
                      .flash_timer = 0 
                      .invisible = 0
                      .mad =  0
  
                      .invincible = -1
  
                      LLObject_ShiftState( Varptr( _enemy[do_stuff] ), .reset_state )
  
                      
                      
                      
                    End If
                    
                  End If
                  
                End If
              
              End If
                
            End If
            
            
            
            If .spawn_cond <> 0 Then
              LLObject_CheckSpawn( Varptr( _enemy[do_stuff] ) )
            
            End If
                              
            If .unique_id = u_gbutton Then
            
              Dim As LLObject_CollisionType collisionCheck
              Dim As Integer buttonSet, rockCheck
              
              collisionCheck = LLObject_Collision( llg( hero ), _enemy[do_stuff] )
              If collisionCheck.isColliding = -1 Then
                buttonSet = -1
                
              End If
              
              If buttonSet = 0 Then
                
                For rockCheck = 0 To now_room().enemies - 1
                  
                  If now_room().enemy[rockCheck].unique_id = u_pushrock Then
                    collisionCheck = LLObject_Collision( now_room().enemy[rockCheck], _enemy[do_stuff] )
                    If collisionCheck.isColliding = -1 Then
                      buttonSet = -1
                      Exit For
                      
                    End If
                    
                  End If
                  
                Next
              
              End If
              
              .funcs.active_state = IIf( buttonSet, 1, 0 )
              
              
            
            
            End If
  
            If ( .unique_id = u_gold ) Or ( .unique_id = u_silver ) Or ( .unique_id = u_health ) Then
              '' this is loot to pick up
              
              LLObject_GrabItems( Varptr( _enemy[do_stuff] ) )
            
            End If
          
            If .unique_id = u_ltorch Then
  
              LLObject_TorchModify( Varptr( _enemy[do_stuff] ) )  
                
            End If
            
            If  .dmg.id <> 0 Then
              '' enemy was hit by lynn 
              
              __flashy( Varptr( _enemy[do_stuff] ) )
          
            End If
  
  
            If Timer > .walk_hold Then .walk_hold = 0
            
  
  
              If .animControl[.current_anim].frame[.frame].concurrents <> 0 Then
                
                LLEngine_ExecuteConcurrents( Varptr( _enemy[do_stuff] ) )
                
                
              End If
            
            If ( .unique_id = u_dyssius ) Or ( .unique_id = u_steelstrider ) Then
              
              If .dead = 0 Then

                If .sway <> 0 Then

                  If Timer > .sway Then
                    __dyssius_jump_slide( Varptr( _enemy[do_stuff] ) )
                    .sway = 0
  
                    .fly_count = 0
                    .fly_timer = 0 
                    .flash_timer = 0 
                    .invisible = 0
                    .hurt = 0
              
                    If ( .projectile->coords[0].x <> 0 ) Or ( .projectile->coords[0].y <> 0 ) Then
                    
                      LLObject_ClearProjectiles( _enemy[do_stuff] )
                      
                    End If
                    
                  End If
                  
                End If
                
              End If
              
            End If
            
          End If

          .funcs.current_func[.funcs.active_state] += .funcs.func[.funcs.active_state][.funcs.current_func[.funcs.active_state]] ( VarPtr( _enemy[do_stuff] ) )
  
        End If
      
      End If
    
    End With
      
  Next
  
  If _enemy = Varptr( now_room().temp_enemy( 0 ) ) Then
    maintain_temps( Varptr( now_room() ) )
    
  End If 


End Sub


Sub ll_main_entry()


  enter_map( Varptr( llg( hero ) ), llg( map ), llg( start_map ), llg( start_entry ) )

  With llg( map )->room[llg( this_room.i )]
  
    set_up_room_enemies( .enemies, .enemy )
    
  End With
  llg( seq ) = llg( hero ).seq
  llg( hero ).seq = 0
  llg( song ) = llg( map )->room[llg( this_room.i )].song

  
  If llg( map )->isDungeon <> 0 Then
    llg( minimap ).room[llg( this_room ).i].hasVisited = -1  
    
  End If

  
  LLMusic_Start( *music_strings( llg( song ) ) )  

                                                                                                                                              antiHackASSIGN( LL_Global.hero_only.healthDummy, LL_Global.hero.hp )
                                                                                                                                              antiHackASSIGN( LL_Global.hero_only.weaponDummy, LL_Global.hero_only.has_weapon )
                                                                                                                                              antiHackASSIGN( LL_Global.hero_only.moneyDummy, LL_Global.hero.money )
                                                                                                                                              antiHackASSIGN2( LL_Global.hero_only.itemDummy, LL_Global.hero_only.hasItem )
                                                                                                                                              antiHackASSIGN2( LL_Global.hero_only.outfitDummy, LL_Global.hero_only.hasCostume )
                                                                                                                                              antiHackASSIGN( LL_Global.hero_only.maxhealthDummy, LL_Global.hero.maxhp )

End Sub



Sub engine_init()

  fb_StartGlobal()

  echo_print( "setting keys to values in ""data\controls.xml""" )

  Kill "roomchange.txt"
  Kill "set_up_room_enemies.txt"

  Dim As xml_type Ptr last_controls
  last_controls = xml_Load( "data\controls.xml" )
  
  
  Dim As Integer control_check
    
  If last_controls <> 0 Then

    control_check = -1
  
    control_check And= ( Val( xml_TagValue( last_controls, "key_map->attack"     ) ) ) <> 0
    control_check And= ( Val( xml_TagValue( last_controls, "key_map->item"       ) ) ) <> 0
    control_check And= ( Val( xml_TagValue( last_controls, "key_map->action"     ) ) ) <> 0
    control_check And= ( Val( xml_TagValue( last_controls, "key_map->move_up"    ) ) ) <> 0
    control_check And= ( Val( xml_TagValue( last_controls, "key_map->move_right" ) ) ) <> 0
    control_check And= ( Val( xml_TagValue( last_controls, "key_map->move_down"  ) ) ) <> 0
    control_check And= ( Val( xml_TagValue( last_controls, "key_map->move_left"  ) ) ) <> 0

  End If
      
  If control_check = 0 Then
    ? "Run Controls.exe to set the game controls."
    Sleep 5000
    End
    
  End If



    
  llg( atk_key )         = init_bin_obj( Val( xml_TagValue( last_controls, "key_map->attack" ) ), ProcPtr( atk_key_in_sub    ), ProcPtr( atk_key_out_sub    ) ) 
  llg( act_key )         = init_bin_obj( Val( xml_TagValue( last_controls, "key_map->item"   ) ), ProcPtr( act_key_in_sub    ), ProcPtr( act_key_out_sub    ) ) 
  llg( conf_key )        = init_bin_obj( Val( xml_TagValue( last_controls, "key_map->action" ) ), ProcPtr( conf_key_in_sub   ), ProcPtr( conf_key_out_sub   ) ) 
  llg( item_l_key )      = init_bin_obj( sc_comma                                               , ProcPtr( item_l_key_in_sub ), ProcPtr( item_l_key_out_sub ) ) 
  llg( item_r_key )      = init_bin_obj( sc_period                                              , ProcPtr( item_r_key_in_sub ), ProcPtr( item_r_key_out_sub ) ) 
  
  llg( u_key.code ) = Val( xml_TagValue( last_controls, "key_map->move_up"    ) )
  llg( r_key.code ) = Val( xml_TagValue( last_controls, "key_map->move_right" ) )
  llg( d_key.code ) = Val( xml_TagValue( last_controls, "key_map->move_down"  ) ) 
  llg( l_key.code ) = Val( xml_TagValue( last_controls, "key_map->move_left"  ) ) 


  xml_Destroy( last_controls ) 


  echo_print( "setting up directional ""hints""." )

  llg( dir_hint ) = CAllocate( Len( uByte ) * 4 )  
                    
    llg( dir_hint[0] ) = llg( u_key.code )
    llg( dir_hint[1] ) = llg( r_key.code )
    llg( dir_hint[2] ) = llg( d_key.code )
    llg( dir_hint[3] ) = llg( l_key.code )



  echo_print( "setting up event table" )
  llg( now ) = CAllocate( Len( uByte ) * LL_EVENTS_MAX )


  echo_print( "setting screen pages" )
  llg( a_page ) = 0
  llg( v_page ) = 1



  
  echo_print( "determining entry point" )
  load_entrypoint()
  
  
  echo_print( "map: " & llg( start_map ) )
  
  
  echo_print( "constructing main object" )
  ctor_hero( Varptr( llg( hero ) ) )
    
  llg( do_hud ) = -1
  
  llg( current_cam ) = Varptr( llg( hero ) )
  
  
  echo_print( "loading menu and HUD gfx" )
  load_status_images( Varptr( llg( savImages ) ) )
  load_hud( Varptr( llg( hud ) ) )
  
  load_menu() 
  menu_StringInit()
  

  '' 15, 241
  llg( font ) = LLSystem_ImageDeref( LLSystem_ImageDerefName( "data\pictures\llfont.spr" ) )
  llg( fontFG ) = 15
  llg( fontBG ) = 241
  



  echo_print( "retrieving screen information" )
  ScreenInfo llg( sx ), llg( sy )
  
  
  llg( menu_ScreenSave ) = ImageCreate( 320, 200 )
  
  llg( scrn_ptr ) = ScreenPtr
  
  llg( hero_only ).specialSequence = callocate( len( sequence_type ) )
  
  llg( hero_only ).specialSequence[0].commands = 1
  
  llg( hero_only ).specialSequence[0].command = callocate( len( command_type ) )
  
  llg( hero_only ).specialSequence[0].command[0].ents = 1
  
  llg( hero_only ).specialSequence[0].command[0].ent = callocate( len( command_data ) )
  
  llg( hero_only ).specialSequence[0].command[0].ent[0].active_ent = SF_BOX
  llg( hero_only ).specialSequence[0].command[0].ent[0].text = "Lynn: I can't use this here."

  llg( hero_only ).healingImage = LLSystem_ImageDeref( LLSystem_ImageDerefName( "data\pictures\char\heal.spr"  ) )
  
  
  
End Sub    
  


Sub update_cam( mn As char_type Ptr = 0 ) 

  If mn = 0 Then mn = Varptr( llg( hero ) )

  Dim As Integer cam_x, cam_y

  With ll_global

    cam_x = mn->coords.x - ( ( ( .sx ) - ( mn->perimeter.x Shr 1 ) ) Shr 1 )  - 1 '' div 2, div 2
    If cam_x < 0 Then cam_x = 0
    If cam_x > ( now_room().x Shl 4 ) - .sx Then cam_x = ( now_room().x Shl 4 ) - .sx '' mul tileX, multileX
  
    cam_y = mn->coords.y - ( ( ( .sy ) - ( mn->perimeter.y Shr 1 ) ) Shr 1 )  - 1 '' div 2, div 2
    If cam_y < 0 Then cam_y = 0
     If cam_y > ( now_room().y Shl 4 ) - .sy Then cam_y = ( now_room().y Shl 4 ) - .sy '' mul tileY, mul tileY
    
    .this_room.cx = cam_x
    .this_room.cy = cam_y


  End With


End Sub


Function move_object( o As char_type Ptr, only_looking As Integer = 0, moment As Double = 1, recurring As Integer = 0 ) As uInteger


  Dim As Integer mx, my '' holds open axes
  
  Select Case o->direction
      
    Case 0
  

      If o->coords.y > 0 Or ( o->unstoppable_by_screen ) Then
        '' object "y" is bigger than 0, or is not stopped by physical bounds. 
      
        If check_walk( o, 0, only_looking Or recurring ) Or ( o->unstoppable_by_tile <> 0 )Then
          '' object has open 'walkable path, or isn't stopped by unwalkable areas 
        
          If check_against_entities ( 0, o ) <> 1 Or ( o->unstoppable_by_object ) Then

            '' object isn't colliding with another (impassable) object, or is not stopped by impassable objects
            
            If only_looking = 0 Then
              '' execute
              ''
              o->coords.y -= 1 * moment
              
            End If
            
            my = 1
            
          End If
          
        End If
      
      End If
      
      
    Case 1
    
      If o->coords.x < ( now_room().x Shl 4 ) - o->perimeter.x Or ( o->unstoppable_by_screen ) Then '' mul tileX

        '' object "x" is smaller than right bound, or is not stopped by physical bounds. 

        If check_walk( o, 1, only_looking Or recurring ) Or ( o->unstoppable_by_tile <> 0 )Then 
          '' object has open 'walkable path, or isn't stopped by unwalkable areas 
        

          If check_against_entities ( 1, o ) <> 1 Or ( o->unstoppable_by_object ) Then

            '' object isn't colliding with another (impassable) object, or is not stopped by impassable objects

            If only_looking = 0 Then
              '' execute
              ''
              o->coords.x += 1 * moment
              
            End If
            
            mx = 1

          End If
          
        End If
        
      End If


    Case 2
        
      If o->coords.y < ( now_room().y Shl 4 ) - o->perimeter.y Or ( o->unstoppable_by_screen ) Then '' mul tileY

        If check_walk( o, 2, only_looking Or recurring ) Or ( o->unstoppable_by_tile <> 0 )Then 
      
          If check_against_entities ( 2, o ) <> 1 Or ( o->unstoppable_by_object ) Then
            
      
            If only_looking = 0 Then
              '' execute
              ''
              o->coords.y += 1 * moment
        
            End If    
            
            my = 1
      
          End If
          
        End If
        
      End If

    Case 3
        

      If o->coords.x > 0 Or ( o->unstoppable_by_screen ) Then 

      
        If check_walk( o, 3, only_looking Or recurring ) Or ( o->unstoppable_by_tile <> 0 )Then 
      

          If check_against_entities ( 3, o ) <> 1 Or ( o->unstoppable_by_object ) Then

      
            If only_looking = 0 Then
              '' execute
              ''
              o->coords.x -= 1 * moment
              
            End If

            mx = 1
      
          End If
          
        End If
        
      End If
    
    Case 4
        

      If o->coords.y > 0 Or ( o->unstoppable_by_screen ) Then 

      
        If check_walk( o, 0, only_looking Or recurring ) Or ( o->unstoppable_by_tile <> 0 )Then 
      

          If check_against_entities ( 0, o ) <> 1 Or ( o->unstoppable_by_object ) Then

      
            If only_looking = 0 Then
              '' execute
              ''
              o->coords.y -= 1 * moment
      
            End If

            my = 1
      
          End If
          
        End If
        
      End If
        

      If o->coords.x > 0 Or ( o->unstoppable_by_screen ) Then 

      
        If check_walk( o, 3, only_looking Or recurring ) Or ( o->unstoppable_by_tile <> 0 )Then 
      

          If check_against_entities ( 3, o ) <> 1 Or ( o->unstoppable_by_object ) Then

      
            If only_looking = 0 Then
              '' execute
              ''
              o->coords.x -= 1 * moment
      
            End If

            mx = 1
      
          End If
          
        End If
        
      End If

    Case 5


      If o->coords.y > 0 Or ( o->unstoppable_by_screen ) Then 

      
        If check_walk( o, 0, only_looking Or recurring ) Or ( o->unstoppable_by_tile <> 0 )Then 
      

          If check_against_entities ( 0, o ) <> 1 Or ( o->unstoppable_by_object ) Then

      
            If only_looking = 0 Then
              '' execute
              ''
              o->coords.y -= 1 * moment
      
            End If

            my = 1
      
          End If
          
        End If
        
      End If
      
      If o->coords.x < ( now_room().x Shl 4 ) - o->perimeter.x Or ( o->unstoppable_by_screen ) Then 

      
        If check_walk( o, 1, only_looking Or recurring ) Or ( o->unstoppable_by_tile <> 0 )Then 
      

          If check_against_entities ( 1, o ) <> 1 Or ( o->unstoppable_by_object ) Then

      
            If only_looking = 0 Then
              '' execute
              ''
              o->coords.x += 1 * moment
      
            End If

            mx = 1
      
          End If
      
          
        End If
        
      End If

    Case 6


      If o->coords.y < ( now_room().y Shl 4 ) - o->perimeter.y Or ( o->unstoppable_by_screen ) Then 

      
        If check_walk( o, 2, only_looking Or recurring ) Or ( o->unstoppable_by_tile <> 0 )Then 
      

          If check_against_entities ( 2, o ) <> 1 Or ( o->unstoppable_by_object ) Then

      
            If only_looking = 0 Then
              '' execute
              ''
              o->coords.y += 1 * moment
      
            End If

            my = 1
      
          End If
      
        End If
        
      End If
      
      If o->coords.x < ( now_room().x Shl 4 ) - o->perimeter.x Or ( o->unstoppable_by_screen ) Then 

      
        If check_walk( o, 1, only_looking Or recurring ) Or ( o->unstoppable_by_tile <> 0 )Then 
      

          If check_against_entities ( 1, o ) <> 1 Or ( o->unstoppable_by_object ) Then

      
            If only_looking = 0 Then
              '' execute
              ''
              o->coords.x += 1 * moment
      
            End If

            mx = 1
      
          End If
          
        End If
        
      End If

    Case 7

      If o->coords.y < ( now_room().y Shl 4 ) - o->perimeter.y Or ( o->unstoppable_by_screen ) Then 

      
        If check_walk( o, 2, only_looking Or recurring ) Or ( o->unstoppable_by_tile <> 0 )Then 
      

          If check_against_entities ( 2, o ) <> 1 Or ( o->unstoppable_by_object ) Then

      
            If only_looking = 0 Then
              '' execute
              ''
              o->coords.y += 1 * moment
      
            End If

            my = 1
      
          End If
          
        End If
        
      End If
      

      If o->coords.x > 0 Or ( o->unstoppable_by_screen ) Then 

      
        If check_walk( o, 3, only_looking Or recurring ) Or ( o->unstoppable_by_tile <> 0 )Then 
      

          If check_against_entities ( 3, o ) <> 1 Or ( o->unstoppable_by_object ) Then

      
            If only_looking = 0 Then
              '' execute
              ''
              o->coords.x -= 1 * moment
              
            End If

            mx = 1
      
          End If
          
        End If
        
      End If
  
      
  End Select
 
 
  Return ( mx Shl 16 ) Or my


End Function



Function check_walk ( o As char_type Ptr, d As Integer, psfing = 0 ) Static

  If ( o->coords.x < 0 ) Or ( o->coords.y < 0 ) Or ( ( o->coords.x + o->perimeter.x ) > ( now_room().x Shl 4 ) ) Or ( ( o->coords.y + o->perimeter.y ) > ( now_room().y Shl 4 ) ) Then
    Return FALSE
  
  End If


  Dim As Integer x_offset_2, y_offset_2, x_tile_2, y_tile_2, quads_x, quads_y, x_aligned, y_aligned
  dim as integer t_index
  Dim As Integer layer
  Dim As Integer crawl_axis, crawl
  Dim As Integer x_opt, y_opt
  Dim As Integer tile_free, psf_free

  x_aligned = 0
  y_aligned = 0

  x_tile_2 = Int( o->coords.x ) Shr 3  
  y_tile_2 = Int( o->coords.y ) Shr 3  

  x_offset_2 = Int( o->coords.x ) And 7
  y_offset_2 = Int( o->coords.y ) And 7
  
  quads_x = Int( o->perimeter.x ) Shr 3
  quads_y = Int( o->perimeter.y ) Shr 3

  If x_offset_2 <> 0 Then 
    quads_x += 1 

  Else 
    x_aligned = 1
    
  End If

  If y_offset_2 <> 0 Then 
    quads_y += 1 
    
  Else 
    y_aligned = 1
    
  End If
  
  '' prime
  if psfing then
    psf_free = TRUE
    
  else
    tile_free = TRUE
    
  end if

    Select Case d Mod 2
    
      Case 0
      
        crawl_axis = quads_x
  
      Case 1
  
        crawl_axis = quads_y
        
    End Select
    

    For layer = 0 To 2
  
    
      For crawl = 0 To crawl_axis - 1
  
  
        Select Case d
        

          Case 0
  
            x_opt = ( x_tile_2 + crawl )
            y_opt = ( y_tile_2 - y_aligned )

          Case 1
  
            x_opt = ( quads_x - 1 ) + x_tile_2 + x_aligned
            y_opt = ( y_tile_2 + crawl )

          Case 2
          
            x_opt = ( x_tile_2 + crawl )
            y_opt = ( quads_y - 1 ) + y_tile_2 + y_aligned

          Case 3
  
            x_opt = ( x_tile_2 - x_aligned )
            y_opt = ( y_tile_2 + crawl )
              
            
        End Select
  
        t_index = ( ( y_opt Shl 3 ) Shr 4 ) * now_room().x + ( ( x_opt Shl 3 ) Shr 4 )
        
        If Bit( now_room().layout[layer][t_index], 15 - quad_calc( x_opt, y_opt ) ) <> 0 Then
          if psfing then
            psf_free = FALSE
            
          else
            tile_free = FALSE
            
          end if
          
        End If
        
      Next
    
    Next


  If tile_free = FALSE Then 
  
    If psfing = FALSE Then
    
      If o->unique_id = u_lynn Then 
        check_psf( o, d )

      Else
        If o->unique_id = u_pushrock Then
          check_psf( o, d )
          
        End If
        
      End If
      
    End If
    
  End If
  
  
  if psfing then
    Return psf_free
  else
    
    Return tile_free
  end if

 

End Function



Function check_against_entities( d As Integer = 0, o As char_type Ptr ) As Integer' Static


  Dim As Integer cycle, relay


  With now_room()  

    If .enemies = 0 Then 
      '' there are no objects to collide with in this room
      Return 0 
      
    End If
  
    For cycle = 0 To .enemies - 1
      '' cycle thru enemies
  
      If o->num <> .enemy[cycle].num Then
        '' if this "o" isn't this enemy, then check it against this enemy
        relay = check_against( o, .enemy, cycle, d )
        If relay Then Return relay
        
      End If
  
    Next
  
  
  
    For cycle = 0 To .temp_enemies - 1
      '' cycle through temp enemies
  
      If o->num <> .temp_enemy( cycle ).num Then
        '' if this "o" isn't this temp enemy, then check it against this temp enemy
        relay = check_against( o, Varptr( .temp_enemy( 0 ) ), cycle, d )
        If relay Then Return relay
  
      End If
  
    Next
    
  End With
  


  If o->unique_id <> u_lynn Then
    '' if this "o" isn't lynn, check the "o" against her
     
    If llg( hero_only ).attacking = 0 Then
      relay = check_against( o, Varptr( llg( hero ) ), 0, d )
      If relay Then Return relay
      
    End If

  End If


  
End Function




Function check_against( o As char_type Ptr, othr As char_type Ptr, check As Integer, d As Integer ) Static

  
  #Define LLObject_Impassable(__THISCHAR__,__FACE__)                                                                             _
                                                                                                                                 _
    ( IIf( __THISCHAR__.##anim[__THISCHAR__.##current_anim]->frame[LLObject_CalculateFrame(__THISCHAR__)].faces = 0,             _
                                                                                                                                 _
    __THISCHAR__.##impassable,                                                                                                   _
                                                                                                                                 _
    __THISCHAR__.##anim[__THISCHAR__.##current_anim]->frame[LLObject_CalculateFrame(__THISCHAR__)].face[__FACE__].impassable ) )                                                                                                   _
                  
  

  '' moving object to static object collision detection
 
  Function = 0

  Dim As Vector opty
  Dim As vector_pair m, n
  Dim As Integer faces, faces2
  Dim As Integer check_fields, check_fields2
  
  dim as integer res
  res = 0
  
  opty.x = 0
  opty.y = 0
  
  Select Case d
  
    Case 0
      opty.y = -1
    
    Case 1
      opty.x = 1
    
    Case 2
      opty.y = 1
    
    Case 3
      opty.x = -1
      
      
  End Select
    
  o->frame_check          = LLObject_CalculateFrame( o[0] )
  othr[check].frame_check = LLObject_CalculateFrame( othr[check] )

  With othr[check]: With .anim[.current_anim]->frame[.frame_check]: faces  = IIf( .faces = 0, 0, .faces -1 ): End With: End With
  With *( o )     : With .anim[.current_anim]->frame[.frame_check]: faces2 = IIf( .faces = 0, 0, .faces -1 ): End With: End With
  
  For check_fields = 0 To faces

    For check_fields2 = 0 To faces2
    
      m.u = V2_Add( o->coords, opty )
      n.u = othr[check].coords

      calc_positions( o, m, check_fields2 )  
      calc_positions( Varptr( othr[check] ), n, check_fields )  


      If check_bounds( m, n ) = 0 Then
        
        If o->unique_id = u_charger Then

          If othr[check].unique_id = u_charger Then
            '' kill both!
            
            o->hp = 0
            othr[check].hp = 0
            
            return 0
            
          End If
          
        End If

        res = (                                                                                                                                       _ 
                IIf(                                                                                                                                  _
                     ( ( o[0].unique_id = u_dyssius ) Or ( o[0].unique_id = u_steelstrider ) ) And ( othr[check].unique_id = u_lynn ),                _
                     1,                                                                                                                               _
                     IIf(                                                                                                                             _
                          IIf(                                                                                                                        _
                               (                                                                                                                      _
                                 ( LLObject_Impassable( o[0], check_fields2 ) = 0 ) And ( LLObject_Impassable( othr[check], check_fields ) = 0 )      _   
                                                                             Or                                                                       _
                                        ( ( o[0].dead ) Or ( othr[check].dead ) Or ( othr[check].unique_id = u_gold ) )                               _
                               ),                                                                                                                     _
                               IIf(                                                                                                                   _ 
                                    (                                                                                                                 _
                                      ( Not ( othr[check].unique_id = u_chest         ) ) And                                                         _
                                      ( Not ( othr[check].unique_id = u_bluechest     ) ) And                                                         _
                                      ( Not ( othr[check].unique_id = u_bluechestitem ) )                                                             _
                                    ),                                                                                                                _
                                    0,                                                                                                                _
                                    1                                                                                                                 _
                                  ),                                                                                                                  _
                               IIf(                                                                                                                   _ 
                                    ( othr[check].unique_id = u_sparkle ) Or ( othr[check].unique_id = u_gbutton ) Or ( o[0].unique_id = u_godstat ), _
                                    0,                                                                                                                _
                                    1                                                                                                                 _
                                  )                                                                                                                   _
                             ),                                                                                                                       _
                          IIf( othr[check].unstoppable_by_object, 0, IIf( o->unstoppable_by_object, 0, 1 ) ),                                         _
                          0                                                                                                                           _
                        )                                                                                                                             _
                   )                                                                                                                                  _
              )

        If res = 1 Then
          
          return res
          
        end if
        
      End If
  
    Next

  Next    


End Function


Sub calc_positions( obj As char_type Ptr, v As vector_pair, _face As Integer )

  With obj->anim[obj->current_anim]->frame[obj->frame_check]

    If .faces = 0 Then
  
      v.v = obj->perimeter
      
    Else
    
      v.u.x += .face[_face].x - obj->animControl[obj->current_anim].x_off
      v.u.y += .face[_face].y - obj->animControl[obj->current_anim].y_off
  
      v.v.x = .face[_face].w
      v.v.y = .face[_face].h
      
    End If
    
  End With
  
End Sub


Sub check_psf( o As char_type Ptr, d As Integer ) 
  
  
  Dim As Integer layercheck, pnts, tmp_dir, po_x, po_y, pol, tmp_d
  Dim As Integer tx_2 = ( 8 ), ty_2 = ( 8 )
  Dim As Integer x_crawl, y_crawl

  in_dir_small( d )
  
  tmp_dir = o->direction
  tmp_d = d

  If ( d And 1 ) = 0 Then
    If rl_key() Then Exit sub
    pnts = ( o->perimeter.x Shr 3 ) '' div tx_2
    x_crawl = tx_2 
  
  Else
    If ud_key() Then Exit Sub
    pnts = ( o->perimeter.y Shr 3 ) '' div ty_2
    y_crawl = ty_2 
      
  End If

  po_x = Int( o->coords.x )
  po_y = Int( o->coords.y )

  Select Case d
  
    Case 0
    
    Case 1
    
      po_x += Int( o->perimeter.x ) - tx_2

    Case 2
    
      po_x += Int( o->perimeter.x )
      po_y += Int( o->perimeter.y ) - ty_2

    Case 3
    
      po_y += Int( o->perimeter.y )

    
  End Select
  

  Select Case d Shr 1
  
    Case 0
    
      pol = 1

    Case Else
    
      pol = -1  
    
  End Select
  

  For layercheck = 0 To 2

    Dim As tile_quad slider, chkr
    Dim As Integer crawl, x_opt, y_opt, po_quad, mi_quad, op_quad

    crawl = 0

    x_opt = ( crawl * x_crawl * pol ) + po_x
    y_opt = ( crawl * y_crawl * pol ) + po_y     

    slider.x = ( x_opt ) Shr 4 '' div tileX
    slider.y = ( y_opt ) Shr 4 '' div tileY
    slider.quad = quad_calc( ( x_opt ) Shr 3, ( y_opt ) Shr 3 ) '' div tx_2, ty_2
  
    chkr = quad_seek( slider, d )
    po_quad = Bit( now_room().layout[layercheck][chkr.y * now_room().x + chkr.x], 15 - chkr.quad )
  

    For crawl = 1 To pnts - 1
  
      x_opt = ( crawl * x_crawl * pol ) + po_x
      y_opt = ( crawl * y_crawl * pol ) + po_y     
      
      slider.x = ( x_opt ) Shr 4 '' div tileX
      slider.y = ( y_opt ) Shr 4 '' div tileY
      slider.quad = quad_calc( ( x_opt ) Shr 3, ( y_opt ) Shr 3 ) '' div tx_2, ty_2

      chkr = quad_seek( slider, d )
      mi_quad Or = Bit( now_room().layout[layercheck][chkr.y * now_room().x + chkr.x], 15 - chkr.quad ) 
      
    Next
    
    '' unnecessary syntactically, but it's clarification that counts, kids.
    crawl = pnts
    
    x_opt = ( crawl * x_crawl * pol ) + po_x
    y_opt = ( crawl * y_crawl * pol ) + po_y     
    
    slider.x = ( x_opt ) Shr 4
    slider.y = ( y_opt ) Shr 4
    slider.quad = quad_calc( ( x_opt ) Shr 3, ( y_opt ) Shr 3 )

    chkr = quad_seek( slider, d )
    op_quad = Bit( now_room().layout[layercheck][chkr.y * now_room().x + chkr.x], 15 - chkr.quad )
  

    d = tmp_d
    '' got all the quads
    
    
    If ( po_quad <> 0 ) And ( op_quad <> 0 ) Then
      Exit sub
      
    End If
    

    If ( po_quad <> 0 ) And ( op_quad = 0 ) Then 
    '' clockwise
      o->direction += 1
      in_dir_small( o->direction )    
      
      o->is_psfing = ( move_object( o, , o->momentum.i( tmp_dir ), 1 ) <> 0 )
      o->direction =  tmp_dir

      Exit Sub
      
    End If
    

    If ( po_quad = 0 ) And ( op_quad <> 0 ) Then 
      '' counter clockwise
      o->direction -= 1
      in_dir_small( o->direction )    
      
      o->is_psfing = ( move_object( o, , o->momentum.i( tmp_dir ), 1 ) <> 0 )
      o->direction =  tmp_dir

      Exit Sub
      
    End If
    
    
    If ( po_quad = 0 ) And ( op_quad = 0 ) And ( mi_quad <> 0 ) Then 
    '' clockwise
      o->direction += 1
      in_dir_small( o->direction )    
      
      o->is_psfing = ( move_object( o, , o->momentum.i( tmp_dir ), 1 ) <> 0 )
      o->direction =  tmp_dir

      Exit Sub
      
    End If
  
  Next

End Sub     




Function quad_seek( t_in As tile_quad, d As Integer ) As tile_quad

  Dim As Integer opt, to_quad, to_tile_x, to_tile_y

  to_tile_x = t_in.x
  to_tile_y = t_in.y

  Select Case As Const d
  
    Case 0
    
      opt = -2
      
    Case 1
    
      opt = 1
            
    Case 2
    
      opt = 2
      
    Case 3
    
      opt = -1
      
  End Select

  to_quad = opt + t_in.quad

  Select Case As Const d '' overflow
  
    Case 0
    
      If to_quad < 0 Then
        ''move tile up one
        
        to_tile_y -= 1
        to_quad = IIf( to_quad = -2, 2, 3 )
        
      End If
      
    Case 1
    
      If ( Abs( to_quad ) And 1 ) = 0 Then
        ''move tile right one

        to_tile_x += 1
        to_quad = IIf( to_quad = 2, 0, 2 )
        
      End If
            
    Case 2                          
    
      If to_quad > 3 Then
        ''move tile down one

        to_tile_y += 1
        to_quad = IIf( to_quad = 4, 0, 1 )
        
      End If
      
    Case 3
    
      If ( Abs( to_quad ) And 1 ) <> 0 Then
        ''move tile left one

        to_tile_x -= 1
        to_quad = IIf( to_quad = 1, 3, 1 )
        
      End If
      
  End Select

  Return Type <tile_quad> ( to_tile_x, to_tile_y, to_quad )
  
End Function



Private Function check_teleports( _char As _char_type, _tele As teleport_type Ptr, num_tele As Integer ) As Integer


  Dim As Integer tele_check
  For tele_check = 0 To num_tele - 1

    Dim As vector_pair origin, target

    origin.u = _char.coords   
    origin.v = _char.perimeter

    target.u.x = _tele[tele_check].x
    target.u.y = _tele[tele_check].y
    target.v.x = _tele[tele_check].w
    target.v.y = _tele[tele_check].h

    If check_bounds( origin, target ) = 0 Then

      Return tele_check
      
    End If
  
  Next

  Return -1

End Function


Private Function check_against_teles( o As _char_type )
  
  Function = -1
  
  Dim As Integer o_returned_tele

  '' returns the teleport lynn is standing on (-1 = no collision detected)
  o_returned_tele = check_teleports( o, now_room().teleport, now_room().teleports )

  If o_returned_tele <> -1 Then
    '' touched a teleport
    
    If now_room().teleport[o_returned_tele].to_map = "" Then
    
      '' this is a room teleport
      change_room( 0, -1, 0 ) '' change_room() is a static FSM, initialize it
      Function = o_returned_tele
      
    Else
      '' this teleport changed the map
      With now_room()

        With .teleport[o_returned_tele]
          o.to_map   = .to_map
          o.to_entry = .to_room
              
        End With
                        
      End With
    
      change_room( 0, -1, 1 ) '' change_room() is a static FSM, initialize it
      Function = o_returned_tele
    
    End If

    o.fade_time = .003
    
  End If


End Function  



Sub hero_main()
  

  if llg( hero_only ).selected_item = 0 then
    if llg( hero_only ).hasItem( 0 ) then
      llg( hero_only ).selected_item = 1
      
    end if
    
  end if

  If ( llg( hero_only ).isWearing = 1 ) Then
    llg( hero ).walk_speed = .003

  elseIf ( llg( hero_only ).isWearing = 5 ) Then
    llg( hero ).walk_speed = .02

  Else
    llg( hero ).walk_speed = .009
    
  End If

  llg( hero_only ).action  = 0
  
  If ( llg( hero_only ).isWearing = 5 ) Then
    
    if llg( hero_only ).healTimer = 0 then
      llg( hero_only ).healTimer = timer + 6
      
    end if
    
    if timer > llg( hero_only ).healTimer then
      if llg( hero ).hp < llg( hero ).maxhp then
        llg( hero ).hp += 1
        antiHackASSIGN( LL_Global.hero_only.healthDummy, LL_Global.hero.hp )

        play_sample( sound_healthgrab )
      end if
      llg( hero_only ).healTimer = 0
      
    end if
    
  else
    llg( hero_only ).healTimer = 0
    
  end if
  
  
  static as integer adrenalineState
  if llg( hero_only ).adrenaline <> NULL then

    select case as const adrenalineState

      case 0    
        adrenalineState += __flash( @llg( hero ) )

      case 1
        adrenalineState += __flash_down( @llg( hero ) )
    
    end select

    if timer > llg( hero_only ).adrenaline then 
      llg( hero_only ).adrenaline = NULL
      adrenalineState = 0
      llg( hero_only ).crazy_points = 0
      
    end if
    
  end if
  
  
  static as double healingTimer
  if llg( hero_only ).healing <> NULL then

    if healingTimer = 0 then
      healingTimer = timer + .1
      
    end if
  
    if timer > healingTimer then
      
      llg( hero_only ).healingFrame += 1 
      healingTimer = 0
      
    end if
    
    if llg( hero_only ).healingFrame = 5 then

      llg( hero_only ).healingFrame = 0
      llg( hero_only ).healing = 0
      
      healingTimer = 0

    end if
    
  end if
  
  
  
  
  With llg( conf_key )
    bin_obj( Type( MultiKey( .code ), .in_ptr, .out_ptr, .in_sub, .out_sub ) )
    
  End With

  If llg( hero ).vol_fade_trig <> 0 Then 
    '' projectile triggered 
    
    __do_vol_fade ( VarPtr( llg( hero ) ) ) 
  
  End If

  
  
  With llg( hero )


    .last_cycle_ice = .on_ice
    .on_ice = 0
    check_ice( llg( hero ) )
    
    If .on_ice = 0 Then
      .coords.x = Int( .coords.x )
      .coords.y = Int( .coords.y )
      
    End If
    

    If ( .on_ice <> 0 ) And .last_cycle_ice = 0 Then

      Dim As Integer all_momentum
      For all_momentum = 0 To 3
        .momentum.i( all_momentum ) = .momentum_history.i( all_momentum )
        
      Next
      
    End If
    
    '' reset lynn move flag
    .moving = 0        
  
  
    If llg( hero_only ).action_lock = 0 Then
      '' lynn can do actions
      
      If llg( hero_only ).attacking = 0 Then 
        '' lynn is not attacking
        
        If (.fly_count = 0) Then 
          '' lynn is not flying back
          
          If .dead = 0 Then
            '' lynn is not dead
            
            If .switch_room = -1 Then
              '' lynn isnt doing a room switch fade thing  
              
              With llg( act_key )
                bin_obj( Type( MultiKey( .code ), .in_ptr, .out_ptr, .in_sub, .out_sub ) )
                
              End With

              With llg( atk_key )
                bin_obj( Type( MultiKey( .code ), .in_ptr, .out_ptr, .in_sub, .out_sub ) )
                
              End With
              
              dir_keys()
              
            End If
          
          End If
          
        End If            
        
      End If
      
      
      If .on_ice = 0 Then
        '' traction
        If .unique_id <> u_steelstrider Then
          __go_grip( Varptr( llg( hero ) ) )      
          
        End If
        
      End If
      
      If .walk_hold = 0 Then
        
        '' walk_hold timer is initialized
        If .dead = 0 Then
          
          If llg( hero_only ).attacking <> 0 Then
            
            If .on_ice <> 0 Then
              __momentum_move( VarPtr( llg( hero ) ) )
              
            End If
            
          Else
'            llg( hero ).momentum.i( llg( hero ).direction ) *= 2
            __momentum_move( VarPtr( llg( hero ) ) )
            
          End If
          
        End If

      End If  

      
      hero_continue_movement( VarPtr( llg( hero ) ) )

      If ( .on_ice <> 0 ) Then
        
        __calc_slide( VarPtr( llg( hero ) ) )      

        
      Else
        __stop_grip( VarPtr( llg( hero ) ) )      
        
      End If
        
      
      .moving Or = ( .is_psfing <> 0 )
      .moving Or = ( .is_pushing <> 0 )
      
      
      If .moving <> 0 Then
        '' lynn's moving
          
        If LLObject_IncrementFrame( varptr( llg( hero ) ) ) <> 0 Then
          llg( hero ).frame = 0
          llg( hero ).frame_hold = Timer + llg( hero ).animControl[llg( hero ).current_anim].rate
          
        End If
        
      Else
        '' lynn isn't moving
        
        If .dead = 0 Then
          '' lynn's alive
          
          If llg( hero_only ).attacking  = 0 Then
            
            If .frame <> 0 Then 
              '' lynn frame not zero, reset
              
              __reset_frame( VarPtr( llg( hero ) ) )
              
              
            End If
            
          End If
        
        End If
      
      End If
      
      
      If llg( hero ).switch_room = -1 Then
        llg( hero ).switch_room = check_against_teles( llg( hero ) )
        
      End If
      
      
    End If
    
    With llg( item_l_key )
      bin_obj( Type( MultiKey( .code ), .in_ptr, .out_ptr, .in_sub, .out_sub ) )
      
    End With
    With llg( item_r_key )
      bin_obj( Type( MultiKey( .code ), .in_ptr, .out_ptr, .in_sub, .out_sub ) )
      
    End With
    
    
    If llg( hero_only ).attacking <> 0 Then
      '' lynn is attacking
      hero_attack( VarPtr( llg( hero ) ) )      
      
    End If
    
    
    If Timer > .walk_hold Then 
      '' walkhold timer expired
      
      .walk_hold = 0
      .is_psfing = 0
      
    End If
    
    
    If .switch_room <> -1 Then
      change_room( VarPtr( llg( hero ) ) )
      
    End If

    
    If .dead = FALSE Then 
      '' lynn's alive,
      
      LLObject_MAINDamage( VarPtr( llg( hero ) ) )

      If ( .dmg.id <> 0 ) Then
        '' lynn is damaged by something
        __flashy( VarPtr( llg( hero ) ) )
  
  
      End If
      
    End If

    
    If .hurt Then
      '' lynn's hurt
      
      .funcs.current_func[.hit_state] += .funcs.func[.hit_state][.funcs.current_func[.hit_state]]( VarPtr( llg( hero ) ) )
      
      
      If .funcs.current_func[.hit_state] = .funcs.func_count[.hit_state] Then
        '' lynn called back
      
        .funcs.current_func[.hit_state] = 0

        .hurt = 0
        .dmg.index = 0
        .dmg.specific = 0
        
      End If
     
    End If
  
  
    If .dead Then
      '' lynn is dead
      
      llg( hero_only ).attacking = 0
      llg( hero ).fade_time = .003

      .funcs.current_func[.death_state] += .funcs.func[.death_state][.funcs.current_func[.death_state]]( VarPtr( llg( hero ) ) )
      
      If ( .funcs.current_func[.death_state] = .funcs.func_count[.death_state] ) Then
        '' lynn called back
        jump_to_title()
        
      End If
        
    End If
  
  End With

  If llg( hero.hp ) > llg( hero.maxhp ) Then 
    llg( hero.hp ) = llg( hero.maxhp )
    antiHackASSIGN( LL_Global.hero_only.healthDummy, LL_Global.hero.hp )
    
  end if

  #IfDef ll_audio
    check_env_sounds()
    
  #EndIf

  cache_crazy()
  decay_crazy()
                                       
  If llg( hero_only ).songFade <> NULL Then
    LLMusic_Fade()
    
  End If


End Sub

Private Sub cache_crazy()

  Static As Double cache_delay = .01, cache_wait
  
  If cache_wait = 0 Then
    
    If llg( hero_only ).crazy_cache > 0 Then
      llg( hero_only ).crazy_points += 1
      llg( hero_only ).crazy_cache -= 1
      
    End If
    
    If llg( hero_only ).crazy_dcache > 0 Then
      llg( hero_only ).crazy_points -= 1
      llg( hero_only ).crazy_dcache -= 1
      
    End If
    
    
    cache_wait = Timer + cache_delay  
      
  
  
  End If
  
  If Timer > cache_wait Then cache_wait = 0




End Sub

Sub decay_crazy()

  Static As Double crazy_decay = .3, crazy_delay
  
  If crazy_delay = 0 Then
  
    crazy_delay = Timer + crazy_decay
    

    If llg( hero_only ).crazy_points > 0 Then 
    
      If llg( hero_only ).crazy_points > 105 Then
        llg( hero_only ).crazy_points = 105
        
      End If

      llg( hero_only ).crazy_dcache += 1

      
    End If
    
    
  End If
  
  If Timer > crazy_delay Then crazy_delay = 0
  

End Sub
  


Private Sub dir_keys()
  
  Static As Double SLIDE_CONSTANT = .02
  
  With llg( hero )
    
    .momentum_history.i( 0 ) = 0
    .momentum_history.i( 1 ) = 0
    .momentum_history.i( 2 ) = 0
    .momentum_history.i( 3 ) = 0

    If .walk_hold = 0 Then

      '' walk_hold timer is initialized
    
      If MultiKey ( llg( l_key.code ) ) Then
        '' hit left
        
        .direction = 3
        .momentum.i( .direction ) += SLIDE_CONSTANT

        If .momentum.i( .direction ) > 1 Then 
          .momentum.i( .direction ) = 1
          
        End If

      Else
        
        If llg( hero.is_pushing ) = 4 Then
          llg( hero.is_pushing ) = 0
          
        End If
        
      End If
      
      If MultiKey ( llg( r_key.code ) ) Then
        '' hit right
        
        .direction = 1
        .momentum.i( .direction ) += SLIDE_CONSTANT
      
        If .momentum.i( .direction ) > 1 Then 
          .momentum.i( .direction ) = 1
          
        End If

      Else  

        If llg( hero.is_pushing ) = 2 Then
          llg( hero.is_pushing ) = 0
          
        End If
        
      End If
        
      If MultiKey ( llg( d_key.code ) ) Then
        '' hit down
        
        .direction = 2
        .momentum.i( .direction ) += SLIDE_CONSTANT
        
        If .momentum.i( .direction ) > 1 Then 
          .momentum.i( .direction ) = 1
          
        End If

      Else  

        If llg( hero.is_pushing ) = 3 Then
          llg( hero.is_pushing ) = 0
          
        End If
        
      End If
      
      If MultiKey ( llg( u_key.code ) )   Then
        '' hit up
        
        .direction = 0
        .momentum.i( .direction ) += SLIDE_CONSTANT

        If .momentum.i( .direction ) > 1 Then 
          .momentum.i( .direction ) = 1
          
        End If

      Else  
        If llg( hero.is_pushing ) = 1 Then
          llg( hero.is_pushing ) = 0
          
        End If
        
      End If
    
    End If  
  
  End With


End Sub


  
  
  
  
Sub hero_continue_movement( mn As _char_type Ptr )
  
  If mn->dead <> 0 Then Exit Sub

  If MultiKey ( llg( u_key ).code ) Or MultiKey ( llg( r_key ).code ) Or MultiKey ( llg( d_key ).code ) Or MultiKey ( llg( l_key ).code ) Then 
    '' hit a directional arrow
    If mn->switch_room = -1 Then
    
      If MultiKey ( llg( l_key ).code ) Then
        '' hit left
        
        mn->direction = 3
        mn->moving Or = move_object ( mn, MO_JUST_CHECKING ) <> 0
        mn->moving Or = ( mn->is_pushing <> 0 )
      
      End If
      
      
      If MultiKey ( llg( r_key ).code ) Then
        '' hit right
        
        mn->direction = 1
        mn->moving Or = move_object ( mn, MO_JUST_CHECKING ) <> 0
        mn->moving Or = ( mn->is_pushing <> 0 )
          
      End If
        
        
      If MultiKey ( llg( d_key ).code ) Then
        '' hit down
        
        mn->direction = 2
        mn->moving Or = move_object ( mn, MO_JUST_CHECKING ) <> 0
        mn->moving Or = ( mn->is_pushing <> 0 )
  
      End If
      
      
      If MultiKey ( llg( u_key ).code )   Then
        '' hit up
        
        mn->direction = 0
        mn->moving Or = move_object ( mn, MO_JUST_CHECKING ) <> 0
        mn->moving Or = ( mn->is_pushing <> 0 )
   
      End If
      
    End If
    
  End If

  
End Sub



Private Sub sequence_LoadGame( savedInfo As ll_saving_data Ptr )
  
  '' only called from play_sequence
  
  llg( hero ).hp              = savedInfo->hp
  llg( hero ).maxhp           = savedInfo->maxhp  
  
  llg( hero ).money           = savedInfo->gold   
  llg( hero_only ).has_weapon = savedInfo->weapon 
'  llg( hero_only ).has_item   = savedInfo->item   
  memcpy( @llg( hero_only ).hasItem(0), @savedInfo->hasItem(0), 6 * len( integer ) )
  
  llg( hero_only ).has_bar    = savedInfo->bar
  
  llg( hero ).key             = savedInfo->key
  llg( hero_only ).b_key      = savedInfo->b_key
  
  llg( hero ).to_map          = savedInfo->map
  llg( hero ).to_entry        = savedInfo->entry
  
  llg( hero_only ).weapon     = llg( hero_only ).has_weapon
  
  MemCpy( Varptr( llg( hero_only ).hasCostume( 0 ) ), Varptr( savedInfo->hasCostume( 0 ) ), 9 )
  llg( hero_only ).isWearing = savedInfo->isWearing
  
  
  '            '' hack
  '            llg( hero ).to_map = "icefield.map"
  '            llg( hero ).to_entry = 1
  '            llg( hero_only ).hasCostume( 1 ) = -1
  '            llg( hero_only ).hasCostume( 2 ) = -1
  '            llg( hero_only ).hasCostume( 3 ) = -1
  '            llg( hero ).to_map          = "arx.map"
  
  '' :::::::::::::::::::::::::::::::::::::
  
  Select Case llg( hero_only ).isWearing
  
    Case 0
      set_regular()
      
    Case 1
      set_cougar()
      
    Case 2
      set_lynnity()
  
    Case 3
      set_ninja()

    Case 4
      set_bikini()
  
    Case 5
      set_rknight()
  
  
  End Select
  
  
  MemCpy( llg( now ), Varptr( savedInfo->happen( 0 ) ), LL_EVENTS_MAX )
  
  
  llg( hero_only ).has_weapon = llg( hero_only ).weapon' + 1
  
  llg( hero ).switch_room = -2
  
  #IfDef ll_audio
    BASS_ChannelStop( now_room().enemy[5].playing_handle )
    
  #EndIf
  
  
  change_room( 0, -1, 1 )
  
  
  llg( hero ).fade_time = .003
  
  llg( hero_only ).action_lock = 0
  llg( hero ).chap = 0
  llg( hero ).menu_sel = 0
  
  dim iRooms as integer
  
  if savedInfo->rooms <> 0 then
    llg( hero_only ).roomVisited = callocate( savedInfo->rooms )
  
    for iRooms = 0 to savedInfo->rooms - 1
      llg( hero_only ).roomVisited[iRooms] = savedInfo->hasVisited[iRooms]
      
    next
    
  end if
  
  hold_key( sc_enter )

  antiHackASSIGN( LL_Global.hero_only.healthDummy, LL_Global.hero.hp )
  antiHackASSIGN( LL_Global.hero_only.weaponDummy, LL_Global.hero_only.has_weapon )
  antiHackASSIGN( LL_Global.hero_only.moneyDummy, LL_Global.hero.money )
  antiHackASSIGN2( LL_Global.hero_only.itemDummy, LL_Global.hero_only.hasItem )
  antiHackASSIGN2( LL_Global.hero_only.outfitDummy, LL_Global.hero_only.hasCostume )
  antiHackASSIGN( LL_Global.hero_only.maxhealthDummy, LL_Global.hero.maxhp )
  
  
End Sub



Sub sequence_AssignEntityData( ByRef charData As char_type, ByRef commandData As command_data )
  
  With commandData

    If charData.mod_lock = 0 Then
      
      If .seq_pause <> 0 Then
      
        charData.seq_paused =  1
  
      End If
  
      charData.mod_lock = 1
      
    End If
    
    If .modify_direction <> 0 Then
    
      charData.direction =  ( .reserved_1 - 1 )
  
    End If
    
    If .free_to_move = 0 Then
      
      llg( hero_only ).action_lock = -1
  
    End If

    If .abs_x <> 0 Then
      charData.coords.x =  ( .abs_x )
      
    End If
    
    If .abs_y <> 0 Then
      charData.coords.y =  ( .abs_y )
      
    End If
    
    if .fadeTime then                                                                 
      charData.fade_time =  ( .fadeTime )
      
    end if
    
  
    If .display_hud <> 0 Then 
  
      llg( do_hud ) = -1
      
    End If
  
      
    '' fill entity with settings stored in the sequence structure    
    charData.dest_x = .dest_x
    charData.dest_y = .dest_y
  
    
    If .jump_count <> 0 Then
  
      charData.jump_count = .jump_count
      
    End If

    charData.chap = .chap
    
    If .walk_speed <> 0 Then 
      
      charData.walk_speed = .walk_speed
    
    End If
    
  End With
  
End Sub

Sub sequence_FullReset( resetSequence As sequence_type ) 
  '' last command executed
  Dim As Integer commandDismantle, entDismantle

  #Define activeEntity resetSequence.ent[.active_ent]

  With resetSequence

    For commandDismantle = 0 To .commands - 1      
      '' command iter.
      With .Command[commandDismantle]
  
        For entDismantle = 0 To .ents - 1
          '' command ent iter.
          With .ent[entDismantle]
  
            If .active_ent <> SF_BOX Then
              '' reset command ents' status
              activeEntity->mod_lock = 0
              activeEntity->seq_paused = 0
              activeEntity->return_trig = 0
  
            End If
            
            .ent_func = 0
          
          End With
          
        Next
        
      End With
      
    Next
  
    .current_command = 0

    llg( hero_only ).action_lock = 0
    
  End With
  
End Sub


Private Function sequence_ExitCondition( activeChar As char_type Ptr )

  If llg( hero_only ).dropoutSequence Then
    '' the map change flag was set
    llg( hero_only ).dropoutSequence = FALSE
    If llg( hero ).switch_room <> -1 Then
      '' switch room, clear seq
      sequence_FullReset( *llg( seq ) )
      llg( seq ) = 0
      
    End If
    Return TRUE
    
  End If

  If llg( hero_only ).isLoading Then
    '' Loading a saved game
    sequence_LoadGame( activeChar->save( activeChar->menu_sel ).link )

    sequence_FullReset( *llg( seq ) )
    llg( seq ) = 0
    Return TRUE

  End If

End Function



Private Sub sequence_CommandIncrement( resetSequence As sequence_type )

  #Define activeEntity resetSequence.ent[.active_ent]

  Dim As Integer reset_ents
    
  With resetSequence 

    For reset_ents = 0 To .Command[.current_command].ents - 1
      '' cycle through command entities
      With .Command[.current_command].ent[reset_ents]
       
        If .active_ent <> SF_BOX Then
          '' Working with a char_type
          activeEntity->return_trig = 0
          activeEntity->jump_counter = 0
          .ent_state = .hold_state
          .ent_func = 0
          
        End If
        
      End With
      
    Next
         
    '' increment command 
    .current_command += 1
    
  End With
  
End Sub

      

Function sequence_isCommandProgressing( thisSequence As sequence_type, currentEntity As Integer )

  #Define activeEntity thisSequence.ent[.active_ent]

  '' Check through for completion
  Dim As Integer check_ents, command_isProgressing
  
  With thisSequence

    '' Prime the pump  
    command_isProgressing = TRUE
    For check_ents = 0 To .Command[.current_command].ents - 1
      '' cycle thru the entity callbacks
      With .Command[.current_command].ent[check_ents]
        
        If .active_ent <> SF_BOX Then
          '' Entity called back
          command_isProgressing And= ( activeEntity->return_trig <> 0 )
        
        Else
          '' Box called back
          command_isProgressing And= ( llg( t_rect ).activated = FALSE )
          
        End If
        
      End With
      
    Next
    
    With .Command[.current_command].ent[currentEntity]

      If .carries_all Then 
        '' This command ent takes precedence
        If .active_ent <> SF_BOX Then

          If activeEntity->return_trig = 1 Then 
            '' Its actor called back
            command_isProgressing = TRUE
            
          End If
          
        Else
          
          If llg( t_rect ).activated = FALSE Then
            
            command_isProgressing = TRUE
            
          End If
          
        End If
  
      End If
      
    End With
  
  End With
  
  Function = command_isProgressing   

End Function

  
  
    

Sub play_sequence ( _seq As sequence_type Ptr )


  If _seq = 0 Then Exit Sub

  #Define activeEntity _seq->ent[.active_ent]

  Static box_IsInited As Integer
  
  llg( dbgstring ) = Str( box_IsInited )

  llg( do_hud ) = 0

  Assert( _seq->Command )

  Dim As Integer do_ents

  For do_ents = 0 To _seq->Command[_seq->current_command].ents - 1
    '' cycle through current command's entities
    
    Assert( _seq->Command[_seq->current_command].ent )
    
    With _seq->Command[_seq->current_command].ent[do_ents]
      '' set up a jump loop, for do_ents  
      If .active_ent = SF_BOX Then
        '' this isn't any old char_type
        If box_IsInited = FALSE Then
          '' box has not been initialized; lock

          box_IsInited = TRUE
          destroy_box( Varptr( llg( t_rect ) ) )
          
'          clear llg( t_rect ), 0, len( boxcontrol_type )
          
          llg( t_rect ) = make_box( .text, .free_to_move, .text_color, .box_invis, .auto_box, .mod_x, .mod_y, .text_speed )

        End If
        
      Else
        '' not a box
        sequence_AssignEntityData( *activeEntity, _seq->Command[_seq->current_command].ent[do_ents] ) 
        
        If .water_align <> 0 Then
          '' flag to loop the backround is set 
          If llg( hero ).coords.y = 2000 Then
            '' top boundary of water hit 
            Dim As Integer change_ents
            
            For change_ents = 0 To _seq->Command[_seq->current_command].ents - 1
              '' cycle through entities to be adjusted
              With _seq->Command[_seq->current_command].ent[change_ents]

                If .active_ent <> SF_BOX Then
                  '' bad pointer mojo
                  If activeEntity->no_cam = FALSE Then
                    '' entity is camera relative, shift it
                    activeEntity->coords.y += 5376
    
                  End If
              
                End If
                
              End With
              
            Next 

          End If
          
        End If
  
        If activeEntity->return_trig Then 
          '' this entity called back already
          Continue For
        
        End If
        
        '' **************************************************************************        
        '' do the entities function           ***************************************
        .ent_func += activeEntity->funcs.func[.ent_state][.ent_func] ( activeEntity )
        ''                                    ***************************************
        '' **************************************************************************
        

        '' Stuff that gets set in entities' functions
        '' #########
                    If sequence_ExitCondition( activeEntity ) Then
                      
                      box_IsInited = FALSE
                      Exit Sub
                    
                    End If

                    If activeEntity->state_shift <> 0 Then
                      '' Just a hack for the menu, as far as I can see.
                      .ent_state = activeEntity->state_shift
                      .ent_func = 0
            
                      activeEntity->state_shift = 0
                      
                    End If 
        '' #########
                    

        If .ent_func = activeEntity->funcs.func_count[.ent_state] Then 
          '' Overflow
          .ent_func = 0
          
        End If
  
        
        
      End If
      
      If sequence_isCommandProgressing( *_seq, do_ents ) Then 
        '' all entities called back
        
        sequence_CommandIncrement( *_seq )
        box_IsInited = FALSE

        Exit For
        
      End If

    End With
  
  Next

  If _seq->current_command = _seq->commands Then
  
    sequence_FullReset( *_seq ) 

    _seq = 0
    llg( hero ).chap = 0
    llg( do_hud ) = -1
    

  End If


End Sub


Sub maintain_temps( r As room_type Ptr )


  Dim As Integer maint, shuffle


    '' i might fix this.. it's pretty solid.
    '' this only happens if you kill more than one temp enemy in the exact same cycle. 
    '' its quite rare. But necessary ;)
    hackish:
  

    With *r

      For maint = 0 To .temp_enemies - 1
        '' maintain temp enemies
      
  
        .temp_enemy( maint ).num = maint + 65536
    
        
        If .temp_enemy( maint ).total_dead <> 0 Then 
          '' this enemy's dead
          
          '' rotate it to the end, and decrement for variable, to recount from this one
          ''optimize: rotate from back, forward, then delete the final entry
          
          For shuffle = maint To ( .temp_enemies - 1 ) - 1
    
            LLSystem_MemSwap( Varptr( .temp_enemy( shuffle ) ), Varptr( .temp_enemy( shuffle + 1 ) ), Len( _char_type ) )      
            
          Next
          
          .temp_enemies -= 1
                   
          LLSystem_ObjectRelease( .temp_enemy( .temp_enemies ) )
          
          '' resets enemy count
          
          
    
          Goto hackish
          
        End If
          
      Next
    
    End With
    

End Sub


Sub echo_print( x As String, arg As Integer = 0 )
  
  
  #IfDef __trace__
    ? x
    If arg <> 0 Then
      reveal()
      
    End If
    
  #EndIf
  
  
End Sub


Function touched_frame_face( c As char_type Ptr, v As vector_pair ) As Integer

  Dim As vector_pair origin
  Dim As Integer face_check
  
  With *( c )
  
    .frame_check = LLObject_CalculateFrame( c[0] )
  
    For face_check = 0 To .anim[.current_anim]->frame[.frame].faces - 1

      origin = LLO_VPE( c, OV_FACE, face_check )
  
      If ( check_bounds( origin, v ) = 0 ) Then
        Return face_check
        
      End If
      
    Next
    
  End With
  
  Return -1


End Function



Function touched_bound_box( c As char_type Ptr, v As vector_pair ) As Integer

  Return check_bounds( LLObject_VectorPair( c ), v )

End Function



Function touched_bound_boxes( c As char_type Ptr, c2 As char_type Ptr ) As Integer

  Return check_bounds( LLObject_VectorPair( c ), LLObject_VectorPair( c2 ) )

End Function





Sub LLEngine_ExecuteConcurrents( o As char_type Ptr )

  Dim As Integer i

  With *( o )

    For i = 0 To .animControl[.current_anim].frame[.frame].concurrents - 1

      With .animControl[.current_anim].frame[.frame].concurrent[i]
  
        act_enemies( 1, .char )
        
        .char->coords = V2_Add(                                               _
                                o->coords,                                    _
                                V2_Subtract(                                  _
                                             .origin,                         _
                                             V2_Scale( .char->perimeter, .5 ) _
                                           )                                  _
                              )

      End With

    Next

  End With


End Sub

Sub LLObject_TorchModify( o As char_type Ptr )



  Dim As Integer chk
  Dim As vector res

  With *( o )
  
    For chk = 0 To now_room().enemies -1         
  
      If now_room().enemy[chk].dead = 0 Then
  
        Select Case As Const now_room().enemy[chk].unique_id
        
          Case u_eguard, u_bguard, u_tguard, u_cguard, u_bshape, u_gshape

            res = V2_Absolute( _ 
                               V2_Subtract(                                                                                                     _
                                            V2_MidPoint( Type <vector_pair> ( .coords, .perimeter ) ),                                          _
                                            V2_MidPoint( Type <vector_pair> ( now_room().enemy[chk].coords, now_room().enemy[chk].perimeter ) ) _
                                          )                                                                                                     _
                             )
                             
        End Select

        Select Case As Const now_room().enemy[chk].unique_id
        
          Case u_eguard, u_bguard, u_tguard, u_cguard
  
            If res.x < .vision_field Then
              If res.y < .vision_field Then
              
                .current_anim = 3 '' LOW TORCH
                Exit Sub
              
              End If

            End If
  
  
          Case u_bshape
  
            If res.x < .vision_field Then
              If res.y < .vision_field Then
              
                .current_anim = 1 '' RED TORCH
                Exit Sub
              
              End If
    
            End If
  
          Case u_gshape
  
            If res.x < .vision_field Then
              If res.y < .vision_field Then
              
                .current_anim = 2 '' GREEN TORCH
                Exit Sub
              
              End If
    
            End If
            
        End Select
      
      End If
      
    Next

  .current_anim = 0 '' nothing special.
    
  End With

  
End Sub


Sub LLObject_GrabItems( o As char_type Ptr )
  
  With *( o )
    If .dead = 0 Then
      '' hasn't been picked up, or it didn't spawn yet
      
      Dim As vector_pair origin, target
      
      origin = LLO_VP( VarPtr( llg( hero ) ) )
      
      target.u = .coords
      target.v.x = 8
      target.v.y = 8
  
      If check_bounds( origin, target ) = 0 Then
  
        Select Case .dropped
        
          Case 1
            If llg( hero ).hp < llg( hero ).maxhp Then llg( hero ).hp += 1
            antiHackASSIGN( LL_Global.hero_only.healthDummy, LL_Global.hero.hp )
            play_sample( llg( snd )[sound_healthgrab] )
              
          Case 2 
            llg( hero ).money += ( .n_gold * 5 ) 
            antiHackASSIGN( LL_Global.hero_only.moneyDummy, LL_Global.hero.money )
            play_sample( llg( snd )[sound_cashget], 0 )
            
          Case 3
            llg( hero ).money += ( .n_silver ) 
            antiHackASSIGN( LL_Global.hero_only.moneyDummy, LL_Global.hero.money )
            play_sample( llg( snd )[sound_cashget], 0 )
              
  
        End Select
  
        .dropped = 0
                  
        __make_dead ( o )
        __cripple   ( o )
      
        
      End If
      
    End If  
    
  End With
  
End Sub


'Private Function LLObject_isTouching( o As char_type, o2 As char_type ) As Integer
'
'    Dim As vector_pair target
'  
'    target.u = V2_Subtract( o2.coords,    Type <vector> ( 1, 1 ) )
'    target.v = V2_Add     ( o2.perimeter, Type <vector> ( 2, 2 ) )
'  
'    Return check_bounds( LLObject_VectorPair( Varptr( o ), target )
'
'End Function
'

Sub LLObject_TouchSequence( o As char_type Ptr )

  Dim As Integer touching, stuff, res, op, i

  With *( o )
  
    touching = LLObject_isTouching( llg( hero ), o[0] )
  
    stuff = -1
    
    stuff And= ( .dead = 0 )
  
    stuff And= ( .seq_release = 0 )
    '' no sequence lock
    stuff And= ( ( .unique_id = u_keydoor ) Imp ( llg( hero ).key <> 0 ) )
    '' if its a key door, then if you have a key..
    stuff And= ( ( .unique_id = u_fkeydoor ) Imp ( llg( hero_only ).b_key <> 0 ) )
    '' if its a fkey door, then if you have a fkey..
    
    If stuff Then
  
      If touching = 0 Then 
        
        If .spawn_cond <> 0 Then
        
          If .spawn_info->active_n <> 0 Then
          
            res = -1
            For i = 0 To .spawn_info->active_n - 1
            
              op = ( llg( now )[.spawn_info->active_spawn[i].code_index] <> 0 )
              If .spawn_info->active_spawn[i].code_state = 0 Then
                op = Not op
                
              End If 
              
              res And= op
            
            Next
          
          Else
            res = -1
            
          End If 
          
        Else
          res = -1
          
        End If

        If res <> 0 Then
          '' all conditions met
          llg( seq ) = .seq + .sel_seq
          
        End If

      End If            
      
    End If
    
  End With
  
End Sub



Sub LLObject_ActionSequence( o As char_type Ptr )
  

  Dim As Integer facing, touching
  Dim As vector_pair origin, target
  
  With *( o )
  
    facing = is_facing( VarPtr( llg( hero ) ), o )
    touching = LLObject_isTouching( llg( hero ), o[0] )
  
    If facing = 0 And touching = 0 Then

      If .seq_release = 0 Then 

        If .dead = 0 Then 

          llg( seq ) = .seq + .sel_seq
          
        End If
  
      End If
      
    End If
    
  End With
  
End Sub




Sub LLObject_CheckSpawn( o As char_type Ptr )

  Dim As Integer op, i, res, do_stuff

  With *( o )
    
    If .spawn_kill_trig = 0 Then

      If .spawn_wait_trig = 0 Then
  
        If .spawn_info->wait_n <> 0 Then
        
          res = -1
          For i = 0 To .spawn_info->wait_n - 1
          
            op = ( llg( now )[.spawn_info->wait_spawn[i].code_index] <> 0 )
            If .spawn_info->wait_spawn[i].code_state = 0 Then
              op = Not op
              
            End If 
            
            res And= op
          
          Next
          
          If res <> 0 Then
            '' all conditions met
            
            do_stuff = .num
            
            LLSystem_CopyNewObject( *o )
            
            .num = do_stuff
            .spawn_wait_trig = -1
            
          End If
              
        End If 
        
      End If

      If .spawn_info->kill_n <> 0 Then
      
        res = -1
        For i = 0 To .spawn_info->kill_n - 1
        
          op = ( llg( now )[.spawn_info->kill_spawn[i].code_index] <> 0 )
          If .spawn_info->kill_spawn[i].code_state = 0 Then
            op = Not op
            
          End If 
          
          res And= op
        
        Next
        
        If res <> 0 Then
          '' all conditions met
          
          __make_dead  ( o )
          __cripple  ( o )
          .seq_release = 0

          .spawn_kill_trig = -1
          
          if .unique_id = u_biglarva then
            LLObject_ShiftState( o, 3 )
            
          end if
          
          if .unique_id = u_ghut then
            LLObject_ShiftState( o, 3 )
            
          end if
          
        End If
            
      End If 
      
    End If
    
  End With

  
End Sub



Function LLSystem_ReadSaveFile( saveName As String ) As ll_saving_data Ptr

  '' Routine type: Constructor ( ll_saving_data )
  ''
  '' Only returns a structure if saveName contains a file.
  '' NO INTEGRITY CHECK IS DONE, if you edit the save file and it crashes
  '' don't come crying to me.


  '' Implementation:
  '' 
  '' 
  '' pointer to the returned structure. (if any)
  Dim As ll_saving_data Ptr res
  ''
  '' Open VFile handle.
  Dim As Integer openVFile
  ''
  '' Buffer to load decompressed file.
  Dim As uByte saveMemory()


  If Dir( saveName ) <> "" Then
    '' The file exists, but i'm way too damn lazy to check
    '' if its valid or not.
    ''
    '' Initialize a structure to fill and return
    res = CAllocate( Len( ll_saving_data ) )
    ''
    '' Decompress the file into the buffer.
    zLib_DeCompress( saveName, saveMemory() )
    ''
    '' Get a valid VFile handle.
    openVFile = VFile_FreeFile()
    ''    
    '' "Open" the buffer as a VFile
    VFile_Open( saveMemory(), openVFile )
      
      With *( res )

        '' Read the savegame information.
        
        VFile_Get openVFile, , .hp
        VFile_Get openVFile, , .maxhp  
    
        VFile_Get openVFile, , .gold
        VFile_Get openVFile, , .weapon 
        VFile_Get openVFile, , VF_Array( .hasItem )
'        VFile_Get openVFile, , .item   
        VFile_Get openVFile, , .bar

        VFile_Get openVFile, , VF_Array( .hasCostume )
        VFile_Get openVFile, , .isWearing

        VFile_Get openVFile, , .key
        VFile_Get openVFile, , .b_key
    
        VFile_Get openVFile, , .map
        VFile_Get openVFile, , .entry
        
        VFile_Get openVFile, , VF_Array( .happen )
        
        VFile_Get openVFile, , .rooms
        
        if .rooms <> 0 then
          
          .hasVisited = callocate( len( ubyte ) * /' <- Unecessary, lol '/ .rooms )
          dim as integer iterRoomy
          
          for iterRoomy = 0 to .rooms - 1
            VFile_Get openVFile, , .hasVisited[iterRoomy]
            
          next
          
        end if
          
      End With
        

    '' "Close" the VFile.
    VFile_Close( openVFile )
    
  End If
  

  Return res


End Function


Sub LLSystem_WriteSaveFile( saveName As String, entry As Integer )

  '' Routine type: Procedure
  ''
  '' Writes information from the global "hero"
  '' structure into a compressed savefile.


  '' Implementation:
  '' 
  '' 
  '' Open VFile handle.
  Dim As Integer openVFile
  ''
  '' Iterate through the "now" array
  Dim As Integer i
  ''
  '' Buffer to save compressed file.
  Redim As uByte saveMemory( 0 )


  ''
  '' Get a valid VFile handle.
  openVFile = VFile_FreeFile()
  ''    
  '' "Open" the buffer as a VFile
  VFile_Open( saveMemory(), openVFile )
    
    '' Write the savegame information.

    VFile_Put openVFile, , llg( hero ).hp
    VFile_Put openVFile, , llg( hero ).maxhp  

    VFile_Put openVFile, , llg( hero ).money
    VFile_Put openVFile, , llg( hero_only ).has_weapon 

    VFile_Put openVFile, , VF_Array( llg( hero_only ).hasItem )
    VFile_Put openVFile, , llg( hero_only ).has_bar

    VFile_Put openVFile, , VF_Array( llg( hero_only ).hasCostume )
    VFile_Put openVFile, , llg( hero_only ).isWearing

    
    VFile_Put openVFile, , llg( hero ).key
    VFile_Put openVFile, , llg( hero_only ).b_key

    VFile_Put openVFile, , kfp( llg( map )->filename )
    VFile_Put openVFile, , entry
    
    VFile_Put openVFile, , Type <VFile_vector> ( llg( now ), LL_EVENTS_MAX, -1 )
    
    dim as integer roomsHere, iterRooms
    roomsHere = llg( map )->rooms

    if llg( map )->isDungeon then
      VFile_Put openVFile, , roomsHere
      
      for iterRooms = 0 to roomsHere - 1
        VFile_Put openVFile, , llg( miniMap ).room[iterRooms].hasVisited
        
      next
      
    else
      roomsHere = 0
      VFile_Put openVFile, , roomsHere
      
    end if
      
      
    
    
    
    VFile_Save( openVFile, saveMemory() )
    zLib_Compress( saveMemory(), saveName, 9 )    
    
      

  '' "Close" the VFile.
  VFile_Close( openVFile )
  

End Sub


Sub LLObject_CheckGTorchLit( this As char_type Ptr )

    Dim As Integer chk
    For chk = 0 To now_room().enemies -1         
      
      If now_room().enemy[chk].unique_id = u_gtorch Then
        '' its a special torch

        Dim As vector_pair origin, target
        origin.u.x = this->projectile->coords[0].x
        origin.u.y = this->projectile->coords[0].y
        origin.v.x = this->anim[this->proj_anim]->x
        origin.v.y = this->anim[this->proj_anim]->y
        
        target.u = now_room().enemy[chk].coords
        target.v = now_room().enemy[chk].perimeter
          
          
          
        
        If check_bounds( origin, target ) = 0 Then
          
          With now_room().enemy[chk]

            '' hit, trigger torch
            If .funcs.active_state = 0 Then
              .jump_timer = 0
              
              LLObject_ShiftState( Varptr( now_room().enemy[chk] ), .hit_state )
              LLObject_ClearProjectiles( now_room().enemy[0] )
              
            End If
            
          End With
          
        End If
        
      End If
      
    Next

End Sub



Sub enemy_main()

  With now_room()

    If .enemies > 0 Then
      act_enemies( .enemies, .enemy )
      
    End If
    If .temp_enemies > 0 Then
      act_enemies( .temp_enemies, Varptr( .temp_enemy( 0 ) ) )
      
    End If
                                                           
  End With                                                 

End Sub



Sub change_room( o As char_type Ptr, _call As Byte = 0, t As Integer = 0 )

  Static As Integer switch_type, switch_state

  If _call <> 0 Then
    switch_type = t
    switch_state = 0
    
    Exit Sub
    
  End If
    
  


  Select Case switch_state
  
    
    Case 0
      '' lynn invincible

      Dim As Integer all_momentum
      For all_momentum = 0 To 3
        
        o->momentum.i( all_momentum ) = 0
        
      Next
  
      Select Case switch_type
      
        Case 0
                                                                   
          With llg( map )->room[now_room().teleport[o->switch_room].to_room]
            
            If .song_changes Then
              
              If llg( now )[.song_changes] <> 0 Then
                llg( song_wait ) = .changes_to

              Else
                llg( song_wait ) = .song

              End If
            
            Else
              llg( song_wait ) = .song
              
            End If
    
            if llg( song ) then
              
              If llg( song ) <> llg( song_wait ) Then
                llg( song_fade ) = -1
      
              End If
              
            end if
            
          End With
  
        
        
        Case 1
          
          
          If o->switch_room = -2 Then
          
            llg( song_fade ) = -1
            llg( song_wait ) = -1
          
          Else
            
            #macro regularChange()
              
              llg( song_wait ) = now_room().teleport[o->switch_room].to_song
              llg( song_fade ) = -1
              
            #endmacro
            
            '' hack coming back from houses...
            If llg( map )->filename = "data\map\inhouse.map" Then
              If now_room().teleport[o->switch_room].to_song = 9 Then
                If llg( now )[199] <> 0 Then
                Else
                  If now_room().teleport[o->switch_room].to_song <> llg( song ) Then
                    '' song is going to change
                    regularChange()
                  End If
                End If
              Else
                If now_room().teleport[o->switch_room].to_song <> llg( song ) Then
                  '' song is going to change
                  regularChange()
                End If
              End If
            Else
              If llg( map )->filename = "data\map\forest_fall.map" Then
                If llg( this_room ).i = 4 Then
                  If llg( now )[199] <> 0 Then
                  Else
                    If now_room().teleport[o->switch_room].to_song <> llg( song ) Then
                      '' song is going to change
                      regularChange()
                    End If
                  End If
                Else
                  If now_room().teleport[o->switch_room].to_song <> llg( song ) Then
                    '' song is going to change
                    regularChange()
                  End If
                End If
              Else
                If now_room().teleport[o->switch_room].to_song <> llg( song ) Then
                  '' song is going to change
                  regularChange()
                End If
              End If
            End If
          End If
            
          
      End Select
           
  
  
      switch_state += __make_invincible ( o )
  
  
    Case 1
      '' do the fade
      
      If llg( hero_only ).fadeStyle And LLFADE_WHITE Then 
        switch_state += __fade_to_white( o )
      
      Else'If llg( hero_only ).fadeStyle And LLFADE_NORMAL Then 
    
        If o->fade_out = 0 Then
          
          Dim As Integer hi_r, cols, r, g, b
          For cols = 0 To 255
        
            Palette Get cols, r, g, b
            
            If r > hi_r Then
              hi_r = r
              
            End If
            
          Next
  
          o->fade_out = hi_r \ 4 
            
        End If  

        switch_state += __fade_to_black ( o )
        
      End If
    
      If switch_state = 2 Then
        '' its gonna progress, last minute sh!t
  
        o->fade_out = 0

        o->song_fade_count = 0

        
        If llg( song_fade ) <> 0 Then

          #IfDef ll_audio
            bass_channelstop( llg( sng ) )
            
          #EndIf
    
        End If
        
      End If
  
  
    Case 2
      '' switch thing! (either or)
      
      Select Case switch_type
      
        Case 0

          llg( seq ) = 0
        
          llg( hero ).coords.x = now_room().teleport[o->switch_room].dx
          llg( hero ).coords.y = now_room().teleport[o->switch_room].dy
          
          If llg( this_room ).i <> now_room().teleport[o->switch_room].to_room Then
          
            #IfDef LL_LOGROOMCHANGE
              LLSystem_Log( "Reached switch (room " & llg( this_room ).i & ")", "roomchange.txt" )
              
            #EndIf
          
            del_room_enemies now_room().enemies, now_room().enemy
            del_room_enemies now_room().temp_enemies, Varptr( now_room().temp_enemy( 0 ) )
  
            #IfDef LL_LOGROOMCHANGE
              LLSystem_Log( "Reached deletion (room " & llg( this_room ).i & ")", "roomchange.txt" )
              
            #EndIf
  
            now_room().temp_enemies = 0
          
            llg( this_room ).i = now_room().teleport[o->switch_room].to_room
          
            llg( dark ) = now_room().dark  
          
            set_up_room_enemies now_room().enemies, now_room().enemy
  
            #IfDef LL_LOGROOMCHANGE
              LLSystem_Log( "Reached initialize (room " & llg( this_room ).i & ")", "roomchange.txt" )
              
            #EndIf
            
            If now_room().seq <> 0 Then
              o->seq = now_room().seq
              
            End If
            
          End If
    
          switch_state += 1
  
        Case 1
          enter_map( o, llg( map ), "data\map\" & o->to_map, o->to_entry ) '' "
          set_up_room_enemies now_room().enemies, now_room().enemy 
 
          switch_state += 1
                
      End Select
      
      If llg( song_wait ) = -1 Then
      
        llg( song_wait ) = now_room().song
        
      End If
      
      If llg( song_fade ) <> 0 Then
    
        llg( song ) = llg( song_wait )  
        
        LLMusic_Start( *music_strings( llg( song ) ) )  
        
      End If
  
      If llg( hero_only ).isLoading Then
        llg( hero_only ).isLoading = FALSE
        llg( do_hud ) = -1
        
      End If
      
      If llg( hero_only ).invisibleEntry = 0 Then
        o->invisible = 0
        
      Else
        llg( hero_only ).invisibleEntry = 0
        llg( hero ).invisible = 1
      
      End If
      
    Case 3

      #IfDef LL_LOGROOMCHANGE
        LLSystem_Log( "Start fade up" )
        
      #EndIf
      '' fade back up
      '' gray is implictly given priority.
      If llg( hero_only ).fadeStyle And LLFADE_GRAY Then 
        switch_state += __fade_down_to_gray( o )
      ElseIf llg( hero_only ).fadeStyle And LLFADE_WHITE Then
        switch_state += __fade_down_to_color( o )
      Else'If llg( hero_only ).fadeStyle And LLFADE_NORMAL Then 
        switch_state += __fade_up_to_color( o )
        
      End If
      
      
      If switch_state = 4 Then
        '' moving along...
        #IfDef LL_LOGROOMCHANGE
          LLSystem_Log( "Fade Succeded" )
          
        #EndIf
        llg( song_fade ) = 0
        
      End If
        
  
    Case 4
      '' make lynn vulnerable
      #IfDef LL_LOGROOMCHANGE
        LLSystem_Log( "Make vulnerable" )
        
      #EndIf
    
      switch_state += __make_vulnerable ( o )
  
  
    Case 5 
      '' final anything :)
  
      llg( seq ) = o->seq
  
      o->seq = 0
  
      o->switch_room = -1
  
      switch_state = -1
      switch_type = -1
      
      If llg( map )->isDungeon <> 0 Then
        llg( minimap ).room[llg( this_room ).i].hasVisited = -1  
        
      End If
      
      llg( hero_only ).fadeStyle = LLFADE_NORMAL
  
      #IfDef LL_LOGROOMCHANGE
        LLSystem_Log( "Final stuff OK" )
        
      #EndIf
  
  End Select
  
      
End Sub

Private Function mouseSelected() As Integer

  Function = -1
  
  Dim As vector_pair origin, destination
  Dim As Integer x_aligned
  
  Const BOX_WIDTH = 24
  Const BOX_HEIGHT = 24
  
  Select Case fb_Global.mouse.x
  
    Case Is >= 126
      '' resume, title
      '' 3 x 1.5
      Const BUTTON_WIDTH = 48
      Const BUTTON_HEIGHT = 24
      
      If fb_Global.mouse.x < 126 + BUTTON_WIDTH Then

        Select Case fb_Global.mouse.y
          Case Is >= 90
            '' title 
            If llg( my ) < 90 + BUTTON_HEIGHT Then
              Return 19
              
            End If
            
          Case Is >= 54
            '' resume
            If llg( my ) < 54 + BUTTON_HEIGHT Then       
              Return 18                                  
                                                         
            End If                                       
                                                         
        End Select                                       
                                                         
      End If                                             
                                                         
                                                         
    Case Is >= 66                                        
      ''                                                 
      If llg( mx ) < 66 + BOX_WIDTH Then                 
        x_aligned = 3                                   
                                                         
      End If                                             
                                                         
    Case Is >= 42                                        
      ''                                                 
      If llg( mx ) < 42 + BOX_WIDTH Then                 
        x_aligned = 2                                   
                                                         
      End If                                             
                                                         
    Case Is >= 18                                        
      ''                                                 
      If llg( mx ) < 18 + BOX_WIDTH Then                 
        x_aligned = 1                                   
                                                         
      End If                                             
                                                         
  End Select                                             
                                                         
  If x_aligned <> 0 Then                                      
                                                         


    Select Case fb_Global.mouse.y
      
'      Case Is >= 162
'      '' 
'        If llg( my ) < 162 + BOX_HEIGHT Then                 
'          Return 14 + x_aligned                                   
'                                                           
'        End If                                             
'
      Case Is >= 157
      '' 
        If llg( my ) < 138 + BOX_HEIGHT Then                 
          Return 11 + x_aligned                                   
                                                           
        End If                                             

      Case Is >= 121
      '' 
        If llg( my ) < 114 + BOX_HEIGHT Then                 
          Return 8 + x_aligned                                   
                                                           
        End If                                             

      Case Is >= 78
      '' 
        If llg( my ) < 78 + BOX_HEIGHT Then                 
          Return 5 + x_aligned                                   
                                                           
        End If                                             

      Case Is >= 54
      '' 
        If llg( my ) < 54 + BOX_HEIGHT Then                 
          Return 2 + x_aligned                                   
                                                           
        End If                                             

      Case Is >= 18
      '' 
        If llg( my ) < 18 + BOX_HEIGHT Then                 
          Return -1 + x_aligned                                   
                                                           
        End If
        
    End Select                                             
  
  End If
  

End Function

Private Sub keyboardSelected()

  Const As Double key_Delay = .5
  
  Dim As Integer key_up, key_right, key_down, key_left
  Dim As Double hkey_up, hkey_right, hkey_down, hkey_left
  Static As Double dkey_up, dkey_right, dkey_down, dkey_left


  key_up    = IIf( dkey_up    = 0, MultiKey( sc_up    ), 0 )
  key_right = IIf( dkey_right = 0, MultiKey( sc_right ), 0 )
  key_down  = IIf( dkey_down  = 0, MultiKey( sc_down  ), 0 )
  key_left  = IIf( dkey_left  = 0, MultiKey( sc_left  ), 0 )
  
  If key_up    = 0 And MultiKey( sc_up    ) Then hkey_up = -1
  If key_right = 0 And MultiKey( sc_right ) Then hkey_right = -1
  If key_down  = 0 And MultiKey( sc_down  ) Then hkey_down = -1
  If key_left  = 0 And MultiKey( sc_left  ) Then hkey_left = -1
  
  
  Select Case As Const llg( menu ).selectedItem
  
    Case 0
      If key_up    = ( Not 0 ) Then llg( menu ).selectedItem = 12
      If key_right = ( Not 0 ) Then llg( menu ).selectedItem = 1 
      If key_down  = ( Not 0 ) Then llg( menu ).selectedItem = 3
      If key_left  = ( Not 0 ) Then llg( menu ).selectedItem = 18

    Case 1
      If key_up    = ( Not 0 ) Then llg( menu ).selectedItem = 13
      If key_right = ( Not 0 ) Then llg( menu ).selectedItem = 2 
      If key_down  = ( Not 0 ) Then llg( menu ).selectedItem = 4
      If key_left  = ( Not 0 ) Then llg( menu ).selectedItem = 0

    Case 2
      If key_up    = ( Not 0 ) Then llg( menu ).selectedItem = 14
      If key_right = ( Not 0 ) Then llg( menu ).selectedItem = 18 
      If key_down  = ( Not 0 ) Then llg( menu ).selectedItem = 5
      If key_left  = ( Not 0 ) Then llg( menu ).selectedItem = 1

    Case 3
      If key_up    = ( Not 0 ) Then llg( menu ).selectedItem = 0
      If key_right = ( Not 0 ) Then llg( menu ).selectedItem = 4 
      If key_down  = ( Not 0 ) Then llg( menu ).selectedItem = 6
      If key_left  = ( Not 0 ) Then llg( menu ).selectedItem = 18

    Case 4
      If key_up    = ( Not 0 ) Then llg( menu ).selectedItem = 1
      If key_right = ( Not 0 ) Then llg( menu ).selectedItem = 5 
      If key_down  = ( Not 0 ) Then llg( menu ).selectedItem = 7
      If key_left  = ( Not 0 ) Then llg( menu ).selectedItem = 3

    Case 5
      If key_up    = ( Not 0 ) Then llg( menu ).selectedItem = 2
      If key_right = ( Not 0 ) Then llg( menu ).selectedItem = 18 
      If key_down  = ( Not 0 ) Then llg( menu ).selectedItem = 8
      If key_left  = ( Not 0 ) Then llg( menu ).selectedItem = 4

    Case 6
      If key_up    = ( Not 0 ) Then llg( menu ).selectedItem = 3
      If key_right = ( Not 0 ) Then llg( menu ).selectedItem = 7 
      If key_down  = ( Not 0 ) Then llg( menu ).selectedItem = 9
      If key_left  = ( Not 0 ) Then llg( menu ).selectedItem = 19

    Case 7
      If key_up    = ( Not 0 ) Then llg( menu ).selectedItem = 4
      If key_right = ( Not 0 ) Then llg( menu ).selectedItem = 8 
      If key_down  = ( Not 0 ) Then llg( menu ).selectedItem = 10
      If key_left  = ( Not 0 ) Then llg( menu ).selectedItem = 6

    Case 8
      If key_up    = ( Not 0 ) Then llg( menu ).selectedItem = 5
      If key_right = ( Not 0 ) Then llg( menu ).selectedItem = 19 
      If key_down  = ( Not 0 ) Then llg( menu ).selectedItem = 11
      If key_left  = ( Not 0 ) Then llg( menu ).selectedItem = 7

    Case 9
      If key_up    = ( Not 0 ) Then llg( menu ).selectedItem = 6
      If key_right = ( Not 0 ) Then llg( menu ).selectedItem = 10 
      If key_down  = ( Not 0 ) Then llg( menu ).selectedItem = 12
      If key_left  = ( Not 0 ) Then llg( menu ).selectedItem = 19

    Case 10
      If key_up    = ( Not 0 ) Then llg( menu ).selectedItem = 7
      If key_right = ( Not 0 ) Then llg( menu ).selectedItem = 11 
      If key_down  = ( Not 0 ) Then llg( menu ).selectedItem = 13
      If key_left  = ( Not 0 ) Then llg( menu ).selectedItem = 9

    Case 11
      If key_up    = ( Not 0 ) Then llg( menu ).selectedItem = 8
      If key_right = ( Not 0 ) Then llg( menu ).selectedItem = 19  
      If key_down  = ( Not 0 ) Then llg( menu ).selectedItem = 14
      If key_left  = ( Not 0 ) Then llg( menu ).selectedItem = 10

    Case 12
      If key_up    = ( Not 0 ) Then llg( menu ).selectedItem = 9
      If key_right = ( Not 0 ) Then llg( menu ).selectedItem = 13 
      If key_down  = ( Not 0 ) Then llg( menu ).selectedItem = 0
      If key_left  = ( Not 0 ) Then llg( menu ).selectedItem = 14

    Case 13
      If key_up    = ( Not 0 ) Then llg( menu ).selectedItem = 10
      If key_right = ( Not 0 ) Then llg( menu ).selectedItem = 14 
      If key_down  = ( Not 0 ) Then llg( menu ).selectedItem = 1
      If key_left  = ( Not 0 ) Then llg( menu ).selectedItem = 12

    Case 14
      If key_up    = ( Not 0 ) Then llg( menu ).selectedItem = 11
      If key_right = ( Not 0 ) Then llg( menu ).selectedItem = 12 
      If key_down  = ( Not 0 ) Then llg( menu ).selectedItem = 2
      If key_left  = ( Not 0 ) Then llg( menu ).selectedItem = 13

'    Case 15
'      If key_up    = ( Not 0 ) Then llg( menu ).selectedItem = 12
'      If key_right = ( Not 0 ) Then llg( menu ).selectedItem = 16 
'      If key_down  = ( Not 0 ) Then llg( menu ).selectedItem = 0
'      If key_left  = ( Not 0 ) Then llg( menu ).selectedItem = 17
'
'    Case 16
'      If key_up    = ( Not 0 ) Then llg( menu ).selectedItem = 13
'      If key_right = ( Not 0 ) Then llg( menu ).selectedItem = 17 
'      If key_down  = ( Not 0 ) Then llg( menu ).selectedItem = 1
'      If key_left  = ( Not 0 ) Then llg( menu ).selectedItem = 15
'
'    Case 17
'      If key_up    = ( Not 0 ) Then llg( menu ).selectedItem = 14
'      If key_right = ( Not 0 ) Then llg( menu ).selectedItem = 15 
'      If key_down  = ( Not 0 ) Then llg( menu ).selectedItem = 2
'      If key_left  = ( Not 0 ) Then llg( menu ).selectedItem = 16
'
    Case 18
      If key_up    = ( Not 0 ) Then llg( menu ).selectedItem = 19
      If key_right = ( Not 0 ) Then llg( menu ).selectedItem = 3 
      If key_down  = ( Not 0 ) Then llg( menu ).selectedItem = 19
      If key_left  = ( Not 0 ) Then llg( menu ).selectedItem = 5

    Case 19
      If key_up    = ( Not 0 ) Then llg( menu ).selectedItem = 18
      If key_right = ( Not 0 ) Then llg( menu ).selectedItem = 6 
      If key_down  = ( Not 0 ) Then llg( menu ).selectedItem = 18
      If key_left  = ( Not 0 ) Then llg( menu ).selectedItem = 8
    
  End Select
  
  #Define delayStopper(__DIREC__)             _
                                              _
    If hkey_##__DIREC__ = 0 Then             :_
                                             :_
      If key_##__DIREC__ = ( Not 0 ) Then    :_
        dkey_##__DIREC__ = Timer + key_Delay :_
                                             :_
      Else                                   :_
        dkey_##__DIREC__ = 0                 :_
                                             :_
      End If                                 :_
                                             :_
    End If

  delayStopper( up )
  delayStopper( right )
  delayStopper( down )
  delayStopper( left )
  
  If Timer > dkey_up    Then dkey_up = 0
  If Timer > dkey_right Then dkey_right = 0
  If Timer > dkey_down  Then dkey_down = 0
  If Timer > dkey_left  Then dkey_left = 0


End Sub

Private Function handleMouseSelected()
  
  function = 0
  
  if ( ( fb_Global.mouse.b And sc_leftbutton ) And ( fb_Global.mouse.x > -1 ) ) then
  
    Dim As vector_pair origin, destination
    Dim As Integer x_aligned
    
    Const BOX_WIDTH = 24
    Const BOX_HEIGHT = 24
    
    Select Case fb_Global.mouse.x
    
      Case Is >= 126
        '' resume, title
        '' 3 x 1.5
        Const BUTTON_WIDTH = 48
        Const BUTTON_HEIGHT = 24
        
        If fb_Global.mouse.x < 126 + BUTTON_WIDTH Then
  
          Select Case fb_Global.mouse.y
            Case Is >= 90
              '' title 
              If llg( my ) < 90 + BUTTON_HEIGHT Then
                jump_to_title()
                Return -1
                
              End If
              
            Case Is >= 54
              '' resume
              If llg( my ) < 54 + BUTTON_HEIGHT Then       
                Return -1
                                                           
              End If                                       
                                                           
          End Select                                       
                                                           
        End If                                             
                                                           
                                                           
      Case Is >= 66                                        
        ''                                                 
        If llg( mx ) < 66 + BOX_WIDTH Then                 
          x_aligned = 3                                   
                                                           
        End If                                             
                                                           
      Case Is >= 42                                        
        ''                                                 
        If llg( mx ) < 42 + BOX_WIDTH Then                 
          x_aligned = 2                                   
                                                           
        End If                                             
                                                           
      Case Is >= 18                                        
        ''                                                 
        If llg( mx ) < 18 + BOX_WIDTH Then                 
          x_aligned = 1                                   
                                                           
        End If                                             
                                                           
    End Select                                             
                                                           
    If x_aligned <> 0 Then                                      
                                                           
  
  
      Select Case fb_Global.mouse.y
        
        Case Is >= 157
        '' 
          If llg( my ) < 138 + BOX_HEIGHT Then                 
            select case as const x_aligned                                   
              
              case 1
                If llg( hero_only ).hasCostume( 3 ) <> 0 Then
                  llg( hero_only ).isWearing = 3
                  set_ninja()
                
                End If
              case 2
                If llg( hero_only ).hasCostume( 4 ) <> 0 Then
                  llg( hero_only ).isWearing = 4
                  set_bikini()
                
                End If
              case 3
                If llg( hero_only ).hasCostume( 5 ) <> 0 Then
                  llg( hero_only ).isWearing = 5
                  set_rknight()
                
                End If
              
            end select
                                                             
          End If                                             
  
        Case Is >= 121
        '' 
          If llg( my ) < 114 + BOX_HEIGHT Then                 
            select case as const x_aligned                                   
              
              case 1
                If llg( hero_only ).hasCostume( 0 ) <> 0 Then
                  llg( hero_only ).isWearing = 0
                  set_regular()
                
                End If
              case 2
                If llg( hero_only ).hasCostume( 1 ) <> 0 Then
                  llg( hero_only ).isWearing = 1
                  set_cougar()
                
                End If
              case 3
                If llg( hero_only ).hasCostume( 2 ) <> 0 Then
                  llg( hero_only ).isWearing = 2
                  set_lynnity()
                
                End If
              
            end select
                                                             
                                                             
          End If                                             
  
        Case Is >= 78
        '' 
          If llg( my ) < 78 + BOX_HEIGHT Then                 
            select case as const x_aligned                                   
              
              case 1
                If llg( hero_only ).hasItem( 3 ) Then
                  llg( hero_only ).selected_item = 4
                
                End If
              case 2
                If llg( hero_only ).hasItem( 4 ) Then
                  llg( hero_only ).selected_item = 5
                
                End If
              case 3
                If llg( hero_only ).hasItem( 5 ) Then
                  llg( hero_only ).selected_item = 6
                
                End If
              
            end select
                                                             
                                                             
          End If                                             
  
        Case Is >= 54
        '' 
          If llg( my ) < 54 + BOX_HEIGHT Then                 
            select case as const x_aligned                                   
              
              case 1
                If llg( hero_only ).hasItem( 0 ) Then
                  llg( hero_only ).selected_item = 1
                
                End If
              case 2
                If llg( hero_only ).hasItem( 1 ) Then
                  llg( hero_only ).selected_item = 2
                
                End If
              case 3
                If llg( hero_only ).hasItem( 2 ) Then
                  llg( hero_only ).selected_item = 3
                
                End If
              
            end select
                                                             
          End If                                             
  
        Case Is >= 18
        '' 
          If llg( my ) < 18 + BOX_HEIGHT Then                 
            select case as const x_aligned                                   
              
              case 1
                If llg( hero_only ).has_Weapon >= 0 Then
                  llg( hero_only ).weapon = 0
                
                End If
              case 2
                If llg( hero_only ).has_Weapon >= 1 Then
                  llg( hero_only ).weapon = 1
                
                End If
              case 3
                If llg( hero_only ).has_Weapon >= 2 Then
                  llg( hero_only ).weapon = 2
                
                End If
              
            end select
                                                             
                                                             
          End If
          
      End Select                                             
    
    End If
    
  end if
  
end function

Private Function handleKeybSelected()

  Function = 0
  
  
  If MultiKey( llg( conf_key ).code ) Or MultiKey( sc_enter ) Then

    Select Case As Const llg( menu ).selectedItem

      Case 0
        If llg( hero_only ).has_weapon >= 0 Then
          llg( hero_only ).weapon = 0
        
        End If

      Case 1
        If llg( hero_only ).has_weapon >= 1 Then
          llg( hero_only ).weapon = 1
        
        End If

      Case 2
        If llg( hero_only ).has_weapon >= 2 Then
          llg( hero_only ).weapon = 2
        
        End If

      Case 3
'        If llg( hero_only ).has_item >= 1 Then
        If llg( hero_only ).hasItem( 0 ) Then
          llg( hero_only ).selected_item = 1
        
        End If

      Case 4
'        If llg( hero_only ).has_item >= 2 Then
        If llg( hero_only ).hasItem( 1 ) Then
          llg( hero_only ).selected_item = 2
        
        End If

      Case 5
        If llg( hero_only ).hasItem( 2 ) Then
          llg( hero_only ).selected_item = 3
        
        End If

      Case 6
        If llg( hero_only ).hasItem( 3 ) Then
          llg( hero_only ).selected_item = 4
        
        End If

      Case 7
        If llg( hero_only ).hasItem( 4 ) Then
          llg( hero_only ).selected_item = 5
        
        End If

      Case 8
        If llg( hero_only ).hasItem( 5 ) Then
          llg( hero_only ).selected_item = 6
        
        End If

      Case 9
        If llg( hero_only ).hasCostume( 0 ) <> 0 Then
          llg( hero_only ).isWearing = 0
          set_regular()
        
        End If
        

      Case 10
        If llg( hero_only ).hasCostume( 1 ) <> 0 Then
          llg( hero_only ).isWearing = 1
          set_cougar()
        
        End If
        

      Case 11
        If llg( hero_only ).hasCostume( 2 ) <> 0 Then
          llg( hero_only ).isWearing = 2
          set_lynnity()
        
        End If
        
      Case 12
        If llg( hero_only ).hasCostume( 3 ) <> 0 Then
          llg( hero_only ).isWearing = 3
          set_ninja()
        
        End If
        
      Case 13
        If llg( hero_only ).hasCostume( 4 ) <> 0 Then
          llg( hero_only ).isWearing = 4
          set_bikini()
        
        End If

      Case 14
        If llg( hero_only ).hasCostume( 5 ) <> 0 Then
          llg( hero_only ).isWearing = 5
          set_rknight()
        
        End If

'      Case 15
'        If llg( hero_only ).hasCostume( 6 ) <> 0 Then
'          llg( hero_only ).isWearing = 6
'        
'        End If
'
'      Case 16
'        If llg( hero_only ).hasCostume( 7 ) <> 0 Then
'          llg( hero_only ).isWearing = 7
'        
'        End If
'
'      Case 17
'        If llg( hero_only ).hasCostume( 8 ) <> 0 Then
'          llg( hero_only ).isWearing = 8
'        
'        End If
'
      Case 18
        Return -1
        
      Case 19
        jump_to_title()
        Return -1
      
      
    End Select
    
  End If
  
  

End Function

Function menu_Input()
  
  If llg( locationChanged ) Then

    Dim As Integer selected = mouseSelected()
    If selected <> -1 Then
      llg( menu ).selectedItem = selected
      
    End If
  
  End If
  
  keyboardSelected()
  
  Return handleKeybSelected() or handleMouseSelected()

End Function

  Sub jump_to_title()


    Dim As Integer lx, ly, ld, i
    
    
    now_room().teleports += 1
    now_room().teleport = Reallocate( now_room().teleport, now_room().teleports *  Len( teleport_type ) )
    MemSet( Varptr( now_room().teleport[now_room().teleports - 1] ), 0, Len( teleport_type ) )
  
    now_room().teleport[now_room().teleports - 1].to_map = "title.map"
    now_room().teleport[now_room().teleports - 1].to_room = 0
    now_room().teleport[now_room().teleports - 1].to_song = 20
    
    change_room( 0, -1, 1 )
  
    lx = llg( hero ).coords.x
    ly = llg( hero ).coords.y
    ld = llg( hero ).direction
  
    ctor_hero( Varptr( llg( hero ) ) )
  
    llg( hero ).coords.x = lx 
    llg( hero ).coords.y = ly 
    llg( hero ).direction = ld
  
    llg( hero ).fade_time = .003
    llg( hero ).walk_speed = .009
                                  
    llg( hero_only ).invisibleEntry = 1
    llg( hero_only ).selected_item = 0
    
    For i = 0 To 8
      llg( hero_only ).hasCostume(i) = FALSE
      
    Next
    For i = 0 To 5
      llg( hero_only ).hasItem(i) = FALSE
      
    Next
    llg( hero_only ).hasCostume(0) = -1
    llg( hero_only ).isWearing = 0
    
    llg( hero ).switch_room = now_room().teleports - 1
  
    llg( hero ).to_map = now_room().teleport[llg( hero ).switch_room].to_map
    llg( hero ).to_entry = now_room().teleport[llg( hero ).switch_room].to_room
  
    MemSet( llg( now ), 0, LL_EVENTS_MAX )
    llg( do_hud ) = 0
    
    llg( xxyxx ) = 0


    antiHackASSIGN( LL_Global.hero_only.healthDummy, LL_Global.hero.hp )
    antiHackASSIGN( LL_Global.hero_only.weaponDummy, LL_Global.hero_only.has_weapon )
    antiHackASSIGN( LL_Global.hero_only.moneyDummy, LL_Global.hero.money )
    antiHackASSIGN2( LL_Global.hero_only.itemDummy, LL_Global.hero_only.hasItem )
    antiHackASSIGN2( LL_Global.hero_only.outfitDummy, LL_Global.hero_only.hasCostume )
    antiHackASSIGN( LL_Global.hero_only.maxhealthDummy, LL_Global.hero.maxhp )

    
  End Sub
  

Sub menu_StringInit()

  With llg( menu )
  
    .menuNames( 0 ) = "Uprooted Sapling"
    
  End With


End Sub


Sub handle_pause_menu()
  
  Static As Integer esc_Hold, end_Hold
  
  If end_Hold <> 0 Then
    If MultiKey( sc_escape ) = 0  Then end_Hold = 0
    
  End If
  
  If llg( hero_only ).attacking = 0 Then
    If llg( hero ).switch_room = -1 Then
      If llg( seq ) = 0 Then
        If llg( hero ).menu_sel = 0 Then
          If llg( hero ).dead = 0 Then
    
            If MultiKey( sc_escape ) And ( end_Hold = 0 ) Then
              esc_Hold = -1
              
              
              SetMouse , , 1
              
              llg( menu ).selectedItem = 18
              Get( 0, 0 )-( 319, 199 ), llg( menu_ScreenSave )
              Flip
              Put( 0, 0 ), llg( menu_ScreenSave )
        
              Do


                Dim As Integer mx, my

                mx = fb_Global.mouse.x
                my = fb_Global.mouse.y
                
                fb_GetMouse()   
                fb_GetKey()   
                
                llg( locationChanged ) And= 0
                If ( fb_Global.mouse.x <> mx ) Or ( fb_Global.mouse.y <> my ) Then
                  llg( locationChanged ) = Not 0
                  
                End If
              
                If MultiKey( sc_escape ) = 0 Then
                  esc_Hold = 0
                  
                End If
                
                Put( 0, 0 ), llg( menu_ScreenSave )
                If menu_Input() Then
                  Exit Do
                  
                End If
                
                menu_Blit()
                '' pause menu
                
                fb_ScreenRefresh()
                Sleep 1

                If MultiKey( sc_escape ) Then
                
                  If esc_Hold = 0 Then
                    end_Hold = -1
                    Exit Do

                  End If
                  
                End If
                
                If fb_WindowKill() Then
                  End
                  
                End If
              
              Loop

              Flip
              Put( 0, 0 ), llg( menu_ScreenSave )
              
            End If
            
          End If
          
        End If
        
      End If
      
    End If
    
  End If
      
      
End Sub


function isFullscreen() as integer

  dim as integer fullScreen
  
  if open( "ll.ini", for input, as #1 ) = 0 then
  
    dim as string isFull  
    
    input #1, isFull
    
    if instr( ucase( isFull ), "FULLSCREEN" ) then
  
      if instr( ucase( isFull ), "YES" ) then
        fullScreen = 1
        
      end if
      
    end if
    
  end if
  
  close #1
  
  return fullScreen

end function

Sub init_splash()


  Dim As Any Ptr ll_SplashScreen

  dim as double justLongEnough
  justLongEnough = timer + 3.5

  Screen 13, , 2, iif( isFullscreen(), 1, 0 )
  
  Sleep 1000, 1
  SetMouse , , 0
  fb_Global.display.pal = load_pal( "data\palette\ll.pal" )
  Palette Using fb_Global.display.pal
  
  ll_SplashScreen = ImageCreate( 320, 200 )
  
  Bload "data\pictures\splash_screen.bmp", ll_SplashScreen
  


  llg( hero ).fade_time = .0001
  Do
  Loop Until __fade_to_black( VarPtr( llg( hero ) ) )
  
  Put( 0, 0 ), ll_SplashScreen
  

  llg( hero ).fade_time = .01
  Do
  Loop Until __fade_up_to_color( VarPtr( llg( hero ) ) )
  

  #IfDef ll_audio
    ' initialize f mod
    
    If bass_init() = 0 Then
      bass_init( 0 )
      
    End If

    init_snd()

  #EndIf

  Kill "objectload.txt"
  Kill "imageload.txt"
  
  
  LLSystem_CachePictureFiles( "data\pictures" )
  LLSystem_CacheObjectFiles( "data\object" )


  do while justLongEnough > timer
    sleep 1
  loop
  
  llg( hero ).fade_time = .01
  Do
  Loop Until __fade_to_black( Varptr( llg( hero ) ) )
  Cls

  llg( hero ).fade_time = .003

  shift_pal()
  
  ImageDestroy( ll_SplashScreen )
  
  Sleep 300, 1
       
       
End Sub


Function LLMiniMap_SizeX()

  Dim As Integer accumulateSizes, i, combine
  
  For i = 0 To llg( map )->rooms - 1
    
    If llg( miniMap ).room[i].floor <> llg( minimapFloor ) Then Continue For

    combine = llg( map )->room[i].x + llg( miniMap ).room[i].location.x

    If combine > accumulateSizes Then
      accumulateSizes = combine
      
    End If
  
  Next
  
  Return accumulateSizes


End Function


Function LLMiniMap_SizeY()

  Dim As Integer accumulateSizes, i, combine
  
  For i = 0 To llg( map )->rooms - 1

    If llg( miniMap ).room[i].floor <> llg( minimapFloor ) Then Continue For

    combine = llg( map )->room[i].y + llg( miniMap ).room[i].location.y

    If combine > accumulateSizes Then
      accumulateSizes = combine
      
    End If
  
  Next
  
  Return accumulateSizes


End Function

Function LLMiniMap_Floors()

  dim as integer iRoom, floorFound, iFloor
  redim as integer floors( 0 ) 
  
  floors( 0 ) = 9999

  dim as integer alreadyFound  
  for iRoom = 0 to llg( map )->rooms - 1
    for iFloor = 0 to floorFound
      if floors( iFloor ) = llg( miniMap ).room[iRoom].floor then
        alreadyFound = TRUE
        exit for
      end if
      
    next
        
    if alreadyFound = FALSE then    
      floors( floorFound ) = llg( miniMap ).room[iRoom].floor 
      floorFound += 1
      
      redim preserve floors( floorFound )
      
      floors( floorFound ) = 9999
      
    end if
    
    
  next
  
  return ubound( floors )
  
end function

Function LLMiniMap_TopFloor()
  
  dim as uinteger tf = ( 2 ^ 31 )
  dim as integer topFloor = tf, iRoom
  
  for iRoom = 0 to llg( map )->rooms - 1
  
    if llg( miniMap ).room[iRoom].floor > topFloor then
      topFloor = llg( miniMap ).room[iRoom].floor
      
    end if
    
  next
  
  return topFloor
  
end function

Function LLMiniMap_BottomFloor()

  dim as integer bottomFloor = ( 2 ^ 31 ) - 1, iRoom

  for iRoom = 0 to llg( map )->rooms - 1
  
    if llg( miniMap ).room[iRoom].floor < bottomFloor then
      bottomFloor = llg( miniMap ).room[iRoom].floor
      
    end if
    
  next
  
  return bottomFloor
  
end function

Sub LLMiniMap_UpdateCam( minimap_Local As LL_MiniMapType ) 

  With minimap_Local.camera 

    If .x > ( LLMiniMap_SizeX() - 320 ) Then .x = ( LLMiniMap_SizeX() - 320 )
    If .x < 0 Then .x = 0
    
    If .y > ( LLMiniMap_SizeY() - 160 ) Then .y = ( LLMiniMap_SizeY() - 160 )
    If .y < 0 Then .y = 0
    
  End With


End Sub


Sub handle_MiniMap()

  static as double moveDelay, roomu, roomd 
  
  If llg( map )->isDungeon <> 0 Then

    If MultiKey( sc_m ) Then
      
  
      llg( minimap ).camera.x = ( llg( minimap ).room[llg( this_room ).i].location.x + ( now_room().x Shr 1 ) ) - 160
      llg( minimap ).camera.y = ( llg( minimap ).room[llg( this_room ).i].location.y + ( now_room().y Shr 1 ) ) - 80
      llg( minimapFloor ) = llg( minimap ).room[llg( this_room ).i].floor
      
      Do
        
        fb_GetKey()
        
        if timer > moveDelay then
        
          If MultiKey( sc_up ) Then
            llg( minimap ).camera.y -= 1
          End If
          If MultiKey( sc_right ) Then
            llg( minimap ).camera.x += 1
          End If
          If MultiKey( sc_down ) Then
            llg( minimap ).camera.y += 1
          End If
          If MultiKey( sc_left ) Then
            llg( minimap ).camera.x -= 1
          End If
          
          moveDelay = timer + .023
          
        end if
        
        If MultiKey( sc_leftbracket ) Then
          if roomd = 0 then
            if llg( minimapFloor ) > LLMiniMap_BottomFloor() then
              llg( minimapFloor ) -= 1
              
            end if
            roomd = -1
            
          end if
        else
          roomd = 0
          
        end if
        
        If MultiKey( sc_rightbracket ) Then
          if roomu = 0 then
            if llg( minimapFloor ) < LLMiniMap_TopFloor() then
              llg( minimapFloor ) += 1
              
            end if
            roomu = -1
            
          end if
        else
          roomu = 0
          
        end if

        LLMiniMap_UpdateCam( llg( minimap ) )
        minimap_Blit()
        
        if fb_WindowKill() then
          end
          
        end if
        
        
        fb_ScreenRefresh()
      
      Loop Until MultiKey( 1 )
      
      llg( minimapFloor ) = llg( minimap ).room[llg( this_room ).i].floor
      
      hold_key( 1 )
      
    End If
    
  End If

End Sub



Sub LLObject_VectorPosition( obj As char_type, vecPair As vector_pair, faceIndex As Integer )


  vecPair.u = obj.coords

  With obj.anim[obj.current_anim]->frame[LLObject_CalculateFrame( obj )]

    If .faces = 0 Then
  
      vecPair.v = obj.perimeter
      
    Else
      
      vecPair.u.x += .face[faceIndex].x - obj.animControl[obj.current_anim].x_off
      vecPair.u.y += .face[faceIndex].y - obj.animControl[obj.current_anim].y_off
  
      vecPair.v.x = .face[faceIndex].w
      vecPair.v.y = .face[faceIndex].h
      
    End If
    
  End With

  
End Sub



Function LLObject_Collision( o As char_type, o2 As char_type ) As LLObject_CollisionType

  Dim As LLObject_CollisionType res
  Dim As Integer faces, faces2
  Dim As Integer i, i2
  
  Dim As vector_pair ov, ov2
  
  With o

    .frame_check = LLObject_CalculateFrame( o )
    
    With .anim[.current_anim]->frame[.frame_check]

      faces = IIf( .faces = 0, 0, .faces - 1 )
      
    End With
    
  End With
  
  With o2

    .frame_check = LLObject_CalculateFrame( o2 )
    
    With .anim[.current_anim]->frame[.frame_check]

      faces2 = IIf( .faces = 0, 0, .faces - 1 )
      
    End With
    
  End With
  
  For i = 0 To faces
    
    LLObject_VectorPosition( o, ov, i ) 
  
    For i2 = 0 To faces2
      
      LLObject_VectorPosition( o2, ov2, i2 )
      
      If check_bounds( ov, ov2 ) = 0 Then
        '' touching
        
        res.isColliding = -1
        res.faces.x = i
        res.faces.y = i2
        
        Return res
        
      End If 
    
    Next i2
    
  Next i
  
  Return res
  
  
End Function


Sub LLObject_ClearProjectiles( char As char_type )

  if char.projectile = 0 then exit sub

  Dim As Integer numOfProjectiles, incre
  
  With char

    For incre = 0 To .projectile->projectiles - 1
      .projectile->coords[incre] = Type <vector> ( 0, 0 )
      
    Next
    .projectile->plock = 0
    .projectile->active = 0      
    .projectile->refreshTime = 0
    .projectile->saveDirection = 0
    .projectile->travelled = 0
    .projectile->sound = 0
  
  End With  



End Sub




Sub LLObject_InitializeProjectiles( char As char_type )


  With char


    Dim As Integer beamModification
    beamModification = IIf( .proj_style = PROJECTILE_BEAM, 2, 1 )

    Select Case As Const .unique_id

      Case u_boss5_left
        .projectile->direction = 3 

      Case u_boss5_right
        .projectile->direction = 1 

      Case u_boss5_down
        .projectile->direction = 2 

      Case u_statue
        .projectile->direction = 2 

      Case Else

        If .projectile->saveDirection = 0 Then
          .projectile->direction = .direction
          .projectile->saveDirection = -1                         

        End If
      
    End Select

    Select Case As Const .unique_id
    
      '' Soooo close... anim needs vectors
      '' .projectile->coords[0] = V2_Subtract( V2_Add( .coords, V2_Scale( .perimeter, .5 ) ), V2_Scale( .anim[.proj_anim]->coords, .5 ) )

      Case u_boss5_left, u_boss5_right
        .projectile->coords[0].x = ( .coords.x + .perimeter.x \ 2 ) - ( .anim[.proj_anim]->x \ 2 )
        .projectile->coords[0].y = ( .coords.y + .perimeter.y \ 2 ) - 3

      Case Else
      
        Dim As Integer i


        .projectile->startVector.x = ( .coords.x + .perimeter.x \ 2 ) - ( .anim[.proj_anim]->x \ 2 )
        .projectile->startVector.y = ( .coords.y + .perimeter.y \ 2 ) - ( .anim[.proj_anim]->y \ 2 )        

        For i = 0 To .projectile->projectiles - 1
          .projectile->coords[i] = .projectile->startVector
          
        Next
        
    End Select

    Select Case As Const .proj_style
      
      Case PROJECTILE_BEAM

        Select Case As Const .projectile->direction
        
          Case 0
            
            .projectile->coords[1].x = .projectile->coords[0].x
            .projectile->coords[1].y = .projectile->coords[0].y - ( 8 * beamModification )
                       
          Case 1
            
            .projectile->coords[1].x = .projectile->coords[0].x + ( 8 * beamModification )
            .projectile->coords[1].y = .projectile->coords[0].y
            
          Case 2
            
            .projectile->coords[1].x = .projectile->coords[0].x 
            .projectile->coords[1].y = .projectile->coords[0].y + ( 8 * beamModification )
                       
          Case 3
            
            .projectile->coords[1].x = .projectile->coords[0].x - ( 8 * beamModification )
            .projectile->coords[1].y = .projectile->coords[0].y
            
        End Select


      Case PROJECTILE_DIAGONAL
      Case PROJECTILE_CROSS
      Case PROJECTILE_8WAY
      Case PROJECTILE_FIREBALL
      Case PROJECTILE_SPIRAL

      
    End Select
  
  End With  

End Sub

Sub LLObject_IncrementProjectiles( char As char_type )

  With char

    Select Case As Const .proj_style
  
      Case PROJECTILE_ORB

        Select Case As Const .projectile->direction
        
          Case 0: .projectile->coords[0].y -= 8
                       
          Case 1: .projectile->coords[0].x += 8
            
          Case 2: .projectile->coords[0].y += 8
                       
          Case 3: .projectile->coords[0].x -= 8
            
        End Select

      Case PROJECTILE_BEAM

        Dim As vector tempVector 
  
        tempVector = .projectile->coords[0]
    
        .projectile->coords[0] = .projectile->coords[1]
        .projectile->coords[1] = V2_Add( .projectile->coords[1], V2_Subtract( .projectile->coords[1], tempVector ) )
  
      Case PROJECTILE_DIAGONAL
  
        .projectile->coords[0].x -= 1
        .projectile->coords[0].y -= 1
    
        .projectile->coords[1].x += 1
        .projectile->coords[1].y -= 1
    
        .projectile->coords[2].x += 1
        .projectile->coords[2].y += 1
    
        .projectile->coords[3].x -= 1
        .projectile->coords[3].y += 1
        
      
      Case PROJECTILE_CROSS, PROJECTILE_8WAY, PROJECTILE_SCHIZO

        Dim As Integer i
        Dim As Double a, m
        
        m = 360 / .projectile->projectiles
        For i = 0 To .projectile->projectiles - 1
        
          .projectile->coords[i].x += Sin( a * rad )
          .projectile->coords[i].y += Cos( a * rad )
          
          a += m
          
        Next
  
      Case PROJECTILE_SPIRAL, PROJECTILE_SUN

        Dim As Integer i
        Dim As Double a, m
        
        m = 360 / .projectile->projectiles
        For i = 0 To .projectile->projectiles - 1
          
          .projectile->coords[i].x = .projectile->startVector.x + Sin( ( ( a + .sway ) Mod 360 ) * rad ) * ( .projectile->travelled ) 
          .projectile->coords[i].y = .projectile->startVector.y + Cos( ( ( a + .sway ) Mod 360 ) * rad ) * ( .projectile->travelled ) 
          
          a += m
          
        Next
        
        If .sway = 359 Then
          .sway = 0
          
        Else
          .sway += 1
          
        End If


      Case PROJECTILE_TRACK '' implied target hero; could be genericized.
      

        If ( .projectile->travelled And 3 ) = 0 Then
    
          If ( Abs( .projectile->coords[0].x - llg( hero ).coords.x ) < 48 ) Then
    
            If ( Abs( .projectile->coords[0].y - llg( hero ).coords.y ) < 48 ) Then
    
              .projectile->plock = 1
    
            End If
    
          End If
          
          If .projectile->plock = 0 Then

            Dim As vector_pair thisProjectile
            
            With .projectile->coords[0]
      
              thisProjectile.u.x = .x 
              thisProjectile.u.y = .y
  
            End With
  
            thisProjectile.v = Type <vector> ( .anim[.proj_anim]->x, .anim[.proj_anim]->y )
            
            .projectile->flightPath = V2_CalcFlyback( V2_MidPoint( LLO_VP( Varptr( llg( hero ) ) ) ), V2_MidPoint( thisProjectile ) )

          End If
    
        End If

       .projectile->coords[0] = V2_Add( .projectile->coords[0], .projectile->flightPath )
  
    End Select
  
  End With

End Sub




Function play_sample( s As uInteger, v As Integer = 0 ) As uInteger

  If v = 0 Then v = 100
  
  Dim As uInteger ret

  #IfDef ll_audio
    
    ret = BASS_SampleGetChannel( s, 0 )    
    
    BASS_ChannelSetAttributes( ret, 0, v, 0 )
    
    BASS_ChannelPlay( ret, 1 )
    
    
  #EndIf

  Return ret
  
End Function
  

Sub LLMusic_SetVolume( volumeDesired As Integer )

  #IfDef ll_audio

    bass_setconfig( BASS_CONFIG_GVOL_MUSIC, volumeDesired )    
    
  #EndIf
  
End Sub
  
Sub LLMusic_Stop()

  #IfDef ll_audio
    
    bass_channelstop( llg( sng ) )
    
  #EndIf
  
End Sub
  
Sub LLMusic_Start( songName As String )

  Dim As uinteger ret 

  #ifdef ll_audio

    ret = BASS_MusicLoad ( 0, songName, 0, 0, BASS_MUSIC_AUTOFREE Or BASS_SAMPLE_LOOP, 44100 )

    If bass_channelplay( ret, 0 ) <> 0 Then
      llg( sng ) = ret
      
    End If
    
  #endif
  
End Sub


Sub LLMusic_Fade()

  Const As Integer slices = 64

  If Timer > llg( hero_only ).songFade->pulse Then
  
    Dim As Double tmp_val
    tmp_val = ( slices - llg( hero_only ).songFade->travelled )
    tmp_val *= 1.5625 '' ( 100 / 64 )
    
    LLMusic_SetVolume( CInt( tmp_val ) )
    
    llg( hero_only ).songFade->travelled += 1

    llg( hero_only ).songFade->pulse = Timer + llg( hero_only ).songFade->pulseLength
    
  End If

  If llg( hero_only ).songFade->travelled = slices Then

    LLMusic_Stop()
    LLMusic_SetVolume( 100 )
    
    clean_Deallocate( llg( hero_only ).songFade )
  
  End If

End Sub


Function is_facing( o As _char_type Ptr, o2 As _char_type Ptr ) As Integer


  Dim As Integer facing

  Select Case o->direction
  
    Case 0
  
      If o->coords.y >=  ( o2->coords.y +  ( o2->perimeter.y - 1 )  )  And  ( o->coords.x >=  ( o2->coords.x -  ( o->perimeter.x - 1 )  )  Or  ( o->coords.x <=  (  ( o2->coords.x + o2->perimeter.x )  +  ( o->perimeter.x - 1 )  )  )  )  Then 
        facing = 0 
        
      Else
        facing = -1
        
      End If
      
    Case 2

      If o->coords.y +  ( llg( map )->tileset->y - 1 )  <=   ( o2->coords.y )  And  ( o->coords.x >=  ( o2->coords.x -  ( llg( map )->tileset->x - 1 )  )  Or  ( o->coords.x <=  (  ( o2->coords.x + o2->perimeter.x )  +  ( llg( map )->tileset->x - 1 )  )  )  )  Then 
        facing = 0
      
      Else
        facing = -1
        
      End If
    
    Case 3

      If o->coords.x >=  ( o2->coords.x +  ( o2->perimeter.x - 1 )  )  And  ( o->coords.y >=  ( o2->coords.y ) Or ( o->coords.y <=  ( o2->coords.y + o2->perimeter.y ) ) )  Then 
        facing = 0
        
      Else
        facing = -1
        
      End If
      
    Case 1

      If o->coords.x +  ( llg( map )->tileset->x - 1 )  <=  ( o2->coords.x )  And  ( o->coords.y >=  ( o2->coords.y )  Or  ( o->coords.y <=  (  ( o2->coords.y + o2->perimeter.y )  )  )  )  Then 
        facing = 0
        
      Else
        facing = -1
        
      End If
    

  End Select

  Return facing
               
               
End Function


private function text_Center( myString as string )

	const as integer screenX = 320
	
	dim as integer stringLen = len( myString )	
	
	return ( screenX shr 1 ) - ( stringLen shl 2 )
	
	
end function
	
private function alignText( mystring as string ) as string 
  
  dim as integer lenString = len( mystring )
  
  
  return space( ( 40 - lenString ) shr 1 ) & myString

  
end function

private sub CreditScroll()

  dim as string creditsString 
  
  creditsString = ""
                  ''                                        ''

  creditsString += alignText( "Directed by Josiah Tobin and cha0s" )        + chr( 10 )
  creditsString += ""                                                       + chr( 10 )
  creditsString += alignText( "All art by Josiah Tobin (some parallax" )    + chr( 10 )
  creditsString += alignText( "backgrounds edited from stock art)" )        + chr( 10 )
  creditsString += ""                                                       + chr( 10 )
  creditsString += alignText( "All programming by cha0s" )                  + chr( 10 )
  creditsString += ""                                                       + chr( 10 )
  creditsString += alignText( "Music and sound effects composed by" )       + chr( 10 )
  creditsString += alignText( "Josiah Tobin (some stock effects used" )     + chr( 10 )
  creditsString += alignText( "in the creation of certain sounds)" )        + chr( 10 )
  creditsString += ""                                                       + chr( 10 )
  creditsString += alignText( "Additional sounds by cha0s" )                + chr( 10 )
  creditsString += ""                                                       + chr( 10 )
  creditsString += alignText( "Dialog and manuscript by Josiah Tobin" )     + chr( 10 )
  creditsString += ""                                                       + chr( 10 )
  creditsString += alignText( "Additional dialog by cha0s" )                + chr( 10 )
  creditsString += ""                                                       + chr( 10 )
  creditsString += alignText( "Maps by Josiah Tobin" )                      + chr( 10 )
  creditsString += ""                                                       + chr( 10 )
  creditsString += alignText( "Cutscenes scripted by cha0s" )               + chr( 10 )
  creditsString += ""                                                       + chr( 10 )
  creditsString += alignText( "All dungeons designed by Josiah Tobin" )     + chr( 10 )
  creditsString += ""                                                       + chr( 10 )
  creditsString += alignText( "Lynn 'Kona' Dempsey as:" )                   + chr( 10 )
  creditsString += alignText( "the voice of Lynn" )                         + chr( 10 )
  creditsString += ""                                                       + chr( 10 )
  creditsString += ""                                                       + chr( 10 )
  creditsString += ""                                                       + chr( 10 )
  creditsString += ""                                                       + chr( 10 )
  creditsString += ""                                                       + chr( 10 )
  creditsString += ""                                                       + chr( 10 )
  creditsString += ""                                                       + chr( 10 )
  creditsString += ""                                                       + chr( 10 )
  creditsString += alignText( "Josiah Tobin special thanks:" )              + chr( 10 )
  creditsString += ""                                                       + chr( 10 )
  creditsString += alignText( "Amelia 'Tassimmet' Bennett," )               + chr( 10 )
  creditsString += alignText( "Chris Greer, James Kinney," )                + chr( 10 )
  creditsString += alignText( "Lynn Dempsey, Brian Tobin," )                + chr( 10 )
  creditsString += alignText( "Stephen Gazzard, 'The Reset Button'," )      + chr( 10 )
  creditsString += alignText( "Anyone else who helped me out " )            + chr( 10 )
  creditsString += alignText( "or inspired me." )                           + chr( 10 )
  creditsString += ""                                                       + chr( 10 )
  creditsString += ""                                                       + chr( 10 )
  creditsString += ""                                                       + chr( 10 )
  creditsString += alignText( "cha0s special thanks:" )                     + chr( 10 )
  creditsString += ""                                                       + chr( 10 )
  creditsString += alignText( "v1ctor, and everyone who contributes" )      + chr( 10 )
  creditsString += alignText( "to the FreeBASIC Compiler..." )              + chr( 10 )
  creditsString += alignText( "(http://www.freebasic.net/forum)" )          + chr( 10 )
  creditsString += alignText( "Without it, this game would" )               + chr( 10 )
  creditsString += alignText( "not have been possible." )                   + chr( 10 )
  creditsString += ""                                                       + chr( 10 )
  creditsString += alignText( "Shouts out to:" )                            + chr( 10 )
  creditsString += ""                                                       + chr( 10 )
  creditsString += alignText( "Autumn, Boy, Dana, 'Diny, Doc. D," )          + chr( 10 )
  creditsString += alignText( "Fat Al, Gal, Guido, Harvey, HinD," )         + chr( 10 )
  creditsString += alignText( "Jay, Jaz, Jewish, Katie, Lizzie," )          + chr( 10 )
  creditsString += alignText( "Katty, Kiana, Keith, marzec, Matt," )        + chr( 10 )
  creditsString += alignText( "'niff, rel, Ron, Sara, Shelby," )            + chr( 10 )
  creditsString += alignText( "Stephanie (both!), The O.B.'s" )             + chr( 10 )
  creditsString += ""                                                       + chr( 10 )
  creditsString += alignText( "Anyone else I missed... Love ya." )          + chr( 10 )
  creditsString += ""                                                       + chr( 10 )
  creditsString += ""                                                       + chr( 10 )
  creditsString += ""                                                       + chr( 10 )
  creditsString += ""                                                       + chr( 10 )
  creditsString += ""                                                       + chr( 10 )
  creditsString += alignText( "The Testers:" )                              + chr( 10 )
  creditsString += alignText( "Deleter, Kiwi Dan, Lachie Dazdarian," )      + chr( 10 )
  creditsString += alignText( "Pritchard, Ryan Szrama, syn9," )             + chr( 10 )
  creditsString += alignText( "voodooattack, Virus Scanner" )               + chr( 10 )
  creditsString += ""                                                       + chr( 10 )
  creditsString += ""                                                       + chr( 10 )
  creditsString += ""                                                       + chr( 10 )
  creditsString += ""                                                       + chr( 10 )
  creditsString += ""                                                       + chr( 10 )
  creditsString += ""                                                       + chr( 10 )
  creditsString += ""                                                       + chr( 10 )
  creditsString += ""                                                       + chr( 10 )
  creditsString += ""                                                       + chr( 10 )
  creditsString += ""                                                       + chr( 10 )
  creditsString += ""                                                       + chr( 10 )
  creditsString += ""                                                       + chr( 10 )
  creditsString += alignText( "And, thank you for playing!" )               + chr( 10 )
  creditsString += ""                                                       + chr( 10 )
  creditsString += ""                                                       + chr( 10 )
  creditsString += ""                                                       + chr( 10 )
  creditsString += ""                                                       + chr( 10 )
  creditsString += ""                                                       + chr( 10 )
  creditsString += ""                                                       + chr( 10 )
  creditsString += ""                                                       + chr( 10 )
  creditsString += ""                                                       + chr( 10 )
  creditsString += ""                                                       + chr( 10 )
  creditsString += ""                                                       + chr( 10 )
  creditsString += ""                                                       + chr( 10 )
  creditsString += ""                                                       + chr( 10 )




  dim as integer creditY
  creditY = 200
  
  do
    creditY -= 1
  	graphicalString( creditsString, 0, creditY, 15 )
    
    fb_ScreenRefresh()
    sleep 80
'    if multikey( sc_space ) = 0 then
'      sleep 60
'                       
'    end if
    fb_GetKey()
    if fb_WindowKill() then end
                
	loop until creditY < ( 200 - ( 90 * 16 ) )
	
	cls

end sub

sub LL_RollCredits()
	
	if stillPlaying() then exit sub
		
  dim as double timeDelay
  dim as string currentText
  
  cls
  fb_ScreenRefresh()
  
  timeDelay = timer + 3
  currentText = "Written by Josiah Tobin,"
	graphicalString( currentText, text_Center( currentText ), 88, 15 )

  currentText = "brought to life by cha0s"
	graphicalString( currentText, text_Center( currentText ), 104, 15 )
  
  fb_ScreenRefresh()
  llg( hero_only ).songFade = CAllocate( Len( songFading_type ) )
  llg( hero_only ).songFade->pulseLength = ( 5 / 64 ) 
  do
    sleep 10
    if llg( hero_only ).songFade then
      LLMusic_Fade()
      
    end if
    fb_GetKey()
    if fb_WindowKill() then end
	loop until llg( hero_only ).songFade = 0
  
  do
    sleep 1
    fb_GetKey()
    if fb_WindowKill() then end
	loop until __fade_to_black( @llg( hero ) )
  
  cls
  fb_ScreenRefresh()
  
  __color_on( @llg( hero ) )
  LLMusic_Start( "data\music\holy.it" )  
  
  CreditScroll()

  __color_off( @llg( hero ) )
  dim as LLSystem_ImageHeader ptr imageWhore
  
  imageWhore = LLSystem_ImageDeref( LLSystem_ImageDerefName( "data\pictures\char\title.spr" ) )
  '' 256, 64
  put ( 160 - 128, 100 - 32 ), imageWhore->image
  fb_ScreenRefresh()
  
  do
    sleep 10
    fb_GetKey()
    if fb_WindowKill() then end
	loop until __fade_up_to_color( @llg( hero ) )
  
  
  llg( hero_only ).songFade = CAllocate( Len( songFading_type ) )
  llg( hero_only ).songFade->pulseLength = ( 5 / 64 ) 
  timeDelay = timer + 4
  do
    sleep 10
    if llg( hero_only ).songFade then
      LLMusic_Fade()
      
    end if
    fb_GetKey()
    if fb_WindowKill() then end
	loop until llg( hero_only ).songFade = 0
	
	llg( hero ).fade_time = .06
  do
    sleep 1
    fb_GetKey()
    if fb_WindowKill() then end
	loop until __fade_to_black( @llg( hero ) )
  __color_off( @llg( hero ) )
	
  imageWhore = LLSystem_ImageDeref( LLSystem_ImageDerefName( "data\pictures\char\moth_wings.spr" ) )
  '' 96, 64

  __color_off( @llg( hero ) )
  put ( 160 - 48, 100 - 32 ), imageWhore->image
  fb_ScreenRefresh()
  put ( 160 - 48, 100 - 32 ), imageWhore->image

  do
    sleep 10
    fb_GetKey()
    if fb_WindowKill() then end
	loop until __fade_up_to_color( @llg( hero ) )

  timeDelay = timer + 2
  do
    sleep 10
    fb_GetKey()
    if fb_WindowKill() then end
	loop until timer > timeDelay

  dim as integer curFrame	
  do
    sleep 100, 1
    fb_GetKey()
    if fb_WindowKill() then end
      
    fb_ScreenRefresh()
    put ( 160 - 48, 100 - 32 ), @imageWhore->image[curFrame * imageWhore->arraysize]
    
    if curFrame = 3 then
      play_sample( llg( snd )[sound_rayflap2], 80 )
      
    end if

    curFrame += 1
	loop until curFrame = imageWhore->frames
	curFrame -= 1
	
  put ( 160 - 48, 100 - 32 ), @imageWhore->image[curFrame * imageWhore->arraysize]

  timeDelay = timer + 2
  do
    sleep 10
    fb_GetKey()
    if fb_WindowKill() then end
	loop until timer > timeDelay

    
  dim as string theEnd = "The End."
  dim as integer theEndLoc, iter
  iter = 1
  do
    sleep 300, 1
    fb_GetKey()
    if fb_WindowKill() then end
      
    put ( 160 - 48, 100 - 32 ), @imageWhore->image[curFrame * imageWhore->arraysize]
    
    graphicalString( mid( theEnd, 1, iter ), text_Center( theEnd ) + 4, 168, 15 )
    iter += 1
    
    fb_ScreenRefresh()
	loop until iter = 9

  timeDelay = timer + 3
  do
    sleep 10
    fb_GetKey()
    if fb_WindowKill() then end
	loop until timer > timeDelay

  sleep    
  
  do
    sleep 1
    fb_GetKey()
    if fb_WindowKill() then end
	loop until __fade_to_black( @llg( hero ) )
  
	
end sub




Function __outfit_swap( this As char_type Ptr ) As Integer 
  
  static as integer swapState
  
  if swapState = 0 then

    set_regular()
    
  else

    select case as const llg( hero_only ).isWearing
      
      case 1
        '' Cat
        set_cougar()        
      case 2
        '' Lynnity
        set_lynnity()
        
      case 3
        '' Ninja
        set_ninja()
        
      case 4
        '' Bikini
        set_bikini()
        
      case 5
        '' Red Knight
        set_rknight()
        
    end select
    
  end if
  
  swapState xor= 1
  
  Function = 1


End Function
