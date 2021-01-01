require("game/constants")
require("game/engine_enums")
require("game/macros")

function init_quad_pool()
  quad_pool = {}
  for i = 1, 1024 do
    quad_pool[i] = love.graphics.newQuad(0, 0, 0, 0, 0, 0)
  end
  quad_pool_index = 1
end

function get_next_quad()
  local result = quad_pool[quad_pool_index]
  quad_pool_index = quad_pool_index + 1
  return result
end

function reset_quad_pool()
  quad_pool_index = 1
end

--Updates a room using the tile indices from the room to arrange
--the spritebatch for drawing, based on an image header.
function layoutLayer(camera, room, layer, imageHeader, spriteBatch)
  if drawing then
    spriteBatch:clear()
    local topLeftMapX = math.floor(ll_global.this_room.cx / imageHeader.x)
    local topLeftMapY = math.floor(ll_global.this_room.cy / imageHeader.y)
    local topLeftScreenX = -math.floor(ll_global.this_room.cx % imageHeader.x)
    local topLeftScreenY = -math.floor(ll_global.this_room.cy % imageHeader.y)
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
          local quad = get_next_quad()
          quad:setViewport(
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
end

-- sub graphicalString( printString as string, byval x as integer, byval y as integer, byval col as integer = 15 )
function graphicalString(printString, x, y, col)
  local col = col and col or 15
--
--   dim as integer letterIteration
  local letterIteration = 1
--
--   for letterIteration = 0 to len( printString ) - 1
  for letterIteration = 1, #printString do
--
--     put( x, y ), varptr( llg( font )->image[llg( font )->arraysize * printString[letterIteration]] ), trans
    draw(ll_global.font.image, ll_global.font.quads[string.byte(printString, letterIteration)], x, y)
--
--     x += 8
    x = x + 8
--
--     if printString[letterIteration] = 10 then
    if string.byte(printString, letterIteration) == 10 then
--       y += 16
      y = y + 16
--       x = 0
      x = 0
--
--     end if
    end
--
--
--   next
  end
--
-- end sub
end

function blit_scene()
  -- If llg( do_chap ) = 0 Then
  if ll_global.do_chap == 0 then
  --   '' chapter screen is not up
  --   update_cam( llg( current_cam ) )
    update_cam(ll_global.current_cam)
  --   blit_room()
    blit_room()
  --
  -- Else
  else
  --   '' display a chapter screen
  --
  --   select case as const llg( hero ).chap
  --   '' allows me to hack black screens!
  --
  --     case 2
      if ll_global.hero.chap == 2 then
  --       Put ( 88, 28 ), llg( hero ).anim[llg( hero ).chap]->image
        draw(ll_global.hero.anim[ll_global.hero.chap].image, 88, 28)
      end
  --
  --   end select
  --
  -- End If
  end
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
  blit_box(ll_global.t_rect)
  --
  --
  -- handle_MiniMap()
  handle_MiniMap()
  --
  -- LLEngine_MouseVanish()
  --
  -- handle_pause_menu()
  handle_pause_menu()
  --
	-- handle_fps()
  -- screenQuake()
  screenQuake()
end

function blit_room()
  -- If llg( tilesDisabled ) = FALSE Then
  if ll_global.tilesDisabled == 0 then
  --   If now_room().parallax <> 0 Then
    if now_room().parallax ~= 0 then
  --   '' this room uses parallax
  --
  --      Put( 0 - ( llg( this_room ).cx \ 12 ), 0 - ( llg( this_room ).cy \ 12 ) ), @now_room().para_img->image[0]
      draw(now_room().para_img.image, 0 - math.floor(ll_global.this_room.cx / 12), 0 - math.floor(ll_global.this_room.cy / 12))
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
  draw(ll_global.map.tileset.spriteBatches[0])
  --   LLEngine_BlitLayer( 1 )
  layoutLayer(camera, now_room(), 1, ll_global.map.tileset, ll_global.map.tileset.spriteBatches[1])
  draw(ll_global.map.tileset.spriteBatches[1])
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
  draw(ll_global.map.tileset.spriteBatches[2])
  --
  -- End If
  --
  -- If llg( box_entity ) <> 0 Then
  if ll_global.box_entity ~= nil then
  --   __handle_menu( llg( box_entity ) )
    __handle_menu(ll_global.box_entity)
  --
  -- End If
  end
end

--NOTE: y-sorting was re-written from a 1:1 port from the original
--codebase. It was originally done 1:1 out of concern for not knowing
--what all the code was doing when first ported, but once clearly
--understood it was helpful to rewrite this code because it was creating
--a lot of new tables every frame which contributed to occasional stuttering
--from garbage collection.
function blit_y_sorted()
  --Clear global sorted objects list
  for k, v in pairs(ll_global.sorted_objects) do
    ll_global.sorted_objects[k] = nil
  end

  --Add all enemies and their concurrents to the sorted objects list
  for i = 0, now_room().enemies - 1 do
    if LLObject_IsWithin(now_room().enemy[i]) ~= 0 then
      local with0 = now_room().enemy[i]
      table.insert(ll_global.sorted_objects, with0)
      if with0.animControl[with0.current_anim].frame[with0.frame].concurrents ~= 0 then
        for it = 0, with0.animControl[with0.current_anim].frame[with0.frame].concurrents - 1 do
          local with1 = with0.animControl[with0.current_anim].frame[with0.frame].concurrent[it]
          table.insert(ll_global.sorted_objects, with1.char)
        end
      end
    end
  end

  --Add all temp enemies to the sorted objects list
  for i = 0, now_room().temp_enemies - 1 do
    if LLObject_IsWithin(now_room().temp_enemy[i]) ~= 0 then
      local with0 = now_room().temp_enemy[i]
      table.insert(ll_global.sorted_objects, with0)
    end
  end

  --Add the hero to the sorted objects list
  table.insert(ll_global.sorted_objects, ll_global.hero)

  --Now sort the objects by placed and then by y coord.
  table.sort(ll_global.sorted_objects,
    function(a, b)
      local aval = a.coords.y + a.placed * 100000
      local bval = b.coords.y + b.placed * 100000
      return aval < bval
    end)

  --Now blit 'em
  for _blit_em = 1, #ll_global.sorted_objects do
    local enemy = ll_global.sorted_objects[_blit_em]
    blit_enemy(enemy)
  end
end

-- Sub blit_box( t_box As boxcontrol_type Ptr )
function blit_box(t_box)
--
--
--
--   Dim As Integer lup, s_a_d
  local lup, s_a_d = 0, 0
--
--     With *t_box
  local with0 = t_box
--
--   #define currentChar() .ptrs.row[.internal.current_line][.internal.opcount]
  local function currentChar()
    return with0.ptrs.row[with0.internal.current_line]:byte(with0.internal.opcount)
  end
--
--   #macro text_sound()
  local function text_sound()
--
--     If .internal.sound = 0 Then
    if with0.internal.sound == 0 then
--
--       If currentChar() <> 0 Then
      if currentChar() ~= 0 then

--
--         If currentChar() <> 32 Then
        if currentChar() ~= 32 then
--
--           play_sample( llg( snd )[sound_texttemp], 25 )
          ll_global.snd[sound_texttemp][with0.internal.opcount % 4]:setVolume(.25)
          ll_global.snd[sound_texttemp][with0.internal.opcount % 4]:play()
--
--           .internal.sound = -1
          with0.internal.sound = -1
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
--   #endmacro
  end
--       If .internal.hold_box <> 0 Then
  --log.debug("with0.internal.hold_box: "..with0.internal.hold_box)
  --log.debug("with0.layout.invis: "..with0.layout.invis)
  --log.debug("with0.box: "..(with0.box and "exists" or "nil"))
  if with0.internal.hold_box ~= 0 then
--
--         If .layout.invis = 0 Then
    if with0.layout.invis == 0 then
--           Put( .layout.x_loc, .layout.y_loc ), .ptrs.box->image, Trans
      draw(with0.ptrs.box.image, with0.layout.x_loc, with0.layout.y_loc)
--
--         End If
    end
--
--
--       End If
  end
--
--       If Timer > .internal.hold_box Then
  if timer > with0.internal.hold_box then
--         .internal.hold_box = 0
    with0.internal.hold_box = 0
--
--       End If
  end
--
--
--       If .activated Then
  if with0.activated ~= 0 then
--         '' box active
--         If llg( hero )_only.action Then
    if ll_global.hero_only.action ~= 0 then
--           '' pressed space
--           If .internal.state <> TEXTBOX_CONFIRMATION Then
      if with0.internal.state ~= TEXTBOX_CONFIRMATION then
--             '' not waitin..
--             With .internal'
        local with1 = with0.internal
--
--               Do
        repeat
--                 '' jump to the end of this "page"
--                 If .current_line = ( .numoflines - 1 ) Then
          if with1.current_line == (with1.numoflines - 1) then
--                   .jump_switch = box_kill_switch
            with1.jump_switch = box_kill_switch
--                   Exit Do
            break
--
--                 End If
          end
--
--                 If ( .current_line And 3 ) = 3 Then
          if bit.band(with1.current_line, 3) == 3 then
--                   Exit Do
            break
--
--                 End If
          end
--
--                 .current_line += 1
          with1.current_line = with1.current_line + 1
--
--               Loop
        until false
--
--               .opcount = Len( t_box->ptrs.row[.current_line] ) - 1
        with1.opcount = #t_box.ptrs.row[with1.current_line] - 1
--               .state = TEXTBOX_CONFIRMATION
        with1.state = TEXTBOX_CONFIRMATION
--
--             End With
--
--             llg( hero_only ).action = 0
        ll_global.hero_only.action = 0
--
--           End If
      end
--
--         End If
    end
--
--         If Not .layout.invis Then Put(.layout.x_loc, .layout.y_loc), @.ptrs.box->image[0], Trans
    if with0.layout.invis == 0 then
      draw(with0.ptrs.box.image, with0.layout.x_loc, with0.layout.y_loc)
    end
--
--         Select Case as const .internal.state
--
--           Case TEXTBOX_REGULAR
    if with0.internal.state == TEXTBOX_REGULAR then
--
--             top_rows( t_box )
      top_rows(t_box)
--             current_row( t_box )
      current_row(t_box)
--
--             text_sound()
      text_sound()
--
--             If .internal.opcount = Len( .ptrs.row[.internal.current_line] ) Then
      if with0.internal.opcount == #with0.ptrs.row[with0.internal.current_line] then
--               '' current char is at the end of the current line.
--               If .internal.current_line = ( .internal.numoflines - 1 ) Then
        if with0.internal.current_line == (with0.internal.numoflines - 1) then
--                 '' last line of the message
--
--                 .internal.opcount -= 1
          with0.internal.opcount = with0.internal.opcount - 1
--                 .internal.state = TEXTBOX_CONFIRMATION
          with0.internal.state = TEXTBOX_CONFIRMATION
--                 .internal.jump_switch = box_kill_switch
          with0.internal.jump_switch = box_kill_switch
--
--               else
        else
--
--                 If ( .internal.current_line And 3 ) = 3 Then
          if bit.band(with0.internal.current_line, 3) == 3 then
--                   '' last line of the page
--                   .internal.opcount -= 1
            with0.internal.opcount = with0.internal.opcount - 1
--                   .internal.state = TEXTBOX_CONFIRMATION
            with0.internal.state = TEXTBOX_CONFIRMATION
--                   .internal.jump_switch = box_jump_back
            with0.internal.jump_switch = box_jump_back
--
--                 else
          else
--
--                   .internal.opcount = 0
            with0.internal.opcount = 0
--                   .internal.current_line += 1
            with0.internal.current_line = with0.internal.current_line + 1
--
--                 End If
          end
--
--               End If
        end
--
--             End If
      end
--
--
--           Case TEXTBOX_CONFIRMATION
    elseif with0.internal.state == TEXTBOX_CONFIRMATION then
--
--             top_rows( t_box )
      top_rows(t_box)
--             current_row( t_box )
      current_row(t_box)
--
--             If .internal.confBox = TRUE Then
      log.debug("confBox: "..with0.internal.confBox)
      if with0.internal.confBox == TRUE then
        log.debug("confBox is true")
--
--               dim as integer fg
        local fg = nil
--
--               fg = llg( fontFG )
        fg = ll_global.font
--
--
        if with0.selected == 0 then
--
--                 __set_font_fg( cast( any ptr, 92 ) )
--               if .selected = 0 then
          --NOTE: See engine_init for how we are addressing font colors.
          ll_global.font = ll_global.fontYellow
--
--               end if
        end
--
--               graphicalString( "Yes", _
--                                .layout.x_loc + 9 + ( 10 shl 3 ), _
--                                .layout.y_loc + 8 + ( 3 Shl 4 ), _
--                                .internal.txtcolor _
--                              )
        graphicalString("Yes",
                        with0.layout.x_loc + 9 + bit.lshift(10, 3),
                        with0.layout.y_loc + 8 + bit.lshift(3, 4),
                        with0.internal.txtcolor)
--
--               if .selected = 0 then
        if with0.selected == 0 then
--
--                 __set_font_fg( cast( any ptr, fg ) )
          ll_global.font = fg
--                 if multikey( sc_right ) then
          if input:pressed("right") then
--
--                   .selected = 1
            with0.selected = 1
--
--                 end if
          end
--
--
--               end if
        end
--
--
--               if .selected = 1 then
        if with0.selected == 1 then
--
--                 __set_font_fg( cast( any ptr, 92 ) )
          --NOTE: See engine_init for how we are addressing font colors.
          ll_global.font = ll_global.fontYellow
--
--               end if
        end
--               graphicalString( "No", _
--                                .layout.x_loc + 9 + ( 26 shl 3 ), _
--                                .layout.y_loc + 8 + ( 3 Shl 4 ), _
--                                .internal.txtcolor _
--                              )
        graphicalString("No",
                        with0.layout.x_loc + 9 + bit.lshift(26, 3),
                        with0.layout.y_loc + 8 + bit.lshift(3, 4),
                        with0.internal.txtcolor)
--
--               if .selected = 1 then
        if with0.selected == 1 then
--
--                 __set_font_fg( cast( any ptr, fg ) )
          ll_global.font = fg
--                 if multikey( sc_left ) then
          if input:pressed("left") then
--
--                   .selected = 0
            with0.selected = 0
--
--                 end if
          end
--
--               end if
        end
--
--               If multikey( sc_enter ) Then
        if input:pressed("action") then
--
--                 .internal.state = TEXTBOX_SHUTDOWN
          with0.internal.state = TEXTBOX_SHUTDOWN
--
--               End If
        end
--
--             else
      else
--
--
--               If .internal.flashbox = TRUE then
        if with0.internal.flashbox == true then
          --log.debug("flashbox is true")
--
--                 If( .layout.invis = FALSE ) Then
          if (with0.layout.invis == 0) then
--
--                   Put (.layout.x_loc + 304, .layout.y_loc + 64 ), .ptrs.next->image, Trans
            draw(with0.ptrs.Next.image, with0.layout.x_loc + 304, with0.layout.y_loc + 64)
--
--                 End If
          end
--
--               End if
        end
--
--               If Timer >= .internal.flashhook Then
        if timer >= with0.internal.flashhook then
--
--                 .internal.flashhook = Timer + .18
          with0.internal.flashhook = timer + .18
--                 .internal.flashbox = iif( .internal.flashbox = FALSE, TRUE, FALSE )
          with0.internal.flashbox = iif(with0.internal.flashbox == false, true, false)
--
--               End If
        end
--
--               If .internal.auto = TRUE Then
        if with0.internal.auto ~= 0 then
--
--                 If .internal.autohook = NULL Then
          if with0.internal.autohook == 0 then
--                   .internal.autohook = Timer + .internal.autosleep
            with0.internal.autohook = timer + with0.internal.autosleep
--
--                 End If
          end
--
--                 If Timer >= .internal.autohook Then
          if timer >= with0.internal.autohook then
--                   .internal.state = TEXTBOX_SHUTDOWN
            with0.internal.state = TEXTBOX_SHUTDOWN
--                   .internal.autohook = NULL
            with0.internal.autohook = 0
--
--                 End If
          end
--
--
--               End If
        end
--
--               If llg( hero_only ).action Then
        if ll_global.hero_only.action ~= 0 then
--
--                 Select Case as const .internal.jump_switch
--
--                   Case box_kill_switch
          if with0.internal.jump_switch == box_kill_switch then
--                     .internal.state = TEXTBOX_SHUTDOWN
            with0.internal.state = TEXTBOX_SHUTDOWN
--
--                   Case box_jump_back
          elseif with0.internal.jump_switch == box_jump_back then
--                     .internal.state = TEXTBOX_REGULAR
            with0.internal.state = TEXTBOX_REGULAR
--                     .internal.current_line += 1
            with0.internal.current_line = with0.internal.current_line + 1
--                     .internal.opcount = 0
            with0.internal.opcount = 0
--
--                 End Select
          end
--
--               End If
        end
--
--             End If
      end
--
--           Case TEXTBOX_SHUTDOWN
    elseif with0.internal.state == TEXTBOX_SHUTDOWN then
--
--             .activated = FALSE
      with0.activated = 0
--             .internal.hold_box = Timer + .03
      with0.internal.hold_box = timer + .03
--             __set_font_fg( cast( any ptr, llg( t_rect ).internal.lastFG ) )
--
--         End Select
    end
--
--         If .internal.state <> TEXTBOX_CONFIRMATION Then
    if with0.internal.state ~= TEXTBOX_CONFIRMATION then
--
--           If Timer > .layout._timer Then
      if timer > with0.layout._timer then
--             .internal.opcount += 1
        with0.internal.opcount = with0.internal.opcount + 1
--
--             .internal.sound = 0
        with0.internal.sound = 0
--             .layout._timer = Timer + .layout.speed
        with0.layout._timer = timer + with0.layout.speed
--
--           End If
      end
--
--           dim as integer destroySpace
      local destroySpace = 0
--
      local function seekChar(__x__)
        local index = with0.internal.opcount + __x__
        return with0.ptrs.row[with0.internal.current_line]:sub(index, index)
      end
--           do
      repeat
--             #define seekChar(__x__) .ptrs.row[.internal.current_line][.internal.opcount + __x__]
--
--             if destroySpace + .internal.opcount = Len( .ptrs.row[.internal.current_line] ) then
        if destroySpace + with0.internal.opcount == #with0.ptrs.row[with0.internal.current_line] then
--               '' hit the end of the line
--               exit do
          break
--
--             end if
        end
--
--             if( seekChar( destroySpace ) <> 0 ) then
        if (seekChar(destroySpace) ~= 0) then
--
--               if( seekChar( destroySpace ) <> 32 ) then
          if (seekChar(destroySpace) ~= ' ') then
--                 '' regular char, increment
--                 exit do
            break
--
--               end if
          end
--
--             end if
        end
--
--             destroySpace += 1
        destroySpace = destroySpace + 1
--
--           loop
      until false
--
--           .internal.opcount += destroySpace
      with0.internal.opcount = with0.internal.opcount + destroySpace
      log.debug("with0.internal.opcount: "..with0.internal.opcount)
--
--         End If
    end
--
--       End If
  end
--
--     End With
--
-- End Sub
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
    ll_global.box_entity = nil
  --
  --     If .projectile Then
    if with0.projectile ~= nil then
  --
  --       If .projectile->overChar = FALSE Then
      if with0.projectile.overChar == FALSE then
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
          draw(with1.image, with1.quads[pf], px - temp_x_cam, py - temp_y_cam)

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

-- Sub blit_enemy_proj( _enemy As char_type Ptr )
function blit_enemy_proj(_enemy)
--
--   Dim As Integer show_proj
  local show_proj = 0
--
--   With *_enemy
  local with0 = _enemy
--
--     Select Case .proj_style
--
--       Case PROJECTILE_ORB, PROJEcTILE_BEAM
  if with0.proj_style == PROJECTILE_ORB or with0.proj_style == PROJECTILE_BEAM then
--
--         If .projectile->invisible = 0 Then
    if with0.projectile.invisible == 0 then
--           '' this projectile is visible
--           If .projectile->coords[0].x <> 0 Or .projectile->coords[0].y <> 0 Then
      if with0.projectile.coords[0].x ~= 0 or with0.projectile.coords[0].y ~= 0 then
--             '' this projectile is active
--             If .proj_style = PROJECTILE_ORB Then
        if with0.proj_style == PROJECTILE_ORB then
--               '' the projectile is uni-directional
--               If ( .projectile->travelled <> 1 ) Then
          if (with0.projectile.travelled ~= 1) then
--                 '' projectile->travelled has incremented at least twice (once, kind of <.<)
--                 Put ( .projectile->coords[0].x - llg( this )_room.cx, .projectile->coords[0].y - llg( this )_room.cy ), @.anim[.proj_anim]->image[( .projectile->travelled Mod .anim[.proj_anim]->frames ) * (.anim[.proj_anim]->arraysize)], Trans
            --draw(with0.projectile.coords[0].x - ll_global.this_room.cx, with0.projectile.coords[0].y - ll_global.this_room.cy, with0.anim[with0.proj_anim].image[with0.projectile.travelled % with0.anim[with0.proj_anim].frames) * (with0.anim[with0.proj_anim].arraysize)])
            draw(with0.anim[with0.proj_anim].image, with0.anim[with0.proj_anim].quads[with0.projectile.travelled % with0.anim[with0.proj_anim].frames], with0.projectile.coords[0].x - ll_global.this_room.cx, with0.projectile.coords[0].y - ll_global.this_room.cy)
