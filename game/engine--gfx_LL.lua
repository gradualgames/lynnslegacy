require("game/macros")

--Updates a room using the tile indices from the room to arrange
--the spritebatch for drawing, based on an image header.
function layoutLayer(camera, room, layer, imageHeader, spriteBatch)

  spriteBatch:clear()
  local topLeftMapX = math.floor(ll_global.this_room.cx / imageHeader.x)
  local topLeftMapY = math.floor(ll_global.this_room.cy / imageHeader.y)
  local topLeftScreenX = -(ll_global.this_room.cx % imageHeader.x)
  local topLeftScreenY = -(ll_global.this_room.cy % imageHeader.y)
  local mapX = topLeftMapX
  local mapY = topLeftMapY
  local screenX = topLeftScreenX
  local screenY = topLeftScreenY
  for y = 1, 14 do
    mapX = topLeftMapX
    screenX = topLeftScreenX
    for x = 1, 21 do
      if mapX >= 0 and mapX < room.x and
         mapY >= 0 and mapY < room.y then
        local tileIndex = bit.band(room.layout[layer][room.x * mapY + mapX + 1], 0xff)
        local quad = love.graphics.newQuad(
          imageHeader.x * tileIndex, 0,
          imageHeader.x, imageHeader.y,
          imageHeader.x * imageHeader.frames, imageHeader.y)
        spriteBatch:add(quad, screenX, screenY)
      end
      mapX = mapX + 1
      screenX = screenX + imageHeader.x
    end
    mapY = mapY + 1
    screenY = screenY + imageHeader.y
  end
  spriteBatch:flush()

end

function blit_scene()
  -- If llg( do_chap ) = 0 Then
  --   '' chapter screen is not up
  --   update_cam( llg( current_cam ) )
  update_cam(ll_global.current_cam)
  blit_room()
  --
  -- Else
  --   '' display a chapter screen
  --
  --   select case as const llg( hero ).chap
  --   '' allows me to hack black screens!
  --
  --     case 2
  --       Put ( 88, 28 ), llg( hero ).anim[llg( hero ).chap]->image
  --
  --   end select
  --
  -- End If
  --
  -- If llg( do_hud ) <> 0 Then
  --   blit_hud()
  --
  -- End If
  --
  -- blit_box( varptr( llg( t_rect ) ) )
  --
  --
  -- handle_MiniMap()
  --
  -- LLEngine_MouseVanish()
  --
  -- handle_pause_menu()
  --
	-- handle_fps()
  -- screenQuake()
end

function blit_room()
  -- If llg( tilesDisabled ) = FALSE Then
  --   If now_room().parallax <> 0 Then
  --   '' this room uses parallax
  --
  --      Put( 0 - ( llg( this_room ).cx \ 12 ), 0 - ( llg( this_room ).cy \ 12 ) ), @now_room().para_img->image[0]
  --
  --   End If
  --
  -- End If
  --
  -- Dim As mat_int on_tile, on_offset, optimization_matrix_2
  -- Dim As Integer save_tile_calcs, save_y_calcs, tile_blit_x, tile_blit_y
  --
  -- #Macro LLEngine_BlitLayer(lyr)
  --
  --   on_tile.x   = llg( this_room ).cx Shr 4
  --   on_offset.x = llg( this_room ).cx And &hf
  --
  --   on_tile.y   = llg( this_room ).cy Shr 4
  --   on_offset.y = llg( this_room ).cy And &hf
  --
  --   save_tile_calcs = on_tile.y * now_room().x + on_tile.x
  --   save_y_calcs = 0 - on_offset.y
  --
  --   For tile_blit_y = 0 To 208 Step llg( map )->tileset->y
  --
  --     For tile_blit_x = 0 To 320 Step llg( map )->tileset->x
  --
  --       If ( now_room().layout[ lyr ][ save_tile_calcs ] <> 0 ) Then
  --         optimization_matrix_2.y = CPtr( uByte Ptr, Varptr( now_room().layout[lyr][save_tile_calcs] ) )[0]
  --         optimization_matrix_2.x = ( optimization_matrix_2.y Shl 7 ) + ( optimization_matrix_2.y Shl 1 )
  --
  --         Put( tile_blit_x - on_offset.x, save_y_calcs ), Varptr( llg( map )->tileset->image[optimization_matrix_2.x] ), Trans
  --
  --       End If
  --
  --       save_tile_calcs += 1
  --
  --     Next
  --
  --     save_y_calcs += 16
  --     save_tile_calcs += now_room().x
  --     save_tile_calcs -= 21
  --
  --   Next
  --
  -- #EndMacro
  --
  -- If llg( tilesDisabled ) = FALSE Then
  --   '' bottom layers
  --   LLEngine_BlitLayer( 0 )
  layoutLayer(camera, map.rooms[curRoom], 1, map.imageHeader, map.imageHeader.spriteBatches[1])
  love.graphics.draw(map.imageHeader.spriteBatches[1])
  --   LLEngine_BlitLayer( 1 )
  layoutLayer(camera, map.rooms[curRoom], 2, map.imageHeader, map.imageHeader.spriteBatches[2])
  love.graphics.draw(map.imageHeader.spriteBatches[2])
  --
  -- End If
  --
  --
  -- '' draw all the entities
  --
  -- blit_y_sorted()
  blit_y_sorted()
  --
  -- if llg( hero_only ).healing <> NULL then
  --
  --   put( llg( hero ).coords.x - llg( this_room ).cx, llg( hero ).coords.y - llg( this_room ).cy - 8 ), @llg( hero_only ).healingImage->image[llg( hero_only ).healingImage->arraysize * llg( hero_only ).healingFrame], trans
  --
  -- end if
  --
  -- blit_enemy_loot()
  --
  --
  -- If llg( tilesDisabled ) = FALSE Then
  --
  --     '' top layer
  --   LLEngine_BlitLayer( 2 )
  --layoutLayer(camera, map.rooms[curRoom], 3, map.imageHeader, map.imageHeader.spriteBatches[3])
  --love.graphics.draw(map.imageHeader.spriteBatches[3])
  --
  -- End If
  --
  -- If llg( box_entity ) <> 0 Then
  --   __handle_menu( llg( box_entity ) )
  --
  -- End If
