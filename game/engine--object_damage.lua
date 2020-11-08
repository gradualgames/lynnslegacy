require("game/engine_enums")
require("game/macros")
require("game/matrices")
require("game/object_modification")
require("game/utils")

-- Sub LLObject_MAINAttack( _enemies As Integer, _enemy As _char_type Ptr, hr As _char_type Ptr )
-- NOTE: The only place this function is called, the count _enemies is passed
-- in as 1, and the current enemy in act_enemies is passed in as _enemy. Therefore,
-- we are simplifying this to just pass the enemy in to begin with and eliminate the loop.
function LLObject_MAINAttack(_enemy, hr)
  --log.debug("LLObject_MAINAttack called.")
--
--   '' ASSUMES: hr->anim[hr->current_anim] contains an attacking anim'.
--   ''
--   '' Fixes...
--   ''
--   '' Use LLObject_Collision(), change to return multiple collisions
--   '' then iterate through, and check for invincible
--
--   Dim As Integer enemy_collide
  local enemy_collide = 0
--   Dim As Integer hero_faces, check_fields
  local hero_faces, check_fields = 0, 0
--   Dim As vector_pair origin, target
  local origin, target = create_vector_pair(), create_vector_pair()
--
--     For enemy_collide = 0 To _enemies - 1
  --NOTE: This loops only once, this function is only ever called once
  --and only with one enemy, this loop only ever runs once. But a break
  --is used, and I preferred to just leave that structure in place rather
  --than introduce a GOTO, hence this bogus single iteration for loop.
  for enemy_collide = 0, 0 do
--       '' cycle thru enemies to compare
--
--
--       _enemy[enemy_collide].frame_check = LLObject_CalculateFrame( _enemy[enemy_collide] )
    _enemy.frame_check = LLObject_CalculateFrame(_enemy)
--
--       hr->frame_check = LLObject_CalculateFrame( hr[0] )
    hr.frame_check = LLObject_CalculateFrame(hr)
--
--       If _enemy[enemy_collide].dead = 0 Then
    if _enemy.dead == 0 then
--         '' this entity is still alive
--
--         If _enemy[enemy_collide].dmg.id = 0 Then
      if _enemy.dmg.id == 0 then
--           '' this entity is unharmed
--
--           For hero_faces = 0 To hr->anim[hr->current_anim]->frame[hr->frame_check].faces - 1
        for hero_faces = 0, hr.anim[hr.current_anim].frame[hr.frame_check].faces - 1 do
--             '' cycle thru hero's mace faces
--
--             '' hero vector pair
--             origin = LLO_VPE( hr, OV_FACE, hero_faces )
          origin = LLO_VPE(hr, OV_FACE, hero_faces)
--
--             If _enemy[enemy_collide].anim[_enemy[enemy_collide].current_anim]->frame[_enemy[enemy_collide].frame_check].faces = 0 Then
          if _enemy.anim[_enemy.current_anim].frame[_enemy.frame_check].faces == 0 then
--               '' this enemy has only one box
--
--               '' enemy's vector pair
--               target = LLO_VP( Varptr( _enemy[enemy_collide] ) )
            target = LLO_VP(_enemy)
--               With _enemy[enemy_collide]
--
--                 If check_bounds( origin, target ) = 0 Then
            if check_bounds(origin, target) == 0 then
--
--                   If _enemy[enemy_collide].unique_id = u_pmouth Then
              if _enemy.unique_id == u_pmouth then
--
--
--                     If _enemy[enemy_collide].funcs.active_state = 0 Then
                if _enemy.funcs.active_state == 0 then
--                       _enemy[enemy_collide].impassable = 0
                  _enemy.impassable = 0
--                       LLObject_ShiftState( Varptr( _enemy[enemy_collide] ), 1 )
                  LLObject_ShiftState(_enemy, 1)
--
--                     End If
                end
--
--
--                   ElseIf _enemy[enemy_collide].unique_id = u_boss5_crystal Then
              elseif _enemy.unique_id == u_boss5_crystal then
--
--
--                     If _enemy[enemy_collide].funcs.active_state = 0 Then
                if _enemy.funcs.active_state == 0 then
-- '                      _enemy[enemy_collide].impassable = 0
                  _enemy.impassable = 0
--                       LLObject_ShiftState( Varptr( _enemy[enemy_collide] ), 1 )
                  LLObject_ShiftState(_enemy, 1)
--
--                       '' possible vguard spawn
--
--                     End If
                end
--
--                   Else
              else
--
--                     '' hero's mace connected with this entity
--                     .dmg.id = DF_MAIN_CHAR
                _enemy.dmg.id = DF_MAIN_CHAR
--                     .dmg.index = 0
                _enemy.dmg.index = 0
--
--                     LLObject_DamageCalc( Varptr( _enemy[enemy_collide] ) )
                LLObject_DamageCalc(_enemy)

--
--                     If .dmg.id <> 0 Then
                if _enemy.dmg.id ~= 0 then
--                     '' ignore the rest of the faces.
--                       Exit For
                  break
--
--                     End If
                end
--
--                   end if
              end
--
--                 End If
            end
--
--               End With
--
--             Else
          else
--               '' enemy has multiple boxes
--
--               For check_fields = 0 To _enemy[enemy_collide].anim[_enemy[enemy_collide].current_anim]->frame[_enemy[enemy_collide].frame_check].faces - 1
            local ubound = _enemy.anim[_enemy.current_anim].frame[_enemy.frame_check].faces - 1
            --log.debug("ubound: "..ubound)
            for check_fields = 0, _enemy.anim[_enemy.current_anim].frame[_enemy.frame_check].faces - 1 do
--                 '' cycle thru this entity's boxes
--
--                 '' enemy's vector pair
--                 target = LLO_VPE( Varptr( _enemy[enemy_collide] ), OV_FACE, check_fields )
              --log.debug("_enemy.current_anim: ".._enemy.current_anim)
              --log.debug("_enemy.frame_check: ".._enemy.frame_check)
              --log.debug("_enemy.anim[_enemy.current_anim].frame[_enemy.frame_check].faces:".._enemy.anim[_enemy.current_anim].frame[_enemy.frame_check].faces)
              --log.debug("_enemy.anim[_enemy.current_anim].frame[_enemy.frame_check].faces - 1:"..(_enemy.anim[_enemy.current_anim].frame[_enemy.frame_check].faces - 1))
              --log.debug("check_fields: "..check_fields)
              target = LLO_VPE(_enemy, OV_FACE, check_fields)
