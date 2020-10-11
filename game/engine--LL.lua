require("game/audio")
require("game/binary_objects")
require("game/engine--object")
require("game/engine--object_damage")
require("game/macros")
require("game/utils")
require("game/utility")

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
function set_up_room_enemies(enemies, enemy)
    -- Dim As Integer setup
    --
    --
    -- For setup = 0 To enemies - 1
  for setup = 0, enemies - 1 do
    --   '' cycle thru these enemies
    --
    --   With enemy[setup]
    local with0 = enemy[setup]
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
    LLSystem_CopyNewObject(with0)
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
    with0.num = setup
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
    if ll_global.hero_only.hasItem[0] ~= 0 then
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
  --log.debug("walk speed: "..ll_global.hero.walk_speed)
  if ll_global.hero.on_ice == 0 then
-- --       .coords.x = Int( .coords.x )
--     ll_global.hero.coords.x = math.floor(ll_global.hero.coords.x)
-- --       .coords.y = Int( .coords.y )
--     ll_global.hero.coords.y = math.floor(ll_global.hero.coords.y)
-- --
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
    --log.debug("action lock was 0")
--       '' lynn can do actions
--
--       If llg( hero_only ).attacking = 0 Then
    if ll_global.hero_only.attacking == 0 then
      --log.debug("attacking was 0")
--         '' lynn is not attacking
--
--         If (.fly_count = 0) Then
      if ll_global.hero.fly_count == 0 then
        --log.debug("fly_count was 0")
--           '' lynn is not flying back
--
--           If .dead = 0 Then
        if ll_global.hero.dead == 0 then
          --log.debug("dead was 0")
--             '' lynn is not dead
--
--             If .switch_room = -1 Then
          if ll_global.hero.switch_room == -1 then
            --log.debug("switch_room is -1")
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
            --NOTE: We are wiring up hard-coded keys directly to their callbacks, here,
            --completely ignoring the key configuration system or porting it. We will
            --add our own key configuration system much later on in development.
            if bpressed("x") then
              log.debug("Pressed attack key.")
              atk_key_in_sub()
            end
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
      --log.debug("unique_id"..ll_global.hero.unique_id)
      --log.debug("u_steelstrider: "..u_steelstrider)
      if ll_global.hero.unique_id ~= u_steelstrider then
        --log.debug("go grip")
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
    --log.debug("ll_global.hero.on_ice: "..ll_global.hero.on_ice)
    --log.debug("Hero is on ice, calling __calc_slide.")
--
--         __calc_slide( VarPtr( llg( hero ) ) )
    __calc_slide(ll_global.hero)
--
--
--       Else
  else
    --log.debug("Hero is on not on ice, calling __stop_grip.")
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
      ll_global.hero.frame = 0
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
        if ll_global.hero.frame ~= 0 then
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
    hero_attack(ll_global.hero)
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
  --log.debug("dir_keys entered.")
--
--   Static As Double SLIDE_CONSTANT = .02
  local SLIDE_CONSTANT = .02
--
--   With llg( hero )
--
--     .momentum_history.i( 0 ) = 0
  ll_global.hero.momentum_history.i[0] = 0
--     .momentum_history.i( 1 ) = 0
  ll_global.hero.momentum_history.i[1] = 0
--     .momentum_history.i( 2 ) = 0
  ll_global.hero.momentum_history.i[2] = 0
--     .momentum_history.i( 3 ) = 0
  ll_global.hero.momentum_history.i[3] = 0
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
  act_enemies(now_room().enemy)
  --
  --   End If
  --   If .temp_enemies > 0 Then
  --     act_enemies( .temp_enemies, Varptr( .temp_enemy( 0 ) ) )
  --
  --   End If
  --
  -- End With
end

-- Private Sub hero_attack( hr As _char_type Ptr )
function hero_attack(hr)
  log.debug("hero_attack called.")
--
--
--   With *hr
--
--     '' increment this function loop
--     .funcs.current_func[.attack_state] += .funcs.func[.attack_state][.funcs.current_func[.attack_state]] ( hr )
  --log.debug("hr.attack_state is: "..hr.attack_state)
  --log.debug("hr.funcs.current_func[hr.attack_state]: "..hr.funcs.current_func[hr.attack_state])
  hr.funcs.current_func[hr.attack_state] = hr.funcs.current_func[hr.attack_state] + hr.funcs.func[hr.attack_state][hr.funcs.current_func[hr.attack_state]](hr)
--
--
--     Dim As Integer call_back
  local call_back = false
--     call_back = ( .funcs.current_func[.attack_state] >= .funcs.func_count[.attack_state] )
  call_back = (hr.funcs.current_func[hr.attack_state] >= hr.funcs.func_count[hr.attack_state])
--
--     If call_back Then
  if call_back == true then
--       '' lynn called back
--
--       .funcs.current_func[.attack_state] = 0
    hr.funcs.current_func[hr.attack_state] = 0
--       llg( hero_only ).attacking = 0
    ll_global.hero_only.attacking = 0