--
--               End If
          end
--
--             ElseIf .proj_style = PROJECTILE_BEAM Then
        elseif with0.proj_style == PROJECTILE_BEAM then
--               '' this projectile changes based on direction
--               If ( .projectile->travelled <> 1 ) Or ( .unique_id = u_dyssius ) Or ( .unique_id = u_steelstrider ) Then
          if (with0.projectile.travelled ~= 1) or (with0.unique_id == u_dyssius) or (with0.unique_id == u_steelstrider) then
--                 '' projectile->travelled has incremented at least twice (once, kind of <.<), disregarded for boss 2
--                 For show_proj = 0 To 1
            for show_proj = 0, 1 do
--
--                   Put ( .projectile->coords[show_proj].x - llg( this )_room.cx, .projectile->coords[show_proj].y - llg( this )_room.cy  ), @.anim[.proj_anim]->image[( .projectile->direction And 1 ) * .anim[.proj_anim]->arraysize], Trans
              draw(with0.anim[with0.proj_anim].image, with0.anim[with0.proj_anim].quads[bit.band(with0.projectile.direction, 1)], with0.projectile.coords[show_proj].x - ll_global.this_room.cx, with0.projectile.coords[show_proj].y - ll_global.this_room.cy)
--
--                 Next
            end
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
--         End If
    end