--
--                 If check_bounds( origin, target ) = 0 Then
              if check_bounds(origin, target) == 0 then
                log.debug("Collision found on:")
                log.debug(" _enemy.id:".._enemy.id)
--
--                   '' ONLY jumps out if the face is not invincible!
--                   With _enemy[enemy_collide]
--                   With .anim[.current_anim]->frame[.frame_check].face[check_fields]
--
--                     If .invincible = 0 Then
                if _enemy.anim[_enemy.current_anim].frame[_enemy.frame_check].face[check_fields].invincible == 0 then
--                       _enemy[enemy_collide].dmg.id       = DF_MAIN_CHAR
                  _enemy.dmg.id = DF_MAIN_CHAR
--                       _enemy[enemy_collide].dmg.index    = 0
                  _enemy.dmg.index = 0
--                       _enemy[enemy_collide].dmg.specific = check_fields
                  _enemy.dmg.specific = check_fields
--
--                       LLObject_DamageCalc( Varptr( _enemy[enemy_collide] ) )
                  log.debug("b4 _enemy.dmg.id:".._enemy.dmg.id)
                  LLObject_DamageCalc(_enemy)
                  log.debug("after _enemy.dmg.id:".._enemy.dmg.id)
--
--                       If _enemy[enemy_collide].dmg.id <> 0 Then
                  if _enemy.dmg.id ~= 0 then
                    log.debug("Damage id is valid, so break out of loop.")
--                       '' ignore the rest of the objects.
--                         Exit For
                    break
--
--                       End If
                  end
--
--                     End If
                end
--
--                   End With
--                   End With
--
--                 End If
              end
--
--               Next

            end
--
--               If _enemy[enemy_collide].dmg.id <> 0 Then
            if _enemy.dmg.id ~= 0 then
--                 '' there was a hit, so jmp the rest of heros frames for this enemy
--
--                 Exit For
              break
--
--               End If
            end
--
--             End If
          end
--
--           Next
        end
--
--         End If
      end
--
--       End If
    end
--
--
--       With _enemy[enemy_collide]
--
--         If .heal_me <> 0 Then
    if _enemy.heal_me ~= 0 then
--
--           .hp = .maxhp
      _enemy.hp = _enemy.maxhp
--
--         End If
    end
--
--       End With
--
--
--     Next
  end
--
--
--
--
-- End Sub
end

-- Sub LLObject_DeriveHurt( h As char_type Ptr )
function LLObject_DeriveHurt(h)
--
--   Select Case h->dmg.id
--
--     Case DF_ROOM_ENEMY
  if h.dmg.id == DF_ROOM_ENEMY then
--
--       With now_room().enemy[h->dmg.index]
--
--         If .anim[.current_anim]->frame[.frame_check].faces = 0 Then
    if now_room().enemy[h.dmg.index].anim[now_room().enemy[h.dmg.index].current_anim].frame[now_room().enemy[h.dmg.index].frame_check].faces == 0 then
--           h->hurt = .strength
      h.hurt = now_room().enemy[h.dmg.index].strength
--
--         Else
    else
--           h->hurt = .anim[.current_anim]->frame[.frame_check].face[h->dmg.specific].strength
      h.hurt = now_room().enemy[h.dmg.index].anim[now_room().enemy[h.dmg.index].current_anim].frame[now_room().enemy[h.dmg.index].frame_check].face[h.dmg.specific].strength
--
--         End If
    end
--
--       End With
--
--
--     Case DF_TEMP_ENEMY
  elseif h.dmg.id == DF_TEMP_ENEMY then
--
--       With now_room().temp_enemy( h->dmg.index )
--
--         If .anim[.current_anim]->frame[.frame_check].faces = 0 Then
    if now_room().temp_enemy[h.dmg.index].anim[now_room().temp_enemy[h.dmg.index].current_anim].frame[now_room().temp_enemy[h.dmg.index].frame_check].faces == 0 then
--           h->hurt = .strength
      h.hurt = now_room().temp_enemy[h.dmg.index].strength
--
--         Else
    else
--           h->hurt = .anim[.current_anim]->frame[.frame_check].face[h->dmg.specific].strength
      h.hurt = now_room().temp_enemy[h.dmg.index].anim[now_room().temp_enemy[h.dmg.index].current_anim].frame[now_room().temp_enemy[h.dmg.index].frame_check].face[h.dmg.specific].strength
--
--         End If
    end
--
--       End With
--
--
--     Case DF_ROOM_ENEMY Or DF_PROJ
  elseif h.dmg.id == DF_ROOM_ENEMY or h.dmg.id == DF_PROJ then
--
--       With now_room().enemy[h->dmg.index]
--
--         h->hurt = .projectile->strength
    h.hurt = now_room().enemy[h.dmg.index].projectile.strength
--
--       End With
--
--
--     Case DF_MAIN_CHAR
  elseif h.dmg.id == DF_MAIN_CHAR then
    log.debug("h.dmg.id == DF_MAIN_CHAR")
--
-- '        With _enemy[enemy_collide]
--
--       If llg( hero_only ).powder <> 0 Then
    if ll_global.hero_only.powder ~= 0 then
      log.debug("ll_global.hero_only.powder ~= 0")
--         '' sprinkling powder
--
--         If h->invincible <> 0 Then
      if h.invincible ~= 0 then
--           '' this enemy is invincible
--
--           If llg( hero_only ).selected_item = 1 Then
        if ll_global.hero_only.selected_item == 1 then
--             '' flare powder selected.
--
--             If h->fire_weak <> 0 Then
          if h.fire_weak ~= 0 then
--               '' this enemy is only vulnerable to fire
--
--               If h->torch <> 0 Then
            if h.torch ~= 0 then
--                 '' this is a torch
--
--                 If h->funcs.current_func[h->funcs.active_state] = 0 Then
              if h.funcs.current_func[h.funcs.active_state] == 0 then
