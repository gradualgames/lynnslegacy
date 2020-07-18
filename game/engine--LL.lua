require("game/engine--object")
require("game/macros")
require("game/utils")

-- Sub engine_init()
function engine_init()
--
--   fb_StartGlobal()
--
--   echo_print( "setting keys to values in ""data\controls.xml""" )
--
--   Kill "roomchange.txt"
--   Kill "set_up_room_enemies.txt"
--
--   Dim As xml_type Ptr last_controls
--   last_controls = xml_Load( "data\controls.xml" )
--
--
--   Dim As Integer control_check
--
--   If last_controls <> 0 Then
--
--     control_check = -1
--
--     control_check And= ( Val( xml_TagValue( last_controls, "key_map->attack"     ) ) ) <> 0
--     control_check And= ( Val( xml_TagValue( last_controls, "key_map->item"       ) ) ) <> 0
--     control_check And= ( Val( xml_TagValue( last_controls, "key_map->action"     ) ) ) <> 0
--     control_check And= ( Val( xml_TagValue( last_controls, "key_map->move_up"    ) ) ) <> 0
--     control_check And= ( Val( xml_TagValue( last_controls, "key_map->move_right" ) ) ) <> 0
--     control_check And= ( Val( xml_TagValue( last_controls, "key_map->move_down"  ) ) ) <> 0
--     control_check And= ( Val( xml_TagValue( last_controls, "key_map->move_left"  ) ) ) <> 0
--
--   End If
--
--   If control_check = 0 Then
--     ? "Run Controls.exe to set the game controls."
--     Sleep 5000
--     End
--
--   End If
--
--
--
--
--   llg( atk_key )         = init_bin_obj( Val( xml_TagValue( last_controls, "key_map->attack" ) ), ProcPtr( atk_key_in_sub    ), ProcPtr( atk_key_out_sub    ) )
--   llg( act_key )         = init_bin_obj( Val( xml_TagValue( last_controls, "key_map->item"   ) ), ProcPtr( act_key_in_sub    ), ProcPtr( act_key_out_sub    ) )
--   llg( conf_key )        = init_bin_obj( Val( xml_TagValue( last_controls, "key_map->action" ) ), ProcPtr( conf_key_in_sub   ), ProcPtr( conf_key_out_sub   ) )
--   llg( item_l_key )      = init_bin_obj( sc_comma                                               , ProcPtr( item_l_key_in_sub ), ProcPtr( item_l_key_out_sub ) )
--   llg( item_r_key )      = init_bin_obj( sc_period                                              , ProcPtr( item_r_key_in_sub ), ProcPtr( item_r_key_out_sub ) )
--
--   llg( u_key.code ) = Val( xml_TagValue( last_controls, "key_map->move_up"    ) )
--   llg( r_key.code ) = Val( xml_TagValue( last_controls, "key_map->move_right" ) )
--   llg( d_key.code ) = Val( xml_TagValue( last_controls, "key_map->move_down"  ) )
--   llg( l_key.code ) = Val( xml_TagValue( last_controls, "key_map->move_left"  ) )
--
--
--   xml_Destroy( last_controls )
--
--
--   echo_print( "setting up directional ""hints""." )
--
--   llg( dir_hint ) = CAllocate( Len( uByte ) * 4 )
--
--     llg( dir_hint[0] ) = llg( u_key.code )
--     llg( dir_hint[1] ) = llg( r_key.code )
--     llg( dir_hint[2] ) = llg( d_key.code )
--     llg( dir_hint[3] ) = llg( l_key.code )
--
--
--
--   echo_print( "setting up event table" )
--   llg( now ) = CAllocate( Len( uByte ) * LL_EVENTS_MAX )
--
--
--   echo_print( "setting screen pages" )
--   llg( a_page ) = 0
--   llg( v_page ) = 1
--
--
--
--
--   echo_print( "determining entry point" )
--   load_entrypoint()
--
--
--   echo_print( "map: " & llg( start_map ) )
--
--
--   echo_print( "constructing main object" )
--   ctor_hero( Varptr( llg( hero ) ) )
  ctor_hero(ll_global.hero)
--
--   llg( do_hud ) = -1
--
--   llg( current_cam ) = Varptr( llg( hero ) )
--
--
--   echo_print( "loading menu and HUD gfx" )
--   load_status_images( Varptr( llg( savImages ) ) )
--   load_hud( Varptr( llg( hud ) ) )
--
--   load_menu()
--   menu_StringInit()
--
--
--   '' 15, 241
--   llg( font ) = LLSystem_ImageDeref( LLSystem_ImageDerefName( "data\pictures\llfont.spr" ) )
--   llg( fontFG ) = 15
--   llg( fontBG ) = 241
--
--
--
--
--   echo_print( "retrieving screen information" )
--   ScreenInfo llg( sx ), llg( sy )
--
--
--   llg( menu_ScreenSave ) = ImageCreate( 320, 200 )
--
--   llg( scrn_ptr ) = ScreenPtr
--
--   llg( hero_only ).specialSequence = callocate( len( sequence_type ) )
--
--   llg( hero_only ).specialSequence[0].commands = 1
--
--   llg( hero_only ).specialSequence[0].command = callocate( len( command_type ) )
--
--   llg( hero_only ).specialSequence[0].command[0].ents = 1
--
--   llg( hero_only ).specialSequence[0].command[0].ent = callocate( len( command_data ) )
--
--   llg( hero_only ).specialSequence[0].command[0].ent[0].active_ent = SF_BOX
--   llg( hero_only ).specialSequence[0].command[0].ent[0].text = "Lynn: I can't use this here."
--
--   llg( hero_only ).healingImage = LLSystem_ImageDeref( LLSystem_ImageDerefName( "data\pictures\char\heal.spr"  ) )
--
--
--
-- End Sub
end

-- Loops over the enemies of the current room and spawns them
function set_up_room_enemies(enemies)
    -- Dim As Integer setup
    --
    --
    -- For setup = 0 To enemies - 1
  for setup = 1, #enemies do
    --   '' cycle thru these enemies
    --
    --   With enemy[setup]
    local enemy = enemies[setup]
    --
    --     If .spawn_cond <> 0 Then
    --
    --       If .spawn_info->wait_n > 0 Then
    --
    --         If LLObject_SpawnWait( Varptr( enemy[setup] ) ) <> 0 Then
    --
    --           '' done waiting
    --
    --           LLSystem_CopyNewObject( enemy[setup] )
    LLSystem_ObjectLoad(enemy)
    --
    --         Else
    --           Dim As String oldid
    --
    --           oldid = enemy[setup].id
    --
    --           LLSystem_ObjectDeepCopy( enemy[setup], *LLSystem_ObjectDeref( LLSystem_ObjectDerefName( "data\object\null.xml" ) ) )
    --           enemy[setup].id = oldid
    --
    --         End If
    --
    --       Else
    --
    --         LLSystem_CopyNewObject( enemy[setup] )
    --
    --       End If
    --
    --     Else
    --
    --     '' if regular then spawn
    --       LLSystem_CopyNewObject( enemy[setup] )
    --
    --     End If
    --
    --     '' setting a couple last vars
    --     .num = setup
    --
    --     If .spawn_cond <> 0 Then
    --
    --       If LLObject_SpawnKill( Varptr( enemy[setup] ) ) <> 0 Then
    --         '' all conditions met to kill
    --
    --         __make_dead  ( Varptr( enemy[setup] ) )
    --         __cripple  ( Varptr( enemy[setup] ) )
    --
    --         If(                                     _
    --             ( .unique_id = u_chest         ) Or _
    --             ( .unique_id = u_bluechest     ) Or _
    --             ( .unique_id = u_bluechestitem ) Or _
    --             ( .unique_id = u_ghut          ) Or _
    --             ( .unique_id = u_button        ) Or _
    --             ( .unique_id = u_gbutton       )    _
    --           ) Then
    --           .current_anim = 1
    --
    --         End If
    --
    --
    --         .seq_release = 0
    --
    --         .spawn_kill_trig = -1
    --
    --
    --         if .unique_id = u_biglarva then
    --           LLObject_ShiftState( Varptr( enemy[setup] ), 3 )
    --
    --         end if
    --
    --         if .unique_id = u_ghut then
    --           LLObject_ShiftState( Varptr( enemy[setup] ), 3 )
    --
    --         end if
    --
    --       End If
    --
    --     End If
    --
    --   End With
    --
    --   #IfDef LL_--logRoomEnemySetup
    --     LLSystem_--log( "Initialized room["& llg( this_room ).i &"] enemy " & setup, "set_up_room_enemies.txt" )
    --
    --   #EndIf
    --
    -- Next
  end
end

-- Sub hero_main()
function hero_main()
--
--
--   if llg( hero_only ).selected_item = 0 then
  if ll_global.hero_only.selected_item == 0 then
--     if llg( hero_only ).hasItem( 0 ) then
    if ll_global.hero_only.has_item[0] ~= 0 then
--       llg( hero_only ).selected_item = 1
      ll_global.hero_only.selected_item = 1
--
--     end if
    end
--
--   end if
  end
--
--   If ( llg( hero_only ).isWearing = 1 ) Then
  if ll_global.hero_only.isWearing == 1 then