--
--       Case Else ' PROJECTILE_CROSS, PROJECTILE_DIAGONAL, PROJECTILE_8WAY, PROJECTILE_SCHIZO, PROJECTILE_SPIRAL, PROJECTILE_SUN
  else
--
--         For show_proj = 0 To .projectile->projectiles - 1
    for show_proj = 0, with0.projectile.projectiles - 1 do
--           '' cycle thru the projectiles
--           If .projectile->coords[show_proj].x <> 0 Or .projectile->coords[show_proj].y <> 0  Then
      if with0.projectile.coords[show_proj].x ~= 0 or with0.projectile.coords[show_proj].y ~= 0 then
--             '' this projectile is active
--             If .projectile->invisible = 0 Then
        if with0.projectile.invisible == 0 then
--               '' this projectile is visible
--               Put ( .projectile->coords[show_proj].x - llg( this )_room.cx, .projectile->coords[show_proj].y - llg( this )_room.cy  ), @.anim[.proj_anim]->image[(.projectile->travelled Mod .anim[.proj_anim]->frames ) * ( .anim[.proj_anim]->arraysize )], Trans
          draw(with0.anim[with0.proj_anim].image, with0.anim[with0.proj_anim].quads[with0.projectile.travelled % with0.anim[with0.proj_anim].frames], with0.projectile.coords[show_proj].x - ll_global.this_room.cx, with0.projectile.coords[show_proj].y - ll_global.this_room.cy)
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
--     End Select
  end
--
--   End With
--
-- End Sub
end

-- Sub blit_enemy_loot()
function blit_enemy_loot()
--
--
--   Dim As Integer enemy_loot, conf
  local enemy_loot, conf = 0, false
--   Dim As vector_pair origin, target
  local origin, target = get_next_vector_pair(), get_next_vector_pair()
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
        draw(anim.image, anim.quads[0],
          math.floor(enemy.drop.coords.x) - math.floor(ll_global.this_room.cx),
          math.floor(enemy.drop.coords.y) - math.floor(ll_global.this_room.cy))
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
        --NOTE: Pulled this frame_check assignment up to blit_enemy_loot.
        --from touched_frame_face.
        --This function is only used from that location. .frame was used to
        --decide whether to call touched_bound_box or touched_frame_face based
        --on how many faces the frame has. Problem is, .frame_check and .frame
        --can be out of sync in some cases. So we use .frame_check all the way
        --up to blit_enemy_loot so it is not out of sync. I THINK that this was
        --a bug in the original code that worked by coincidence most of the time,
        --but I am leaving this note here just in case I effed something up.
        ll_global.hero.frame_check = LLObject_CalculateFrame(ll_global.hero)
--             If llg( hero ).anim[llg( hero ).current_anim]->frame[llg( hero ).frame].faces = 0 Then
        if ll_global.hero.anim[ll_global.hero.current_anim].frame[ll_global.hero.frame_check].faces == 0 then
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
        ll_global.snd[with1.sound]:setVolume((with1.vol ~= 0) and (with1.vol / 100) or iifCalc)
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

-- Sub top_rows( b As boxcontrol_type Ptr )
function top_rows(b)
  --log.debug("top_rows called.")
--
--
--   Dim As Integer line_loop, b_opt
  local line_loop, b_opt = 0, 0
--
--     For line_loop = 1 To b->internal.current_line And 3
  --log.debug("bit.band(b.internal.current_line, 3): "..bit.band(b.internal.current_line, 3))
  for line_loop = 1, bit.band(b.internal.current_line, 3) do
--
--       b_opt = b->internal.current_line - line_loop
    b_opt = b.internal.current_line - line_loop
--
--       graphicalString( _
--                        b->ptrs.row[b_opt], _
--                        b->layout.x_loc + 9, _
--                        b->layout.y_loc + 8 + ( ( b_opt And 3 ) Shl 4 ), _
--                        b->internal.txtcolor _
--                      )
    graphicalString(b.ptrs.row[b_opt],
                    b.layout.x_loc + 9,
                    b.layout.y_loc + 8 + ((b_opt % 4) * 16),
                    b.internal.txtcolor)

    --log.debug(b.ptrs.row[b_opt])
--     Next
  end
--
--
-- End Sub
end
--
--
-- Sub current_row( b As boxcontrol_type Ptr )
function current_row(b)
--
--   static as string bufferString
--   bufferString = "                                    "
  local bufferString = "                                    "
--
--   dim as integer i
--   for i = 0 to 35
--     bufferString[i] = asc( " " )
--
--   next
--
--   for i = 0 to b->internal.opcount
  for i = 0, b.internal.opcount do
--     bufferString[i] = b->ptrs.row[b->internal.current_line][i]
    bufferString = replace_char(i, bufferString, b.ptrs.row[b.internal.current_line]:sub(i, i))
--
--   next
  end
--
--   graphicalString( bufferString, _
--                    b->layout.x_loc + 9, _
--                    b->layout.y_loc + 8 + ( ( b->internal.current_line And 3 ) Shl 4 ), _
--                    b->internal.txtcolor _
--                  )
  graphicalString(bufferString,
                  b.layout.x_loc + 9,
                  b.layout.y_loc + 8 + ((b.internal.current_line % 4) * 16),
                  b.internal.txtcolor)
  --log.debug("bufferString: "..bufferString)
--
-- End Sub
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
  x_opt = math.floor(with0.coords.x)
  --     y_opt = .coords.y
  y_opt = math.floor(with0.coords.y)
  --
  --     If .no_cam = 0 Then
  if with0.no_cam == 0 then
  --
  --       x_opt -= llg( this_room ).cx
    x_opt = x_opt - math.floor(ll_global.this_room.cx)
  --       y_opt -= llg( this_room ).cy
    y_opt = y_opt - math.floor(ll_global.this_room.cy)
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
  draw(anim.image, anim.quads[f_opt], x_opt, y_opt)
  --draw(anim.image, x_opt, y_opt)


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
  if ll_low_health == nil then ll_low_health = 0.0 end
--   Dim As Integer key_Put
  local key_Put = 0
--
--   With *e
  local with0 = e
--
--     hud_BlitMain( e )
  hud_BlitMain(e)