--                   '' torch isn't currently lit
--
--                   h->jump_timer = 0
                h.jump_timer = 0
--
--                   LLObject_ShiftState( h, h->hit_state )
                LLObject_ShiftState(h, h.hit_state)
--
--
--                 End If
              end
--
--               Else
            else
--                 ''destroy it
--                 h->hp = 0
                h.hp = 0
--
--               End If
            end
--
--             End If
          end
--
--           Else
        else
--             '' ice powder selected
--
--
--             If h->ice_weak <> 0 Then
          if h.ice_weak ~= 0 then
--               '' this enemy is only destroyable by ice
--
--               If h->torch <> 0 Then
            if h.torch ~= 0 then
--                 '' this is a torch
--
--                 If ( h->funcs.active_state = h->hit_state ) Then
              if h.funcs.active_state == h.hit_state then
--                   '' torch is currently lit
--
--                   h->jump_timer = 0
                h.jump_timer = 0
--
--                   LLObject_ShiftState( h, h->reset_state )
                LLObject_ShiftState(h, h.reset_state)
--
--
--                 End If
              end
--
--
--               Else
            else
--
--
--                 ''destroy it
--                 h->hp = 0
              h.hp = 0
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
--           '' reset enemy damage flags
--           LLObject_ClearDamage( h )
        LLObject_ClearDamage(h)
--           Exit Sub
        return
--
--         Else
      else
--           '' entity is not invincible
--
--
--           If llg( hero_only ).selected_item = 1 Then
        if ll_global.hero_only.selected_item == 1 then
--             '' flare powder selected
--
--
--             If h->fire_weak <> 0 Then
          if h.fire_weak ~= 0 then
--               '' knocked back and stunned with fire powder
--
--
--               If h->melt = 0 Then
            if h.melt == 0 then
--                 '' it's not a frozen bush
--
--                 LLObject_ShiftState( h, h->fire_state )
              LLObject_ShiftState(h, h.fire_state)
--                 LLObject_ClearDamage( h )
              LLObject_ClearDamage(h)
--
--               Else
            else
--                 '' thaw the frozen bush
--
--                 LLObject_ShiftState( h, h->thaw_state )
              LLObject_ShiftState(h, h.thaw_state)
--                 LLObject_ClearDamage( h )
              LLObject_ClearDamage(h)
--
--
--               End If
            end
--
--               h->fly = V2_CalcFlyback( _
--                                         V2_MidPoint( LLObject_VectorPair( h ) ), _
--                                         V2_MidPoint( LLObject_VectorPair( Varptr( llg( hero ) ) ) ) _
--                                       )
            h.fly = V2_CalcFlyback(
                                    V2_MidPoint(LLObject_VectorPair(h)),
                                    V2_MidPoint(LLObject_VectorPair(ll_global.hero))
                                  )
--
--               LLObject_ClearDamage( h )
            LLObject_ClearDamage(h)
--
--
--             Else
          else
--               '' not susceptible
--
--               LLObject_ClearDamage( h )
            LLObject_ClearDamage(h)
--
--             End If
          end
--
--
--           Else
        else
--
--
--             If h->ice_weak <> 0 Then
          if h.ice_weak ~= 0 then
--               '' ice powder freezes this entity
--
--               LLObject_ShiftState( h, h->ice_state )
            LLObject_ShiftState(h, h.ice_state)
--
--               If h->unique_id = u_bush Then
            if h.unique_id == u_bush then
--                 '' it's a bush
--
--                 h->melt = 1
              h.melt = 1
--                 LLObject_ClearDamage( h )
              LLObject_ClearDamage(h)
--
--               End If
            end
--
--               h->hurt = 0
            h.hurt = 0
--
--
--
--               h->fly = V2_CalcFlyback( _
--                                        V2_MidPoint( LLObject_VectorPair( h ) ), _
--                                        V2_MidPoint( LLObject_VectorPair( Varptr( llg( hero ) ) ) ) _
--                                      )
            h.fly = V2_CalcFlyback(
                                    V2_MidPoint(LLObject_VectorPair(h)),
                                    V2_MidPoint(LLObject_VectorPair(ll_global.hero))
                                  )

--               LLObject_ClearDamage( h )
            LLObject_ClearDamage(h)
--
--             Else
          else
--               '' not susceptible
--
--               LLObject_ClearDamage( h )
            LLObject_ClearDamage(h)
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
--       Else
    else
      log.debug("Attacking normally.")
--         '' attacking normally
--
--         If h->invincible <> 0 Then
      if h.invincible ~= 0 then
--           '' current enemy is invincible
--
--
--           If llg( hero_only ).weapon >= 1 Then
        if ll_global.hero_only.weapon >= 1 then
--             '' hero's weapon is mace or better
--             If h->mace_weak <> 0 Then
          if h.mace_weak ~= 0 then
--               '' this entity dies from a mace or better weapon hit.
--
--               h->hp = 0
            h.hp = 0
--               LLObject_ClearDamage( h )
            LLObject_ClearDamage(h)
--
--             End If
          end
--
--           End If
        end
--
--           If llg( hero_only ).weapon >= 2 Then
        if ll_global.hero_only.weapon >= 2 then
--             '' hero's weapon is the divius star
--             If h->star_weak <> 0 Then
          if h.star_weak ~= 0 then
--               '' this entity dies from a hit with the star
--               h->hp = 0
            h.hp = 0
--               LLObject_ClearDamage( h )
            LLObject_ClearDamage(h)
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
--
--         If h->anim[h->current_anim]->frame[h->frame_check].faces = 0 Then
      if h.anim[h.current_anim].frame[h.frame_check].faces == 0 then
--           '' enemy only has one bound
--
--           If h->invincible = 0 Then
        if h.invincible == 0 then
--             '' enemy is not invincible
--

-- NOTE: I do not really understand why Imp is used in the
-- original code, below. However, this example was supplied
-- by someone on discord, so if we ever have a bug here, we can
-- refer to this example to try to understand the code:
-- If I am in Sacramento, then I am in California.
--
-- I am not in Sacramento and I am not in California. [true]
-- I am in Sacramento and I am not in California. [false]
-- I am not in Sacramento and I am in Calfornia. [true]
-- I am in Sacramento and I am in California. [true]
-- [4:23 PM]
-- As an example