--     llg( hero ).walk_speed = .003
    ll_global.hero.walk_speed = .003
--
--   elseIf ( llg( hero_only ).isWearing = 5 ) Then
  elseif ll_global.hero_only.isWearing == 5 then
--     llg( hero ).walk_speed = .02
    ll_global.hero.walk_speed = .02
--
--   Else
  else
--     llg( hero ).walk_speed = .009
    ll_global.hero.walk_speed = .009
--
--   End If
  end
--
--   llg( hero_only ).action  = 0
  ll_global.hero_only.action = 0
--
--   If ( llg( hero_only ).isWearing = 5 ) Then
  if ll_global.hero_only.isWearing == 5 then
--
--     if llg( hero_only ).healTimer = 0 then
    if ll_global.hero_only.healTimer == 0 then
--       llg( hero_only ).healTimer = timer + 6
      ll_global.hero_only.healTimer = timer + 6
--
--     end if
    end
--
--     if timer > llg( hero_only ).healTimer then
    if timer > ll_global.hero_only.healTimer then
--       if llg( hero ).hp < llg( hero ).maxhp then
      if ll_global.hero.hp < ll_global.hero.maxhp then
--         llg( hero ).hp += 1
        ll_global.hero.hp = ll_global.hero.hp + 1
--         antiHackASSIGN( LL_Global.hero_only.healthDummy, LL_Global.hero.hp )
--
--         play_sample( sound_healthgrab )
--       end if
      end
--       llg( hero_only ).healTimer = 0
      ll_global.hero_only.healTimer = 0
--
--     end if
    end
--
--   else
  else
--     llg( hero_only ).healTimer = 0
    ll_global.hero_only.healTimer = 0
--
--   end if
  end
--
--
--   static as integer adrenalineState
--   if llg( hero_only ).adrenaline <> NULL then
  if ll_global.hero_only.adrenaline ~= 0.0 then
--
--     select case as const adrenalineState
--
--       case 0
--         adrenalineState += __flash( @llg( hero ) )
--
--       case 1
--         adrenalineState += __flash_down( @llg( hero ) )
--
--     end select
--
--     if timer > llg( hero_only ).adrenaline then
--       llg( hero_only ).adrenaline = NULL
--       adrenalineState = 0
--       llg( hero_only ).crazy_points = 0
--
--     end if
--
--   end if
  end
--
--
--   static as double healingTimer
--   if llg( hero_only ).healing <> NULL then
--
--     if healingTimer = 0 then
--       healingTimer = timer + .1
--
--     end if
--
--     if timer > healingTimer then
--
--       llg( hero_only ).healingFrame += 1
--       healingTimer = 0
--
--     end if
--
--     if llg( hero_only ).healingFrame = 5 then
--
--       llg( hero_only ).healingFrame = 0
--       llg( hero_only ).healing = 0
--
--       healingTimer = 0
--
--     end if
--
--   end if
--
--
--
--
--   With llg( conf_key )
--     bin_obj( Type( MultiKey( .code ), .in_ptr, .out_ptr, .in_sub, .out_sub ) )
--
--   End With
--
--   If llg( hero ).vol_fade_trig <> 0 Then
--     '' projectile triggered
--
--     __do_vol_fade ( VarPtr( llg( hero ) ) )
--
--   End If
--
--
--
--   With llg( hero )
--
--
--     .last_cycle_ice = .on_ice
  ll_global.hero.last_cycle_ice = ll_global.hero.on_ice
--     .on_ice = 0
  ll_global.hero.on_ice = 0
--     check_ice( llg( hero ) )
  check_ice(ll_global.hero)
--
--     If .on_ice = 0 Then
  if ll_global.hero.on_ice == 0 then
--       .coords.x = Int( .coords.x )
    ll_global.hero.coords.x = math.floor(ll_global.hero.coords.x)
--       .coords.y = Int( .coords.y )
    ll_global.hero.coords.y = math.floor(ll_global.hero.coords.y)
--
--     End If
  end
--
--
--     If ( .on_ice <> 0 ) And .last_cycle_ice = 0 Then
  if (ll_global.hero.on_ice ~= 0) and ll_global.hero.last_cycle_ice == 0 then
--
--       Dim As Integer all_momentum
--       For all_momentum = 0 To 3
    for all_momentum = 0, 3 do
--         .momentum.i( all_momentum ) = .momentum_history.i( all_momentum )
      ll_global.hero.momentum.i[all_momentum] = ll_global.hero.momentum_history.i[all_momentum]
--
--       Next
    end
--
--     End If
  end
--
--     '' reset lynn move flag
--     .moving = 0
  ll_global.hero.moving = 0
--
--
--     If llg( hero_only ).action_lock = 0 Then
  if ll_global.hero_only.action_lock == 0 then
    log.debug("action lock was 0")
--       '' lynn can do actions
--
--       If llg( hero_only ).attacking = 0 Then
    if ll_global.hero_only.attacking == 0 then
      log.debug("attacking was 0")
--         '' lynn is not attacking
--
--         If (.fly_count = 0) Then
      if ll_global.hero.fly_count == 0 then
        log.debug("fly_count was 0")
--           '' lynn is not flying back
--
--           If .dead = 0 Then
        if ll_global.hero.dead == 0 then
          log.debug("dead was 0")
--             '' lynn is not dead
--
--             If .switch_room = -1 Then
          if ll_global.hero.switch_room == -1 then
            log.debug("switch_room is -1")
--               '' lynn isnt doing a room switch fade thing
--
--               With llg( act_key )
--                 bin_obj( Type( MultiKey( .code ), .in_ptr, .out_ptr, .in_sub, .out_sub ) )
--
--               End With
--
--               With llg( atk_key )
--                 bin_obj( Type( MultiKey( .code ), .in_ptr, .out_ptr, .in_sub, .out_sub ) )
--
--               End With
--
--               dir_keys()
            dir_keys()
--
--             End If
          end
--
--           End If
        end
--
--         End If
      end
--
--       End If
    end
--
--
--       If .on_ice = 0 Then
    if ll_global.hero.on_ice == 0 then
--         '' traction
--         If .unique_id <> u_steelstrider Then
      if ll_global.hero.unique_id ~= u_steelstrider then
--           __go_grip( Varptr( llg( hero ) ) )
        __go_grip(ll_global.hero)
--
--         End If
      end
--
--       End If
  end
--
--       If .walk_hold = 0 Then
  if ll_global.hero.walk_hold == 0 then
--
--         '' walk_hold timer is initialized
--         If .dead = 0 Then
    if ll_global.hero.dead == 0 then
--
--           If llg( hero_only ).attacking <> 0 Then
      if ll_global.hero_only.attacking ~= 0 then
--
--             If .on_ice <> 0 Then
        if ll_global.hero.on_ice ~= 0 then
--               __momentum_move( VarPtr( llg( hero ) ) )
          __momentum_move(ll_global.hero)

--
--             End If
        end
--
--           Else
      else
-- '            llg( hero ).momentum.i( llg( hero ).direction ) *= 2
--             __momentum_move( VarPtr( llg( hero ) ) )
        __momentum_move(ll_global.hero)
--
--           End If
      end
--
--         End If
    end
--
--       End If
  end
--
--
--       hero_continue_movement( VarPtr( llg( hero ) ) )
  hero_continue_movement(ll_global.hero)
--
--       If ( .on_ice <> 0 ) Then
  if ll_global.hero.on_ice ~= 0 then
--
--         __calc_slide( VarPtr( llg( hero ) ) )
    __calc_slide(ll_global.hero)
--
--
--       Else
  else
--         __stop_grip( VarPtr( llg( hero ) ) )
    __stop_grip(ll_global.hero)
--
--       End If
  end
--
--
--       .moving Or = ( .is_psfing <> 0 )
  if ll_global.hero.is_psfing ~= 0 then
    ll_global.hero.moving = 1
  end
--       .moving Or = ( .is_pushing <> 0 )
  if ll_global.hero.is_pushing ~= 0 then
    ll_global.hero.moving = 1
  end
--
--
--       If .moving <> 0 Then
  if ll_global.hero.moving ~= 0 then
--         '' lynn's moving
--
--         If LLObject_IncrementFrame( varptr( llg( hero ) ) ) <> 0 Then
    if LLObject_IncrementFrame(ll_global.hero) ~= 0 then
--           llg( hero ).frame = 0
      ll_global.hero.frame = 1
--           llg( hero ).frame_hold = Timer + llg( hero ).animControl[llg( hero ).current_anim].rate
      ll_global.hero.frame_hold = timer + ll_global.hero.animControl[ll_global.hero.current_anim].rate
--
--         End If
    end
--
--       Else
  else
--         '' lynn isn't moving
--
--         If .dead = 0 Then
    if ll_global.hero.dead == 0 then
--           '' lynn's alive
--
--           If llg( hero_only ).attacking  = 0 Then
      if ll_global.hero_only.attacking == 0 then
--
--             If .frame <> 0 Then
        if ll_global.frame ~= 1 then
--               '' lynn frame not zero, reset
--
--               __reset_frame( VarPtr( llg( hero ) ) )
          __reset_frame(ll_global.hero)
--
--
--             End If
        end
--
--           End If
      end
--
--         End If
    end