--     hud_BlitEnemies()
  hud_BlitEnemies()
--
--
--     scope
--
--       if llg( hero_only ).selected_item = 3 then
  if ll_global.hero.selected_item == 3 then
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
  else
--         Put( 132, 8 ), @llg( hud ).img(1)->image[llg( hero_only ).selected_item * llg( hud ).img(1)->arraysize], Trans
    draw(ll_global.hud.img[1].image, ll_global.hud.img[1].quads[ll_global.hero_only.selected_item], 132, 8)
--
--       end if
  end
--
--       '' selected item
--
--     end scope
--
--
--
--
--     If llg( map )->isDungeon Then
  if ll_global.map.isDungeon ~= 0 then
--       '' regular key
--
--       If llg( hero_only ).b_key <> 0 Then
    if ll_global.hero_only.b_key ~= 0 then
--         Put( 8, 164 ), llg( hud ).img(6)->image, Trans
      draw(ll_global.hud.img[6].image, ll_global.hud.img[6].quads[0], 8, 164)
--
--       End If
    end
--
--       For key_Put = 0 To llg( hero ).key - 1
    for key_Put = 0, ll_global.hero.key - 1 do
--
--         Put( 8 + (key_Put * 8) , 180 ), llg( hud ).img(5)->image, Trans
      draw(ll_global.hud.img[5].image, ll_global.hud.img[5].quads[0], 8 + (key_Put * 8), 180)
--
--       Next
    end
--
--     End If
  end
--
--     '' dollar sign
--     Put( 275, 8 ), @llg( hud ).img(2)->image[0], Trans
  draw(ll_global.hud.img[2].image, ll_global.hud.img[2].quads[0], 275, 8)
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
    draw(ll_global.hud.img[3].image, ll_global.hud.img[3].quads[mny:byte(nums + 1) - 48], 289 + nums * 8, 8)
-- '          Put ( 289 + ( nums * 8 ), 8 ), @llg( hud ).img(3).image[( mny[nums] - 48 ) * llg( hud ).img(3).arraysize], Trans
--
--         Next
  end
--
--     End Scope
--
--
--     If .hp <= int( llg( hero ).maxhp / 3 ) Then
  if with0.hp <= math.floor(ll_global.hero.maxhp / 3) then
--
--       If ll_low_health = 0 Then
    if ll_low_health == 0 then
--
--         play_sample( llg( snd )[sound_lowhealth] )
      ll_global.snd[sound_lowhealth]:play()
--
--
--
--         ll_low_health = Timer + 1.5
      ll_low_health = timer + 1.5
--
--         If .hp <= cint( llg( hero ).maxhp / 6.5 ) Then
      if with0.hp <= math.floor(ll_global.hero.maxhp / 6.5) then
--           ll_low_health = Timer + .75
        ll_low_health = timer + .75
--
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
--     If Timer > ll_low_health Then
  if timer > ll_low_health then
--       ll_low_health = 0
    ll_low_health = 0
--
--     End If
  end
--
--     if llg( hero_only ).adrenaline = NULL then
  if ll_global.hero_only.adrenaline == NULL then
--       Put( 12, 24 ), llg( hud ).img(4)->image, Trans
    draw(ll_global.hud.img[4].image, 12, 24)
--
--       Dim As Integer crazy_Ceiling = llg( hero_only ).crazy_points
    local crazy_Ceiling = ll_global.hero_only.crazy_points
--       If crazy_Ceiling > 100 Then
    if crazy_Ceiling > 100 then
--         crazy_Ceiling = 100
      crazy_Ceiling = 100
--
--       End If
    end
--       '' 15, 27
--       If ( llg( hero_only ).crazy_points ) > 0 Then
    if (ll_global.hero_only.crazy_points) > 0 then
--
--         Line( 15, 27 )-( 15 + ( crazy_Ceiling ), 30 ), 26, bf
      love.graphics.setColor(26 / 255, 0, 0, 1.0)
      love.graphics.rectangle("fill", 15, 27, crazy_Ceiling, 4)
      love.graphics.setColor(1, 1, 1, 1)
--
--       End If
    end
--
--     end if
  end
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
      draw(ll_global.hud.img[0].image, ll_global.hud.img[0].quads[0], x_opt, y_opt)
--
--         ElseIf (.maxhp ) > p Then
    elseif this.maxhp > p then
--           Put( x_opt, y_opt ), varptr( llg( hud ).img(0)->image[34] ), Trans
      draw(ll_global.hud.img[0].image, ll_global.hud.img[0].quads[1], x_opt, y_opt)
--
--         Else
    else
--           Put( x_opt, y_opt ), varptr( llg( hud ).img(0)->image[68] ), Trans
      draw(ll_global.hud.img[0].image, ll_global.hud.img[0].quads[2], x_opt, y_opt)
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

-- Function hud_IsShowing( this As char_type Ptr ) As Integer
function hud_IsShowing(this)
--
--   With *( this )
  local with0 = this
--
--     Dim As Integer dmgd, dying, hpgone, nodead, elit, flick, no_change, show_enemies
  local dmgd, dying, hpgone, nodead, elit, flick, no_change, show_enemies = 0, 0, 0, 0, 0, 0, 0, 0
--
--       dmgd   = .dmg.id <> 0
  dmgd = with0.dmg.id ~= 0
--       dying  = ( .dead = -1 ) And ( ( .unique_id <> u_boss5_right ) And ( .unique_id <> u_boss5_left ) And ( .unique_id <> u_boss5_down ) )
  dying = ((with0.dead == -1) and ((with0.unique_id ~= u_boss5_right) and (with0.unique_id ~= u_boss5_left) and (with0.unique_id ~= boss5_down)))
--       flick  = .invisible = 0
  flick = with0.invisible == 0
--       hpgone = .hp <= 0
  hpgone = with0.hp <= 0
--       nodead = .total_dead = 0
  nodead = with0.total_dead == 0
--
--       elit   = ( ( .unique_id = u_core ) Imp llg( now )[725] ) And ( .isBoss )' Or ( .unique_id = u_dyssius ) Or ( .unique_id = u_steelstrider ) Or ( .unique_id = u_anger ) Or ( .unique_id = u_sterach ) Or ( .unique_id = u_divine )Or ( .unique_id = u_divine_bug )
  elit = (imp((with0.unique_id == u_core) and -1 or 0, ll_global.now[725]) ~= 0) and (with0.isBoss ~= 0)
-- '      elit   = ( .unique_id = u_grult ) Or ( .unique_id = u_dyssius ) Or ( .unique_id = u_steelstrider ) Or ( .unique_id = u_anger ) Or ( .unique_id = u_sterach ) Or ( .unique_id = u_divine )Or ( .unique_id = u_divine_bug )
--       no_change = llg( hero.switch_room ) = -1
  no_change = ll_global.hero.switch_room == -1
--
--       show_enemies = -1
  show_enemies = true
--       show_enemies And= ( Not ( .unique_id = u_hotrock ) )
  show_enemies = show_enemies and (not (with0.unique_id == u_hotrock))
--       show_enemies And= ( Not ( .unique_id = u_coldrock ) )
  show_enemies = show_enemies and (not (with0.unique_id == u_coldrock))
--       show_enemies And= ( Not ( .unique_id = u_bush ) )
  show_enemies = show_enemies and (not (with0.unique_id == u_bush))
--       show_enemies And= ( Not ( .unique_id = u_crate ) )
  show_enemies = show_enemies and (not (with0.unique_id == u_crate))
--       show_enemies And= ( Not ( .unique_id = u_crate_health ) )
  show_enemies = show_enemies and (not (with0.unique_id == u_crate_health))
--       show_enemies And= ( Not ( .unique_id = u_greyrock ) )
  show_enemies = show_enemies and (not (with0.unique_id == u_greyrock))
--       show_enemies And= ( Not ( .unique_id = u_bombrock ) )
  show_enemies = show_enemies and (not (with0.unique_id == u_bombrock))
--       show_enemies And= ( Not ( .unique_id = u_beetle ) )
  show_enemies = show_enemies and (not (with0.unique_id == u_beetle))
--       show_enemies And= ( Not ( .unique_id = u_charger ) )
  show_enemies = show_enemies and (not (with0.unique_id == u_charger))
--       show_enemies And= ( Not ( .unique_id = u_swordie ) )
  show_enemies = show_enemies and (not (with0.unique_id == u_swordie))
--       show_enemies And= ( Not ( .unique_id = u_antiwall ) )
  show_enemies = show_enemies and (not (with0.unique_id == u_antiwall))
--       show_enemies And= ( Not ( .unique_id = u_antiwall2 ) )
  show_enemies = show_enemies and (not (with0.unique_id == u_antiwall2))
--       show_enemies And= ( Not ( .unique_id = u_goldblock ) )
  show_enemies = show_enemies and (not (with0.unique_id == u_goldblock))
-- '      show_enemies And= ( Not ( .unique_id =  ) )
--
--
--       Return ( ( ( dmgd Or elit Or ( dying And flick And hpgone ) ) And nodead And no_change ) And show_enemies )
  return (((dmgd or elit or (dying and flick and hpgone)) and nodead and no_change) and show_enemies)
--
--   End With
--
--
-- End Function
end

-- Sub hud_BlitEnemy( this As char_type Ptr, ctr As Integer )
function hud_BlitEnemy(this, ctr)
--
--   With *( this )
  local with0 = this
--
--     Dim As Integer p, x_opt, y_opt
  local p, x_opt, y_opt = 0, 0, 0
--
--       For p = 0 To 59
  for p = 0, 59 do
--
--         x_opt = ( ( p Mod 15 ) Shl 3 ) + 8
    x_opt = bit.lshift((p % 15), 3) + 8
--         y_opt = ( ( p  \  15 ) Shl 3 ) + 8
    y_opt = bit.lshift(math.floor(p / 15), 3) + 8