end

function blit_y_sorted()
  -- Redim As char_type Ptr y_sort( 0 )
  --
  -- Redim As char_type Ptr srt_Char( 0 )
  -- Redim As Integer srt_CharNum( 0 )
  -- Dim As Integer srt_Num, ac
  --
  -- srt_Num = 0
  --
  -- srt_Num += 1 '' enemy bank
  -- srt_Num += 1 '' temp enemy bank
  --
  --
  --
  -- Redim srt_CharNum( srt_Num - 1 )
  -- Redim srt_Char( srt_Num - 1 )
  --
  -- srt_CharNum( 0 ) = now_room().enemies
  -- srt_Char( 0 ) = now_room().enemy
  --
  -- srt_CharNum( 1 ) = now_room().temp_enemies
  -- srt_Char( 1 ) = @now_room().temp_enemy( 0 )
  --
  --
  -- '' Add concurrents to y-sorting list
  --
  -- Dim As Integer i, it
  -- For i = 0 To now_room().enemies - 1
  --
  --   If LLObject_IsWithin( Varptr( now_room().enemy[i] ) ) = 0 Then
  --     Continue For
  --
  --   End If
  --
  --   With now_room().enemy[i]
  --
  --     If .animControl[.current_anim].frame[.frame].concurrents <> 0 Then
  --
  --       For it = 0 To .animControl[.current_anim].frame[.frame].concurrents - 1
  --         '' add one.
  --
  --         srt_Num += 1
  --
  --         Redim Preserve srt_CharNum( srt_Num - 1 )
  --         Redim Preserve srt_Char( srt_Num - 1 )
  --
  --         srt_CharNum( srt_Num - 1 ) = 1
  --
  --         With .animControl[.current_anim].frame[.frame].concurrent[it]
  --           srt_Char( srt_Num - 1 ) = .char
  --
  --         End With
  --
  --       Next
  --
  --     End If
  --
  --   End With
  --
  -- Next
  --
  -- ac = sort_index( y_sort(), Varptr( srt_Char( 0 ) ), Varptr( srt_CharNum( 0 ) ), srt_Num )
  --
  -- Dim As Integer _blit_em
  --
  -- For _blit_em = 0 To ac - 1
  for i = 1, #now_room().enemies do
  --
  --   If LLObject_IsWithin( y_sort( _blit_em ) ) Then
  --
  --     blit_enemy( *y_sort( _blit_em ) )
    local enemy = now_room().enemies[i]
    blit_enemy(enemy)
  --
  --   End If
  --
  -- Next
  end
  --FIXME: For now, we're just going to blit the hero separately. Eventually
  --we will want to port or rewrite the full sorting implementation in this
  --function
  log.level = "debug"
  blit_object(ll_global.hero)
  log.level = "fatal"
end