--
--       End If
  end
--
--
--       If llg( hero ).switch_room = -1 Then
  if ll_global.hero.switch_room == -1 then
--         llg( hero ).switch_room = check_against_teles( llg( hero ) )
--
--       End If
  end
--
--
--     End If
  end
--
--     With llg( item_l_key )
--       bin_obj( Type( MultiKey( .code ), .in_ptr, .out_ptr, .in_sub, .out_sub ) )
--
--     End With
--     With llg( item_r_key )
--       bin_obj( Type( MultiKey( .code ), .in_ptr, .out_ptr, .in_sub, .out_sub ) )
--
--     End With
--
--
--     If llg( hero_only ).attacking <> 0 Then
  if ll_global.hero_only.attacking ~= 0 then
--       '' lynn is attacking
--       hero_attack( VarPtr( llg( hero ) ) )
--
--     End If
  end
--
--
--     If Timer > .walk_hold Then
  if timer > ll_global.hero.walk_hold then
--       '' walkhold timer expired
--
--       .walk_hold = 0
    ll_global.hero.walk_hold = 0
--       .is_psfing = 0
    ll_global.hero.is_psfing = 0
--
--     End If
  end
--
--
--     If .switch_room <> -1 Then
--       change_room( VarPtr( llg( hero ) ) )
--
--     End If
--
--
--     If .dead = FALSE Then
--       '' lynn's alive,
--
--       LLObject_MAINDamage( VarPtr( llg( hero ) ) )
--
--       If ( .dmg.id <> 0 ) Then
--         '' lynn is damaged by something
--         __flashy( VarPtr( llg( hero ) ) )
--
--
--       End If
--
--     End If
--
--
--     If .hurt Then
  if ll_global.hero.hurt ~= 0 then
--       '' lynn's hurt
--
--       .funcs.current_func[.hit_state] += .funcs.func[.hit_state][.funcs.current_func[.hit_state]]( VarPtr( llg( hero ) ) )
--
--
--       If .funcs.current_func[.hit_state] = .funcs.func_count[.hit_state] Then
--         '' lynn called back
--
--         .funcs.current_func[.hit_state] = 0
--
--         .hurt = 0
--         .dmg.index = 0
--         .dmg.specific = 0
--
--       End If
--
--     End If
  end
--
--
--     If .dead Then
  if ll_global.hero.dead ~= 0 then
--       '' lynn is dead
--
--       llg( hero_only ).attacking = 0
--       llg( hero ).fade_time = .003
--
--       .funcs.current_func[.death_state] += .funcs.func[.death_state][.funcs.current_func[.death_state]]( VarPtr( llg( hero ) ) )
--
--       If ( .funcs.current_func[.death_state] = .funcs.func_count[.death_state] ) Then
--         '' lynn called back
--         jump_to_title()
--
--       End If
--
--     End If
  end
--
--   End With
--
--   If llg( hero.hp ) > llg( hero.maxhp ) Then
--     llg( hero.hp ) = llg( hero.maxhp )
--     antiHackASSIGN( LL_Global.hero_only.healthDummy, LL_Global.hero.hp )
--
--   end if
--
--   #IfDef ll_audio
--     check_env_sounds()
--
--   #EndIf
--
--   cache_crazy()
--   decay_crazy()
--
--   If llg( hero_only ).songFade <> NULL Then
--     LLMusic_Fade()
--
--   End If
--
--
-- End Sub
end

-- Private Sub dir_keys()
function dir_keys()
  log.debug("dir_keys entered.")
--
--   Static As Double SLIDE_CONSTANT = .02
  local SLIDE_CONSTANT = .02
--
--   With llg( hero )
--
--     .momentum_history.i( 0 ) = 0
  ll_global.hero.momentum_history[0] = 0
--     .momentum_history.i( 1 ) = 0
  ll_global.hero.momentum_history[1] = 0
--     .momentum_history.i( 2 ) = 0
  ll_global.hero.momentum_history[2] = 0
--     .momentum_history.i( 3 ) = 0
  ll_global.hero.momentum_history[3] = 0
--
--     If .walk_hold = 0 Then
  if ll_global.hero.walk_hold == 0 then
--
--       '' walk_hold timer is initialized
--
--       If MultiKey ( llg( l_key.code ) ) Then
    if love.keyboard.isDown("left") then
--         '' hit left
--
--         .direction = 3
      ll_global.hero.direction = 3
--         .momentum.i( .direction ) += SLIDE_CONSTANT
      ll_global.hero.momentum.i[ll_global.hero.direction] = ll_global.hero.momentum.i[ll_global.hero.direction] + SLIDE_CONSTANT
--
--         If .momentum.i( .direction ) > 1 Then
      if ll_global.hero.momentum.i[ll_global.hero.direction] > 1 then
--           .momentum.i( .direction ) = 1
        ll_global.hero.momentum.i[ll_global.hero.direction] = 1
--
--         End If
      end
--
--       Else
    else
--
--         If llg( hero.is_pushing ) = 4 Then
      if ll_global.hero.is_pushing == 4 then
--           llg( hero.is_pushing ) = 0
        ll_global.hero.is_pushing = 0
--
--         End If
      end
--
--       End If
    end
--
--       If MultiKey ( llg( r_key.code ) ) Then
    if love.keyboard.isDown("right") then
--         '' hit right
--
--         .direction = 1
      ll_global.hero.direction = 1
--         .momentum.i( .direction ) += SLIDE_CONSTANT
      ll_global.hero.momentum.i[ll_global.hero.direction] = ll_global.hero.momentum.i[ll_global.hero.direction] + SLIDE_CONSTANT
--
--         If .momentum.i( .direction ) > 1 Then
      if ll_global.hero.momentum.i[ll_global.hero.direction] > 1 then
--           .momentum.i( .direction ) = 1
        ll_global.hero.momentum.i[ll_global.hero.direction] = 1
--
--         End If
      end
--
--       Else
    else
--
--         If llg( hero.is_pushing ) = 2 Then
      if ll_global.hero.is_pushing == 2 then
--           llg( hero.is_pushing ) = 0
        ll_global.hero.is_pushing = 0
--
--         End If
      end
--
--       End If
    end
--
--       If MultiKey ( llg( d_key.code ) ) Then
    if love.keyboard.isDown("down") then
--         '' hit down
--
--         .direction = 2
      ll_global.hero.direction = 2
--         .momentum.i( .direction ) += SLIDE_CONSTANT
      ll_global.hero.momentum.i[ll_global.hero.direction] = ll_global.hero.momentum.i[ll_global.hero.direction] + SLIDE_CONSTANT
--
--         If .momentum.i( .direction ) > 1 Then
      if ll_global.hero.momentum.i[ll_global.hero.direction] > 1 then
--           .momentum.i( .direction ) = 1
        ll_global.hero.momentum.i[ll_global.hero.direction] = 1
--
--         End If
      end
--
--       Else
    else
--
--         If llg( hero.is_pushing ) = 3 Then
      if ll_global.hero.is_pushing == 3 then
--           llg( hero.is_pushing ) = 0
        ll_global.hero.is_pushing = 0
--
--         End If
      end
--
--       End If
    end
--
--       If MultiKey ( llg( u_key.code ) )   Then
    if love.keyboard.isDown("up") then
--         '' hit up
--
--         .direction = 0
      ll_global.hero.direction = 0
--         .momentum.i( .direction ) += SLIDE_CONSTANT
      ll_global.hero.momentum.i[ll_global.hero.direction] = ll_global.hero.momentum.i[ll_global.hero.direction] + SLIDE_CONSTANT
--
--         If .momentum.i( .direction ) > 1 Then
      if ll_global.hero.momentum.i[ll_global.hero.direction] > 1 then
--           .momentum.i( .direction ) = 1
        ll_global.hero.momentum.i[ll_global.hero.direction] = 1
--
--         End If
      end
--
--       Else
    else
--         If llg( hero.is_pushing ) = 1 Then
      if ll_global.hero.is_pushing == 1 then
--           llg( hero.is_pushing ) = 0
        ll_global.hero.is_pushing = 0
--
--         End If
      end
--
--       End If
    end
--
--     End If
  end
--
--   End With
--
--
-- End Sub
end

-- Sub hero_continue_movement( mn As _char_type Ptr )
function hero_continue_movement(mn)
--
--   If mn->dead <> 0 Then Exit Sub
  if mn.dead ~= 0 then return end
--
--   If MultiKey ( llg( u_key ).code ) Or MultiKey ( llg( r_key ).code ) Or MultiKey ( llg( d_key ).code ) Or MultiKey ( llg( l_key ).code ) Then
  if love.keyboard.isDown("up") or love.keyboard.isDown("right") or love.keyboard.isDown("down") or love.keyboard.isDown("left") then
--     '' hit a directional arrow
--     If mn->switch_room = -1 Then
    if mn.switch_room == -1 then
--
--       If MultiKey ( llg( l_key ).code ) Then
      if love.keyboard.isDown("left") then
--         '' hit left
--
--         mn->direction = 3
        mn.direction = 3
--         mn->moving Or = move_object ( mn, MO_JUST_CHECKING ) <> 0
        if move_object(mn, MO_JUST_CHECKING) ~= 0 then
          mn.moving = 1
        end