--       llg( hero ).psycho = 0
    ll_global.hero.psycho = 0
--
--
--     End If
  end
--
--   End With
--
--
-- End Sub
end

function act_enemies(enemies)
  -- Dim As Integer do_stuff
  --
  -- For do_stuff = 0 To _enemies - 1
  for do_stuff = 0, #enemies - 1 do
  --
  --
  --   With _enemy[do_stuff]
    local enemy = enemies[do_stuff]
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
          if ll_global.hero_only.attacking ~= 0 then
  --             LLObject_MAINAttack( 1, Varptr( _enemy[do_stuff] ), Varptr( llg( hero ) ) )
            -- NOTE: The only place this function is called, the count _enemies is passed
            -- in as 1, and the current enemy in act_enemies is passed in as _enemy. Therefore,
            -- we are simplifying this to just pass the enemy in to begin with and eliminate the loop.
            LLObject_MAINAttack(enemy, ll_global.hero)
  --
  --           End If
          end
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
          if enemy.hurt ~= 0 then
            log.debug("This enemy is showing damage effects")
  --             '' this enemy is showing damage effects
  --
  --             If ( .unique_id = u_dyssius ) Or ( .unique_id = u_steelstrider ) Then
            if (enemy.unique_id == u_dyssius) or (enemy.unique_id == u_steelstrider) then
  --
  --             Else
            else
  --
  --               If  .funcs.current_func[.funcs.active_state] = .funcs.func_count[.funcs.active_state] Then
              if enemy.funcs.current_func[enemy.funcs.active_state] == enemy.funcs.func_count[enemy.funcs.active_state] then
                log.debug("The enemy called back (damage is done)")
  --                 '' the enemy called back (damage is done)
  --
  --                 LLObject_ShiftState( Varptr( _enemy[do_stuff] ), .reset_state )
                LLObject_ShiftState(enemy, enemy.reset_state)
  --
  --                 If .unique_id = u_ferus Then
                if enemy.unique_id == u_ferus then
  --
  --                   LLObject_ClearProjectiles( _enemy[do_stuff] )
                  LLObject_ClearProjectiles(enemy)
  --                   .radius = Timer
                  enemy.radius = timer
  --
  --
  --                 End If
                end
  --
  --                 If .unique_id = u_grult Then
                if enemy.unique_id == u_grult then
  --
  --                   LLObject_ShiftState( Varptr( _enemy[do_stuff] ), .stun_state )
                  LLObject_ShiftState(enemy, enemy.stun_state)
  --                   .funcs.current_func[.funcs.active_state] = 2
                  enemy.funcs.current_func[enemy.funcs.active_state] = 2
  --
  --                 End If
                end
  --
  --                 LLObject_ClearDamage( Varptr( _enemy[do_stuff] ) )
                LLObject_ClearDamage(enemy)
  --                 .flash_count = 0
                enemy.flash_count = 0
  --                 .flash_timer = 0
                enemy.flash_timer = 0
  --                 .invisible = 0
                enemy.invisible = 0
  --
  --
  --               End If
              end
  --
  --             End If
            end
  --
  --           End If
          end
  --
  --           If .funcs.current_func[.funcs.active_state] = .funcs.func_count[.funcs.active_state] Then
          if enemy.funcs.current_func[enemy.funcs.active_state] == enemy.funcs.func_count[enemy.funcs.active_state] then
  --             '' if function block reaches end, return to beginning.
  --
  --             .funcs.current_func[.funcs.active_state] = 0
            enemy.funcs.current_func[enemy.funcs.active_state] = 0
  --
  --           End If
          end
  --
  --
  --           If .dead = 0 Then
          if enemy.dead == 0 then
  --             '' entity is not dead
  --
  --             If .hp <= 0 Then
            if enemy.hp <= 0 then
  --               '' entity is below the hp limit (marked for death)
  --
  --
  --
  --               If .dead_sound <> 0 Then
              if enemy.dead_sound ~= 0 then
  --                 play_sample( llg( snd )[.dead_sound] )
                ll_global.snd[enemy.dead_sound]:play()
  --
  --               End If
              end
  --
  --               LLObject_ShiftState( Varptr( _enemy[do_stuff] ), _enemy[do_stuff].death_state )
              LLObject_ShiftState(enemy, enemy.death_state)
  --
  --             End If
            end
  --
  --             If .dead = 0 Then
            if enemy.dead == 0 then
  --               If .froggy <> 0 Then
              if enemy.froggy ~= 0 then
  --                 '' this entity can become mad
  --
  --
  --                 If ( .mad = 0 ) Then
                if (enemy.mad == 0) then
  --                   '' entity is not mad
  --
  --                   If ( .funcs.active_state < .reset_state ) Then
                  if (enemy.funcs.active_state < enemy.reset_state) then
  --
  --                     '' entity is not resetting
  --
                    --TODO: Port proximity detection. Don't know what this is yet.
  --                     '' implicit proximity detection
  --                     .funcs.active_state = in_proximity( Varptr( _enemy[do_stuff] ) )
  --
  --                   End If
                  end
  --
  --                 End If
                end
  --
  --               End If
              end
  --
  --               If .mad <> 0 Then
              if enemy.mad ~= 0 then
  --                 '' entity is mad
  --
                --TODO: Port proximity logic.
  --                 '' see if its far enough to get a reset
  --                 .funcs.active_state = out_proximity( Varptr( _enemy[do_stuff] ) )
  --
  --               End If
              end
  --
  --             End If
            end
  --
  --           End If
          end
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
          if enemy.dmg.id ~= 0 then
            log.debug("Enemy was hit by lynn.")
  --             '' enemy was hit by lynn
  --
  --             __flashy( Varptr( _enemy[do_stuff] ) )
            __flashy(enemy)
  --
  --           End If
          end
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
        if check_against_entities(1, o) ~= 1 or o.unstoppable_by_object then
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
  --log.debug("check_walk called.")
  --log.debug("psfing: "..psfing)
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
    --log.debug("psf_free is true.")
  --     psf_free = TRUE
    psf_free = true
  --
  --   else
  else
  --     tile_free = TRUE
    tile_free = true
    --log.debug("tile_free is true.")
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
  for layer = 0, 2 do
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
        if psfing ~= 0 then
          --log.debug("psf_free set to false.")
  --             psf_free = FALSE
          psf_free = false
  --
  --           else
        else
          --log.debug("tile_free set to false.")
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
  if tile_free == false then
  --
  --     If psfing = FALSE Then
    if psfing == 0 then
  --
  --       If o->unique_id = u_lynn Then
      if o.unique_id == u_lynn then
  --         check_psf( o, d )
        check_psf(o, d)
  --
  --       Else
      else
  --         If o->unique_id = u_pushrock Then
        if o.unique_id == u_pushrock then
  --           check_psf( o, d )
          check_psf(o, d)
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
  --   End If
  end
  --
  --
  --   if psfing then

  if psfing ~= 0 then
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
  local cycle, relay = 0, 0