function blit_enemy(enemy)
  -- With _enemy
  --
  --   Dim As Integer temp_x_cam, temp_y_cam
  --
  --   temp_x_cam = 0
  --   temp_y_cam = 0
  --
  --   If .no_cam = 0 Then
  --
  --     '' this object is not camera relative
  --     temp_x_cam = llg( this )_room.cx
  --     temp_y_cam = llg( this )_room.cy
  --
  --   End If
  --
  --   If llg( hero ).menu_sel <> 0 Then
  --       '' menu showing
  --
  --     If .unique_id = u_menu Or .unique_id = u_savepoint Then
  --       '' the menu is the active "enemy"
  --
  --       llg( box_entity ) = Varptr( _enemy )
  --
  --
  --     End If
  --
  --
  --   Else
  --     '' no menu
  --
  --     llg( box_entity ) = 0
  --
  --     If .projectile Then
  --
  --       If .projectile->overChar = FALSE Then
  --         '' this enemy's projectiles are under it.
  --         blit_enemy_proj( Varptr( _enemy ) )
  --
  --       End If
  --
  --     End If
  --
  --
  --
  --     If Not ( .unique_id = u_menu ) Then
  --       '' put the enemy on screen
  --
  --       blit_object( VarPtr( _enemy ) )
  blit_object(enemy)
  --
  --     End If
  --
  --
  --     If .projectile Then
  --
  --       If .projectile->overChar Then
  --         '' this enemy's projectiles are over it.
  --         blit_enemy_proj( Varptr( _enemy ) )
  --
  --       End If
  --
  --     End If
  --
  --
  --
  --     If .grult_proj_trig <> 0 Then
  --
  --       Put( .projectile->coords[0].x - llg( this )_room.cx, .projectile->coords[0].y - llg( this )_room.cy ), @.anim[.proj_anim]->image[( .projectile->travelled Mod .anim[.proj_anim]->frames ) * (.anim[.proj_anim]->arraysize)], Trans
  --
  --     End If
  --
  --     If .anger_proj_trig <> 0 Then
  --
  --       Put( .projectile->coords[0].x - llg( this )_room.cx, .projectile->coords[0].y - llg( this )_room.cy ), @.anim[.proj_anim]->image[( .projectile->travelled Mod .anim[.proj_anim]->frames ) * (.anim[.proj_anim]->arraysize)], Trans
  --
  --     End If
  --
  --
  --     If .cur_expl > 0 Then
  --
  --       Dim As Integer px, py, pf, pa, do_expl
  --
  --       For do_expl = 0 To .cur_expl - 1
  --         '' cycle through active explosions
  --
  --         With .explosion( do_expl )
  --
  --           px = .x
  --           py = .y
  --           pf = .frame
  --           pa = .alive
  --
  --         End With
  --
  --         If pa <> 0 Then
  --           '' this explosion is animating
  --
  --           With *( .anim[.expl_anim] )
  --
  --             Put ( px - temp_x_cam, py - temp_y_cam ), @.image[pf * ( .arraysize )], Trans
  --
  --           End With
  --
  --         End If
  --
  --       Next
  --
  --     End If
  --
  --   End If
  --
  -- End With
end

function blit_object(enemy)
--   With *this
--
--
--   If .invisible = 0 Then
--
--     dim as integer handShake
--     handShake = LLObject_CalculateFrame( this[0] )
--     With .anim[.current_anim]->frame[handShake]
--
--       If .sound <> 0 Then
--
--         If this->animControl[this->current_anim].frame[handShake].sound_lock = 0 Then
--
--           Dim As Integer iifCalc
--           iifCalc = Int( Rnd * 30 ) + 70
--
--           play_sample( llg( snd )[.sound], IIf( .vol <> 0, .vol, iifCalc  ) )
--           this->animControl[this->current_anim].frame[handShake].sound_lock = -1
--
--         End If
--
--       End If
--
--     End With
--
--     blit_object_ex( this )
  blit_object_ex(enemy)
--
--   End If
--
-- End With

end

function blit_object_ex(enemy)
  -- With *( this )
  --
  --   Dim As Integer f_opt, x_opt, y_opt
  --
  --
  --     x_opt = .coords.x
  local x_opt = enemy.coords.x
  --     y_opt = .coords.y
  local y_opt = enemy.coords.y
  --
  --     If .no_cam = 0 Then
  --
  --       x_opt -= llg( this_room ).cx
  x_opt = x_opt - ll_global.this_room.cx
  --       y_opt -= llg( this_room ).cy
  y_opt = y_opt - ll_global.this_room.cy
  --
  --     End If
  --
  --     f_opt = .frame
  local f_opt = enemy.frame
  log.debug("f_opt: "..f_opt)
  --
  --     With *( .anim[.current_anim] )
  --
  --       x_opt -= this->animControl[this->current_anim].x_off
  x_opt = x_opt - enemy.animControl[enemy.current_anim].x_off
  log.debug("x_opt: "..x_opt)
  --       y_opt -= this->animControl[this->current_anim].y_off
  y_opt = y_opt - enemy.animControl[enemy.current_anim].y_off
  log.debug("y_opt: "..y_opt)

  --
  --       f_opt *= .arraysize
  --
  --       If LLObject_IgnoreDirectional( this ) = 0 Then
  --         f_opt += this->direction * ( this->animControl[this->current_anim].dir_frames * .arraysize )
  --
  --       End If
  --
  --       Put( x_opt, y_opt ), varptr( .image[f_opt] ), Trans

  local anim = enemy.anim[enemy.current_anim]
  love.graphics.draw(anim.image, anim.quads[f_opt], x_opt, y_opt)
  --love.graphics.draw(anim.image, x_opt, y_opt)
--love.graphics.draw(animation.image, animation.quads[animation.frame], screenX, screenY)


  --
  --     End With
  --
  -- End With
end