--         mn->moving Or = ( mn->is_pushing <> 0 )
        if mn.is_pushing ~= 0 then
          mn.moving = 1
        end
--
--       End If
      end
--
--
--       If MultiKey ( llg( r_key ).code ) Then
      if love.keyboard.isDown("right") then
--         '' hit right
--
--         mn->direction = 1
        mn.direction = 1
--         mn->moving Or = move_object ( mn, MO_JUST_CHECKING ) <> 0
        if move_object(mn, MO_JUST_CHECKING) ~= 0 then
          mn.moving = 1
        end
--         mn->moving Or = ( mn->is_pushing <> 0 )
        if mn.is_pushing ~= 0 then
          mn.moving = 1
        end
--
--       End If
      end
--
--
--       If MultiKey ( llg( d_key ).code ) Then
      if love.keyboard.isDown("down") then
--         '' hit down
--
--         mn->direction = 2
        mn.direction = 2
--         mn->moving Or = move_object ( mn, MO_JUST_CHECKING ) <> 0
        if move_object(mn, MO_JUST_CHECKING) ~= 0 then
          mn.moving = 1
        end
--         mn->moving Or = ( mn->is_pushing <> 0 )
        if mn.is_pushing ~= 0 then
          mn.moving = 1
        end
--
--       End If
      end
--
--
--       If MultiKey ( llg( u_key ).code )   Then
      if love.keyboard.isDown("up") then
--         '' hit up
--
--         mn->direction = 0
        mn.direction = 0
--         mn->moving Or = move_object ( mn, MO_JUST_CHECKING ) <> 0
        if move_object(mn, MO_JUST_CHECKING) ~= 0 then
          mn.moving = 1
        end
--         mn->moving Or = ( mn->is_pushing <> 0 )
        if mn.is_pushing ~= 0 then
          mn.moving = 1
        end
--
--       End If
      end
--
--     End If
    end
--
--   End If
  end
--
--
-- End Sub
end

function enemy_main()
  -- With now_room()
  --
  --   If .enemies > 0 Then
  --     act_enemies( .enemies, .enemy )
  act_enemies(now_room().enemies)
  --
  --   End If
  --   If .temp_enemies > 0 Then
  --     act_enemies( .temp_enemies, Varptr( .temp_enemy( 0 ) ) )
  --
  --   End If
  --
  -- End With
end