--             If  ( ( h->mace_weak ) Imp ( llg( hero_only ).weapon >= 1 ) ) And _
--                 ( ( h->star_weak ) Imp ( llg( hero_only ).weapon >= 2 ) ) Then
          if (imp(h.mace_weak, ll_global.hero_only.weapon >= 1 and 1 or 0) ~= 0) and
             (imp(h.star_weak, ll_global.hero_only.weapon >= 2 and 1 or 0) ~= 0) then
--               '' Imp-i-fied
--
--               h->hurt = ( 2 ^ ( llg( hero_only ).weapon ) ) * IIf( llg( hero ).psycho <> 0, 2, 1 )
            h.hurt = (2 ^ (ll_global.hero_only.weapon)) * (ll_global.hero.psycho ~= 0 and 2 or 1)
--
--               if llg( hero_only ).adrenaline <> 0 then
            if ll_global.hero_only.adrenaline ~= 0 then
--                 select case as const llg( hero_only ).weapon
--                   case 0
              if ll_global.hero_only.weapon == 0 then
--                     h->hurt += 1
                h.hurt = h.hurt + 1
--                   case 1
              elseif ll_global.hero_only.weapon == 1 then
--                     h->hurt += 1
                h.hurt = h.hurt + 1
--                   case 2
              elseif ll_global.hero_only.weapon == 2 then
--                     h->hurt += 2
                h.hurt = h.hurt + 2
--                 end select
              end
--
--               end if
            end
--
--
--             End If
          end
--
--
--           End If
        end
--
--
--         Else
      else
--           '' enemy has multiple faces
--
--
--
--           If h->anim[h->current_anim]->frame[h->frame_check].face[h->dmg.specific].invincible = 0 Then
        if h.anim[h.current_anim].frame[h.frame_check].face[h.dmg.specific].invincible == 0 then
--             '' entity face is not invincible
--
--             If  ( ( h->mace_weak <> 0 ) Imp ( llg( hero_only ).weapon >= 1 ) ) _
--             And ( ( h->star_weak <> 0 ) Imp ( llg( hero_only ).weapon >= 2 ) ) Then
          if (imp(h.mace_weak, ll_global.hero_only.weapon >= 1 and 1 or 0) ~= 0) and
             (imp(h.star_weak, ll_global.hero_only.weapon >= 2 and 1 or 0) ~= 0) then

--
--               h->hurt = ( 2 ^ ( llg( hero_only ).weapon ) ) * IIf( llg( hero ).psycho <> 0, 2, 1 )
            h.hurt = (2 ^ (ll_global.hero_only.weapon)) * (ll_global.hero.psycho ~= 0 and 2 or 1)
--
--               if llg( hero_only ).adrenaline <> 0 then
            if ll_global.hero_only.adrenaline ~= 0 then
--                 select case as const llg( hero_only ).weapon
--                   case 0
              if ll_global.hero_only.weapon == 0 then
--                     h->hurt += 1
                h.hurt = h.hurt + 1
--                   case 1
              elseif ll_global.hero_only.weapon == 1 then
--                     h->hurt += 1
                h.hurt = h.hurt + 1
--                   case 2
              elseif ll_global.hero_only.weapon == 2 then
--                     h->hurt += 2
                h.hurt = h.hurt + 2
--                 end select
              end
--
--               end if
            end
--
--
--
--             End If
          end
--
--           End If
        end
--
--           '' reset face
--           h->dmg.specific = 0
          h.dmg.specific = 0
--
--         End If
      end
--
--
--
--
--       End If
    end
--
-- '        End With
--
--
--   End Select
  end
--
-- End Sub
end

-- Sub LLObject_ProcessHurt( h As char_type Ptr )
function LLObject_ProcessHurt(h)
  log.debug("LLObject_ProcessHurt called.")
--
--
--
--   h->hp -= h->hurt
  log.debug("h.id: "..h.id)
  log.debug("h.hp: "..(h.hp and h.hp or "nil"))
  log.debug("h.hurt: "..(h.hurt and h.hurt or "nil"))
  h.hp = h.hp - h.hurt
--   '' take away the damage from the hp .
--
--   if h->unique_id = u_lynn then
--     antiHackASSIGN( LL_Global.hero_only.healthDummy, LL_Global.hero.hp )
--
--   end if
--
--
--   If h->hurt < 0 Then
  if h.hurt < 0 then
--     '' reset damaged status.
--     LLObject_ClearDamage( h )
    LLObject_ClearDamage(h)
--     Exit Sub
    return
--
--   End If
  end
--
--
--   Dim As vector flyback
  local flyback = create_vector()
--   Dim As vector_pair origin, target
  local origin, target = create_vector_pair(), create_vector_pair()
--
--   If h->hp > 0 Then
  if h.hp > 0 then
--     '' lynn's still alive.
--
--
--     Select Case h->dmg.id
--
--       Case DF_ROOM_ENEMY
    if h.dmg.id == DF_ROOM_ENEMY then
--
--         with now_room().enemy[h->dmg.index]
      local with0 = now_room().enemy[h.dmg.index]
--           If .anim[.current_anim]->frame[.frame_check].faces = 0 Then
      if with0.anim[with0.current_anim].frame[with0.frame_check].faces == 0 then
--             origin = LLObject_VectorPair( @now_room().enemy[h->dmg.index] )
        origin = LLObject_VectorPair(now_room().enemy[h.dmg.index])
--
--           Else
      else
--
--             origin.u.x = .coords.x
        origin.u.x = with0.coords.x
--             origin.u.y = .coords.y
        origin.u.y = with0.coords.y
--
--             with .animControl[.current_anim]
        local with1 = with0.animControl[with0.current_anim]
--
--               origin.u.x -= .x_off
        origin.u.x = origin.u.x - with1.x_off
--               origin.u.y -= .y_off
        origin.u.y = origin.u.y - with1.y_off
--
--             end with
--
--             with .anim[.current_anim]->frame[.frame_check]
        with1 = with0.anim[with0.current_anim].frame[with0.frame_check]
