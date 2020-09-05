require("game/macros")
require("game/matrices")

-- Sub LLObject_MAINAttack( _enemies As Integer, _enemy As _char_type Ptr, hr As _char_type Ptr )
-- NOTE: The only place this function is called, the count _enemies is passed
-- in as 1, and the current enemy in act_enemies is passed in as _enemy. Therefore,
-- we are simplifying this to just pass the enemy in to begin with and eliminate the loop.
function LLObject_MAINAttack(_enemy, hr)
  log.debug("LLObject_MAINAttack called.")
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
            for check_fields = 0, _enemy.anim[_enemy.current_anim].frame[_enemy.frame_check].faces - 1 do
--                 '' cycle thru this entity's boxes
--
--                 '' enemy's vector pair
--                 target = LLO_VPE( Varptr( _enemy[enemy_collide] ), OV_FACE, check_fields )
              target = LLO_VPE(_enemy, OV_FACE, check_fields)
--
--                 If check_bounds( origin, target ) = 0 Then
              if check_bounds(origin, target) == 0 then
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
                  LLObject_DamageCalc(_enemy)
--
--                       If _enemy[enemy_collide].dmg.id <> 0 Then
                  if _enemy.dmg.id ~= 0 then
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

-- Sub LLObject_DamageCalc( h As _char_type Ptr )
function LLObject_DamageCalc(h)
  log.debug("LLObject_DamageCalc called. TODO: Implement me.")
--
--   With *h
--
--
--
--     LLObject_DeriveHurt( h )
--
--     If .hurt <> 0 Then
--       '' got hurt.
--       If h->dmg.id = DF_ROOM_ENEMY Then
--
--         If( now_room().enemy[h->dmg.index].unique_id = u_gshape ) _
--                                    Or                             _
--           ( now_room().enemy[h->dmg.index].unique_id = u_bshape ) Then
--
--           __make_dead( Varptr( now_room().enemy[h->dmg.index] ) )
--           __cripple( Varptr( now_room().enemy[h->dmg.index] ) )
--
--         End If
--
--         If ( now_room().enemy[h->dmg.index].unique_id = u_beetle ) Then
--
--           With now_room().enemy[h->dmg.index]
--
--             .hp = 0
--
--             LLObject_ShiftState( Varptr( now_room().enemy[h->dmg.index] ), now_room().enemy[h->dmg.index].death_state )
--
--             now_room().enemy[h->dmg.index].dead = 1
--             now_room().enemy[h->dmg.index].fade_time = .07
--
--             play_sample( llg( snd )[.dead_sound], IIf( .dead_sound_vol <> 0, .dead_sound_vol, 100 ) )
--
--           End With
--
--           dim as integer saveIndex
--           saveIndex = h->dmg.index
--
--           h->hurt = 0
--           LLObject_ClearDamage( h )
--
--           h->dmg.index = saveIndex
--
--         End If
--
--       End If
--
--       LLObject_ProcessHurt( h )
--
--     Else
--       '' took 0 damage.
--
--       '' reset damaged status.
--       LLObject_ClearDamage( h )
--
--     End If
--
--     .frame_check = 0
--
--   End With
--
-- End Sub
end