function act_enemies(enemies)
  -- Dim As Integer do_stuff
  --
  -- For do_stuff = 0 To _enemies - 1
  for i = 1, #enemies do
  --
  --
  --   With _enemy[do_stuff]
    local enemy = enemies[i]
  --
  --     If LLObject_IsWithin( Varptr( _enemy[do_stuff] ) ) Then
    if LLObject_IsWithin(enemy) then
  --
  --       If ( .seq_paused <> 0 ) And ( llg( seq ) <> 0 ) Then
      --TODO: Actually port the above if statement once we understand the sequence system.
      if false then
  --
  --       Else
      else
  --
  --
  --         .seq_paused = 0
  --
  --
  --         if .unique_id = u_healthguy then
  --           __healthguy_branch( Varptr( _enemy[do_stuff] ) )
  --
  --         end if
  --
  --
  --         If .unique_id <> u_sparkle Then
        if true then
  --
  --           Dim As vector_pair target, origin
  --
  --           If .unique_id = u_slimeman Then
  --             If .chap = 255 Then
  --               .mad = 1
  --
  --             End If
  --
  --           End If
  --
  --           If llg( hero ).menu_sel <> 0 Then
  --
  --             If ( .unique_id <> u_savepoint ) And ( .unique_id <> u_menu ) Then
  --
  --               Continue For
  --
  --             End If
  --
  --           End If
  --
  --
  --           .last_cycle_ice = .on_ice
  --           .on_ice = 0
  --
  --           check_ice( _enemy[do_stuff] )
  --
  --
  --           If .unique_id = u_core Then
  --             '' Hack Fest!!!!!!!!!!!!
  --
  --             If llg( now )[725] Then
  --
  --               Dim As Integer enemyIterate, stateConfirm
  --               stateConfirm = -1
  --               Select Case .shifty_state
  --               '' if wave dead then advance
  --                 Case 0
  --                   .shifty_state += 1
  --                   For enemyIterate = 5 To 10
  --                     now_room().enemy[enemyIterate].trigger = TRUE
  --
  --                   Next
  --                   play_sample( sound_turret, 80 )
  --                   .unstoppable_by_object = 0
  --
  --                 Case 1
  --                   '' 5- 10
  --                   For enemyIterate = 5 To 10
  --                     stateConfirm And= ( now_room().enemy[enemyIterate].dead )
  --                   Next
  --                   If stateConfirm Then
  --                     .shifty_state += 1
  --                     For enemyIterate = 11 To 18
  --                       now_room().enemy[enemyIterate].trigger = TRUE
  --
  --                     Next
  --                     play_sample( sound_turret, 80 )
  --
  --                   End If
  --
  --                 Case 2
  --                   '' 11 - 18
  --                   For enemyIterate = 11 To 18
  --                     stateConfirm And= ( now_room().enemy[enemyIterate].dead )
  --                   Next
  --                   If stateConfirm Then
  --                     .shifty_state += 1
  --                     For enemyIterate = 19 To 28
  --                       now_room().enemy[enemyIterate].trigger = TRUE
  --
  --                     Next
  --                     play_sample( sound_turret, 80 )
  --
  --                   End If
  --
  --                 Case 3
  --                   '' 19 - 28
  --                   For enemyIterate = 19 To 28
  --                     stateConfirm And= ( now_room().enemy[enemyIterate].dead )
  --                   Next
  --                   If stateConfirm Then
  --                     .shifty_state += 1
  --                     For enemyIterate = 29 To 48
  --                       now_room().enemy[enemyIterate].trigger = TRUE
  --
  --                     Next
  --                     play_sample( sound_turret, 80 )
  --
  --                   End If
  --
  --                 Case 4
  --                   '' 29 - 48
  --                   For enemyIterate = 29 To 48
  --                     stateConfirm And= ( now_room().enemy[enemyIterate].dead )
  --                   Next
  --                   If stateConfirm Then
  --                     .shifty_state += 1
  --                     For enemyIterate = 0 To 7
  --                       .anim[.current_anim]->frame[0].face[enemyIterate].invincible = 0
  --
  --                     Next
  --                     .invincible = 0
  --                     LLObject_ShiftState( Varptr( _enemy[do_stuff] ), .jump_state )
  --
  --                   End If
  --
  --                 Case 5
  --                   '' core vulnerable
  --
  --               End Select
  --
  --             End If
  --
  --           End If
  --
  --
  --
  --           If llg( hero_only ).attacking <> 0 Then
  --             LLObject_MAINAttack( 1, Varptr( _enemy[do_stuff] ), Varptr( llg( hero ) ) )
  --
  --           End If
  --
  --
  --           If ( .unique_id = u_anger ) Or ( .unique_id = u_sterach ) Then
  --
  --             If .hit <> 0 Then
  --               '' This is how all hit state shifts should be handled.
  --               '' This runs parallel to any running state.
  --               If __anger_flyback( Varptr( _enemy[do_stuff] ) ) <> 0 Then
  --
  --                 .hit = 0
  --
  --               End If
  --
  --             End If
  --
  --           End If
  --
  --           If ( .unique_id = u_beamcrystal ) Or _
  --              ( .unique_id = u_boss5_right ) Or _
  --              ( .unique_id = u_boss5_down ) Or _
  --              ( .unique_id = u_boss5_left ) Or _
  --              ( .unique_id = u_boss5_crystal ) Then
  --
  --             LLObject_ProjectileDamage( now_room().enemies, now_room().enemy, Varptr( _enemy[do_stuff] ) )
  --
  --           End If
  --
  --
  --           If ( .on_ice <> 0 ) Then
  --
  --             __calc_slide( Varptr( _enemy[do_stuff] ) )
  --
  --           End If
  --
  --           If .on_ice = 0 Then
          if enemy.on_ice == 0 then
  --             __stop_grip( Varptr( _enemy[do_stuff] ) )
            __stop_grip(enemy)
  --
  --           End If
          end
  --
  --
  --           If .walk_hold = 0 Then
          if enemy.walk_hold == 0 then
  --
  --             If .walk_steps = 0 Then
            if enemy.walk_steps == 0 then
  --               __momentum_move ( Varptr( _enemy[do_stuff] ) )
              __momentum_move(enemy)
  --
  --             End If
            end
  --
  --           End If
          end
  --
  --
  --
  --           If  .hurt <> 0 Then
  --             '' this enemy is showing damage effects
  --
  --             If ( .unique_id = u_dyssius ) Or ( .unique_id = u_steelstrider ) Then
  --
  --             Else
  --
  --               If  .funcs.current_func[.funcs.active_state] = .funcs.func_count[.funcs.active_state] Then
  --                 '' the enemy called back (damage is done)
  --
  --                 LLObject_ShiftState( Varptr( _enemy[do_stuff] ), .reset_state )
  --
  --                 If .unique_id = u_ferus Then
  --
  --                   LLObject_ClearProjectiles( _enemy[do_stuff] )
  --                   .radius = Timer
  --
  --
  --                 End If
  --
  --                 If .unique_id = u_grult Then
  --
  --                   LLObject_ShiftState( Varptr( _enemy[do_stuff] ), .stun_state )
  --                   .funcs.current_func[.funcs.active_state] = 2
  --
  --                 End If
  --
  --                 LLObject_ClearDamage( Varptr( _enemy[do_stuff] ) )
  --                 .flash_count = 0
  --                 .flash_timer = 0
  --                 .invisible = 0
  --
  --
  --               End If
  --
  --             End If
  --
  --           End If
  --
  --           If .funcs.current_func[.funcs.active_state] = .funcs.func_count[.funcs.active_state] Then
  --             '' if function block reaches end, return to beginning.
  --
  --             .funcs.current_func[.funcs.active_state] = 0
  --
  --           End If
  --
  --
  --           If .dead = 0 Then
  --             '' entity is not dead
  --
  --             If .hp <= 0 Then
  --               '' entity is below the hp limit (marked for death)
  --
  --
  --
  --               If .dead_sound <> 0 Then
  --                 play_sample( llg( snd )[.dead_sound] )
  --
  --               End If
  --
  --               LLObject_ShiftState( Varptr( _enemy[do_stuff] ), _enemy[do_stuff].death_state )
  --
  --             End If
  --
  --             If .dead = 0 Then
  --               If .froggy <> 0 Then
  --                 '' this entity can become mad
  --
  --
  --                 If ( .mad = 0 ) Then
  --                   '' entity is not mad
  --
  --                   If ( .funcs.active_state < .reset_state ) Then
  --
  --                     '' entity is not resetting
  --
  --                     '' implicit proximity detection
  --                     .funcs.active_state = in_proximity( Varptr( _enemy[do_stuff] ) )
  --
  --                   End If
  --
  --                 End If
  --
  --               End If
  --
  --               If .mad <> 0 Then
  --                 '' entity is mad
  --
  --                 '' see if its far enough to get a reset
  --                 .funcs.active_state = out_proximity( Varptr( _enemy[do_stuff] ) )
  --
  --               End If
  --
  --             End If
  --
  --           End If
  --
  --
  --           If .projectile Then
  --             If .projectile->active <> 0 Then
  --               '' projectile triggered
  --
  --               __do_proj ( Varptr( _enemy[do_stuff] ) )
  --
  --             End If
  --
  --           End If
  --
  --           If .unique_id = u_ferus Then
  --
  --             if .radius = 0 then
  --               .radius = Timer + 3 + ( Rnd * 3 )
  --
  --             end if
  --
  --             If Timer > .radius Then
  --
  --               .radius = 0
  --               __trigger_projectile( Varptr( _enemy[do_stuff] ) )
  --
  --
  --             End If
  --
  --
  --
  --           End If
  --
  --
  --           If .pushable <> 0 Then
  --             '' the entity is pushable
  --
  --             __push ( Varptr( _enemy[do_stuff] ) )
  --
  --           End If
  --
  --           If .vol_fade_trig <> 0 Then
  --             '' projectile triggered
  --
  --             __do_vol_fade ( Varptr( _enemy[do_stuff] ) )
  --
  --           End If
  --
  --
  --           If llg( seq ) = 0 Then
  --             '' no sequence happening already
  --
  --
  --             If llg( hero ).switch_room = -1 Then
  --
  --               If .action_sequence <> 0 Then
  --                 '' ths entity loads a sequence when you action it
  --
  --                 If llg( hero_only ).action <> 0 Then
  --
  --                   LLObject_ActionSequence( Varptr( _enemy[do_stuff] ) )
  --
  --                 End If
  --
  --
  --               End If
  --
  --
  --
  --
  --               If .touch_sequence <> 0 Then
  --                 '' ths entity loads a sequence when you touch it
  --
  --                 LLObject_TouchSequence( Varptr( _enemy[do_stuff] ) )
  --
  --               End If
  --
  --             End If
  --
  --           End If
  --
  --
  --           If .grult_proj_trig <> 0 Then
  --
  --
  --             '' projectile triggered (concurrent functionality)
  --             __do_grult_proj ( Varptr( _enemy[do_stuff] ) )
  --
  --             LLObject_CheckGTorchLit( Varptr( _enemy[do_stuff] ) )
  --
  --           End If
  --
  --
  --           If .anger_proj_trig <> 0 Then
  --             __do_anger_proj ( Varptr( _enemy[do_stuff] ) )
  --
  --           End If
  --
  --           If .unique_id = u_grult Then
  --
  -- '              If .funcs.active_state <> .stun_state Then
  --             If .funcs.active_state = 0 Or ( .funcs.active_state = .proj_state )Then
  --
  --
  --               If llg( dark ) <> 4 Then
  --                 '' stunned
  --
  --                 .stun_return_trig = 0
  --                 LLObject_ClearProjectiles( _enemy[do_stuff] )
  --                 .fly_timer = 0
  --                 .fly_count = 0
  --                 .grult_proj_trig = 0
  --
  --
  --                 .jump_counter = 0
  --
  --                 LLObject_ShiftState( Varptr( _enemy[do_stuff] ), .stun_state )
  --
  --               End If
  --
  --             Else'If (.funcs.active_state = .stun_state) Or (.funcs.active_state = .hit_state) Then
  --
  --
  --               If (.stun_return_trig = 0) Then
  --
  -- '                    If now_room().dark = 4 Then
  --                 If llg( dark ) = 4 Then
  --                   .stun_return_trig = 1
  --
  --                 End If
  --                   '' un-stunned!
  --
  --                 If .stun_return_trig = 1 Then
  --
  --                   If .dead = 0 Then
  --
  --                     .jump_counter = 0
  --
  --                     .hurt = 0
  --
  --
  --                     LLObject_ClearDamage( Varptr( _enemy[do_stuff] ) )
  --
  --                     .fly_count = 0
  --                     .fly_timer = 0
  --                     .flash_timer = 0
  --                     .invisible = 0
  --                     .mad =  0
  --
  --                     .invincible = -1
  --
  --                     LLObject_ShiftState( Varptr( _enemy[do_stuff] ), .reset_state )
  --
  --
  --
  --
  --                   End If
  --
  --                 End If
  --
  --               End If
  --
  --             End If
  --
  --           End If
  --
  --
  --
  --           If .spawn_cond <> 0 Then
  --             LLObject_CheckSpawn( Varptr( _enemy[do_stuff] ) )
  --
  --           End If
  --
  --           If .unique_id = u_gbutton Then
  --
  --             Dim As LLObject_CollisionType collisionCheck
  --             Dim As Integer buttonSet, rockCheck
  --
  --             collisionCheck = LLObject_Collision( llg( hero ), _enemy[do_stuff] )
  --             If collisionCheck.isColliding = -1 Then
  --               buttonSet = -1
  --
  --             End If
  --
  --             If buttonSet = 0 Then
  --
  --               For rockCheck = 0 To now_room().enemies - 1
  --
  --                 If now_room().enemy[rockCheck].unique_id = u_pushrock Then
  --                   collisionCheck = LLObject_Collision( now_room().enemy[rockCheck], _enemy[do_stuff] )
  --                   If collisionCheck.isColliding = -1 Then
  --                     buttonSet = -1
  --                     Exit For
  --
  --                   End If
  --
  --                 End If
  --
  --               Next
  --
  --             End If
  --
  --             .funcs.active_state = IIf( buttonSet, 1, 0 )
  --
  --
  --
  --
  --           End If
  --
  --           If ( .unique_id = u_gold ) Or ( .unique_id = u_silver ) Or ( .unique_id = u_health ) Then
  --             '' this is loot to pick up
  --
  --             LLObject_GrabItems( Varptr( _enemy[do_stuff] ) )
  --
  --           End If
  --
  --           If .unique_id = u_ltorch Then
  --
  --             LLObject_TorchModify( Varptr( _enemy[do_stuff] ) )
  --
  --           End If
  --
  --           If  .dmg.id <> 0 Then
  --             '' enemy was hit by lynn
  --
  --             __flashy( Varptr( _enemy[do_stuff] ) )
  --
  --           End If
  --
  --
  --           If Timer > .walk_hold Then .walk_hold = 0
          if timer > enemy.walk_hold then enemy.walk_hold = 0 end
  --
  --
  --
  --             If .animControl[.current_anim].frame[.frame].concurrents <> 0 Then
  --
  --               LLEngine_ExecuteConcurrents( Varptr( _enemy[do_stuff] ) )
  --
  --
  --             End If
  --
  --           If ( .unique_id = u_dyssius ) Or ( .unique_id = u_steelstrider ) Then
  --
  --             If .dead = 0 Then
  --
  --               If .sway <> 0 Then
  --
  --                 If Timer > .sway Then
  --                   __dyssius_jump_slide( Varptr( _enemy[do_stuff] ) )
  --                   .sway = 0
  --
  --                   .fly_count = 0
  --                   .fly_timer = 0
  --                   .flash_timer = 0
  --                   .invisible = 0
  --                   .hurt = 0
  --
  --                   If ( .projectile->coords[0].x <> 0 ) Or ( .projectile->coords[0].y <> 0 ) Then
  --
  --                     LLObject_ClearProjectiles( _enemy[do_stuff] )
  --
  --                   End If
  --
  --                 End If
  --
  --               End If
  --
  --             End If
  --
  --           End If
  --
  --         End If
        end
  --
  --         .funcs.current_func[.funcs.active_state] += .funcs.func[.funcs.active_state][.funcs.current_func[.funcs.active_state]] ( VarPtr( _enemy[do_stuff] ) )
        --log.debug("enemy.funcs.active_state: "..enemy.funcs.active_state)
        --log.debug("enemy.funcs.current_func[enemy.funcs.active_state]: "..enemy.funcs.current_func[enemy.funcs.active_state])
        local result = enemy.funcs.func[enemy.funcs.active_state][enemy.funcs.current_func[enemy.funcs.active_state]](enemy)
        --log.debug("result: "..(result and result or "nil"))
        enemy.funcs.current_func[enemy.funcs.active_state] = enemy.funcs.current_func[enemy.funcs.active_state] + result