--
--               with .face[h->dmg.specific]
        local with2 = with1.face[h.dmg.specific]
--                 origin.u.x += .x
        origin.u.x = origin.u.x + with2.x
--                 origin.u.y += .y
        origin.u.y = origin.u.y + with2.y
--                 origin.v.x = .w
        origin.v.x = with2.w
--                 origin.v.y = .h
        origin.v.y = with2.h
--
--               end with
--
--             end with
--
--           End If
      end
--
--         end with
--
--
--       Case DF_TEMP_ENEMY
    elseif h.dmg.id == DF_TEMP_ENEMY then
--         origin = LLObject_VectorPair( @now_room().temp_enemy( h->dmg.index ) )
      origin = LLObject_VectorPair(now_room().temp_enemy[h.dmg.index])
--
--
--       Case DF_ROOM_ENEMY Or DF_PROJ
    elseif h.dmg.id == DF_ROOM_ENEMY or h.dmg.id == DF_PROJ then
--
--         With now_room().enemy[h->dmg.index]
      local with0 = now_room().enemy[h.dmx.index]
--
--           origin.u.x = .projectile->coords[h->dmg.specific].x
      origin.u.x = with0.projectile.coords[h.dmg.specific].x
--           origin.u.y = .projectile->coords[h->dmg.specific].y
      origin.u.y = with0.projectile.coords[h.dmg.specific].y
--           origin.v.x = .anim[.proj_anim]->x
      origin.v.x = with0.anim[with0.proj_anim].x
--           origin.v.y = .anim[.proj_anim]->y
      origin.v.y = with0.anim[with0.proj_anim].y
--
--         End With
--
--       Case DF_TEMP_ENEMY Or DF_PROJ
    elseif h.dmg.id == DF_TEMP_ENEMY or h.dmg.id == DF_PROJ then
--
--         With now_room().temp_enemy( h->dmg.index )
      local with0 = now_room().temp_enemy[h.dmx.index]
--
--           origin.u.x = .projectile->coords[h->dmg.specific].x
      origin.u.x = with0.projectile.coords[h.dmg.specific].x
--           origin.u.y = .projectile->coords[h->dmg.specific].y
      origin.u.y = with0.projectile.coords[h.dmg.specific].y
--           origin.v.x = .anim[.proj_anim]->x
      origin.v.x = with0.anim[with0.proj_anim].x
--           origin.v.y = .anim[.proj_anim]->y
      origin.v.y = with0.anim[with0.proj_anim].y
--
--         End With
--
--
--       Case DF_MAIN_CHAR
    elseif h.dmg.id == DF_MAIN_CHAR then
--
--         Dim As Integer unhurt_enemies = -1
      local unhurt_enemies = -1
--         unhurt_enemies = -1
      unhurt_enemies = -1
--
--         unhurt_enemies And= ( Not ( h->unique_id = u_bush ) )
      unhurt_enemies = bit.band(unhurt_enemies, bit.bnot((h.unique_id == u_bush) and 1 or 0))
--         unhurt_enemies And= ( Not ( h->unique_id = u_crate ) )
      unhurt_enemies = bit.band(unhurt_enemies, bit.bnot((h.unique_id == u_crate) and 1 or 0))
--         unhurt_enemies And= ( Not ( h->unique_id = u_crate_health ) )
      unhurt_enemies = bit.band(unhurt_enemies, bit.bnot((h.unique_id == u_crate_health) and 1 or 0))
--         unhurt_enemies And= ( Not ( h->unique_id = u_greyrock ) )
      unhurt_enemies = bit.band(unhurt_enemies, bit.bnot((h.unique_id == u_greyrock) and 1 or 0))
--         unhurt_enemies And= ( Not ( h->unique_id = u_bombrock ) )
      unhurt_enemies = bit.band(unhurt_enemies, bit.bnot((h.unique_id == u_bombrock) and 1 or 0))
--         unhurt_enemies And= ( Not ( h->unique_id = u_goldblock ) )
      unhurt_enemies = bit.band(unhurt_enemies, bit.bnot((h.unique_id == u_goldblock) and 1 or 0))
--
--         If unhurt_enemies <> 0 Then
      if unhurt_enemies ~= 0 then
--           llg( hero_only ).crazy_cache += IIf( llg( hero_only ).isWearing = 2, 20, 10 )
        ll_global.hero_only.crazy_cache = ll_global.hero_only.crazy_cache + ((ll_global.hero_only.isWearing == 2) and 20 or 10)

--
--         End If
      end
--
--         If ( h->unique_id = u_anger ) Or ( h->unique_id = u_sterach ) Then
      if (h.unique_id == u_anger) or (h.unique_id == u_sterach) then
--           h->shifty_state = 0
        h.shifty_state = 0
--           h->hit = -1
        h.hit = -1
--
--         Else
      else
--
--           LLObject_ShiftState( h, h->hit_state )
        LLObject_ShiftState(h, h.hit_state)
--           origin = LLO_VP( @llg( hero ) )
        origin = LLO_VP(ll_global.hero)
--           If h->unique_id = u_dyssius Then
        if h.unique_id == u_dyssius then
--             h->fly_count = 0
          h.fly_count = 0
--
--           End If
        end
--           If h->unique_id = u_steelstrider Then
        if h.unique_id == u_steelstrider then
--             h->fly_count = 0
          h.fly_count = 0
--
--           End If
        end
--           If h->unique_id = u_grult Then
        if h.unique_id == u_grult then
--             h->fly_count = 0
          h.fly_count = 0
--
--           End If
        end
--           If h->unique_id = u_divine Then
        if h.unique_id == u_divine then
--             h->fly_count = 0
          h.fly_count = 0
--
--           End If
        end
--           If (h->unique_id = u_dyssius) or (h->unique_id = u_anger) Then
        if (h.unique_id == u_dyssius) or (h.unique_id == u_anger) then
--             h->shifty_state = 0
          h.shifty_state = 0
--             h->slide_hold   = 0
          h.slide_hold = 0
--
--           end if
        end
--
--
--         End If
      end
--
--
--     End Select
    end
--
--     If h->unique_id = u_lynn Then
    if h.unique_id == u_lynn then
