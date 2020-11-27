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
  --   blit_room()
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
  if ll_global.do_hud ~= 0 then
  --   blit_hud()
    blit_hud()
  --
  -- End If
  end
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
  if ll_global.tilesDisabled == 0 then
  --   If now_room().parallax <> 0 Then
    if now_room().parallax ~= 0 then
  --   '' this room uses parallax
  --
  --      Put( 0 - ( llg( this_room ).cx \ 12 ), 0 - ( llg( this_room ).cy \ 12 ) ), @now_room().para_img->image[0]
      love.graphics.draw(now_room().para_img.image, 0 - math.floor(ll_global.this_room.cx / 12), 0 - math.floor(ll_global.this_room.cy / 12))
  --
  --   End If
    end
  --
  -- End If
  end
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
  layoutLayer(camera, now_room(), 0, ll_global.map.tileset, ll_global.map.tileset.spriteBatches[0])
  love.graphics.draw(ll_global.map.tileset.spriteBatches[0])
  --   LLEngine_BlitLayer( 1 )
  layoutLayer(camera, now_room(), 1, ll_global.map.tileset, ll_global.map.tileset.spriteBatches[1])
  love.graphics.draw(ll_global.map.tileset.spriteBatches[1])
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
  blit_enemy_loot()
  --
  --
  -- If llg( tilesDisabled ) = FALSE Then
  --
  --     '' top layer
  --   LLEngine_BlitLayer( 2 )
  layoutLayer(camera, now_room(), 2, ll_global.map.tileset, ll_global.map.tileset.spriteBatches[2])
  love.graphics.draw(ll_global.map.tileset.spriteBatches[2])
  --
  -- End If
  --
  -- If llg( box_entity ) <> 0 Then
  if ll_global.box_entity ~= 0 then
  --   __handle_menu( llg( box_entity ) )
    __handle_menu(ll_global.box_entity)
  --
  -- End If
  end
end