--NOTE: The above line should be ported to Lua first as it is what actually performs the function execution.
  --
  --       End If
      end
  --
  --     End If
    end
  --
  --   End With
  --
  -- Next
  end
  --
  -- If _enemy = Varptr( now_room().temp_enemy( 0 ) ) Then
  --   maintain_temps( Varptr( now_room() ) )
  --
  -- End If

end

-- Sub update_cam( mn As char_type Ptr = 0 )
function update_cam(mn)
--
--   If mn = 0 Then mn = Varptr( llg( hero ) )
  mn = mn or ll_global.hero
--
--   Dim As Integer cam_x, cam_y
  local cam_x, cam_y = 0, 0
--
--   With ll_global
--
--     cam_x = mn->coords.x - ( ( ( .sx ) - ( mn->perimeter.x Shr 1 ) ) Shr 1 )  - 1 '' div 2, div 2
  cam_x = mn.coords.x - (bit.rshift((ll_global.sx) - bit.rshift(mn.perimeter.x, 1), 1)) - 1
--     If cam_x < 0 Then cam_x = 0
  if cam_x < 0 then cam_x = 0 end
--     If cam_x > ( now_room().x Shl 4 ) - .sx Then cam_x = ( now_room().x Shl 4 ) - .sx '' mul tileX, multileX
  if cam_x > bit.lshift(now_room().x, 4) - ll_global.sx then
    cam_x = bit.lshift(now_room().x, 4) - ll_global.sx
  end
--
--     cam_y = mn->coords.y - ( ( ( .sy ) - ( mn->perimeter.y Shr 1 ) ) Shr 1 )  - 1 '' div 2, div 2
  cam_y = mn.coords.y - (bit.rshift((ll_global.sy) - bit.rshift(mn.perimeter.y, 1), 1)) - 1
--     If cam_y < 0 Then cam_y = 0
  if cam_y < 0 then cam_y = 0 end
--      If cam_y > ( now_room().y Shl 4 ) - .sy Then cam_y = ( now_room().y Shl 4 ) - .sy '' mul tileY, mul tileY
  if cam_y > bit.lshift(now_room().y, 4) - ll_global.sy then
    cam_y = bit.lshift(now_room().y, 4) - ll_global.sy
  end
--
--     .this_room.cx = cam_x
  ll_global.this_room.cx = cam_x
--     .this_room.cy = cam_y
  ll_global.this_room.cy = cam_y
--
--
--   End With
--
--
-- End Sub
end