-- '      If h->dmg.id = DF_ROOM_ENEMY Then
--         If now_room().enemy[h->dmg.index].unique_id <> u_beetle Then
      if now_room().enemy[h.dmg.index].unique_id ~= u_beetle then
--           Dim As Integer lynn_yell
        local lynn_yell = 0
--           lynn_yell = CInt( sound_lynn_hurt_1 ) + Int( Rnd * 3 )
        lynn_yell = sound_lynn_hurt_1 + math.floor(math.random() * 3)
--
--           play_sample( llg( snd )[lynn_yell], 50 )
        ll_global.snd[lynn_yell]:play()

--
--         End If
      end
--
-- '      End If
--
--     Else
    else
--
--       If h->hit_sound <> 0 Then
      if h.hit_sound ~= 0 then
--
--         #IfDef ll_audio
-- '          If h->hit_sound_vol <> 0 Then
--             play_sample( llg( snd )[h->hit_sound], IIf( h->hit_sound_vol <> 0, h->hit_sound_vol, 100 ) )
        --FIXME: Port the volume adjustment based on hit_sound_vol
        ll_global.snd[h.hit_sound]:play()
--
-- '          End If
--
--         #EndIf
--
--       End If
      end
--
--     End If
    end
--
--     flyback = V2_CalcFlyback( V2_MidPoint( LLO_VP( h ) ), V2_MidPoint( origin ) )
    flyback = V2_CalcFlyback(V2_MidPoint(LLO_VP(h)), V2_MidPoint(origin))
--
--     If llg( hero ).psycho <> 0 Then
    if ll_global.hero.psycho ~= 0 then
--
--       If h->unique_id <> u_lynn Then
      if h.unique_id ~= u_lynn then
--
--         flyback = V2_CalcFlyback( V2_MidPoint( LLO_VP( h ) ), V2_MidPoint( origin ) )
        flyback = V2_CalcFlyback(V2_MidPoint(LLO_VP(h)), V2_MidPoint(origin))
--         flyback = V2_Scale( flyback, 4 )
        flyback = V2_Scale(flyback, 4)
--
--       End If
      end
--
--     End If
    end
--
--     If ( h->unique_id <> u_anger ) And ( h->unique_id <> u_grult ) Then
    if (h.unique_id ~= u_anger) and (h.unique_id ~= u_grult) then
--       '' his fireballs are affected by fly_?, and he doesn't fly back.
--       h->fly = flyback
      h.fly = flyback
--
--     End If
    end
--
--
--   Else
  else
--     '' hp is 0 or below, dead.
--
--     If h->dead = 0 Then
    if h.dead == 0 then
--       '' first time initialization.
--
--       If h->dead_sound <> 0 Then
      if h.dead_sound ~= 0 then
--
--         If h->unique_id <> u_lynn Then
        if h.unique_id ~= u_lynn then
--           play_sample( llg( snd )[h->dead_sound] )
          ll_global.snd[h.dead_sound]:play()
--
--         else
        else
--           play_sample( llg( snd )[h->dead_sound], 30 )
          --FIXME: Port the volume adjustments
          ll_global.snd[h.dead_sound]:play()
--
--         End If
        end
--
--       End If
      end
--
--       if h->unique_id = u_battleseed then
      if h.unique_id == u_battleseed then
--         now_room().enemy[2].hp = 0
        now_room().enemy[2].hp = 0
--
--       end if
      end
--
--       LLObject_ClearProjectiles( *h )
      LLObject_ClearProjectiles(h)
--       LLObject_ShiftState( h, h->death_state )
      LLObject_ShiftState(h, h.death_state)
--
--       h->dead = 1
      h.dead = 1
--       h->fade_time = .07
      h.fade_time = .07
--
--     End If
    end
--
--     '' reset damaged status.
--     LLObject_ClearDamage( h )
    LLObject_ClearDamage(h)
--
--   End If
  end
--
-- End Sub
end

-- Sub LLObject_DamageCalc( h As _char_type Ptr )
function LLObject_DamageCalc(h)
  log.debug("LLObject_DamageCalc called.")
--
--   With *h
--
--
--
--     LLObject_DeriveHurt( h )d
  LLObject_DeriveHurt(h)
--
--     If .hurt <> 0 Then
  if h.hurt ~= 0 then
    log.debug("Enemy got hurt.")
--       '' got hurt.
--       If h->dmg.id = DF_ROOM_ENEMY Then
    if h.dmg.id == DF_ROOM_ENEMY then
--
--         If( now_room().enemy[h->dmg.index].unique_id = u_gshape ) _
--                                    Or                             _
--           ( now_room().enemy[h->dmg.index].unique_id = u_bshape ) Then
      if (now_room().enemy[h.dmg.index].unique_id == u_gshape) or (now_room().enemy[h.dmg.index].unique_id == u_bshape) then
--
--           __make_dead( Varptr( now_room().enemy[h->dmg.index] ) )
        __make_dead(now_room().enemy[h.dmg.index])
--           __cripple( Varptr( now_room().enemy[h->dmg.index] ) )
        __cripple(now_room().enemy[h.dmg.index])
--
--         End If
      end
--
--         If ( now_room().enemy[h->dmg.index].unique_id = u_beetle ) Then
      if (now_room().enemy[h.dmg.index].unique_id == u_beetle) then
--
--           With now_room().enemy[h->dmg.index]
        local with0 = now_room().enemy[h.dmg.index]
--
--             .hp = 0
        with0.hp = 0
--
--             LLObject_ShiftState( Varptr( now_room().enemy[h->dmg.index] ), now_room().enemy[h->dmg.index].death_state )
        LLObject_ShiftState(now_room().enemy[h.dmg.index], now_room().enemy[h.dmg.index].death_state)
--
--             now_room().enemy[h->dmg.index].dead = 1
        now_room().enemy[h.dmg.index].dead = 1
--             now_room().enemy[h->dmg.index].fade_time = .07
        now_room().enemy[h.dmg.index].fade_time = .07
--
--             play_sample( llg( snd )[.dead_sound], IIf( .dead_sound_vol <> 0, .dead_sound_vol, 100 ) )
        --FIXME: Port volume adjustment
        ll_global.snd[with0.dead_sound]:play()