--
--
--   With now_room()
  local with0 = now_room()
--
--     If .enemies = 0 Then
  if with0.enemies == 0 then
--       '' there are no objects to collide with in this room
--       Return 0
    return 0
--
--     End If
  end
--
--     For cycle = 0 To .enemies - 1
  for cycle = 0, with0.enemies - 1 do
--       '' cycle thru enemies
--
--       If o->num <> .enemy[cycle].num Then
    if o.num ~= with0.enemy[cycle].num then
      log.debug("Proceeding to call check_against")
--         '' if this "o" isn't this enemy, then check it against this enemy
--         relay = check_against( o, .enemy, cycle, d )
      relay = check_against({[0] = o}, with0.enemy, cycle, d)
--         If relay Then Return relay
      if relay then return relay end
--
--       End If
    end
--
--     Next
  end
--
--
--
--     For cycle = 0 To .temp_enemies - 1
  for cycle = 0, with0.temp_enemies - 1 do
--       '' cycle through temp enemies
--
--       If o->num <> .temp_enemy( cycle ).num Then
    if o.num ~= with0.temp_enemy[cycle].num then
--         '' if this "o" isn't this temp enemy, then check it against this temp enemy
--         relay = check_against( o, Varptr( .temp_enemy( 0 ) ), cycle, d )
      relay = check_against({[0] = o}, with0.temp_enemy, cycle, d)
--         If relay Then Return relay
      if relay then return relay end
--
--       End If
    end
--
--     Next
  end
--
--   End With
--
--
--
--   If o->unique_id <> u_lynn Then
  if o.unique_id ~= u_lynn then
--     '' if this "o" isn't lynn, check the "o" against her
--
--     If llg( hero_only ).attacking = 0 Then
    if ll_global.hero_only.attacking == 0 then
--       relay = check_against( o, Varptr( llg( hero ) ), 0, d )
      relay = check_against({[0] = o}, {[0] = ll_global.hero}, 0, d)
--       If relay Then Return relay
      if relay then return relay end
--
--     End If
    end
--
--   End If
  end
--
--
--
  return 0
-- End Function
end

-- Function check_against( o As char_type Ptr, othr As char_type Ptr, check As Integer, d As Integer ) Static
function check_against(o, othr, check, d)
  --log.debug("othr: "..(othr and "exists" or "nil"))
--
--
--   #Define LLObject_Impassable(__THISCHAR__,__FACE__)          _
  function LLObject_Impassable(__THISCHAR__, __FACE__)