--
--         If ( .hp ) > p Then
    if (with0.hp) > p then
--           Put( x_opt + ( 146 ), y_opt + ( ctr Shl 4 ) ), varptr( llg( hud ).img(0)->image[0] ), Trans
      draw(ll_global.hud.img[0].image, ll_global.hud.img[0].quads[0], x_opt + 146, y_opt + bit.lshift(ctr, 4))
--
--         ElseIf ( .maxhp ) > p Then
    elseif (with0.maxhp) > p then
--           Put( x_opt + ( 146 ), y_opt + ( ctr Shl 4 ) ), varptr( llg( hud ).img(0)->image[34] ), Trans
      draw(ll_global.hud.img[0].image, ll_global.hud.img[0].quads[1], x_opt + 146, y_opt + bit.lshift(ctr, 4))
--
--         Else
    else
--
--         End If
    end
--
--       Next
  end
--
--   End With
--
--
-- End Sub
end
--
--
-- Sub hud_BlitEnemies() Static
function hud_BlitEnemies()
--
--
--   Dim As Integer ctr, dmg_by
  local ctr, dmg_by = 0, 0
--
--   ctr = 0
  ctr = 0
--   For dmg_by = 0 To ll_current_room( enemies ) - 1
  for dmg_by = 0, now_room().enemies - 1 do
--
--     If LLObject_IsWithin( Varptr( ll_current_room( enemy[dmg_by] ) ) ) = 0 Then
    if LLObject_IsWithin(now_room().enemy[dmg_by]) == 0 then
--       Continue For
      goto continue
--
--     End If
    end
--
--
--     If hud_IsShowing( Varptr( ll_current_room( enemy[dmg_by] ) ) ) Then
    if hud_IsShowing(now_room().enemy[dmg_by]) then
--       hud_BlitEnemy( Varptr( ll_current_room( enemy[dmg_by] ) ), ctr )
      hud_BlitEnemy(now_room().enemy[dmg_by], ctr)
--
--       ctr += 1
      ctr = ctr + 1
--
--     End If
    end
--
  ::continue::
--   Next
  end
--
--
-- End Sub
end

-- Sub menu_Blit()
function menu_Blit()
--
--   #Define menu_BlitImage(x,y,i) Put( x, y ), .img( i )->image, Trans
--
--   With llg( menu )
  local with0 = ll_global.menu
--     With .menuimages
  local with1 = with0.menuImages
--       Put( 0, 0 ), .img( menu_full_background )->image, Trans
  draw(with1.img[menu_full_background].image, 0, 0)
--
--
--       If llg( hero_only ).has_weapon >= 0 Then
  if ll_global.hero_only.has_weapon >= 0 then
--         If llg( hero_only ).weapon = 0 Then
    if ll_global.hero_only.weapon == 0 then
--           menu_BlitImage( 18, 18, menu_sapling_select )
      draw(with1.img[menu_sapling_select].image, 18, 18)
--         Else
    else
--           menu_BlitImage( 18, 18, menu_sapling )
      draw(with1.img[menu_sapling].image, 18, 18)
--         End If
    end
--       Else
  else
--         menu_BlitImage( 18, 18, menu_blankspace )
    draw(with1.img[menu_blankspace].image, 18, 18)

--       End If
  end
--
--       If llg( hero_only ).has_weapon >= 1 Then
  if ll_global.hero_only.has_weapon >= 1 then
--         If llg( hero_only ).weapon = 1 Then
    if ll_global.hero_only.weapon == 1 then
--           menu_BlitImage( 42, 18, menu_mace_select )
      draw(with1.img[menu_mace_select].image, 42, 18)
--         Else
    else
--           menu_BlitImage( 42, 18, menu_mace )
      draw(with1.img[menu_mace].image, 42, 18)
--         End If
    end
--       Else
  else

--         menu_BlitImage( 42, 18, menu_blankspace )
    draw(with1.img[menu_blankspace].image, 42, 18)
--       End If
  end
--
--       If llg( hero_only ).has_weapon >= 2 Then
  if ll_global.hero_only.has_weapon >= 2 then
--         If llg( hero_only ).weapon = 2 Then
    if ll_global.hero_only.weapon == 2 then
--           menu_BlitImage( 66, 18, menu_star_select )
      draw(with1.img[menu_star_select].image, 66, 18)
--         Else
    else
--           menu_BlitImage( 66, 18, menu_star )
      draw(with1.img[menu_star].image, 66, 18)
--         End If
    end
--       Else
  else
--         menu_BlitImage( 66, 18, menu_blankspace )
    draw(with1.img[menu_blankspace].image, 66, 18)
--       End If
  end
--
--
-- '      If llg( hero_only ).has_item > 0 Then
--       If llg( hero_only ).hasItem( 0 ) Then
  if ll_global.hero_only.hasItem[0] ~= 0 then
--         If llg( hero_only ).selected_item = 1 Then
    if ll_global.hero_only.selected_item == 1 then
--           menu_BlitImage( 18, 54, menu_flare_select )
      draw(with1.img[menu_flare_select].image, 18, 54)
--         Else
    else
--           menu_BlitImage( 18, 54, menu_flare )
      draw(with1.img[menu_flare].image, 18, 54)
--         End If
    end
--
--       Else
  else
--         menu_BlitImage( 18, 54, menu_blankspace )
    draw(with1.img[menu_blankspace].image, 18, 54)
--       End If
  end
--       If llg( hero_only ).hasItem( 1 ) Then
  if ll_global.hero_only.hasItem[1] ~= 0 then
--         If llg( hero_only ).selected_item = 2 Then
    if ll_global.hero_only.selected_item == 2 then
--           menu_BlitImage( 42, 54, menu_ice_select )
      draw(with1.img[menu_ice_select].image, 42, 54)
--         Else
    else
--           menu_BlitImage( 42, 54, menu_ice )
      draw(with1.img[menu_ice].image, 42, 54)
--         End If
    end
--
--       Else
  else
--         menu_BlitImage( 42, 54, menu_blankspace )
    draw(with1.img[menu_blankspace].image, 42, 54)
--       End If
  end
--       If llg( hero_only ).hasItem( 2 ) Then
  if ll_global.hero_only.hasItem[2] ~= 0 then
--
--         dim as integer currentBridge, currentBridgeSelect
    local currentBridge, currentBridgeSelect = 0, 0
--
--         currentBridge = menu_bridge
    currentBridge = menu_bridge
--         currentBridgeSelect = menu_bridge_select
    currentBridgeSelect = menu_bridge_select
--
--
--         if llg( hero_only ).has_weapon = 2 then
    if ll_global.hero_only.has_weapon == 2 then
--
--           currentBridge = menu_blank
      currentBridge = menu_blank
--           currentBridgeSelect = menu_blank_select
      currentBridgeSelect = menu_blank_select
--
--         elseif llg( now )[1206] then
    elseif ll_global.now[1206] ~= 0 then
--           ''templewood
--           currentBridge = menu_bridge3
      currentBridge = menu_bridge3
--           currentBridgeSelect = menu_bridge3_select
      currentBridgeSelect = menu_bridge3_select
--
--         elseif llg( now )[470] then
    elseif ll_global.now[470] ~= 0 then
--
--           currentBridge = menu_bridge2
      currentBridge = menu_bridge2
--           currentBridgeSelect = menu_bridge2_select
      currentBridgeSelect = menu_bridge2_select
--
--         end if
    end
--
--
--
--         If llg( hero_only ).selected_item = 3 Then
    if ll_global.hero_only.selected_item == 3 then
--           menu_BlitImage( 66, 54, currentBridgeSelect )
      draw(with1.img[currentBridgeSelect].image, 66, 54)
--         Else
    else
--           menu_BlitImage( 66, 54, currentBridge )
      draw(with1.img[currentBridge].image, 66, 54)
--         End If
    end
--
--       Else
  else
--         menu_BlitImage( 66, 54, menu_blankspace )
    draw(with1.img[menu_blankspace].image, 66, 54)
--       End If
  end
--
--       If llg( hero_only ).hasItem( 3 ) Then
  if ll_global.hero_only.hasItem[3] ~= 0 then
--
--         dim as integer currentIdol, currentIdolSelect
    local currentIdol, currentIdolSelect = 0, 0
--
--         currentIdol = menu_idol
    currentIdol = menu_idol
--         currentIdolSelect = menu_idol_select
    currentIdolSelect = menu_idol_select
--
--         if llg( now )[1212] then
    if ll_global.now[1212] ~= 0 then
--
--           currentIdol = menu_blank
      currentIdol = menu_blank
--           currentIdolSelect = menu_blank_select
      currentIdolSelect = menu_blank_select
--
--         end if
    end
--
--
--         If llg( hero_only ).selected_item = 4 Then
    if ll_global.hero_only.selected_item == 4 then
--           menu_BlitImage( 18, 78, currentIdolSelect )
      draw(with1.img[currentIdolSelect].image, 18, 78)
--         Else
    else
--           menu_BlitImage( 18, 78, currentIdol )
      draw(with1.img[currentIdol].image, 17, 78)
--         End If
    end
--
--       Else
  else
--         menu_BlitImage( 18, 78, menu_blankspace )
    draw(with1.img[menu_blankspace].image, 18, 78)
--       End If
  end
--       If llg( hero_only ).hasItem( 4 ) Then
  if ll_global.hero_only.hasItem[4] ~= 0 then
--
--         If llg( hero_only ).selected_item = 5 Then
    if ll_global.hero_only.selected_item == 5 then
--           menu_BlitImage( 42, 78, menu_regen_select )
      draw(with1.img[menu_regen_select].image, 42, 78)
--         Else
    else