--Function move_object( o As char_type Ptr, only_looking As Integer = 0, moment As Double = 1, recurring As Integer = 0 ) As uInteger
function move_object(o, only_looking, moment, recurring)
  only_looking = only_looking or 0
  moment = moment or 1
  recurring = recurring or 0
  --log.debug("move_object called.")
  --log.debug("moment: "..moment)
    -- Dim As Integer mx, my '' holds open axes
  local mx, my = 0, 0
    --
    -- Select Case o->direction
    --
    --   Case 0
  if o.direction == 0 then
    --log.debug("o.direction is 0.")
    --
    --
    --     If o->coords.y > 0 Or ( o->unstoppable_by_screen ) Then
    if o.coords.y > 0 or o.unstoppable_by_screen then
      --log.debug("o.coords.y: "..o.coords.y)
      --log.debug("o.unstoppable_by_screen: "..o.unstoppable_by_screen)
    --       '' object "y" is bigger than 0, or is not stopped by physical bounds.
    --
    --       If check_walk( o, 0, only_looking Or recurring ) Or ( o->unstoppable_by_tile <> 0 )Then
      if check_walk(o, 0, only_looking or recurring) or o.unstoppable_by_tile ~= 0 then
        --log.debug("check_walk(o, 0, only_looking or recurring): "..(check_walk(o, 0, only_looking or recurring) and "true" or "false"))
        --log.debug("o.unstoppable_by_tile: "..o.unstoppable_by_tile)
    --         '' object has open 'walkable path, or isn't stopped by unwalkable areas
    --
    --         If check_against_entities ( 0, o ) <> 1 Or ( o->unstoppable_by_object ) Then
        if check_against_entities(0, o) ~= 1 or o.unstoppable_by_object then
          --log.debug("check_against_entities(0, o): "..(check_against_entities(0, o) and "true" or "false"))
          --log.debug("o.unstoppable_by_object: "..o.unstoppable_by_object)
          --log.debug("only_looking: "..only_looking)
    --
    --           '' object isn't colliding with another (impassable) object, or is not stopped by impassable objects
    --
    --           If only_looking = 0 Then
          if only_looking == 0 then
            --log.debug("only_looking: "..only_looking)
            --log.debug("moment: "..moment)
    --             '' execute
    --             ''
    --             o->coords.y -= 1 * moment
            o.coords.y = o.coords.y - moment
    --
    --           End If
          end
    --
    --           my = 1
          my = 1
    --
    --         End If
        end
    --
    --       End If
      end
    --
    --     End If
    end
    --
    --
  end
    --   Case 1
  if o.direction == 1 then
    --
    --     If o->coords.x < ( now_room().x Shl 4 ) - o->perimeter.x Or ( o->unstoppable_by_screen ) Then '' mul tileX
    if o.coords.x < (now_room().x * 16) - o.perimeter.x or o.unstoppable_by_screen then
    --
    --       '' object "x" is smaller than right bound, or is not stopped by physical bounds.
    --
    --       If check_walk( o, 1, only_looking Or recurring ) Or ( o->unstoppable_by_tile <> 0 )Then
      if check_walk(o, 1, only_looking or recurring) or (o.unstoppable_by_tile ~= 0) then
    --         '' object has open 'walkable path, or isn't stopped by unwalkable areas
    --
    --
    --         If check_against_entities ( 1, o ) <> 1 Or ( o->unstoppable_by_object ) Then
        if check_against_entities(1, o) ~= 0 or o.unstoppable_by_object then
    --
    --           '' object isn't colliding with another (impassable) object, or is not stopped by impassable objects
    --
    --           If only_looking = 0 Then
          if only_looking == 0 then
    --             '' execute
    --             ''
    --             o->coords.x += 1 * moment
            o.coords.x = o.coords.x + moment
    --
    --           End If
          end
    --
    --           mx = 1
          mx = 1
    --
    --         End If
        end
    --
    --       End If
      end
    --
    --     End If
    end
    --
    --
  end
    --   Case 2
  if o.direction == 2 then
    --
    --     If o->coords.y < ( now_room().y Shl 4 ) - o->perimeter.y Or ( o->unstoppable_by_screen ) Then '' mul tileY
    if o.coords.y < (now_room().y * 16) - o.perimeter.y or (o.unstoppable_by_screen) then
    --
    --       If check_walk( o, 2, only_looking Or recurring ) Or ( o->unstoppable_by_tile <> 0 )Then
      if check_walk(o, 2, only_looking or recurring) or (o.unstoppable_by_tile ~= 0) then
    --
    --         If check_against_entities ( 2, o ) <> 1 Or ( o->unstoppable_by_object ) Then
        if check_against_entities(2, o) ~= 1 or (o.unstoppable_by_object) then
    --
    --
    --           If only_looking = 0 Then
          if only_looking == 0 then
    --             '' execute
    --             ''
    --             o->coords.y += 1 * moment
            o.coords.y = o.coords.y + moment
    --
    --           End If
          end
    --
    --           my = 1
          my = 1
    --
    --         End If
        end
    --
    --       End If
      end
    --
    --     End If
    end
    --
  end
    --   Case 3
  if o.direction == 3 then
    --
    --
    --     If o->coords.x > 0 Or ( o->unstoppable_by_screen ) Then
    if o.coords.x > 0 or o.unstoppable_by_screen then
    --
    --
    --       If check_walk( o, 3, only_looking Or recurring ) Or ( o->unstoppable_by_tile <> 0 )Then
      if check_walk(o, 3, only_looking or recurring) or (o.unstoppable_by_tile ~= 0) then
    --
    --
    --         If check_against_entities ( 3, o ) <> 1 Or ( o->unstoppable_by_object ) Then
        if check_against_entities(3, o) ~= 1 or (o.unstoppable_by_object) then
    --
    --
    --           If only_looking = 0 Then
          if only_looking == 0 then
    --             '' execute
    --             ''
    --             o->coords.x -= 1 * moment
            o.coords.x = o.coords.x - moment
    --
    --           End If
          end
    --
    --           mx = 1
          mx = 1
    --
    --         End If
        end
    --
    --       End If
      end
    --
    --     End If
    end
    --
  end
    --   Case 4
  if o.direction == 4 then
    --
    --
    --     If o->coords.y > 0 Or ( o->unstoppable_by_screen ) Then
    if o.coords.y > 0 or (o.unstoppable_by_screen) then
    --
    --
    --       If check_walk( o, 0, only_looking Or recurring ) Or ( o->unstoppable_by_tile <> 0 )Then
      if check_walk(o, 0, only_looking or recurring) or (o.unstoppable_by_tile ~= 0) then
    --
    --
    --         If check_against_entities ( 0, o ) <> 1 Or ( o->unstoppable_by_object ) Then
        if check_against_entities(0, o) ~= 1 or (o.unstoppable_by_object) then
    --
    --
    --           If only_looking = 0 Then
          if only_looking == 0 then
    --             '' execute
    --             ''
    --             o->coords.y -= 1 * moment
            o.coords.y = o.coords.y - moment
    --
    --           End If
          end
    --
    --           my = 1
          my = 1
    --
    --         End If
        end
    --
    --       End If
      end
    --
    --     End If
    end
    --
    --
    --     If o->coords.x > 0 Or ( o->unstoppable_by_screen ) Then
    if o.coords.x > 0 or (o.unstoppable_by_screen) then
    --
    --
    --       If check_walk( o, 3, only_looking Or recurring ) Or ( o->unstoppable_by_tile <> 0 )Then
      if check_walk(o, 3, only_looking or recurring) or (o.unstoppable_by_tile ~= 0) then
    --
    --
    --         If check_against_entities ( 3, o ) <> 1 Or ( o->unstoppable_by_object ) Then
        if check_against_entities(3, o) ~= 1 or (o.unstoppable_by_object) then
    --
    --
    --           If only_looking = 0 Then
          if only_looking == 0 then
    --             '' execute
    --             ''
    --             o->coords.x -= 1 * moment
            o.coords.x = o.coords.x - moment
    --
    --           End If
          end
    --
    --           mx = 1
          mx = 1
    --
    --         End If
        end
    --
    --       End If
      end
    --
    --     End If
    end
    --
  end
    --   Case 5
  if o.direction == 5 then
    --
    --
    --     If o->coords.y > 0 Or ( o->unstoppable_by_screen ) Then
    if o.coords.y > 0 or (o.unstoppable_by_screen) then
    --
    --
    --       If check_walk( o, 0, only_looking Or recurring ) Or ( o->unstoppable_by_tile <> 0 )Then
      if check_walk(o, 0, only_looking or recurring) or (o.unstoppable_by_tile ~= 0) then
    --
    --
    --         If check_against_entities ( 0, o ) <> 1 Or ( o->unstoppable_by_object ) Then
        if check_against_entities(0, i) ~= 1 or (o.unstoppable_by_object) then
    --
    --
    --           If only_looking = 0 Then
          if only_looking == 0 then
    --             '' execute
    --             ''
    --             o->coords.y -= 1 * moment
            o.coords.y = o.coords.y - moment
    --
    --           End If
          end
    --
    --           my = 1
          my = 1
    --
    --         End If
        end
    --
    --       End If
      end
    --
    --     End If
    end
    --
    --     If o->coords.x < ( now_room().x Shl 4 ) - o->perimeter.x Or ( o->unstoppable_by_screen ) Then '' mul tileX
    if o.coords.x < (now_room().x * 16) - o.perimeter.x or o.unstoppable_by_screen then
    --
    --       '' object "x" is smaller than right bound, or is not stopped by physical bounds.
    --
    --       If check_walk( o, 1, only_looking Or recurring ) Or ( o->unstoppable_by_tile <> 0 )Then
      if check_walk(o, 1, only_looking or recurring) or (o.unstoppable_by_tile ~= 0) then
    --         '' object has open 'walkable path, or isn't stopped by unwalkable areas
    --
    --
    --         If check_against_entities ( 1, o ) <> 1 Or ( o->unstoppable_by_object ) Then
        if check_against_entities(1, o) ~= 0 or o.unstoppable_by_object then
    --
    --           '' object isn't colliding with another (impassable) object, or is not stopped by impassable objects
    --
    --           If only_looking = 0 Then
          if only_looking == 0 then
    --             '' execute
    --             ''
    --             o->coords.x += 1 * moment
            o.coords.x = o.coords.x + moment
    --
    --           End If
          end
    --
    --           mx = 1
          mx = 1
    --
    --         End If
        end
    --
    --       End If
      end
    --
    --     End If
    end
    --
  end
    --   Case 6
  if o.direction == 6 then
    --
    --
    --     If o->coords.y < ( now_room().y Shl 4 ) - o->perimeter.y Or ( o->unstoppable_by_screen ) Then '' mul tileY
    if o.coords.y < (now_room().y * 16) - o.perimeter.y or (o.unstoppable_by_screen) then
    --
    --       If check_walk( o, 2, only_looking Or recurring ) Or ( o->unstoppable_by_tile <> 0 )Then
      if check_walk(o, 2, only_looking or recurring) or (o.unstoppable_by_tile ~= 0) then
    --
    --         If check_against_entities ( 2, o ) <> 1 Or ( o->unstoppable_by_object ) Then
        if check_against_entities(2, o) ~= 1 or (o.unstoppable_by_object) then
    --
    --
    --           If only_looking = 0 Then
          if only_looking == 0 then
    --             '' execute
    --             ''
    --             o->coords.y += 1 * moment
            o.coords.y = o.coords.y + moment
    --
    --           End If
          end
    --
    --           my = 1
          my = 1
    --
    --         End If
        end
    --
    --       End If
      end
    --
    --     End If
    end
    --
    --     If o->coords.x < ( now_room().x Shl 4 ) - o->perimeter.x Or ( o->unstoppable_by_screen ) Then '' mul tileX
    if o.coords.x < (now_room().x * 16) - o.perimeter.x or o.unstoppable_by_screen then
    --
    --       '' object "x" is smaller than right bound, or is not stopped by physical bounds.
    --
    --       If check_walk( o, 1, only_looking Or recurring ) Or ( o->unstoppable_by_tile <> 0 )Then
      if check_walk(o, 1, only_looking or recurring) or (o.unstoppable_by_tile ~= 0) then
    --         '' object has open 'walkable path, or isn't stopped by unwalkable areas
    --
    --
    --         If check_against_entities ( 1, o ) <> 1 Or ( o->unstoppable_by_object ) Then
        if check_against_entities(1, o) ~= 0 or o.unstoppable_by_object then
    --
    --           '' object isn't colliding with another (impassable) object, or is not stopped by impassable objects
    --
    --           If only_looking = 0 Then
          if only_looking == 0 then
    --             '' execute
    --             ''
    --             o->coords.x += 1 * moment
            o.coords.x = o.coords.x + moment
    --
    --           End If
          end
    --
    --           mx = 1
          mx = 1
    --
    --         End If
        end
    --
    --       End If
      end
    --
    --     End If
    end
    --
  end
    --   Case 7
  if o.direction == 7 then
    --
    --     If o->coords.y < ( now_room().y Shl 4 ) - o->perimeter.y Or ( o->unstoppable_by_screen ) Then '' mul tileY
    if o.coords.y < (now_room().y * 16) - o.perimeter.y or (o.unstoppable_by_screen) then
    --
    --       If check_walk( o, 2, only_looking Or recurring ) Or ( o->unstoppable_by_tile <> 0 )Then
      if check_walk(o, 2, only_looking or recurring) or (o.unstoppable_by_tile ~= 0) then
    --
    --         If check_against_entities ( 2, o ) <> 1 Or ( o->unstoppable_by_object ) Then
        if check_against_entities(2, o) ~= 1 or (o.unstoppable_by_object) then
    --
    --
    --           If only_looking = 0 Then
          if only_looking == 0 then
    --             '' execute
    --             ''
    --             o->coords.y += 1 * moment
            o.coords.y = o.coords.y + moment
    --
    --           End If
          end
    --
    --           my = 1
          my = 1
    --
    --         End If
        end
    --
    --       End If
      end
    --
    end
    --
    --     If o->coords.x > 0 Or ( o->unstoppable_by_screen ) Then
    if o.coords.x > 0 or (o.unstoppable_by_screen) then
    --
    --
    --       If check_walk( o, 3, only_looking Or recurring ) Or ( o->unstoppable_by_tile <> 0 )Then
      if check_walk(o, 3, only_looking or recurring) or (o.unstoppable_by_tile ~= 0) then
    --
    --
    --         If check_against_entities ( 3, o ) <> 1 Or ( o->unstoppable_by_object ) Then
        if check_against_entities(3, o) ~= 1 or (o.unstoppable_by_object) then
    --
    --
    --           If only_looking = 0 Then
          if only_looking == 0 then
    --             '' execute
    --             ''
    --             o->coords.x -= 1 * moment
            o.coords.x = o.coords.x - moment
    --
    --           End If
          end
    --
    --           mx = 1
          mx = 1
    --
    --         End If
        end
    --
    --       End If
      end
    --
    --     End If
    end
    --
  end
    --
    -- Return ( mx Shl 16 ) Or my
  return bit.bor(bit.lshift(mx, 16), my)