--                                                                                                                                  _
--     ( IIf( __THISCHAR__.##anim[__THISCHAR__.##current_anim]->frame[LLObject_CalculateFrame(__THISCHAR__)].faces = 0,             _
    return __THISCHAR__.anim[__THISCHAR__.current_anim].frame[LLObject_CalculateFrame(__THISCHAR__)].faces == 0 and
--                                                                                                                                  _
--     __THISCHAR__.##impassable,                                                                                                   _
--                                                                                                                                  _
      __THISCHAR__.impassable or
--     __THISCHAR__.##anim[__THISCHAR__.##current_anim]->frame[LLObject_CalculateFrame(__THISCHAR__)].face[__FACE__].impassable ) )                                                                                                   _
      __THISCHAR__.anim[__THISCHAR__.current_anim].frame[LLObject_CalculateFrame(__THISCHAR__)].face[__FACE__].impassable
--
  end
--
--
--   '' moving object to static object collision detection
--
  --NOTE: Function = 0 sets return value to 0, but we just return 0
  --at the end instead---Should work the same, but just keeping this
  --note here in case...
--   Function = 0
--
--   Dim As Vector opty
  local opty = create_vector()
--   Dim As vector_pair m, n
  local m, n = create_vector_pair(), create_vector_pair()
--   Dim As Integer faces, faces2
  local faces, faces2 = 0, 0
--   Dim As Integer check_fields, check_fields2
  local check_fields, check_fields2 = 0, 0
--
--   dim as integer res
--   res = 0
  local res = 0
--
--   opty.x = 0
  opty.x = 0
--   opty.y = 0
  opty.y = 0
--
--   Select Case d
--
--     Case 0
  if d == 0 then
--       opty.y = -1
    opty.y = -1
--
--     Case 1
  elseif d == 1 then
--       opty.x = 1
    opty.x = 1
--
--     Case 2
  elseif d == 2 then
--       opty.y = 1
    opty.y = 1
--
--     Case 3
  elseif d == 3 then
--       opty.x = -1
    opty.x = -1
--
--
--   End Select
  end
--
--   o->frame_check          = LLObject_CalculateFrame( o[0] )
  o[0].frame_check = LLObject_CalculateFrame(o[0])
--   othr[check].frame_check = LLObject_CalculateFrame( othr[check] )
  othr[check].frame_check = LLObject_CalculateFrame(othr[check])
--
--   With othr[check]:
  local with0 = othr[check]
--     With .anim[.current_anim]->frame[.frame_check]:
  local with1 = with0.anim[with0.current_anim].frame[with0.frame_check]
--       faces  = IIf( .faces = 0, 0, .faces -1 ):
  faces = with1.faces == 0 and 0 or with1.faces - 1
--     End With:
--   End With

--   With *( o )     :
  with0 = o[0]
--     With .anim[.current_anim]->frame[.frame_check]:
  with1 = with0.anim[with0.current_anim].frame[with0.frame_check]
--       faces2 = IIf( .faces = 0, 0, .faces -1 ):
  faces2 = with1.faces == 0 and 0 or with1.faces - 1
--     End With:
--   End With
--
--   For check_fields = 0 To faces
  for check_fields = 0, faces do
--
--     For check_fields2 = 0 To faces2
    for check_fields2 = 0, faces2 do
--
--       m.u = V2_Add( o->coords, opty )
      m.u = V2_Add(o[0].coords, opty)
--       n.u = othr[check].coords
      n.u = othr[check].coords
--
--       calc_positions( o, m, check_fields2 )
      calc_positions(o[0], m, check_fields2)
--       calc_positions( Varptr( othr[check] ), n, check_fields )
      calc_positions(othr[check], n, check_fields)
--
--
--       If check_bounds( m, n ) = 0 Then
      if check_bounds(m, n) == 0 then
--
--         If o->unique_id = u_charger Then
        if o.unique_id == u_charger then
--
--           If othr[check].unique_id = u_charger Then
          if othr[check].unique_id == u_charger then
--             '' kill both!
--
--             o->hp = 0
            o[0].hp = 0
--             othr[check].hp = 0
            othr[check].hp = 0
--
--             return 0
            return 0
--
--           End If
          end
--
--         End If
        end
--
--         res = (                                                                                                                                       _
           res = (
--                 IIf(                                                                                                                                  _
                   iif(
--                      ( ( o[0].unique_id = u_dyssius ) Or ( o[0].unique_id = u_steelstrider ) ) And ( othr[check].unique_id = u_lynn ),                _
                        (( o[0].unique_id == u_dyssius ) or (o[0].unique_id == u_steelstrider ) ) and (othr[check].unique_id == u_lynn ),

--                      1,                                                                                                                               _
                        1,
--                      IIf(                                                                                                                             _
                        iif(

--                           IIf(                                                                                                                        _
                             iif(
--                                (                                                                                                                      _
                                  (
--                                  ( LLObject_Impassable( o[0], check_fields2 ) = 0 ) And ( LLObject_Impassable( othr[check], check_fields ) = 0 )      _
                                    ( LLObject_Impassable( o[0], check_fields2) == 0 ) and ( LLObject_Impassable( othr[check], check_fields) == 0 )
--                                                                              Or                                                                       _
                                                                                or
--                                         ( ( o[0].dead ) Or ( othr[check].dead ) Or ( othr[check].unique_id = u_gold ) )                               _
                                           ( ( o[0].dead ) or ( othr[check].dead ) or (othr[check].unique_id == u_gold ) )
--                                ),                                                                                                                     _
                                  ),
--                                IIf(                                                                                                                   _
                                  iif(
--                                     (                                                                                                                 _
                                       (
--                                       ( Not ( othr[check].unique_id = u_chest         ) ) And                                                         _
                                         ( not ( othr[check].unique_id == u_chest        ) ) and
--                                       ( Not ( othr[check].unique_id = u_bluechest     ) ) And                                                         _
                                         ( not ( othr[check].unique_id == u_bluechest    ) ) and
--                                       ( Not ( othr[check].unique_id = u_bluechestitem ) )                                                             _
                                         ( not (othr[check].unique_id == u_bluechestitem ) )
--                                     ),                                                                                                                _
                                       ),
--                                     0,                                                                                                                _
                                       0,
--                                     1                                                                                                                 _
                                       1
--                                   ),                                                                                                                  _
                                     ),
--                                IIf(                                                                                                                   _
                                  iif(
--                                     ( othr[check].unique_id = u_sparkle ) Or ( othr[check].unique_id = u_gbutton ) Or ( o[0].unique_id = u_godstat ), _
                                       (othr[check].unique_id == u_sparkle ) or (othr[check].unique_id == u_gbutton ) or (o[0].unique_id == u_godstat ),
--                                     0,                                                                                                                _
                                       0,
--                                     1                                                                                                                 _
                                       1
--                                   )                                                                                                                   _
                                     )
--                              ),                                                                                                                       _
                                ),
--                           IIf( othr[check].unstoppable_by_object, 0, IIf( o->unstoppable_by_object, 0, 1 ) ),                                         _
                             iif( othr[check].unstoppable_by_object, 0, iif( o[0].unstoppable_by_object, 0, 1 ) ),
--                           0                                                                                                                           _
                             0
--                         )                                                                                                                             _
                           )
--                    )                                                                                                                                  _
                      )
--               )
                 )
--
--         If res = 1 Then
        if res == 1 then
--
--           return res
          return res
--
--         end if
        end
--
--       End If
      end
--
--     Next
    end
--
--   Next
  end
--
--
  return 0
-- End Function
end

-- Sub calc_positions( obj As char_type Ptr, v As vector_pair, _face As Integer )
function calc_positions(obj, v, _face)
--
--   With obj->anim[obj->current_anim]->frame[obj->frame_check]
  local with0 = obj.anim[obj.current_anim].frame[obj.frame_check]
--
--     If .faces = 0 Then
  if with0.faces == 0 then
--
--       v.v = obj->perimeter
    v.v = obj.perimeter:clone()
--
--     Else
  else
--
--       v.u.x += .face[_face].x - obj->animControl[obj->current_anim].x_off
    v.u.x = v.u.x + with0.face[_face].x - obj.animControl[obj.current_anim].x_off
--       v.u.y += .face[_face].y - obj->animControl[obj->current_anim].y_off
    v.u.y = v.u.y + with0.face[_face].y - obj.animControl[obj.current_anim].y_off
--
--       v.v.x = .face[_face].w
    v.v.x = with0.face[_face].w
--       v.v.y = .face[_face].h
    v.v.y = with0.face[_face].h
--
--     End If
  end
--
--   End With
--
-- End Sub
end

-- Sub check_psf( o As char_type Ptr, d As Integer )
function check_psf(o, d)
  --log.debug("check_psf entered.")
--
--
--   Dim As Integer layercheck, pnts, tmp_dir, po_x, po_y, pol, tmp_d
  local layercheck, pnts, tmp_dir, po_x, po_y, pol, tmp_d = 0, 0, 0, 0, 0, 0, 0
--   Dim As Integer tx_2 = ( 8 ), ty_2 = ( 8 )
  local tx_2, ty_2 = 8, 8
--   Dim As Integer x_crawl, y_crawl
  local x_crawl, y_crawl = 0, 0
--
--   in_dir_small( d )
  d = in_dir_small(d)
--
--   tmp_dir = o->direction
  tmp_dir = o.direction
--   tmp_d = d
  tmp_d = d
--
--   If ( d And 1 ) = 0 Then
  if bit.band(d, 1) == 0 then
--     If rl_key() Then Exit sub
    if rl_key() then
      --log.debug("rl_key() true so return")
      return
    end
--     pnts = ( o->perimeter.x Shr 3 ) '' div tx_2
    pnts = bit.rshift(o.perimeter.x, 3)
--     x_crawl = tx_2
    x_crawl = tx_2
--
--   Else
  else
--     If ud_key() Then Exit Sub
    if ud_key() then
      --log.debug("ud_key() true so return")
      return
    end
--     pnts = ( o->perimeter.y Shr 3 ) '' div ty_2
    pnts = bit.rshift(o.perimeter.y, 3)
--     y_crawl = ty_2
    y_crawl = ty_2
--
--   End If
  end
--
--   po_x = Int( o->coords.x )
  po_x = math.floor(o.coords.x)
--   po_y = Int( o->coords.y )
  po_y = math.floor(o.coords.y)
--
--   Select Case d
--
--     Case 0
--
--     Case 1
  if d == 1 then
--
--       po_x += Int( o->perimeter.x ) - tx_2
    po_x = po_x + math.floor(o.perimeter.x) - tx_2
--
--     Case 2
  elseif d == 2 then
--
--       po_x += Int( o->perimeter.x )
    po_x = po_x + math.floor(o.perimeter.x)
--       po_y += Int( o->perimeter.y ) - ty_2
    po_y = po_y + math.floor(o.perimeter.y) - ty_2
--
--     Case 3
  elseif d == 3 then
--
--       po_y += Int( o->perimeter.y )
    po_y = po_y + math.floor(o.perimeter.y)
--
--
--   End Select
  end
--
--
--   Select Case d Shr 1
--
--     Case 0
  if bit.rshift(d, 1) == 0 then
--
--       pol = 1
    pol = 1
--
--     Case Else
  else
--
--       pol = -1
    pol = -1
--
--   End Select
  end
--
--
--   For layercheck = 0 To 2
  for layercheck = 0, 2 do
--
--     Dim As tile_quad slider, chkr
    local slider, chkr = create_tile_quad(), create_tile_quad()
--     Dim As Integer crawl, x_opt, y_opt, po_quad, mi_quad, op_quad
    local crawl, x_opt, y_opt, po_quad, mi_quad, op_quad = 0, 0, 0, 0, 0, 0
--
--     crawl = 0
    crawl = 0
--
--     x_opt = ( crawl * x_crawl * pol ) + po_x
    x_opt = (crawl * x_crawl * pol) + po_x
--     y_opt = ( crawl * y_crawl * pol ) + po_y
    y_opt = (crawl * y_crawl * pol) + po_y
--
--     slider.x = ( x_opt ) Shr 4 '' div tileX
    slider.x = bit.rshift(x_opt, 4)
--     slider.y = ( y_opt ) Shr 4 '' div tileY
    slider.y = bit.rshift(y_opt, 4)
--     slider.quad = quad_calc( ( x_opt ) Shr 3, ( y_opt ) Shr 3 ) '' div tx_2, ty_2
    slider.quad = quad_calc(bit.rshift(x_opt, 3), bit.rshift(y_opt, 3))
--
--     chkr = quad_seek( slider, d )
    chkr = quad_seek(slider, d)
--     po_quad = Bit( now_room().layout[layercheck][chkr.y * now_room().x + chkr.x], 15 - chkr.quad )
    po_quad = testbit(now_room().layout[layercheck][chkr.y * now_room().x + chkr.x + 1], 15 - chkr.quad)
--
--
--     For crawl = 1 To pnts - 1
    for crawl = 1, pnts - 1 do
--
--       x_opt = ( crawl * x_crawl * pol ) + po_x
      x_opt = (crawl * x_crawl * pol) + po_x
--       y_opt = ( crawl * y_crawl * pol ) + po_y
      y_opt = (crawl * y_crawl * pol) + po_y
--
--       slider.x = ( x_opt ) Shr 4 '' div tileX
      slider.x = bit.rshift(x_opt, 4)
--       slider.y = ( y_opt ) Shr 4 '' div tileY
      slider.y = bit.rshift(y_opt, 4)
--       slider.quad = quad_calc( ( x_opt ) Shr 3, ( y_opt ) Shr 3 ) '' div tx_2, ty_2
      slider.quad = quad_calc(bit.rshift(x_opt, 3), bit.rshift(y_opt, 3))
--
--       chkr = quad_seek( slider, d )
      chkr = quad_seek(slider, d)

      table.insert(dbgrects, {x = chkr.x, y = chkr.y})
--       mi_quad Or = Bit( now_room().layout[layercheck][chkr.y * now_room().x + chkr.x], 15 - chkr.quad )
      mi_quad = bit.bor(mi_quad, testbit(now_room().layout[layercheck][chkr.y * now_room().x + chkr.x + 1], 15 - chkr.quad))
--
--     Next
    end
--
--     '' unnecessary syntactically, but it's clarification that counts, kids.
--     crawl = pnts
    crawl = pnts
--
--     x_opt = ( crawl * x_crawl * pol ) + po_x
    x_opt = (crawl * x_crawl * pol) + po_x
--     y_opt = ( crawl * y_crawl * pol ) + po_y
    y_opt = (crawl * y_crawl * pol) + po_y
--
--     slider.x = ( x_opt ) Shr 4
    slider.x = bit.rshift(x_opt, 4)
--     slider.y = ( y_opt ) Shr 4
    slider.y = bit.rshift(y_opt, 4)
--     slider.quad = quad_calc( ( x_opt ) Shr 3, ( y_opt ) Shr 3 )
    slider.quad = quad_calc(bit.rshift(x_opt, 3), bit.rshift(y_opt, 3))
--
--     chkr = quad_seek( slider, d )
    chkr = quad_seek(slider, d)

    table.insert(dbgrects, {x = chkr.x, y = chkr.y})
--     op_quad = Bit( now_room().layout[layercheck][chkr.y * now_room().x + chkr.x], 15 - chkr.quad )
    op_quad = testbit(now_room().layout[layercheck][chkr.y * now_room().x + chkr.x + 1], 15 - chkr.quad)
--
--
--     d = tmp_d
    d = tmp_d
--     '' got all the quads
--
--
--     If ( po_quad <> 0 ) And ( op_quad <> 0 ) Then
    if (po_quad ~= 0) and (op_quad ~= 0) then
      --log.debug("Returning")
--       Exit sub
      return
--
--     End If
    end
--
--
--     If ( po_quad <> 0 ) And ( op_quad = 0 ) Then
    if (po_quad ~= 0) and (op_quad == 0) then
--     '' clockwise
--       o->direction += 1
      --log.debug("cw before o.direction: "..o.direction)
      o.direction = o.direction + 1
--       in_dir_small( o->direction )
      o.direction = in_dir_small(o.direction)
      --log.debug("cw after o.direction: "..o.direction)
--
--       o->is_psfing = ( move_object( o, , o->momentum.i( tmp_dir ), 1 ) <> 0 )
      o.is_psfing = move_object(o, nil, o.momentum.i[tmp_dir], 1) ~= 0
--       o->direction =  tmp_dir
      o.direction = tmp_dir
--
--       Exit Sub
      return
--
--     End If
    end
--
--
--     If ( po_quad = 0 ) And ( op_quad <> 0 ) Then
    if po_quad == 0 and op_quad ~= 0 then
--       '' counter clockwise
--       o->direction -= 1
      --log.debug("ccw before o.direction: "..o.direction)
      o.direction = o.direction - 1
--       in_dir_small( o->direction )
      o.direction = in_dir_small(o.direction)
      --log.debug("ccw after o.direction: "..o.direction)
--
--       o->is_psfing = ( move_object( o, , o->momentum.i( tmp_dir ), 1 ) <> 0 )
      o.is_psfing = move_object(o, nil, o.momentum.i[tmp_dir], 1) ~= 0
--       o->direction =  tmp_dir
      o.direction = tmp_dir
--
--       Exit Sub
      return
--
--     End If
    end
--
--
--     If ( po_quad = 0 ) And ( op_quad = 0 ) And ( mi_quad <> 0 ) Then
    if (po_quad == 0) and (op_quad == 0) and (mi_quad ~= 0) then
--     '' clockwise
--       o->direction += 1
      --log.debug("cw3 before o.direction: "..o.direction)
      o.direction = o.direction + 1
--       in_dir_small( o->direction )
      o.direction = in_dir_small(o.direction)
      --log.debug("cw3 after o.direction: "..o.direction)
--
--       o->is_psfing = ( move_object( o, , o->momentum.i( tmp_dir ), 1 ) <> 0 )
      o.is_psfing = move_object(o, nil, o.momentum.i[tmp_dir], 1) ~= 0
--       o->direction =  tmp_dir
      o.direction = tmp_dir
--
--       Exit Sub
      return
--
--     End If
    end
--
--   Next
  end
  --log.debug("got to end of check_psf...")
--
-- End Sub
end
--
--
--
--
-- Function quad_seek( t_in As tile_quad, d As Integer ) As tile_quad
function quad_seek(t_in, d)
--
--   Dim As Integer opt, to_quad, to_tile_x, to_tile_y
  local opt, to_quad, to_tile_x, to_tile_y = 0, 0, 0, 0
--
--   to_tile_x = t_in.x
  to_tile_x = t_in.x
--   to_tile_y = t_in.y
  to_tile_y = t_in.y
--
--   Select Case As Const d
--
--     Case 0
  if d == 0 then
--
--       opt = -2
    opt = -2
--
--     Case 1
  elseif d == 1 then
--
--       opt = 1
    opt = 1
--
--     Case 2
  elseif d == 2 then
--
--       opt = 2
    opt = 2
--
--     Case 3
  elseif d == 3 then
--
--       opt = -1
    opt = -1
--
--   End Select
  end
--
--   to_quad = opt + t_in.quad
  to_quad = opt + t_in.quad
--
--   Select Case As Const d '' overflow
--
--     Case 0
  if d == 0 then
--
--       If to_quad < 0 Then
    if to_quad < 0 then
--         ''move tile up one
--
--         to_tile_y -= 1
      to_tile_y = to_tile_y - 1
--         to_quad = IIf( to_quad = -2, 2, 3 )
      to_quad = ((to_quad == -2) and 2 or 3)
--
--       End If
    end
--
--     Case 1
  elseif d == 1 then
--
--       If ( Abs( to_quad ) And 1 ) = 0 Then
    if bit.band(math.abs(to_quad), 1) == 0 then
--         ''move tile right one
--
--         to_tile_x += 1
      to_tile_x = to_tile_x + 1
--         to_quad = IIf( to_quad = 2, 0, 2 )
      to_quad = ((to_quad == 2) and 0 or 2)
--
--       End If
    end
--
--     Case 2
  elseif d == 2 then
--
--       If to_quad > 3 Then
    if to_quad > 3 then
--         ''move tile down one
--
--         to_tile_y += 1
      to_tile_y = to_tile_y + 1
--         to_quad = IIf( to_quad = 4, 0, 1 )
      to_quad = ((to_quad == 4) and 0 or 1)
--
--       End If
    end
--
--     Case 3
  elseif d == 3 then
--
--       If ( Abs( to_quad ) And 1 ) <> 0 Then
    if bit.band(math.abs(to_quad), 1) ~= 0 then
--         ''move tile left one
--
--         to_tile_x -= 1
      to_tile_x = to_tile_x - 1
--         to_quad = IIf( to_quad = 1, 3, 1 )
      to_quad = ((to_quad == 1) and 3 or 1)
--
--       End If
    end
--
--   End Select
  end
--
--   Return Type <tile_quad> ( to_tile_x, to_tile_y, to_quad )
  local result = create_tile_quad()
  result.x = to_tile_x
  result.y = to_tile_y
  result.quad = to_quad
  return result
--
-- End Function
end
--
-- Sub init_splash()
function init_splash()
--
--
--   Dim As Any Ptr ll_SplashScreen
--
--   dim as double justLongEnough
--   justLongEnough = timer + 3.5
--
--   Screen 13, , 2, iif( isFullscreen(), 1, 0 )
--
--   Sleep 1000, 1
--   SetMouse , , 0
--   fb_Global.display.pal = load_pal( "data\palette\ll.pal" )
--   Palette Using fb_Global.display.pal
--
--   ll_SplashScreen = ImageCreate( 320, 200 )
--
--   Bload "data\pictures\splash_screen.bmp", ll_SplashScreen
--
--
--
--   llg( hero ).fade_time = .0001
--   Do
--   Loop Until __fade_to_black( VarPtr( llg( hero ) ) )
--
--   Put( 0, 0 ), ll_SplashScreen
--
--
--   llg( hero ).fade_time = .01
--   Do
--   Loop Until __fade_up_to_color( VarPtr( llg( hero ) ) )
--
--
--   #IfDef ll_audio
--     ' initialize f mod
--
--     If bass_init() = 0 Then
--       bass_init( 0 )
--
--     End If
--
--     init_snd()
  init_snd()
--
--   #EndIf
--
--   Kill "objectload.txt"
--   Kill "imageload.txt"
--
--
--   LLSystem_CachePictureFiles( "data\pictures" )
--   LLSystem_CacheObjectFiles( "data\object" )
--
--
--   do while justLongEnough > timer
--     sleep 1
--   loop
--
--   llg( hero ).fade_time = .01
--   Do
--   Loop Until __fade_to_black( Varptr( llg( hero ) ) )
--   Cls
--
--   llg( hero ).fade_time = .003
--
--   shift_pal()
--
--   ImageDestroy( ll_SplashScreen )
--
--   Sleep 300, 1
--
--
-- End Sub
end

-- Sub LLObject_ClearProjectiles( char As char_type )
function LLObject_ClearProjectiles(char)
  log.debug("Implement LLObject_ClearProjectiles.")
--
--   if char.projectile = 0 then exit sub
--
--   Dim As Integer numOfProjectiles, incre
--
--   With char
--
--     For incre = 0 To .projectile->projectiles - 1
--       .projectile->coords[incre] = Type <vector> ( 0, 0 )
--
--     Next
--     .projectile->plock = 0
--     .projectile->active = 0
--     .projectile->refreshTime = 0
--     .projectile->saveDirection = 0
--     .projectile->travelled = 0
--     .projectile->sound = 0
--
--   End With
--
--
--
-- End Sub
end

-- Function touched_frame_face( c As char_type Ptr, v As vector_pair ) As Integer
function touched_frame_face(c, v)
--
--   Dim As vector_pair origin
  local origin = create_vector_pair()
--   Dim As Integer face_check
  local face_check = 0
--
--   With *( c )
--
--     .frame_check = LLObject_CalculateFrame( c[0] )
  c.frame_check = LLObject_CalculateFrame(c)
--
--     For face_check = 0 To .anim[.current_anim]->frame[.frame].faces - 1
  for face_check = 0, c.anim[c.current_anim].frame[c.frame].faces - 1 do
--
--       origin = LLO_VPE( c, OV_FACE, face_check )
    origin = LLO_VPE(c, OV_FACE, face_check)
--
--       If ( check_bounds( origin, v ) = 0 ) Then
    if (check_bounds(origin, v) == 0) then
--         Return face_check
      return face_check
--
--       End If
    end
--
--     Next
  end
--
--   End With
--
--   Return -1
  return -1
--
--
-- End Function
end
--
--
--
-- Function touched_bound_box( c As char_type Ptr, v As vector_pair ) As Integer
function touched_bound_box(c, v)
--
--   Return check_bounds( LLObject_VectorPair( c ), v )
  return check_bounds(LLObject_VectorPair(c), v)
--
-- End Function
end