--           menu_BlitImage( 42, 78, menu_regen )
      draw(with1.img[menu_regen].image, 42, 78)
--         End If
    end
--
--       Else
  else
--         menu_BlitImage( 42, 78, menu_blankspace )
    draw(with1.img[menu_blankspace].image, 42, 78)
--       End If
  end
--       If llg( hero_only ).hasItem( 5 ) Then
  if ll_global.hero_only.hasItem[5] ~= 0 then
--
--         If llg( hero_only ).selected_item = 6 Then
    if ll_global.hero_only.selected_item == 6 then
--           menu_BlitImage( 66, 78, menu_heal_select )
      draw(with1.img[menu_heal_select].image, 66, 78)
--         Else
    else
--           menu_BlitImage( 66, 78, menu_heal )
      draw(with1.img[menu_heal].image, 66, 78)
--         End If
    end
--
--       Else
  else
--         menu_BlitImage( 66, 78, menu_blankspace )
    draw(with1.img[menu_blankspace].image, 66, 78)
--       End If
  end
--
--
--
--
--       '' Outfits
--
--       If llg( hero_only ).hasCostume( 0 ) <> 0 Then
  if ll_global.hero_only.hasCostume[0] ~= 0 then
--
--         If llg( hero_only ).isWearing = 0 Then
    if ll_global.hero_only.isWearing == 0 then
--           menu_BlitImage( 18, 121, menu_standard_select )
      draw(with1.img[menu_standard_select].image, 18, 121)
--
--         Else
    else
--           menu_BlitImage( 18, 121, menu_standard )
      draw(with1.img[menu_standard].image, 18, 121)
--
--         End If
    end
--
--       Else
  else
--         menu_BlitImage( 18, 121, menu_blankspace )
    draw(with1.img[menu_blankspace].image, 18, 121)
--
--       End If
  end
--
--       If llg( hero_only ).hasCostume( 1 ) <> 0 Then
  if ll_global.hero_only.hasCostume[1] ~= 0 then
--
--         If llg( hero_only ).isWearing = 1 Then
    if ll_global.hero_only.isWearing == 1 then
--           menu_BlitImage( 42, 121, menu_cougar_select )
      draw(with1.img[menu_cougar_select].image, 42, 121)
--
--         Else
    else
--           menu_BlitImage( 42, 121, menu_cougar )
      draw(with1.img[menu_cougar].image, 42, 121)
--
--         End If
    end
--
--       Else
  else
--         menu_BlitImage( 42, 121, menu_blankspace )
    draw(with1.img[menu_blankspace].image, 42, 121)
--
--       End If
  end
--
--
--       If llg( hero_only ).hasCostume( 2 ) <> 0 Then
  if ll_global.hero_only.hasCostume[2] ~= 0 then
--
--         If llg( hero_only ).isWearing = 2 Then
    if ll_global.hero_only.isWearing == 2 then
--           menu_BlitImage( 66, 121, menu_lynnity_select )
      draw(with1.img[menu_lynnity_select].image, 66, 121)
--
--         Else
    else
--           menu_BlitImage( 66, 121, menu_lynnity )
      draw(with1.img[menu_lynnity].image, 66, 121)
--
--         End If
    end
--
--       Else
  else
--         menu_BlitImage( 66, 121, menu_blankspace )
    draw(with1.img[menu_blankspace].image, 66, 121)
--
--       End If
  end
--
--
--       If llg( hero_only ).hasCostume( 3 ) <> 0 Then
  if ll_global.hero_only.hasCostume[3] ~= 0 then
--
--         If llg( hero_only ).isWearing = 3 Then
    if ll_global.hero_only.isWearing == 3 then
--           menu_BlitImage( 18, 157, menu_ninja_select )
      draw(with1.img[menu_ninja_select].image, 18, 157)
--
--         Else
    else
--           menu_BlitImage( 18, 157, menu_ninja )
      draw(with1.img[menu_ninja].image, 18, 157)
--
--         End If
    end
--
--       Else
  else
--         menu_BlitImage( 18, 157, menu_blankspace )
    draw(with1.img[menu_blankspace].image, 18, 157)
--
--       End If
  end
--
--
--       If llg( hero_only ).hasCostume( 4 ) <> 0 Then
  if ll_global.hero_only.hasCostume[4] ~= 0 then
--
--         If llg( hero_only ).isWearing = 4 Then
    if ll_global.hero_only.isWearing == 4 then
--           menu_BlitImage( 42, 157, menu_bikini_select )
      draw(with1.img[menu_bikini_select].image, 42, 157)
--
--         Else
    else
--           menu_BlitImage( 42, 157, menu_bikini )
      draw(with1.img[menu_bikini].image, 42, 157)
--
--         End If
    end
--
--       Else
  else
--         menu_BlitImage( 42, 157, menu_blankspace )
    draw(with1.img[menu_blankspace].image, 42, 157)
--
--       End If
  end
--
--
--       If llg( hero_only ).hasCostume( 5 ) <> 0 Then
  if ll_global.hero_only.hasCostume[5] ~= 0 then
--
--         If llg( hero_only ).isWearing = 5 Then
    if ll_global.hero_only.isWearing == 5 then
--           menu_BlitImage( 66, 157, menu_rknight_select )
      draw(with1.img[menu_rknight_select].image, 66, 157)
--
--         Else
    else
--           menu_BlitImage( 66, 157, menu_rknight )
      draw(with1.img[menu_rknight].image, 66, 157)
--
--         End If
    end
--
--       Else
  else
--         menu_BlitImage( 66, 157, menu_blankspace )
    draw(with1.img[menu_blankspace].image, 66, 157)
--
--       End If
  end
--
--
--
--       '' Square Cursors
--
--
--       Select Case As Const llg( menu ).selectedItem
--         Case 0
  if ll_global.menu.selectedItem == 0 then
--
--           If llg( hero_only ).has_weapon >= 0 Then
    if ll_global.hero_only.has_weapon >= 0 then
--             graphicalString( llg( menu ).menuNames( menu_sapling_select ), 134, 154, 114 )
      graphicalString(ll_global.menu.menuNames[menu_sapling_select], 134, 154, 114)
--
--           End If
    end
--           menu_BlitImage( 18, 18 , menu_square_cursor )
    draw(with1.img[menu_square_cursor].image, with1.img[menu_square_cursor].quads[0], 18, 18)
--
--         Case 1
  elseif ll_global.menu.selectedItem == 1 then
--
--           If llg( hero_only ).has_weapon >= 1 Then
    if ll_global.hero_only.has_weapon >= 1 then
--             graphicalString( llg( menu ).menuNames( menu_mace_select ), 134, 154, 114 )
      graphicalString(ll_global.menu.menuNames[menu_mace_select], 134, 154, 114)
--
--           End If
    end
--           menu_BlitImage( 42, 18 , menu_square_cursor )
    draw(with1.img[menu_square_cursor].image, with1.img[menu_square_cursor].quads[0], 42, 18)
--
--         Case 2
  elseif ll_global.menu.selectedItem == 2 then
--
--           If llg( hero_only ).has_weapon >= 2 Then
    if ll_global.hero_only.has_weapon >= 2 then
--             graphicalString( llg( menu ).menuNames( menu_star_select ), 134, 154, 114 )
      graphicalString(ll_global.menu.menuNames[menu_star_select], 134, 154, 114)
--
--           End If
    end
--           menu_BlitImage( 66, 18 , menu_square_cursor )
    draw(with1.img[menu_square_cursor].image, with1.img[menu_square_cursor].quads[0], 66, 18)
--
--         Case 3
  elseif ll_global.menu.selectedItem == 3 then
--
--           If llg( hero_only ).hasItem( 0 ) Then
    if ll_global.hero_only.hasItem[0] ~= 0 then
--             graphicalString( llg( menu ).menuNames( menu_flare_select ), 134, 154, 114 )
      graphicalString(ll_global.menu.menuNames[menu_flare_select], 134, 154, 114)
--
--           End If
    end
--           menu_BlitImage( 18, 54 , menu_square_cursor )
    draw(with1.img[menu_square_cursor].image, with1.img[menu_square_cursor].quads[0], 18, 54)
--
--         Case 4
  elseif ll_global.menu.selectedItem == 4 then
--
--           If llg( hero_only ).hasItem( 1 ) Then
    if ll_global.hero_only.hasItem[1] ~= 0 then
--             graphicalString( llg( menu ).menuNames( menu_ice_select ), 134, 154, 114 )
      graphicalString(ll_global.menu.menuNames[menu_ice_select], 134, 154, 114)
--
--           End If
    end
--           menu_BlitImage( 42, 54 , menu_square_cursor )
    draw(with1.img[menu_square_cursor].image, with1.img[menu_square_cursor].quads[0], 42, 54)
--
--         Case 5
  elseif ll_global.menu.selectedItem == 5 then
--
--           If llg( hero_only ).hasItem( 2 ) Then
    if ll_global.hero_only.hasItem[2] ~= 0 then
--
--             if llg( hero_only ).has_weapon = 2 then
      if ll_global.hero_only.has_weapon == 2 then
--
--               graphicalString( "Nothing left!", 134, 154, 114 )
        graphicalString("Nothing left!", 134, 154, 114)
--
--             elseif llg( now )[1206] then
      elseif ll_global.now[1206] ~= 0 then
--               ''templewood
--               graphicalString( "A sturdy rope.", 134, 154, 114 )
        graphicalString("A sturdy rope.", 134, 154, 114)
--
--             else
      else
--               graphicalString( llg( menu ).menuNames( menu_bridge_select ), 134, 154, 114 )
        graphicalString(ll_global.menu.menuNames[menu_bridge_select], 134, 154, 114)
--
--             end if
      end
--
--           End If
    end