end

  -- Function check_walk ( o As char_type Ptr, d As Integer, psfing = 0 ) Static
function check_walk(o, d, psfing)
  log.debug("check_walk called.")
  log.debug("psfing: "..psfing)
  psfing = psfing or 0
  --
  --   If ( o->coords.x < 0 ) Or ( o->coords.y < 0 ) Or ( ( o->coords.x + o->perimeter.x ) > ( now_room().x Shl 4 ) ) Or ( ( o->coords.y + o->perimeter.y ) > ( now_room().y Shl 4 ) ) Then
  if (o.coords.x < 0) or (o.coords.y < 0) or ((o.coords.x + o.perimeter.x) > (now_room().x * 16)) or ((o.coords.y + o.perimeter.y) > (now_room().y * 16)) then
  --     Return FALSE
    return false
  --
  --   End If
  end
  --
  --
  --   Dim As Integer x_offset_2, y_offset_2, x_tile_2, y_tile_2, quads_x, quads_y, x_aligned, y_aligned
  --   dim as= integer t_index
  local t_index
  --   Dim As Integer layer
  local layer
  --   Dim As Integer crawl_axis, crawl
  local crawl_axis, crawl
  --   Dim As Integer x_opt, y_opt
  local x_opt, y_opt
  --   Dim As Integer tile_free, psf_free
  local tile_free, psf_free = true, true
  --
  --   x_aligned = 0
  local x_aligned = 0
  --   y_aligned = 0
  local y_aligned = 0
  --
  --   x_tile_2 = Int( o->coords.x ) Shr 3
  local x_tile_2 = bit.rshift(math.floor(o.coords.x), 3)
  --log.debug("x_tile_2: "..x_tile_2)
  --   y_tile_2 = Int( o->coords.y ) Shr 3
  local y_tile_2 = bit.rshift(math.floor(o.coords.y), 3)
  --log.debug("y_tile_2: "..y_tile_2)
  --
  --   x_offset_2 = Int( o->coords.x ) And 7
  local x_offset_2 = bit.band(math.floor(o.coords.x), 7)
  --log.debug("x_offset_2: "..x_offset_2)
  --   y_offset_2 = Int( o->coords.y ) And 7
  local y_offset_2 = bit.band(math.floor(o.coords.y), 7)
  --log.debug("y_offset_2: "..y_offset_2)
  --
  --   quads_x = Int( o->perimeter.x ) Shr 3
  local quads_x = bit.rshift(math.floor(o.perimeter.x), 3)
  --log.debug("quads_x: "..quads_x)
  --   quads_y = Int( o->perimeter.y ) Shr 3
  local quads_y = bit.rshift(math.floor(o.perimeter.y), 3)
  --log.debug("quads_y: "..quads_y)
  --
  --   If x_offset_2 <> 0 Then
  if x_offset_2 ~= 0 then
  --     quads_x += 1
    quads_x = quads_x + 1
  --
  --   Else
  else
  --     x_aligned = 1
    x_aligned = 1
  --
  --   End If
  end
  --
  --   If y_offset_2 <> 0 Then
  if y_offset_2 ~= 0 then
  --     quads_y += 1
    quads_y = quads_y + 1
  --
  --   Else
  else
  --     y_aligned = 1
    y_aligned = 1
  --
  --   End If
  end
  --
  --   '' prime
  --   if psfing then
  if psfing ~= 0 then
    log.debug("psf_free is true.")
  --     psf_free = TRUE
    psf_free = true
  --
  --   else
  else
  --     tile_free = TRUE
    tile_free = true
    log.debug("tile_free is true.")
  --
  --   end if
  end
  --
  --     Select Case d Mod 2
  --
  --       Case 0
  if d % 2 == 0 then
  --
  --         crawl_axis = quads_x
    crawl_axis = quads_x
  --
  --       Case 1
  elseif d % 2 == 1 then
  --
  --         crawl_axis = quads_y
    crawl_axis = quads_y
  --
  --     End Select
  end
  --
  --
  --     For layer = 0 To 2
  for layer = 1, 3 do
  --
  --
  --       For crawl = 0 To crawl_axis - 1
    for crawl = 0, crawl_axis - 1 do
  --
  --
  --         Select Case d
  --
  --
  --           Case 0
      if d == 0 then
  --
  --             x_opt = ( x_tile_2 + crawl )
        x_opt = (x_tile_2 + crawl)
  --             y_opt = ( y_tile_2 - y_aligned )
        y_opt = (y_tile_2 - y_aligned)
  --
  --           Case 1
      elseif d == 1 then
  --
  --             x_opt = ( quads_x - 1 ) + x_tile_2 + x_aligned
        x_opt = (quads_x - 1) + x_tile_2 + x_aligned
  --             y_opt = ( y_tile_2 + crawl )
        y_opt = (y_tile_2 + crawl)
  --
  --           Case 2
      elseif d == 2 then
  --
  --             x_opt = ( x_tile_2 + crawl )
        x_opt = (x_tile_2 + crawl)
  --             y_opt = ( quads_y - 1 ) + y_tile_2 + y_aligned
        y_opt = (quads_y - 1) + y_tile_2 + y_aligned
  --
  --           Case 3
      elseif d == 3 then
  --
  --             x_opt = ( x_tile_2 - x_aligned )
        x_opt = (x_tile_2 - x_aligned)
  --             y_opt = ( y_tile_2 + crawl )
        y_opt = (y_tile_2 + crawl)
  --
  --
  --         End Select
      end
  --
  --         t_index = ( ( y_opt Shl 3 ) Shr 4 ) * now_room().x + ( ( x_opt Shl 3 ) Shr 4 )
      t_index = bit.rshift(bit.lshift(y_opt, 3), 4) * now_room().x + bit.rshift(bit.lshift(x_opt, 3), 4) + 1
      --log.debug("t_index: "..t_index)
  --
  --         If Bit( now_room().layout[layer][t_index], 15 - quad_calc( x_opt, y_opt ) ) <> 0 Then
      local tile = now_room().layout[layer][t_index]
      --log.debug("tile: "..tile)
      --log.debug("bitstring: "..bitstring(tile))
      local quad = quad_calc(x_opt, y_opt)
      --log.debug("quad: "..quad)
      local bit_index = 15 - quad
      --log.debug("bit_index: "..bit_index)
      if testbit(tile, bit_index) ~= 0 then
        --log.debug("bit was set.")
  --           if psfing then
        if psfing then
          log.debug("psf_free set to false.")
  --             psf_free = FALSE
          psf_free = false
  --
  --           else
        else
          log.debug("tile_free set to false.")
  --             tile_free = FALSE
          tile_free = false
  --
  --           end if
        end
  --
  --         End If
      else
        --log.debug("bit was not set.")
      end
  --
  --       Next
    end
  --
  --     Next
  end
  --
  --
  --   If tile_free = FALSE Then
  --
  --     If psfing = FALSE Then
  --
  --       If o->unique_id = u_lynn Then
  --         check_psf( o, d )
  --
  --       Else
  --         If o->unique_id = u_pushrock Then
  --           check_psf( o, d )
  --
  --         End If
  --
  --       End If
  --
  --     End If
  --
  --   End If
  --
  --
  --   if psfing then

  if psfing then
  --     Return psf_free
    return psf_free
  --   else
  else
  --
  --     Return tile_free
    return tile_free
  --   end if
  end
  --
  --
  --
  -- End Function

end

-- Function check_against_entities( d As Integer = 0, o As char_type Ptr ) As Integer' Static
function check_against_entities(d, o)
  d = d or 0
--
--
--   Dim As Integer cycle, relay
--
--
--   With now_room()
--
--     If .enemies = 0 Then
--       '' there are no objects to collide with in this room
--       Return 0
--
--     End If
--
--     For cycle = 0 To .enemies - 1
--       '' cycle thru enemies
--
--       If o->num <> .enemy[cycle].num Then
--         '' if this "o" isn't this enemy, then check it against this enemy
--         relay = check_against( o, .enemy, cycle, d )
--         If relay Then Return relay
--
--       End If
--
--     Next
--
--
--
--     For cycle = 0 To .temp_enemies - 1
--       '' cycle through temp enemies
--
--       If o->num <> .temp_enemy( cycle ).num Then
--         '' if this "o" isn't this temp enemy, then check it against this temp enemy
--         relay = check_against( o, Varptr( .temp_enemy( 0 ) ), cycle, d )
--         If relay Then Return relay
--
--       End If
--
--     Next
--
--   End With
--
--
--
--   If o->unique_id <> u_lynn Then
--     '' if this "o" isn't lynn, check the "o" against her
--
--     If llg( hero_only ).attacking = 0 Then
--       relay = check_against( o, Varptr( llg( hero ) ), 0, d )
--       If relay Then Return relay
--
--     End If
--
--   End If
--
--
--
-- End Function
  --FIXME: Returning 0 while porting just so we can get something moving without
  --collision checks. Remove.
  return 0
end
