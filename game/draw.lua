function blit_scene()
  -- If llg( do_chap ) = 0 Then
  --   '' chapter screen is not up
  --   update_cam( llg( current_cam ) )
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
  --   LLEngine_BlitLayer( 1 )
  layoutLayer(camera, map.rooms[curRoom], 2, map.imageHeader, map.imageHeader.spriteBatches[2])
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
  layoutLayer(camera, map.rooms[curRoom], 3, map.imageHeader, map.imageHeader.spriteBatches[3])
  --
  -- End If
  --
  -- If llg( box_entity ) <> 0 Then
  --   __handle_menu( llg( box_entity ) )
  --
  -- End If

  love.graphics.draw(map.imageHeader.spriteBatches[1])
  love.graphics.draw(map.imageHeader.spriteBatches[2])
  --drawEnemies()
  love.graphics.draw(map.imageHeader.spriteBatches[3])
end

function blit_y_sorted()

end

--Updates a room using the tile indices from the room to arrange
--the spritebatch for drawing, based on an image header.
function layoutLayer(camera, room, layer, imageHeader, spriteBatch)

  spriteBatch:clear()
  local topLeftMapX = math.floor(camera.x / imageHeader.x)
  local topLeftMapY = math.floor(camera.y / imageHeader.y)
  local topLeftScreenX = -(camera.x % imageHeader.x)
  local topLeftScreenY = -(camera.y % imageHeader.y)
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

function drawFirstSpriteInImage(spriteSheet, image, screenX, screenY)
  local quadX, quadY = 0, 0
  local quad = love.graphics.newQuad(
    quadX,
    quadY,
    spriteSheet.width,
    spriteSheet.height,
    image:getDimensions())
  love.graphics.draw(image, quad, screenX, screenY)
end

function drawImage(spriteSheet, image, screenX, screenY)
  love.graphics.draw(image, screenX, screenY)
end

-- --This function just lays out the first sprite from the sprite
-- --sheet into the sprite batch, just for testing.
-- function layoutFirstSpriteInSpriteBatch(spriteSheet, spriteBatch)
--
--   spriteBatch:clear()
--   local quadX, quadY = 0, 0
--   for i = 1, 1 do
--     local quad = love.graphics.newQuad(
--       quadX,
--       quadY,
--       spriteSheet.width,
--       spriteSheet.height,
--       spriteSheet.width * spriteSheet.frameCount,
--       spriteSheet.height)
--     spriteBatch:add(quad, quadX, quadY)
--     quadX = quadX + spriteSheet.width
--   end
--   spriteBatch:flush()
--
-- end
--
-- --This function lays out a sprite batch with all frames in
-- --order. This is really just used for debugging and inspecting
-- --a given sprite sheet.
-- function layoutSpriteBatch(spriteSheet, spriteBatch)
--
--   spriteBatch:clear()
--   local quadX, quadY = 0, 0
--   for i = 1, spriteSheet.frameCount do
--     local quad = love.graphics.newQuad(
--       quadX,
--       quadY,
--       spriteSheet.width,
--       spriteSheet.height,
--       spriteSheet.width * spriteSheet.frameCount,
--       spriteSheet.height)
--     spriteBatch:add(quad, quadX, quadY)
--     quadX = quadX + spriteSheet.width
--   end
--   spriteBatch:flush()
--
-- end