--
--           End With
--
--           dim as integer saveIndex
        local saveIndex = 0
--           saveIndex = h->dmg.index
        saveIndex = h.dmg.index
--
--           h->hurt = 0
        h.hurt = 0
--           LLObject_ClearDamage( h )
        LLObject_ClearDamage(h)
--
--           h->dmg.index = saveIndex
        h.dmg.index = saveIndex
--
--         End If
      end
--
--       End If
    end
--
--       LLObject_ProcessHurt( h )
    LLObject_ProcessHurt(h)
--
--     Else
  else
    log.debug("Enemy not hurt. This leads to resetting damage id...")
--       '' took 0 damage.
--
--       '' reset damaged status.
--       LLObject_ClearDamage( h )
    LLObject_ClearDamage(h)
--
--     End If
  end
--
--     .frame_check = 0
  h.frame_check = 0
--
--   End With
--
-- End Sub
end

-- Sub LLObject_ProjectileDamage( _objects As Integer, _object As _char_type Ptr, h As _char_type Ptr )
function LLObject_ProjectileDamage(_objects, _object, h)
--
--
--   Dim As Integer chk_proj, do_stuff
  local chk_proj, do_stuff = 0, 0
--
--   Dim As vector_pair origin, target
  local origin, target = create_vector_pair(), create_vector_pair()
--
--   For do_stuff = 0 To _objects - 1
  for do_stuff = 0, _objects - 1 do
--     '' loop through all objects
--
--     With _object[do_stuff]
    local with0 = _object[do_stuff]
--
--       If ( .dead = 0 ) Or ( .unique_id = u_ibug ) Or ( .unique_id = u_fbug ) Then
    if (with0.dead == 0) or (with0.unique_id == u_ibug) or (with0.unique_id == u_fbug) then
--
--         If .projectile Then
      if with0.projectile then
--
--           If ( .projectile->active <> 0 ) Or _
        if (with0.projectile.active ~= 0) or
--              ( .unique_id = u_dyssius ) Or ( .unique_id = u_steelstrider ) Or _
                (with0.unique_id == u_dyssius) or (with0.unique_id == u_steelstrider) or
--              ( .unique_id = u_grult     ) Or _
                (with0.unique_id == u_grult) or
--              ( .unique_id = u_anger     ) Then
                (with0.unique_id == u_anger) then
--
--             For chk_proj = 0 To .projectile->projectiles - 1
          for chk_proj = 0, with0.projectile.projectiles - 1 do
--
--               origin.u = .projectile->coords[chk_proj]
            origin.u = with0.projectile.coords[chk_proj]:clone()
--               origin.v.x = .anim[.proj_anim]->x
            origin.v.x = with0.anim[with0.proj_anim].x
--               origin.v.y = .anim[.proj_anim]->y
            origin.v.y = with0.anim[with0.proj_anim].y
--
--               target.u = h->coords
            target.u = h.coords:clone()
--               target.v = h->perimeter
            target.v = h.perimeter:clone()
--
--               If check_bounds( origin, target ) = 0 Then
            if check_bounds(origin, target) == 0 then
--
--                 Select Case h->unique_id
--
--                   Case u_boss5_left, u_boss5_right, u_boss5_down
              if h.unique_id == u_boss5_left or h.unique_id == u_boss5_right or
                 h.unique_id == u_boss5_down then
--
--                     If .unique_id = h->unique_id Then
                if with0.unique_id == h.unique_id then
--
--                       If h->shifty Then
                  if h.shifty ~= 0 then
--
--                         LLObject_ShiftState( h, h->hit_state )
                    LLObject_ShiftState(h, h.hit_state)

--                         LLObject_ClearProjectiles( _object[do_stuff] )
                    LLObject_ClearProjectiles(_object[do_stuff])
--
--                         h->hp -=1
                    h.hp = h.hp - 1
--                         .shifty = 0
                    with0.shifty = 0
--
--                       End If
                  end
--
--                     End If
                end
--
--                     Continue For
                goto continue
--
--
--                   Case u_boss5_crystal
              elseif h.unique_id == u_boss5_crystal then
--
--                     If h->funcs.active_state = 1 Then
                if h.funcs.active_state == 1 then
--
--                       LLObject_ShiftState( h, 2 )
                  LLObject_ShiftState(h, 2)
--
--                       .projectile->direction += 2
                  with0.projectile.direction = with0.projectile.direction + 2
--                       .projectile->direction And= 3
                  with0.projectile.direction = bit.band(with0.projectile.direction, 3)
--
--                       Swap .projectile->coords[0], .projectile->coords[1]
                  --save a
                  local c0 = with0.projectile.coords[0]:clone()
                  --a = b
                  with0.projectile.coords[0] = with0.projectile.coords[1]:clone()
                  --b = saved a
                  with0.projectile.coords[1] = c0:clone()
--
--                       LLObject_IncrementProjectiles( _object[do_stuff] )
                  LLObject_IncrementProjectiles(_object[do_stuff])
--
--                       .shifty = -1
                  with0.shifty = -1
--
--                     Else
                else
--
--                       If .unique_id <> u_boss5_crystal Then
                  if with0.unique_id ~= u_boss5_crystal then
--                         LLObject_ClearProjectiles( _object[do_stuff] )
                    LLObject_ClearProjectiles(_object[do_stuff])
--
--                       End If
                  end
--
--                     End If
                end
--
--                     Continue For
                goto continue
--
--
--                   Case u_beamcrystal
              elseif h.unique_id == u_beamcrystal then
--
--                     LLObject_ClearProjectiles( _object[do_stuff] )
                LLObject_ClearProjectiles(_object[do_stuff])
--
--
--                   Case Else
              else
--
--                     If h->dmg.id = 0 Then
                if h.dmg.id == 0 then
--                       h->dmg.id       = DF_ROOM_ENEMY Or DF_PROJ
                  h.dmg.id = bit.band(DF_ROOM_ENEMY, DF_PROJ)
--                       h->dmg.index    = do_stuff
                  h.dmg.index = do_stuff
--                       h->dmg.specific = chk_proj
                  h.dmg.specific = chk_proj