function blit_y_sorted()
  -- Redim As char_type Ptr y_sort( 0 )
  local y_sort = {[0] = {}}
  --
  -- Redim As char_type Ptr srt_Char( 0 )
  local srt_Char = {[0] = {}}
  -- Redim As Integer srt_CharNum( 0 )
  local srt_CharNum = {0}
  -- Dim As Integer srt_Num, ac
  local srt_Num, ac = 0, 0
  --
  -- srt_Num = 0
  srt_Num = 0
  --
  -- srt_Num += 1 '' enemy bank
  srt_Num = srt_Num + 1
  -- srt_Num += 1 '' temp enemy bank
  srt_Num = srt_Num + 1
  --
  --
  --
  -- Redim srt_CharNum( srt_Num - 1 )
  local srt_CharNum = {0, 0}
  -- Redim srt_Char( srt_Num - 1 )
  local srt_Char = {[0] = {}, {}}
  --
  -- srt_CharNum( 0 ) = now_room().enemies
  srt_CharNum[0] = now_room().enemies
  -- srt_Char( 0 ) = now_room().enemy
  srt_Char[0] = now_room().enemy
  --
  -- srt_CharNum( 1 ) = now_room().temp_enemies
  srt_CharNum[1] = now_room().temp_enemies
  -- srt_Char( 1 ) = @now_room().temp_enemy( 0 )
  srt_Char[1] = now_room().temp_enemy
  --
  --
  -- '' Add concurrents to y-sorting list
  --
  -- Dim As Integer i, it
  local i, it = 0, 0
  -- For i = 0 To now_room().enemies - 1
  for i = 0, now_room().enemies - 1 do
  --
  --   If LLObject_IsWithin( Varptr( now_room().enemy[i] ) ) = 0 Then
    if LLObject_IsWithin(now_room().enemy[i]) == 0 then
  --     Continue For
      goto continue
  --
  --   End If
    end
  --
  --   With now_room().enemy[i]
    local with0 = now_room().enemy[i]
  --
  --     If .animControl[.current_anim].frame[.frame].concurrents <> 0 Then
    -- log.debug("with0.id: "..with0.id)
    -- log.debug("with0.frame: " ..with0.frame)
    -- log.debug("with0.current_anim: " ..with0.current_anim)
    -- log.debug("with0.animControl: " ..(with0.animControl and "exists" or "nil"))
    -- log.debug("#with0.animControl: " ..#with0.animControl)
    -- log.debug("#with0.anim: " ..#with0.anim)
    -- log.debug("with0.animControl[with0.current_anim]: "..(with0.animControl[with0.current_anim] and "exists" or "null"))
    -- log.debug("with0.animControl[with0.current_anim].frame: "..(with0.animControl[with0.current_anim].frame and "exists" or "null"))
    -- log.debug("#with0.animControl[with0.current_anim].frame: "..#with0.animControl[with0.current_anim].frame)
    -- log.debug("with0.animControl[with0.current_anim].frame[with0.frame]: "..(with0.animControl[with0.current_anim].frame[with0.frame] and "exists" or "null"))
    if with0.animControl[with0.current_anim].frame[with0.frame].concurrents ~= 0 then
  --
  --       For it = 0 To .animControl[.current_anim].frame[.frame].concurrents - 1
      for it = 0, with0.animControl[with0.current_anim].frame[with0.frame].concurrents - 1 do
  --         '' add one.
  --
  --         srt_Num += 1
        srt_Num = srt_Num + 1
  --
        --NOTE: This is resizing these arrays, not needed with Lua tables...
  --         Redim Preserve srt_CharNum( srt_Num - 1 )
  --         Redim Preserve srt_Char( srt_Num - 1 )
  --
  --         srt_CharNum( srt_Num - 1 ) = 1
        srt_CharNum[srt_Num - 1] = 1
  --
  --         With .animControl[.current_anim].frame[.frame].concurrent[it]
        local with1 = with0.animControl[with0.current_anim].frame[with0.frame].concurrent[it]
  --           srt_Char( srt_Num - 1 ) = .char
        srt_Char[srt_Num - 1] = with1.char
  --
  --         End With
  --
  --       Next
      end
  --
  --     End If
    end
  --
  --   End With
  --
  -- Next
  ::continue::
  end
  --
  -- ac = sort_index( y_sort(), Varptr( srt_Char( 0 ) ), Varptr( srt_CharNum( 0 ) ), srt_Num )
  ac = sort_index(y_sort, srt_Char, srt_CharNum, srt_Num)
  --
  -- Dim As Integer _blit_em
  --
  -- For _blit_em = 0 To ac - 1
  --log.debug("ac: "..ac)
  for _blit_em = 0, ac - 1 do
  --
  --   If LLObject_IsWithin( y_sort( _blit_em ) ) Then
    if LLObject_IsWithin(y_sort[0][_blit_em + 1]) then
  --
  --     blit_enemy( *y_sort( _blit_em ) )
      local enemy = y_sort[0][_blit_em + 1]
      blit_enemy(enemy)
  --
  --   End If
    end
  --
  -- Next
  end
end

function blit_enemy(_enemy)
  -- With _enemy
  local with0 = _enemy
  --
  --   Dim As Integer temp_x_cam, temp_y_cam
  local temp_x_cam, temp_y_cam = 0, 0
  --
  --   temp_x_cam = 0
  temp_x_cam = 0
  --   temp_y_cam = 0
  temp_y_cam = 0
  --
  --   If .no_cam = 0 Then
  if with0.no_cam == 0 then
  --
  --     '' this object is not camera relative
  --     temp_x_cam = llg( this )_room.cx
    temp_x_cam = ll_global.this_room.cx
  --     temp_y_cam = llg( this )_room.cy
    temp_y_cam = ll_global.this_room.cy
  --
  --   End If
  end
  --
  --   If llg( hero ).menu_sel <> 0 Then
  if ll_global.hero.menu_sel ~= 0 then
  --       '' menu showing
  --
  --     If .unique_id = u_menu Or .unique_id = u_savepoint Then
    if with0.unique_id == u_menu or with0.unique_id == u_savepoint then
  --       '' the menu is the active "enemy"
  --
  --       llg( box_entity ) = Varptr( _enemy )
      ll_global.box_entity = _enemy
  --
  --
  --     End If
    end
  --
  --
  --   Else
  else
  --     '' no menu
  --
  --     llg( box_entity ) = 0
    ll_global.box_entity = 0
  --
  --     If .projectile Then
    if with0.projectile ~= nil then
  --
  --       If .projectile->overChar = FALSE Then
      if with0.projectile.overChar == 0 then
  --         '' this enemy's projectiles are under it.
  --         blit_enemy_proj( Varptr( _enemy ) )

        blit_enemy_proj(_enemy)
  --
  --       End If
      end
  --
  --     End If
    end
  --
  --
  --
  --     If Not ( .unique_id = u_menu ) Then
    if not (with0.unique_id == u_menu) then
  --       '' put the enemy on screen
  --
  --       blit_object( VarPtr( _enemy ) )
      blit_object(_enemy)
  --
  --     End If
    end
  --
  --
  --     If .projectile Then
    if with0.projectile ~= nil then
  --
  --       If .projectile->overChar Then
      if with0.projectile.overChar ~= 0 then
  --         '' this enemy's projectiles are over it.
  --         blit_enemy_proj( Varptr( _enemy ) )
        blit_enemy_proj(_enemy)
  --
  --       End If
      end
  --
  --     End If
    end
  --
  --
  --
  --     If .grult_proj_trig <> 0 Then
    if with0.gult_proj_trig ~= 0 then
  --
  --       Put( .projectile->coords[0].x - llg( this )_room.cx, .projectile->coords[0].y - llg( this )_room.cy ), @.anim[.proj_anim]->image[( .projectile->travelled Mod .anim[.proj_anim]->frames ) * (.anim[.proj_anim]->arraysize)], Trans
  --
  --     End If
    end
  --
  --     If .anger_proj_trig <> 0 Then
    if with0.anger_proj_trig ~= 0 then
  --
  --       Put( .projectile->coords[0].x - llg( this )_room.cx, .projectile->coords[0].y - llg( this )_room.cy ), @.anim[.proj_anim]->image[( .projectile->travelled Mod .anim[.proj_anim]->frames ) * (.anim[.proj_anim]->arraysize)], Trans
  --
  --     End If
    end
  --
  --
  --     If .cur_expl > 0 Then
    if with0.cur_expl > 0 then
  --
  --       Dim As Integer px, py, pf, pa, do_expl
      local px, py, pf, pa, do_expl = 0, 0, 0, 0, 0, 0
  --
  --       For do_expl = 0 To .cur_expl - 1
      for do_expl = 0, with0.cur_expl - 1 do
  --         '' cycle through active explosions
  --
  --         With .explosion( do_expl )
        local with1 = with0.explosion[do_expl]
  --
  --           px = .x
        px = with1.x
  --           py = .y
        py = with1.y
  --           pf = .frame
        pf = with1.frame
  --           pa = .alive
        pa = with1.alive
  --
  --         End With
  --
  --         If pa <> 0 Then
        if pa ~= 0 then
  --           '' this explosion is animating
  --
  --           With *( .anim[.expl_anim] )
          local with1 = with0.anim[with0.expl_anim]
  --
  --             Put ( px - temp_x_cam, py - temp_y_cam ), @.image[pf * ( .arraysize )], Trans
          love.graphics.draw(with1.image, with1.quads[pf], px - temp_x_cam, py - temp_y_cam)

  --
  --           End With
  --
  --         End If
        end
  --
  --       Next
      end
  --
  --     End If
    end
  --
  --   End If
  end
  --
  -- End With
end

-- Function sort_index( ary() As char_type Ptr, bank As char_type Ptr Ptr, bank_size As Integer Ptr, banks As Integer ) As Integer Static
function sort_index(ary, bank, bank_size, banks)
  -- log.debug("#ary: "..#ary[0])
  -- log.debug("#bank: "..#bank)
  -- log.debug("#bank[0]: "..#bank[0])
  -- log.debug("#bank_size: "..#bank_size)
  -- log.debug("bank_size[0]: "..bank_size[0])
  -- log.debug("bank_size[1]: "..bank_size[1])
  -- log.debug("banks: "..banks)
--
--
--   Dim As Integer i, it, j
  local i, it, j = 0, 0, 0
--   Dim As char_type Ptr transfer
  local transfer = {}
--
--   j = 0
  j = 0
--   For i = 0 To banks - 1
  for i = 0, banks - 1 do
--     j += bank_size[i]
    j = j + bank_size[i]
--
--   Next
  end
--
--   j = iif( j = 0, 1, j )
  j = (j == 0) and 1 or j
--NOTE: Not porting redim because Lua tables
--   Redim ary( j - 1 )
--
--   j = 0
  j = 0
--   For i = 0 To banks - 1
  -- log.debug("banks - 1: "..(banks - 1))
  for i = 0, banks - 1 do
--
--     For it = 0 To bank_size[i] - 1
    -- log.debug("bank_size[i] - 1: "..(bank_size[i] - 1))
    for it = 0, bank_size[i] - 1 do
--
--       transfer = Varptr( bank[i][it] )
      transfer = bank[i][it]
--       If LLObject_IsWithin( transfer ) <> 0 Then
      if LLObject_IsWithin(transfer) ~= 0 then
--
--         ary( j ) = transfer
        ary[0][j + 1] = transfer
--         j += 1
        j = j + 1
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
  --NOTE: Not porting Redim Preserve because Lua tables
--   Redim Preserve ary( j )
--
--   ary( j ) = Varptr( llg( hero ) )
  -- log.debug("Adding hero to array...")
  ary[0][j + 1] = ll_global.hero

--
--   mergesort_y( ary() )
  -- log.debug("        #ary[0]: "..#ary[0])
  --NOTE: The original code had two sorts one after another
  --for sorting by y, then by placed. When I attempt to do
  --this it appears to mess up some of the order and I never
  --figured out why. Instead, I was able to distill sorting by
  --both properties into one sorting function where the .placed
  --property is scaled much larger than any y coordinate will ever
  --be, making it a higher priority to sort by (it is what is used to
  --make flat items always appear behind the player sprite, such as
  --save points).
  table.sort(ary[0],
    function(a, b)
      local aval = a.coords.y + a.placed * 100000
      local bval = b.coords.y + b.placed * 100000
      return aval < bval
    end)
--   mergesort_placed( ary() )
  --table.sort(ary[0], function(a, b) return a.placed < b.placed end)
--
--   Return j + 1
  return j + 1
--
-- End Function
end

-- Sub blit_enemy_loot()
function blit_enemy_loot()
--
--
--   Dim As Integer enemy_loot, conf
  local enemy_loot, conf = 0, false
--   Dim As vector_pair origin, target
  local origin, target = create_vector_pair(), create_vector_pair()
--
--
--     For enemy_loot = 0 To now_room().enemies - 1
  for enemy_loot = 0, now_room().enemies - 1 do
--
--       With now_room().enemy[enemy_loot]
    local enemy = now_room().enemy[enemy_loot]
--
--         Dim As Integer drop_check = -1, face_check
    local drop_check, face_check = true, 0

    --NOTE: I'm ignoring this convoluted logic and
    --just writing a straightforward if statement...
--
--         drop_check And= Not ( .unique_id = u_gold )
--         drop_check And= Not ( .unique_id = u_silver )
--         drop_check And= Not ( .unique_id = u_health )
    if enemy.unique_id == u_gold or
       enemy.unique_id == u_silver or
       enemy.unique_id == u_health then
      drop_check = false
    end
--
--         If drop_check = 0 Then
    if drop_check == false then
--           Continue For
      goto continue
--
--         End If
    end
--
--         If drop_check Then
    if drop_check == true then
      --log.debug("drop_check is true.")
--
--           If .dropped <> 0 Then
      if enemy.dropped ~= 0 then
--
--             Put ( .drop->coords.x - llg( this )_room.cx, .drop->coords.y - llg( this )_room.cy ), .drop->anim[.dropped - 1]->image, Trans
        local anim = enemy.drop.anim[enemy.dropped - 1]
        love.graphics.draw(anim.image, anim.quads[0], enemy.drop.coords.x - ll_global.this_room.cx, enemy.drop.coords.y - ll_global.this_room.cy)
--
--             target.u.x = .drop->coords.x
        target.u.x = enemy.drop.coords.x
--             target.u.y = .drop->coords.y
        target.u.y = enemy.drop.coords.y
--             target.v.x = 8
        target.v.x = 8
--             target.v.y = 8
        target.v.y = 8
--
--             If llg( hero ).anim[llg( hero ).current_anim]->frame[llg( hero ).frame].faces = 0 Then
        if ll_global.hero.anim[ll_global.hero.current_anim].frame[ll_global.hero.frame].faces == 0 then
--
--               conf = ( touched_bound_box( varptr( llg( hero ) ), target ) <> -1 )
          conf = (touched_bound_box(ll_global.hero, target) ~= -1)
--
--             Else
        else
--
--               conf = ( touched_frame_face( varptr( llg( hero ) ), target ) <> -1 )
          conf = (touched_frame_face(ll_global.hero, target) ~= -1)
--
--             End If
        end
--
--             If conf Then
        if conf then
--
--               Select Case .dropped
--
--                 Case 1
          if enemy.dropped == 1 then
--                   If llg( hero ).hp < llg( hero ).maxhp Then llg( hero ).hp += 1
            if ll_global.hero.hp < ll_global.hero.maxhp then
              ll_global.hero.hp = ll_global.hero.hp + 1
            end
--                   antiHackASSIGN( LL_Global.hero_only.healthDummy, LL_Global.hero.hp )
--                   play_sample( llg( snd )[sound_healthgrab] )
            ll_global.snd[sound_healthgrab]:play()
--
--                 Case 2
          elseif enemy.dropped == 2 then
--                   llg( hero ).money += ( .n_gold * 5 )
            ll_global.hero.money = ll_global.hero.money + (enemy.n_gold * 5)
--                   antiHackASSIGN( LL_Global.hero_only.moneyDummy, LL_Global.hero.money )
--                   play_sample( llg( snd )[sound_cashget] )
            ll_global.snd[sound_cashget]:play()
--
--                 Case 3
          elseif enemy.dropped == 3 then
--                   llg( hero ).money += ( .n_silver )
            ll_global.hero.money = ll_global.hero.money + (enemy.n_silver)
--                   antiHackASSIGN( LL_Global.hero_only.moneyDummy, LL_Global.hero.money )
--                   play_sample( llg( snd )[sound_cashget] )
            ll_global.snd[sound_cashget]:play()
--
--               End Select
          end
--
--               .dropped = 0
          enemy.dropped = 0
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
--       End With
--
--     Next
    ::continue::
  end
--
-- End Sub
end

function blit_object(this)
--   With *this
  local with0 = this
--
--
--   If .invisible = 0 Then
  if this.invisible == 0 then
--
--     dim as integer handShake
--     handShake = LLObject_CalculateFrame( this[0] )
    local handShake = LLObject_CalculateFrame(this)
--     With .anim[.current_anim]->frame[handShake]
    local with1 = with0.anim[with0.current_anim].frame[handShake]
--
--       If .sound <> 0 Then
    if with1.sound ~= 0 then
--
--         If this->animControl[this->current_anim].frame[handShake].sound_lock = 0 Then
      if this.animControl[this.current_anim].frame[handShake].sound_lock == 0 then
        --log.debug("play frame sound for: "..this.id)
--
--           Dim As Integer iifCalc
--           iifCalc = Int( Rnd * 30 ) + 70
        local iifCalc = (math.floor(math.random() * 30) + 70) / 100
--
--           play_sample( llg( snd )[.sound], IIf( .vol <> 0, .vol, iifCalc  ) )
        --ll_global.snd[with1.sound]:setVolume((with1.vol ~= 0) and with1.vol or iifCalc)
        ll_global.snd[with1.sound]:play()
--           this->animControl[this->current_anim].frame[handShake].sound_lock = -1
        this.animControl[this.current_anim].frame[handShake].sound_lock = -1
--
--         End If
      end
--
--       End If
    end
--
--     End With
--
--     blit_object_ex( this )
    blit_object_ex(this)
--
--   End If
  end
--
-- End With

end

function blit_object_ex(this)
  -- With *( this )
  local with0 = this
  --
  --   Dim As Integer f_opt, x_opt, y_opt
  local f_opt, x_opt, y_opt = 0, 0, 0
  --
  --
  --     x_opt = .coords.x
  x_opt = with0.coords.x
  --     y_opt = .coords.y
  y_opt = with0.coords.y
  --
  --     If .no_cam = 0 Then
  if with0.no_cam == 0 then
  --
  --       x_opt -= llg( this_room ).cx
    x_opt = x_opt - ll_global.this_room.cx
  --       y_opt -= llg( this_room ).cy
    y_opt = y_opt - ll_global.this_room.cy
  --
  --     End If
  end
  --
  --     f_opt = .frame
  f_opt = with0.frame
  --log.debug("f_opt: "..f_opt)
  --
  --     With *( .anim[.current_anim] )
  --
  --       x_opt -= this->animControl[this->current_anim].x_off
  x_opt = x_opt - this.animControl[this.current_anim].x_off
  --log.debug("x_opt: "..x_opt)
  --       y_opt -= this->animControl[this->current_anim].y_off
  y_opt = y_opt - this.animControl[this.current_anim].y_off
  --log.debug("y_off: "..enemy.animControl[enemy.current_anim].y_off)
  --log.debug("y_opt: "..y_opt)
  --log.debug("enemy.animControl[enemy.current_anim].dir_frames: "..enemy.animControl[enemy.current_anim].dir_frames)
  --
  --       f_opt *= .arraysize
  --
  --       If LLObject_IgnoreDirectional( this ) = 0 Then
  if LLObject_IgnoreDirectional(this) == 0 then
  --         f_opt += this->direction * ( this->animControl[this->current_anim].dir_frames * .arraysize )
    f_opt = f_opt + this.direction * this.animControl[this.current_anim].dir_frames
  --
  --       End If
  end
  --
  --       Put( x_opt, y_opt ), varptr( .image[f_opt] ), Trans

  local anim = with0.anim[with0.current_anim]
  love.graphics.draw(anim.image, anim.quads[f_opt], x_opt, y_opt)
  --love.graphics.draw(anim.image, x_opt, y_opt)
--love.graphics.draw(animation.image, animation.quads[animation.frame], screenX, screenY)


  --
  --     End With
  --
  -- End With
end

-- Sub blit_hud( e As _char_type Ptr = 0 )
function blit_hud(e)
--
--   If e = 0 Then e = Varptr( llg( hero ) )
  e = e or ll_global.hero
--
--   Static As Double ll_low_health
  local ll_low_health = 0.0
--   Dim As Integer key_Put
  local key_Put = 0
--
--   With *e
  local with0 = e
--
--     hud_BlitMain( e )
  hud_BlitMain(e)
--     hud_BlitEnemies()
--
--
--     scope
--
--       if llg( hero_only ).selected_item = 3 then
--
--
--         if llg( hero_only ).has_weapon = 2 then
--           ''templewood
--           Put( 132, 8 ), llg( hud ).img(1)->image, Trans
--
--         elseif llg( now )[1206] then
--           ''templewood
--           Put( 132, 8 ), llg( hud ).img(8)->image, Trans
--
--         elseif llg( now )[470] then
--
--           Put( 132, 8 ), llg( hud ).img(7)->image, Trans
--
--         else
--           Put( 132, 8 ), @llg( hud ).img(1)->image[llg( hero_only ).selected_item * llg( hud ).img(1)->arraysize], Trans
--
--         end if
--
--       else
--         Put( 132, 8 ), @llg( hud ).img(1)->image[llg( hero_only ).selected_item * llg( hud ).img(1)->arraysize], Trans
--
--       end if
--
--       '' selected item
--
--     end scope
--
--
--
--
--     If llg( map )->isDungeon Then
--       '' regular key
--
--       If llg( hero_only ).b_key <> 0 Then
--         Put( 8, 164 ), llg( hud ).img(6)->image, Trans
--
--       End If
--
--       For key_Put = 0 To llg( hero ).key - 1
--
--         Put( 8 + (key_Put * 8) , 180 ), llg( hud ).img(5)->image, Trans
--
--       Next
--
--     End If
--
--     '' dollar sign
--     Put( 275, 8 ), @llg( hud ).img(2)->image[0], Trans
  love.graphics.draw(ll_global.hud.img[2].image, ll_global.hud.img[2].quads[0], 275, 8)
--
--     if .money < 0 then
  if with0.money < 0 then
--       .money = 0
    with0.money = 0
--       antiHackASSIGN( LL_Global.hero_only.moneyDummy, LL_Global.hero.money )
--
--     end if
  end
--
--     if .money > 999 then
  if with0.money > 999 then
--       .money = 999
    with0.money = 999
--       antiHackASSIGN( LL_Global.hero_only.moneyDummy, LL_Global.hero.money )
--
--     end if
  end
--
--     Scope
--
--       Dim mny As String
  local mny = ""
--
--         mny = String( 3 - Len( Str( .money ) ), "0" )
--         mny += Str( .money )
  --log.debug("with0.money: "..with0.money)
  for i = 1, 3 - #(""..with0.money) do
    mny = mny.."0"
  end
  mny = mny..(""..with0.money)
  --log.debug("mny: "..mny)
--
--       Dim As Integer nums
  local nums = 0
--
--         For nums = 0 To 2
  for nums = 0, 2 do
--
--           Put ( 289 + ( nums Shl 3 ), 8 ), @llg( hud ).img(3)->image[( mny[nums] - 48 ) * llg( hud ).img(3)->arraysize], Trans
    love.graphics.draw(ll_global.hud.img[3].image, ll_global.hud.img[3].quads[mny:byte(nums + 1) - 48], 289 + nums * 8, 8)
-- '          Put ( 289 + ( nums * 8 ), 8 ), @llg( hud ).img(3).image[( mny[nums] - 48 ) * llg( hud ).img(3).arraysize], Trans
--
--         Next
  end
--
--     End Scope
--
--
--     If .hp <= int( llg( hero ).maxhp / 3 ) Then
--
--       If ll_low_health = 0 Then
--
--         play_sample( llg( snd )[sound_lowhealth] )
--
--
--
--         ll_low_health = Timer + 1.5
--
--         If .hp <= cint( llg( hero ).maxhp / 6.5 ) Then
--           ll_low_health = Timer + .75
--
--
--         End If
--
--       End If
--
--     End If
--
--
--     If Timer > ll_low_health Then
--       ll_low_health = 0
--
--     End If
--
--     if llg( hero_only ).adrenaline = NULL then
--       Put( 12, 24 ), llg( hud ).img(4)->image, Trans
--
--       Dim As Integer crazy_Ceiling = llg( hero_only ).crazy_points
--       If crazy_Ceiling > 100 Then
--         crazy_Ceiling = 100
--
--       End If
--       '' 15, 27
--       If ( llg( hero_only ).crazy_points ) > 0 Then
--
--         Line( 15, 27 )-( 15 + ( crazy_Ceiling ), 30 ), 26, bf
--
--       End If
--
--     end if
--
--   End With
--
--
-- End Sub
end

-- Sub hud_BlitMain( this As char_type Ptr )
function hud_BlitMain(this)
--
--
--   With *( this )
--
--     Dim As Integer p, x_opt, y_opt
  local p, x_opt, y_opt = 0, 0, 0
--
--       For p = 0 To 29
  for p = 0, 29 do
--
--         x_opt = ( ( p Mod 15 ) Shl 3 ) + 8
    x_opt = bit.lshift(p % 15, 3) + 8
--         y_opt = ( ( p  \  15 ) Shl 3 ) + 8
    y_opt = bit.lshift(math.floor(p / 15), 3) + 8
--
--         If ( .hp  > p )Then
    if this.hp > p then
--           Put( x_opt, y_opt ), varptr( llg( hud ).img(0)->image[0] ), Trans
      love.graphics.draw(ll_global.hud.img[0].image, ll_global.hud.img[0].quads[0], x_opt, y_opt)
--
--         ElseIf (.maxhp ) > p Then
    elseif this.maxhp > p then
--           Put( x_opt, y_opt ), varptr( llg( hud ).img(0)->image[34] ), Trans
      love.graphics.draw(ll_global.hud.img[0].image, ll_global.hud.img[0].quads[1], x_opt, y_opt)
--
--         Else
    else
--           Put( x_opt, y_opt ), varptr( llg( hud ).img(0)->image[68] ), Trans
      love.graphics.draw(ll_global.hud.img[0].image, ll_global.hud.img[0].quads[2], x_opt, y_opt)
--
--         End If
    end
--
--       Next
  end
--
--
--   End With
--
--
-- End Sub
end

-- Sub shift_pal()
function shift_pal()
  -- log.debug("shift_pal called.")
--
--
--   Dim As Integer cols, jmper, res( 255 )
  local cols, jmper = 0, 0
--
--   For cols = 0 To 255
  for cols = 0, 255 do
--
--     For jmper = 0 To 16 Step 8
--
--       res( cols ) Or= Int(                                              _
--                            (                                            _
--                              ( 5 - ( llg( dark ) * .66 ) ) / 5          _
--                            ) *                                          _
--                              (                                          _
--                                ( fb_Global.display.pal[cols] Shr jmper ) And &hff _
--                              )                                          _
--                          ) Shl( jmper )
    palette[cols][0] = ((5 - ( ll_global.dark * .66)) / 5) * (masterPalette[cols][0])
    palette[cols][1] = ((5 - ( ll_global.dark * .66)) / 5) * (masterPalette[cols][1])
    palette[cols][2] = ((5 - ( ll_global.dark * .66)) / 5) * (masterPalette[cols][2])
--
--     Next
--
--   Next
  end
--
--   Palette Using res
--
--
-- End Sub
end
