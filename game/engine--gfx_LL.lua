require("game/constants")
require("game/macros")

--Updates a room using the tile indices from the room to arrange
--the spritebatch for drawing, based on an image header.
function layoutLayer(camera, room, layer, imageHeader, spriteBatch)
  if drawing then
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
          if bpressed("right") then
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
          if bpressed("left") then
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
        if bpressed("space") then
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
        draw(anim.image, anim.quads[0], enemy.drop.coords.x - ll_global.this_room.cx, enemy.drop.coords.y - ll_global.this_room.cy)
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