--
--                       LLObject_DamageCalc( h )
                  LLObject_DamageCalc(h)
--                       If h->dmg.id <> 0 Then
                  if h.dmg.id ~= 0 then
--                         Exit Sub
                    return
--
--                       End If
                  end
--
--                     End If
                end
--
--                 End Select
              end
--
--               End If
            end
--
--             Next
            ::continue::
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
--     End With
--
--   Next
  end
--
--
-- End Sub
end

-- Sub LLObject_ObjectDamage( _enemies As Integer, _enemy As _char_type Ptr, hr As _char_type Ptr, e_type As Integer = DF_ROOM_ENEMY )
function LLObject_ObjectDamage(_enemies, _enemy, hr, e_type)
  e_type = e_type and e_type or DF_ROOM_ENEMY
--
--   If hr->invincible <> 0 Then Exit Sub
  if hr.invincible ~= 0 then return end
--
--   Dim As Integer enemy_collide, check_fields
  local enemy_collide, check_fields = 0, 0
--   Dim As vector_pair origin
  local origin = create_vector_pair()
--
--   For enemy_collide = 0 To _enemies - 1
  for enemy_collide = 0, _enemies - 1 do
--     '' loop through all enemies in this room.
--
--     With _enemy[enemy_collide]
    local with0 = _enemy[enemy_collide]
--
--       If LLObject_IsWithin( Varptr( _enemy[enemy_collide] ) ) = 0 Then
    if LLObject_IsWithin(_enemy[enemy_collide]) == 0 then
--         Continue For
      goto continue
--
--       End If
    end
--
--
--       If .strength = 0 Then
    if with0.strength == 0 then
--         Continue For
      goto continue
--
--       End If
    end
--
--       .frame_check = LLObject_CalculateFrame( _enemy[enemy_collide] )
    with0.frame_check = LLObject_CalculateFrame(_enemy[enemy_collide])
--
--       If .anim[.current_anim]->frame[.frame_check].faces = 0 Then
    if with0.anim[with0.current_anim].frame[with0.frame_check].faces == 0 then
--         '' this enemy only has a single box boundary.
--
--         If check_bounds( LLObject_VectorPair( Varptr( _enemy[enemy_collide] ) ), _
--                          LLObject_VectorPair( hr ) ) = 0 Then
      if check_bounds(LLObject_VectorPair(_enemy[enemy_collide]), LLObject_VectorPair(hr)) == 0 then
--
--           '' hit by the current enemy.
--           hr->dmg.id    = e_type
        hr.dmg.id = e_type
--           hr->dmg.index = enemy_collide
        hr.dmg.index = enemy_collide
--
--           LLObject_DamageCalc( hr )
        LLObject_DamageCalc(hr)
--
--           If hr->dmg.id <> 0 Then
        if hr.dmg.id ~= 0 then
--           '' ignore the rest of the objects.
--             Exit For
          break
--
--           End If
        end
--
--         End If
      end
--
--
--       Else
    else
--         '' this enemy has multiple box boundaries.
--
--
--         For check_fields = 0 To .anim[.current_anim]->frame[.frame_check].faces - 1
      for check_fields = 0, with0.anim[with0.current_anim].frame[with0.frame_check].faces - 1 do
--           '' loop thru all of the current enemy's box boundaries.
--
--           origin = LLO_VPE( Varptr( _enemy[enemy_collide] ), OV_FACE, check_fields )
        origin = LLO_VPE(_enemy[enemy_collide], OV_FACE, check_fields)
--
--           If check_bounds( origin, LLObject_VectorPair( hr ) ) = 0 Then
        if check_bounds(origin, LLObject_VectorPair(hr)) == 0 then
--             '' got damaged by the object that owns this face.
--
--             hr->dmg.id       = e_type
          hr.dmg.id = e_type
--             hr->dmg.index    = enemy_collide
          hr.dmg.index = enemy_collide
--             hr->dmg.specific = check_fields
          hr.dmg.specific = check_fields
--
--             LLObject_DamageCalc( hr )
          LLObject_DamageCalc(hr)
--
--             If hr->dmg.id <> 0 Then
          if hr.dmg.id ~= 0 then
--             '' ignore the rest of the objects.
--               Exit For
            break
--
--             End If

          end
--
--           End If
        end
--
--         Next
      end
--
--       End If
    end
--
--     End With
--
--   Next
  ::continue::
  end
--
-- End Sub
end

-- Sub LLObject_MAINDamage( hr As _char_type Ptr )
function LLObject_MAINDamage(hr)
--
--
--   If hr->invincible <> 0 Then Exit Sub
  if hr.invincible ~= 0 then return end
--
--   With now_room()
  local with0 = now_room()
--
--     If ( hr->dmg.id = 0 ) Then
  if hr.dmg.id == 0 then
--       LLObject_ProjectileDamage( .enemies, .enemy, hr )
    LLObject_ProjectileDamage(with0.enemies, with0.enemy, hr)
--
--     End If
  end
--       If ( hr->dmg.id = 0 ) Then
  if hr.dmg.id == 0 then
--         LLObject_ObjectDamage( .enemies, .enemy, hr, DF_ROOM_ENEMY )
    LLObject_ObjectDamage(with0.enemies, with0.enemy, hr, DF_ROOM_ENEMY)
--
--       End If
  end
--         If ( hr->dmg.id = 0 ) Then
  if hr.dmg.id == 0 then
--           LLObject_ObjectDamage( .temp_enemies, @.temp_enemy( 0 ), hr, DF_TEMP_ENEMY )
    LLObject_ObjectDamage(with0.temp_enemies, with0.temp_enemy[0], hr, DF_TEMP_ENEMY)
--
--         End If
  end
--
--
--
--   End With
--
--
-- End Sub
end

-- Sub LLObject_ClearDamage( h As char_type Ptr )
function LLObject_ClearDamage(h)
  log.debug("LLObject_ClearDamage called.")
--
--   h->hurt         = 0
  h.hurt = 0
--
--   h->dmg.id       = 0
  h.dmg.id = 0
--   h->dmg.index    = 0
  h.dmg.index = 0
--   h->dmg.specific = 0
  h.dmg.specific = 0
--
-- End Sub
end