--           menu_BlitImage( 66, 54 , menu_square_cursor )
    draw(with1.img[menu_square_cursor].image, with1.img[menu_square_cursor].quads[0], 66, 54)
--
--         Case 6
  elseif ll_global.menu.selectedItem == 6 then
--
--
--           If llg( hero_only ).hasItem( 3 ) Then
    if ll_global.hero_only.hasItem[3] ~= 0 then
--
--             if llg( now )[1212] then
      if ll_global.now[1212] ~= 0 then
--
--               graphicalString( "Gave it away...", 134, 154, 114 )
        graphicalString("Gave it away...", 134, 154, 114)
--
--             else
      else
--               graphicalString( llg( menu ).menuNames( menu_idol_select ), 134, 154, 114 )
        graphicalString(ll_global.menu.menuNames[menu_idol_select], 134, 154, 114)
--
--             end if
      end
--
--           End If
    end
--           menu_BlitImage( 18, 78 , menu_square_cursor )
    draw(with1.img[menu_square_cursor].image, with1.img[menu_square_cursor].quads[0], 18, 78)
--
--         Case 7
  elseif ll_global.menu.selectedItem == 7 then
--
--           If llg( hero_only ).hasItem( 4 ) Then
    if ll_global.hero_only.hasItem[4] ~= 0 then
--             graphicalString( llg( menu ).menuNames( menu_regen_select ), 134, 154, 114 )
      graphicalString(ll_global.menu.menuNames[menu_regen_select], 134, 154, 114)
--
--           End If
    end
--           menu_BlitImage( 42, 78 , menu_square_cursor )
    draw(with1.img[menu_square_cursor].image, with1.img[menu_square_cursor].quads[0], 42, 78)
--
--         Case 8
  elseif ll_global.menu.selectedItem == 8 then
--
--           If llg( hero_only ).hasItem( 5 ) Then
    if ll_global.hero_only.hasItem[5] ~= 0 then
--             graphicalString( llg( menu ).menuNames( menu_heal_select ), 134, 154, 114 )
      graphicalString(ll_global.menu.menuNames[menu_heal_select], 134, 154, 114)
--
--           End If
    end
--           menu_BlitImage( 66, 78 , menu_square_cursor )
    draw(with1.img[menu_square_cursor].image, with1.img[menu_square_cursor].quads[0], 66, 78)
--
--         Case 9
  elseif ll_global.menu.selectedItem == 9 then
--
--           If llg( hero_only ).hasCostume(0) <> 0 Then
    if ll_global.hero_only.hasCostume[0] ~= 0 then
--             graphicalString( llg( menu ).menuNames( menu_standard_select ), 134, 154, 114 )
      graphicalString(ll_global.menu.menuNames[menu_standard_select], 134, 154, 114)
--
--           End If
    end
--           menu_BlitImage( 18, 121, menu_square_cursor )
    draw(with1.img[menu_square_cursor].image, with1.img[menu_square_cursor].quads[0], 18, 121)
--
--         Case 10
  elseif ll_global.menu.selectedItem == 10 then
--
--           If llg( hero_only ).hasCostume(1) <> 0 Then
    if ll_global.hero_only.hasCostume[1] ~= 0 then
--             graphicalString( llg( menu ).menuNames( menu_cougar_select ), 134, 154, 114 )
      graphicalString(ll_global.menu.menuNames[menu_cougar_select], 134, 154, 114)
--
--           End If
    end
--           menu_BlitImage( 42, 121, menu_square_cursor )
    draw(with1.img[menu_square_cursor].image, with1.img[menu_square_cursor].quads[0], 42, 121)
--
--         Case 11
  elseif ll_global.menu.selectedItem == 11 then
--
--           If llg( hero_only ).hasCostume(2) <> 0 Then
    if ll_global.hero_only.hasCostume[2] ~= 0 then
--             graphicalString( llg( menu ).menuNames( menu_lynnity_select ), 134, 154, 114 )
      graphicalString(ll_global.menu.menuNames[menu_lynnity_select], 134, 154, 114)
--
--           End If
    end
--
--           menu_BlitImage( 66, 121, menu_square_cursor )
    draw(with1.img[menu_square_cursor].image, with1.img[menu_square_cursor].quads[0], 66, 121)
--
--         Case 12
  elseif ll_global.menu.selectedItem == 12 then
--
--           If llg( hero_only ).hasCostume(3) <> 0 Then
    if ll_global.hero_only.hasCostume[3] ~= 0 then
--
--             graphicalString( llg( menu ).menuNames( menu_ninja_select ), 134, 154, 114 )
      graphicalString(ll_global.menu.menuNames[menu_ninja_select], 134, 154, 114)
--           End If
    end
--
--           menu_BlitImage( 18, 157, menu_square_cursor )
    draw(with1.img[menu_square_cursor].image, with1.img[menu_square_cursor].quads[0], 18, 157)
--
--         Case 13
  elseif ll_global.menu.selectedItem == 13 then
--
--           If llg( hero_only ).hasCostume(4) <> 0 Then
    if ll_global.hero_only.hasCostume[4] ~= 0 then
--
--             graphicalString( llg( menu ).menuNames( menu_bikini_select ), 134, 154, 114 )
      graphicalString(ll_global.menu.menuNames[menu_bikini_select], 134, 154, 114)
--           End If
    end
--
--           menu_BlitImage( 42, 157, menu_square_cursor )
    draw(with1.img[menu_square_cursor].image, with1.img[menu_square_cursor].quads[0], 42, 157)
--
--         Case 14
  elseif ll_global.menu.selectedItem == 14 then
--
--           If llg( hero_only ).hasCostume(5) <> 0 Then
    if ll_global.hero_only.hasCostume[5] ~= 0 then
--
--             graphicalString( llg( menu ).menuNames( menu_rknight_select ), 134, 154, 114 )
      graphicalString(ll_global.menu.menuNames[menu_rknight_select], 134, 154, 114)
--           End If
    end
--
--           menu_BlitImage( 66, 157, menu_square_cursor )
    draw(with1.img[menu_square_cursor].image, with1.img[menu_square_cursor].quads[0], 66, 157)
--
-- '        Case 15
-- '          If llg( hero_only ).hasCostume(6) <> 0 Then
-- '            graphicalString( llg( menu ).menuNames( menu_sapling_select ), 134, 154, 114 )
-- '          End If
-- '          menu_BlitImage( 18, 162, menu_square_cursor )
-- '        Case 16
-- '          If llg( hero_only ).hasCostume(7) <> 0 Then
-- '            graphicalString( llg( menu ).menuNames( menu_sapling_select ), 134, 154, 114 )
-- '          End If
-- '          menu_BlitImage( 42, 162, menu_square_cursor )
-- '        Case 17
-- '          If llg( hero_only ).hasCostume(8) <> 0 Then
-- '            graphicalString( llg( menu ).menuNames( menu_sapling_select ), 134, 154, 114 )
-- '          End If
-- '          menu_BlitImage( 66, 162, menu_square_cursor )
--
--         Case 18
  elseif ll_global.menu.selectedItem == 18 then
--
--           If llg( hero_only ).has_weapon >= 0 Then
    if ll_global.hero_only.has_weapon >= 0 then
--             graphicalString( llg( menu ).menuNames( menu_resume_select ), 134, 154, 114 )
      graphicalString(ll_global.menu.menuNames[menu_resume_select], 134, 154, 114)
--
--           End If
    end
--           menu_BlitImage( 126, 54, menu_resume_select )
    draw(with1.img[menu_resume_select].image, 126, 54)
--
--         Case 19
  elseif ll_global.menu.selectedItem == 19 then
--
--           If llg( hero_only ).has_weapon >= 0 Then
    if ll_global.hero_only.has_weapon >= 0 then
--             graphicalString( llg( menu ).menuNames( menu_menu_select ), 134, 154, 114 )
      graphicalString(ll_global.menu.menuNames[menu_menu_select], 134, 154, 114)
--
--           End If
    end
--           menu_BlitImage( 126, 90, menu_menu_select )
    draw(with1.img[menu_menu_select].image, 126, 90)
--
--       End Select
  end
--
--
--
--
--
--
--
--
--
--
--
--     End With
--
--
--   End With
--
-- End Sub
end

-- Sub minimap_Blit()
function minimap_Blit()
--
--
--   Static As Integer color_Current( 9 ) => {36, 38, 40, 41, 43, 44, 43, 41, 40, 38}, index_Current
  if color_Current == nil then
    color_Current = {[0] = 36, 38, 40, 41, 43, 44, 43, 41, 40, 38}
  end
  if index_Current == nil then index_Current = 0 end
--   Static As Double shiftDelay = .05, shiftTimer
  if shiftDelay == nil then shiftDelay = .05 end
  if shiftTimer == nil then shiftTimer = 0 end
--
--   Const As Integer minimap_Offset = 20
  local minimap_Offset = 20
--   Const As Integer minimap_Size = 160
  local minimap_Size = 160
--
--   Dim As Integer floor_Current, i, j, k, eventsAchieved
  local floor_Current, i, j, k, eventsAchieved = 0, 0, 0, 0, 0
--   floor_Current = llg( miniMapFloor )
  floor_Current = ll_global.miniMapFloor
--
--   Dim As Integer gx, gy
  local gx, gy = 0, 0
--
--   Dim As Integer roomX, roomY
  local roomX, roomY = 0, 0
--   Dim As Integer doorX, doorY
  local doorX, doorY = 0, 0
--
--   gx = LLMiniMap_SizeX()
  gx = LLMiniMap_SizeX()
--   gy = LLMiniMap_SizeY()
  gy = LLMiniMap_SizeY()
--
--   If gx < 320 Then
  if gx < 320 then
--     gx = ( 320 - gx ) Shr 1
    gx = bit.rshift(320 - gx, 1)
--
--   Else
  else
--     gx = 0
    gx = 0
--
--   End If
  end
--
--   If gy < minimap_Size Then
  if gy < minimap_Size then
--     gy = ( minimap_Size - gy ) Shr 1
    gy = bit.rshift(minimap_Size - gy, 1)
--
--   Else
  else
--     gy = 0
    gy = 0
--
--   End If
  end
--
--
--   graphicalString( llg( dungeonName ), 160 - ( Len( llg( dungeonName ) ) Shl 2 ), 2 )
  graphicalString(ll_global.dungeonName, 160 - bit.lshift(#ll_global.dungeonName, 2), 2)
--
--   View Screen( 0, 20 )-( 319, 179 )
--   For i = 0 To llg( map )->rooms - 1
  for i = 0, ll_global.map.rooms - 1 do
--
--
--     With llg( minimap ).room[i]
    local with0 = ll_global.miniMap.room[i]
--
--       If .hasVisited Then
    if with0.hasVisited ~= 0 then
--
--         If .floor = floor_Current Then
      if with0.floor == floor_Current then
--
--           roomX = gx + .location.x - llg( miniMap ).camera.x
        roomX = gx + with0.location.x - ll_global.miniMap.camera.x
--           roomY = gy + .location.y + minimap_Offset - llg( miniMap ).camera.y
        roomY = gy + with0.location.y + minimap_Offset - ll_global.miniMap.camera.y
--
--           If i = llg( this_room ).i Then
        if i == ll_global.this_room.i then
--
--             Line( roomX, roomY )-( roomX + llg( map )->room[i].x - 1, roomY + llg( map )->room[i].y - 1 ), color_Current( index_Current ), bf
          love.graphics.setColor(color_Current[index_Current] / 255, 0, 0, 1.0)
          love.graphics.rectangle("fill", roomX, roomY, ll_global.map.room[i].x - 1, ll_global.map.room[i].y - 1)
          love.graphics.setColor(1, 1, 1, 1)

--             If shiftTimer = 0 Then
          if shiftTimer == 0 then
--
--               index_Current += 1
            index_Current = index_Current + 1
--               If index_Current = 10 Then index_Current = 0
            if index_Current == 10 then index_Current = 0 end
--
--               shiftTimer = Timer + shiftDelay
            shiftTimer = timer + shiftDelay
--
--             End If
          end
--
--             If Timer > shiftTimer Then shiftTimer = 0
          if timer > shiftTimer then shiftTimer = 0 end
--
--           Else
        else
--             Line( roomX, roomY )-( roomX + llg( map )->room[i].x - 1, roomY + llg( map )->room[i].y - 1 ), 36, bf
          love.graphics.setColor(36 / 255, 0, 0, 1.0)
          love.graphics.rectangle("fill", roomX, roomY, ll_global.map.room[i].x - 1, ll_global.map.room[i].y - 1)
          love.graphics.setColor(1, 1, 1, 1)
--
--           End If
        end
--           Line( roomX, roomY )-( roomX + llg( map )->room[i].x - 1, roomY + llg( map )->room[i].y - 1 ), 15, b
        love.graphics.setColor(15 / 255, 0, 0, 1.0)
        love.graphics.rectangle("line", roomX, roomY, ll_global.map.room[i].x - 1, ll_global.map.room[i].y - 1)
        love.graphics.setColor(1, 1, 1, 1)

--
--
--
--           For j = 0 To .doors - 1
        for j = 0, with0.doors - 1 do
--
--             With .door[j]
          local with1 = with0.door[j]
--
--               doorX = .location.x + roomX
          doorX = with1.location.x + roomX
--               doorY = .location.y + roomY
          doorY = with1.location.y + roomY
--
--               If .codes = 0 Then
          if with1.codes == 0 then
--
--                 Select Case .id
--
--                   Case DOOR_OPEN
            if with1.id == DOOR_OPEN then
--                     Line( doorX - 1, doorY - 1 )-( doorX + 1, doorY + 1 ), 36, bf
              love.graphics.setColor(36 / 255, 0, 0, 1.0)
              love.graphics.rectangle("fill", doorX - 1, doorY - 1, 2, 2)
              love.graphics.setColor(1, 1, 1, 1)
--
--                   Case DOOR_STAIR
            elseif with1.id == DOOR_STAIR then
--                     Line( doorX - 1, doorY - 1 )-( doorX + 1, doorY + 1 ), 170, bf
              love.graphics.setColor(170 / 255, 0, 0, 1.0)
              love.graphics.rectangle("fill", doorX - 1, doorY - 1, 2, 2)
              love.graphics.setColor(1, 1, 1, 1)
--
--                 End Select
            end
--
--               Else
          else
--
--                 eventsAchieved = -1
            eventsAchieved = -1
--                 For k = 0 To .codes - 1
            for k = 0, with1.codes - 1 do
--
--                   If .code[k] <> -1 Then
              if with1.code[k] ~= -1 then
--                     eventsAchieved And= ( llg( now )[.code[k]] <> 0 )
                eventsAchieved = bit.band(eventsAchieved, (ll_global.now[with1.code[k]] ~= 0) and -1 or 0)
--
--                   Else
              else
--                     eventsAchieved = 0
                eventsAchieved = 0
--
--                   End If
              end
--
--                 Next
            end
--
--                 If eventsAchieved <> 0 Then
            if eventsAchieved ~= 0 then
--                   Line( doorX - 1, doorY - 1 )-( doorX + 1, doorY + 1 ), 36, bf
              love.graphics.setColor(36 / 255, 0, 0, 1.0)
              love.graphics.rectangle("fill", doorX - 1, doorY - 1, 2, 2)
              love.graphics.setColor(1, 1, 1, 1)

--
--                 Else
            else
--
--                   Select Case .id
--
--                     Case DOOR_LOCKED
              if with1.id == DOOR_LOCKED then
--                       Line( doorX - 1, doorY - 1 )-( doorX + 1, doorY + 1 ), 15, bf
                love.graphics.setColor(15 / 255, 0, 0, 1.0)
                love.graphics.rectangle("fill", doorX - 1, doorY - 1, 2, 2)
                love.graphics.setColor(1, 1, 1, 1)

--
--                     Case DOOR_BARRED
              elseif with1.id == DOOR_BARRED then
--                       Line( doorX - 1, doorY - 1 )-( doorX + 1, doorY + 1 ), 245, bf
                love.graphics.setColor(245 / 255, 0, 0, 1.0)
                love.graphics.rectangle("fill", doorX - 1, doorY - 1, 2, 2)
                love.graphics.setColor(1, 1, 1, 1)
--
--                     Case DOOR_FKEYLOCKED
              elseif with1.id == DOOR_FKEYLOCKED then
--                       Line( doorX - 1, doorY - 1 )-( doorX + 1, doorY + 1 ), 27, bf
                love.graphics.setColor(27 / 255, 0, 0, 1.0)
                love.graphics.rectangle("fill", doorX - 1, doorY - 1, 2, 2)
                love.graphics.setColor(1, 1, 1, 1)
--
--                   End Select
              end
--
--                 End If
            end
--
--               End If
          end
--
--             End With
--
--           Next
        end
--
--
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
--   View Screen( 0, 0 )-( 319, 199 )
--
--   graphicalString( "Floor dn: [", 8, 182 )
  graphicalString("Floor dn: [", 8, 182)
--   If floor_Current > -1 Then
  if floor_Current > -1 then
--     graphicalString( "F" + Str( floor_Current + 1 ), 160 - ( Len( "F" + Str( floor_Current + 1 ) ) Shl 2 ), 182 )
    graphicalString("F"..(floor_Current + 1), 160 - bit.lshift(#("F"..(floor_Current + 1)), 2), 182)
--   Else
  else
--     graphicalString( "B" + Str( -floor_Current ), 160 - ( Len( "B" + Str( -floor_Current ) ) Shl 2 ), 182 )
    graphicalString("B"..(-floor_Current), 160 - bit.lshift(#("B"..(-floor_Current)), 2), 182)
--   End If
  end
--
--   graphicalString( "Floor up: ]", 224, 182 )
  graphicalString("Floor up: ]", 224, 182)
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

-- Sub screenQuake()
function screenQuake()
--
--   Const As Double frequency = .1
  local frequency = .1
--
--
--   If llg( hero_only ).quakeViolence = 0 Then
  if ll_global.hero_only.quakeViolence == 0 then
--     Exit Sub
    return
--
--   End If
  end
--
--   If Timer > tripPosition Then
  if timer > tripPosition then
--
--     Dim As Double calcTrip
    local calcTrip = 0.0
--     tripOffset.x = llg( hero_only ).quakeViolence
    tripOffset.x = ll_global.hero_only.quakeViolence
--     tripOffset.y = llg( hero_only ).quakeViolence
    tripOffset.y = ll_global.hero_only.quakeViolence
--
--     calcTrip = ( Rnd * 3 )
    calcTrip = (math.random() * 3)
--     calcTrip -= 1
    calcTrip = calcTrip - 1
--
--     tripOffset.x *= calcTrip
    tripOffset.x = tripOffset.x * calcTrip
--
--     calcTrip = ( Rnd * 3 )
    calcTrip = (math.random() * 3)
--     calcTrip -= 1
    calcTrip = calcTrip - 1
--
--     tripOffset.y *= calcTrip
    tripOffset.y = tripOffset.y * calcTrip
--
--     tripPosition = frequency + ( Rnd / 3 )
    tripPosition = frequency + (math.random() / 3)
--
--   End If
  end
--
--   Get( 0, 0 )-( 319, 199 ), llg( menu_ScreenSave )
--   Cls
--   Put( tripOffset.x, tripOffset.y ), llg( menu_ScreenSave ), Trans
--
--
--
-- End Sub
end
