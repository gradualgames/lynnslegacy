require("game/constants")
require("game/map_structures")
require("game/object_structures")

-- Function ctor_hero( l As char_type Ptr = 0 ) As char_type Ptr
function ctor_hero(l)
--
  --NOTE: The ability of the function to factory a new hero
  --object and return it was never used, so we do not port the logic here.
  --all we do is set up the hero object that is passed in.
--   Dim As Integer pass
--
--   If l = 0 Then
--     l = CAllocate( Len( char_type ) )
--     pass = Not 0
--
--   End If
--
--
--   With *l
--
--
--
--     l->id = "data\object\lynn.xml"
  l.id = "data/object/lynn.xml"
--
--     LLSystem_CopyNewObject( *l )
  LLSystem_CopyNewObject(l)
--
--     l->dead_sound = sound_lynn_die
  l.dead_sound = sound_lynn_die
--
--     .num = -1
  l.num = -1
--
--     .hp = 6
  l.hp = 6
--     .maxhp = 6
  l.maxhp = 6
--
--     llg( hero_only ).weapon = -1
  ll_global.hero_only.weapon = -1
--     llg( hero_only ).has_weapon = -1
  ll_global.hero_only.has_weapon = -1
--
--     llg( hero_only ).hasCostume( 0 ) = -1
  ll_global.hero_only.hasCostume[0] = -1
--     llg( hero ).fade_time = .003
  ll_global.hero.fade_time = .003
--
--   End With
--
  --NOTE: The ability of the function to factory a new hero
  --object and return it was never used, so we do not port the logic here.
  --all we do is set up the hero object that is passed in.
--   If pass <> 0 Then
--     Return l
--
--   End If
--
--
-- End Function
end

-- Sub seq_id( seqs As Integer, s As sequence_type Ptr, e As char_type Ptr )
function seq_id(seqs, s, e)
--
--   Dim As Integer grab_seq, loop_ents
  local grab_seq, loop_ents = 0, 0
--
--   For grab_seq = 0 To seqs - 1
  for grab_seq = 0, seqs - 1 do
--
--     For loop_ents = 0 To s[grab_seq].ents - 1
    for loop_ents = 0, s[grab_seq].ents - 1 do
--
--       If s[grab_seq].ent_code[loop_ents] = -1 Then
      if s[grab_seq].ent_code[loop_ents] == -1 then
--
--         s[grab_seq].ent[loop_ents] = @llg( hero )
        s[grab_seq].ent[loop_ents] = ll_global.hero
--
--       Else
      else
--
--         s[grab_seq].ent[loop_ents] = @e[s[grab_seq].ent_code[loop_ents]]
        s[grab_seq].ent[loop_ents] = e[s[grab_seq].ent_code[loop_ents]]
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
-- End Sub
end

--Loads a sequence from an already loaded map binary blob.
function load_seqV(mapBlob, numSeqs, seqs, seqType, seqIndex)
  -- For 0 to seqs - 1 do
  for grabSeq = 0, numSeqs - 1 do

    local sequence = create_sequence_type()
    sequence.seq_type = seqType
    sequence.seq_index = seqIndex

    -- Load .ents Integer
    sequence.ents = readInt(mapBlob)
    sequence.ent_code = {}

    -- For loop_ents is 0 to ents - 1 do
    for loopEnts = 0, sequence.ents - 1 do

      -- Load ent_code[loop_ents] Integer
      local ent_code = readInt(mapBlob)
      sequence.ent_code[loopEnts] = ent_code
    end

    -- Load .commands Integer

    sequence.commands = readInt(mapBlob)

    sequence.Command = {}

    -- For loop_commands is 0 to commands - 1 do
    for loopCommands = 0, sequence.commands - 1 do

      local command = create_command_type()
      -- load .ents Integer
      command.ents = readInt(mapBlob)
      command.ent = {}

      -- For loop_command_ents is 0 to ents - 1 do
      for loopCommandEnts = 0, command.ents - 1 do

        local commandData = create_command_data()

        -- Load .active_ent (command_data type)  Integer
        commandData.active_ent = readInt(mapBlob)
        -- Load .ent_state Integer
        commandData.ent_state = readInt(mapBlob)
        -- Set .hold_state to match .ent_state so commands can be reset
        commandData.hold_state = commandData.ent_state
        -- Load .text String
        commandData.text = readString(mapBlob)
        -- Load .walk_speed Double
        commandData.walk_speed = readDouble(mapBlob)
        -- Load .dest_y Short
        commandData.dest_y_box_invis = readShort(mapBlob)
        -- Load .dest_x Short
        commandData.dest_x = readShort(mapBlob)
        -- Load .abs_x Short
        commandData.abs_x = readShort(mapBlob)
        -- Load .abs_y Short
        commandData.abs_y = readShort(mapBlob)
        -- Load .mod_y Short
        commandData.mod_y = readShort(mapBlob)
        -- Load .mod_x Short
        commandData.mod_x = readShort(mapBlob)
        -- Load .to_map Integer
        commandData.to_map = readString(mapBlob)
        -- Load .to_entry Integer
        commandData.to_entry = readInt(mapBlob)
        -- Load .jump_count Integer
        commandData.jump_count = readInt(mapBlob)
        -- Load .water_align Integer
        commandData.water_align_union_text_speed = readInt(mapBlob)
        -- Load .chap Integer
        commandData.chap = readInt(mapBlob)
        -- Load .carries_all Integer
        commandData.carries_all = readInt(mapBlob)
        -- Load .nocam Integer
        commandData.nocam = readInt(mapBlob)
        -- Load .modify_direction Integer
        commandData.modify_direction = readInt(mapBlob)
        -- Load .seq_pause Integer
        commandData.seq_pause = readInt(mapBlob)
        -- Load .reserved_3 Integer
        commandData.reserved_3 = readInt(mapBlob)
        -- Load .reserved_4 Integer
        commandData.reserved_4 = readInt(mapBlob)
        -- Load .free_to_move Integer
        commandData.free_to_move = readInt(mapBlob)
        -- Load .display_hud Integer
        commandData.display_hud = readInt(mapBlob)
        -- Load .fadeTime Integer
        commandData.fadeTime = readDouble(mapBlob)
        -- 'Load .reserved_7 Integer COMMENTED OUT?
        -- 'Load .reserved_8 Integer COMMENTED OUT?
        -- Load .reserved_9 Integer
        commandData.reserved9 = readInt(mapBlob)
        -- Load .reserved_10 Integer
        commandData.reserved10 = readInt(mapBlob)

        command.ent[loopCommandEnts] = commandData
      end
      sequence.Command[loopCommands] = command
    end
    seqs[grabSeq] = sequence
  end
end

function LLSystem_LoadMap(fileName)
  local map = load_mapV(fileName)
  return map
end

-- Sub load_entrypoint()
function load_entrypoint()
--
--   llg( start_map ) = "data\map\title.map"
  ll_global.start_map = "data/map/title.map"
--   llg( start_entry ) = 0
  ll_global.start_entry = 0
--
-- End Sub
end

--Loads a Lynn's Legacy .map file. Assumes it is an uncompressed .map file.
--The original set of files were zlib compressed. I ran them through the
--offzip utility to decompress them.
function load_mapV(fileName)

  local map = create_map_type()

  local mapBlob = loadBlob(fileName)

  if mapBlob then

    map.filename = readString(mapBlob)

    -- If Instr( lmap->filename, "moenia" ) <> 0 Then
    if map.filename:find("moenia") then
    --   lmap->isDungeon = -1
      map.isDungeon = -1
    --   llg( dungeonName ) = "Moenia"
      ll_global.dungeonName = "Moenia"
    --
    -- End If
    end
    --
    -- If Instr( lmap->filename, "gelidus" ) <> 0 Then
    if map.filename:find("gelidus") then
    --   lmap->isDungeon = -1
      map.isDungeon = -1
    --   llg( dungeonName ) = "Gelidus"
      ll_global.dungeonName = "Gelidus"
    --
    -- End If
    end
    --
    -- If Instr( lmap->filename, "icefield" ) <> 0 Then
    if map.filename:find("icefield") then
    --   lmap->isDungeon = -1
      map.isDungeon = -1
    --   llg( dungeonName ) = "Ice Field"
      ll_global.dungeonName = "Ice Field"
    --
    -- End If
    end
    --
    -- If Instr( lmap->filename, "ignia" ) <> 0 Then
    if map.filename:find("ignia") then
    --   lmap->isDungeon = -1
      map.isDungeon = -1
    --   llg( dungeonName ) = "Ignia"
      ll_global.dungeonName = "Ignia"
    --
    -- End If
    end
    --
    -- If Instr( lmap->filename, "arx" ) <> 0 Then
    if map.filename:find("arx") then
    --   lmap->isDungeon = -1
      map.isDungeon = -1
    --   llg( dungeonName ) = "Arx"
      ll_global.dungeonName = "Arx"
    --
    -- End If
    end
    --
    -- If Instr( lmap->filename, "nerme" ) <> 0 Then
    if map.filename:find("nerme") then
    --   lmap->isDungeon = -1
      map.isDungeon = -1
    --   llg( dungeonName ) = "Nerme"
      ll_global.dungeonName = "Nerme"
    --
    -- End If
    end
    --
    -- If Instr( lmap->filename, "divius" ) <> 0 Then
    if map.filename:find("divius") then
    --   lmap->isDungeon = -1
      map.isDungeon = -1
    --   llg( dungeonName ) = "Divius"
      ll_global.dungeonName = "Divius"
    --
    -- End If
    end
    --
    -- '' add checks for all dungeons here

    map.entries = readInt(mapBlob)
    map.rooms = readInt(mapBlob)

    --NOTE: Load the tileset and set up sprite batches for
    --map specific 3 layer handling.
    map.tileset_filename = readString(mapBlob)
    map.tileset = getImageHeader(map.tileset_filename)
    map.tileset.spriteBatches = {}
    map.tileset.spriteBatches[0] = love.graphics.newSpriteBatch(map.tileset.image)
    map.tileset.spriteBatches[1] = love.graphics.newSpriteBatch(map.tileset.image)
    map.tileset.spriteBatches[2] = love.graphics.newSpriteBatch(map.tileset.image)

    map.room = {}

    for roomIndex = 0, map.rooms - 1 do

      local room = create_room_type()

      room.x = readInt(mapBlob)
      room.y = readInt(mapBlob)
      room.parallax = readInt(mapBlob)
      if room.parallax ~= 0 then
        room.para_filename = readString(mapBlob)
        room.para_img = getImageHeader(room.para_filename)
      end
      room.dark = readInt(mapBlob)
      room.teleports = readInt(mapBlob)
      room.song = readInt(mapBlob)
      room.song_changes = readInt(mapBlob)
      room.changes_to = readInt(mapBlob)
      room.reserved = readC(readInt, mapBlob, 18)

      room.teleport = {}

      for teleportIndex = 0, room.teleports - 1 do

        local teleport = {}

        teleport.x = readInt(mapBlob)
        teleport.y = readInt(mapBlob)
        teleport.w = readInt(mapBlob)
        teleport.h = readInt(mapBlob)
        teleport.to_room = readInt(mapBlob)
        teleport.to_map = readString(mapBlob)
        teleport.dx = readInt(mapBlob)
        teleport.dy = readInt(mapBlob)
        teleport.dd = readInt(mapBlob)
        teleport.to_song = readInt(mapBlob)
        teleport.reserved = readC(readInt, mapBlob, 20)

        room.teleport[teleportIndex] = teleport
      end

      room.seq_here = readInt(mapBlob)

      room.seq = room.seq_here > 0 and {} or nil
      room.seqi = 0

      load_seqV(mapBlob, room.seq_here, room.seq, "room", roomIndex)

      room.enemies = readInt(mapBlob)

      room.enemy = {}

      for enemyIndex = 0, room.enemies - 1 do
        local enemy = create_Object()
        enemy.x_origin = readInt(mapBlob)
        enemy.y_origin = readInt(mapBlob)
        enemy.id = readString(mapBlob)
        enemy.direction = readInt(mapBlob)
        enemy.seq_here = readInt(mapBlob)
        enemy.spawn_h = readShort(mapBlob)
        enemy.is_h_set = readShort(mapBlob)
        enemy.chap = readInt(mapBlob)
        enemy.spawn_d = readInt(mapBlob)
        enemy.is_d_set = readInt(mapBlob)
        enemy.reserved_5 = readInt(mapBlob)
        enemy.seq = enemy.seq_here > 0 and {} or nil
        enemy.seqi = 0
        load_seqV(mapBlob, enemy.seq_here, enemy.seq, "enemy", enemyIndex)

        enemy.spawn_cond = readInt(mapBlob)

        if enemy.spawn_cond ~= 0 then

          enemy.spawn_info = create_LLObject_ConditionalSpawn()
          enemy.spawn_info.wait_n = readInt(mapBlob)
          enemy.spawn_info.wait_spawn = {}

          for loopSpawns = 0, enemy.spawn_info.wait_n - 1 do
            local spawn = {}
            spawn.code_index = readShort(mapBlob)
            spawn.code_state = readInt(mapBlob)
            enemy.spawn_info.wait_spawn[loopSpawns] = spawn
          end

          enemy.spawn_info.kill_n = readInt(mapBlob)
          enemy.spawn_info.kill_spawn = {}

          for loopSpawns = 0, enemy.spawn_info.kill_n - 1 do
            local spawn = {}
            spawn.code_index = readShort(mapBlob)
            spawn.code_state = readInt(mapBlob)
            enemy.spawn_info.kill_spawn[loopSpawns] = spawn
          end

          enemy.spawn_info.active_n = readInt(mapBlob)
          enemy.spawn_info.active_spawn = {}

          for loopSpawns = 0, enemy.spawn_info.active_n - 1 do
            local spawn = {}
            spawn.code_index = readShort(mapBlob)
            spawn.code_state = readInt(mapBlob)
            enemy.spawn_info.active_spawn[loopSpawns] = spawn
          end

        end

        enemy.coords = create_vector()
        enemy.coords.x = enemy.x_origin
        enemy.coords.y = enemy.y_origin

        enemy.ori_dir = enemy.direction

        room.enemy[enemyIndex] = enemy

      end

      room.layout = {}

      --This calculation for the number of room elements represents the
      --upper bound (ubound) of a buffer from the original source code.
      --When declaring an array in FreeBASIC, you declare it with the
      --upper bound, which means the actual number of elements is the
      --upper bound plus one. To read the data correctly, we add one
      --to this number of elements (see the readC call below).

      room.room_elem = room.x * (room.y + 1) + 1

      for getNCpy = 0, 2 do

        local layer = readC(readShort, mapBlob, room.room_elem + 1)
        room.layout[getNCpy] = layer
        --function readC(readF, blob, count)

      end
      map.room[roomIndex] = room
    end

    map.entry = create_map_entry_type()

    for loopEntries = 0, map.entries - 1 do

      local entry = {}

      entry.x = readInt(mapBlob)
      entry.y = readInt(mapBlob)
      entry.room = readInt(mapBlob)
      entry.direction = readByte(mapBlob)
      entry.seq_here = readInt(mapBlob)
      entry.reserved = readStringL(mapBlob, 84)
      entry.seq = entry.seq_here > 0 and {} or nil
      entry.seqi = 0
      load_seqV(mapBlob, entry.seq_here, entry.seq, "entry", loopEntries)
      map.entry[loopEntries] = entry
    end

    -- For loop_rooms = 0 To lmap->rooms- 1
    for loop_rooms = 0, map.rooms - 1 do
    --
    --   With lmap->room[loop_rooms]
      local with0 = map.room[loop_rooms]
    --
    --     seq_id( .seq_here, _
    --             .seq, _
    --             .enemy )
      seq_id(with0.seq_here, with0.seq, with0.enemy)
    --
    --     For loop_enemies = 0 To .enemies - 1
      for loop_enemies = 0, with0.enemies - 1 do
    --
    --       With .enemy[loop_enemies]
        local with1 = with0.enemy[loop_enemies]
    --
    --         seq_id( .seq_here, _
    --                 .seq, _
    --                 lmap->room[loop_rooms].enemy )
        seq_id(with1.seq_here, with1.seq, map.room[loop_rooms].enemy)
    --
    --       End With
    --
    --     Next
      end
    --
    --   End With
    --
    -- Next
    end
    --
    -- For loop_entries = 0 To lmap->entries - 1
    for loop_entries = 0, map.entries - 1 do
    --
    --   With lmap->entry[loop_entries]
      local with0 = map.entry[loop_entries]
    --
    --     seq_id( .seq_here, _
    --             .seq, _
    --             lmap->room[.room].enemy )
      seq_id(with0.seq_here, with0.seq, map.room[with0.room].enemy)
    --
    --   End With
    --
    -- Next
    end

  end

  -- If lmap->isDungeon <> 0 Then
  if map.isDungeon ~= 0 then
  --   llg( minimap ) = LLMiniMap_LoadMiniMap( kfe( lmap->filename ) & ".mni", lmap->rooms )
    --NOTE: Beware of case insensitivity. miniMap is spelled in camel case
    --everywhere else!
    ll_global.miniMap = LLMiniMap_LoadMiniMap(string.sub(map.filename, 1, #map.filename - 4)..".mni", map.rooms)
  --
  -- End If
  end

  return map

end

-- Sub load_status_images( t As load_savImage Ptr )
function load_status_images(t)
--
--   With *t
  local with0 = t
--
--       .img( 0 ) = LLSystem_ImageDeref( LLSystem_ImageDerefName( "data\pictures\char\lynnstatus1.spr" ) )
  with0.img[0] = getImageHeader("data/pictures/char/lynnstatus1.spr")
--       .img( 1 ) = LLSystem_ImageDeref( LLSystem_ImageDerefName( "data\pictures\char\lynnstatus2.spr" ) )
  with0.img[1] = getImageHeader("data/pictures/char/lynnstatus2.spr")
--       .img( 2 ) = LLSystem_ImageDeref( LLSystem_ImageDerefName( "data\pictures\char\lynnstatus3.spr" ) )
  with0.img[2] = getImageHeader("data/pictures/char/lynnstatus3.spr")
--
--
--   End With
--
-- End Sub
end

-- Sub load_menu()
function load_menu()
--
--
--     With llg( menu ).menuImages
  local with0 = ll_global.menu.menuImages
--       .img( menu_blankspace      ) = LLSystem_ImageDeref( LLSystem_ImageDerefName( "data\pictures\menu\blankspace.spr"                    ) )
  with0.img[menu_blankspace] = getImageHeader("data/pictures/menu/blankspace.spr")
--       .img( menu_bridge          ) = LLSystem_ImageDeref( LLSystem_ImageDerefName( "data\pictures\menu\bridge.spr"                        ) )
  with0.img[menu_bridge] = getImageHeader("data/pictures/menu/bridge.spr")
--       .img( menu_bridge_select   ) = LLSystem_ImageDeref( LLSystem_ImageDerefName( "data\pictures\menu\bridge_select.spr"                 ) )
  with0.img[menu_bridge_select] = getImageHeader("data/pictures/menu/bridge_select.spr")
--       .img( menu_bridge2         ) = LLSystem_ImageDeref( LLSystem_ImageDerefName( "data\pictures\menu\bridge2.spr"                       ) )
  with0.img[menu_bridge2] = getImageHeader("data/pictures/menu/bridge2.spr")
--       .img( menu_bridge2_select  ) = LLSystem_ImageDeref( LLSystem_ImageDerefName( "data\pictures\menu\bridge2_select.spr"                ) )
  with0.img[menu_bridge2_select] = getImageHeader("data/pictures/menu/bridge2_select.spr")
--       .img( menu_bridge3         ) = LLSystem_ImageDeref( LLSystem_ImageDerefName( "data\pictures\menu\bridge3.spr"                       ) )
  with0.img[menu_bridge3] = getImageHeader("data/pictures/menu/bridge3.spr")
--       .img( menu_bridge3_select  ) = LLSystem_ImageDeref( LLSystem_ImageDerefName( "data\pictures\menu\bridge3_select.spr"                ) )
  with0.img[menu_bridge3_select] = getImageHeader("data/pictures/menu/bridge3_select.spr")
--       .img( menu_blank           ) = LLSystem_ImageDeref( LLSystem_ImageDerefName( "data\pictures\menu\item_blank.spr"                    ) )
  with0.img[menu_blank] = getImageHeader("data/pictures/menu/item_blank.spr")
--       .img( menu_blank_select    ) = LLSystem_ImageDeref( LLSystem_ImageDerefName( "data\pictures\menu\item_blank_select.spr"             ) )
  with0.img[menu_blank_select] = getImageHeader("data/pictures/menu/item_blank_select.spr")
--       .img( menu_flare           ) = LLSystem_ImageDeref( LLSystem_ImageDerefName( "data\pictures\menu\flare.spr"                         ) )
  with0.img[menu_flare] = getImageHeader("data/pictures/menu/flare.spr")
--       .img( menu_flare_select    ) = LLSystem_ImageDeref( LLSystem_ImageDerefName( "data\pictures\menu\flare_select.spr"                  ) )
  with0.img[menu_flare_select] = getImageHeader("data/pictures/menu/flare_select.spr")
--       .img( menu_full_background ) = LLSystem_ImageDeref( LLSystem_ImageDerefName( "data\pictures\menu\full_background.spr"               ) )
  with0.img[menu_full_background] = getImageHeader("data/pictures/menu/full_background.spr")
--       .img( menu_heal            ) = LLSystem_ImageDeref( LLSystem_ImageDerefName( "data\pictures\menu\heal.spr"                          ) )
  with0.img[menu_heal] = getImageHeader("data/pictures/menu/heal.spr")
--       .img( menu_heal_select     ) = LLSystem_ImageDeref( LLSystem_ImageDerefName( "data\pictures\menu\heal_select.spr"                   ) )
  with0.img[menu_heal_select] = getImageHeader("data/pictures/menu/heal_select.spr")
--       .img( menu_ice             ) = LLSystem_ImageDeref( LLSystem_ImageDerefName( "data\pictures\menu\ice.spr"                           ) )
  with0.img[menu_ice] = getImageHeader("data/pictures/menu/ice.spr")
--       .img( menu_ice_select      ) = LLSystem_ImageDeref( LLSystem_ImageDerefName( "data\pictures\menu\ice_select.spr"                    ) )
  with0.img[menu_ice_select] = getImageHeader("data/pictures/menu/ice_select.spr")
--       .img( menu_idol            ) = LLSystem_ImageDeref( LLSystem_ImageDerefName( "data\pictures\menu\idol.spr"                          ) )
  with0.img[menu_idol] = getImageHeader("data/pictures/menu/idol.spr")
--       .img( menu_idol_select     ) = LLSystem_ImageDeref( LLSystem_ImageDerefName( "data\pictures\menu\idol_select.spr"                   ) )
  with0.img[menu_idol_select] = getImageHeader("data/pictures/menu/idol_select.spr")
--       .img( menu_mace            ) = LLSystem_ImageDeref( LLSystem_ImageDerefName( "data\pictures\menu\mace.spr"                          ) )
  with0.img[menu_mace] = getImageHeader("data/pictures/menu/mace.spr")
--       .img( menu_mace_select     ) = LLSystem_ImageDeref( LLSystem_ImageDerefName( "data\pictures\menu\mace_select.spr"                   ) )
  with0.img[menu_mace_select] = getImageHeader("data/pictures/menu/mace_select.spr")
--       .img( menu_menu_select     ) = LLSystem_ImageDeref( LLSystem_ImageDerefName( "data\pictures\menu\menu_select.spr"                   ) )
  with0.img[menu_menu_select] = getImageHeader("data/pictures/menu/menu_select.spr")
--       .img( menu_regen           ) = LLSystem_ImageDeref( LLSystem_ImageDerefName( "data\pictures\menu\regen.spr"                         ) )
  with0.img[menu_regen] = getImageHeader("data/pictures/menu/regen.spr")
--       .img( menu_regen_select    ) = LLSystem_ImageDeref( LLSystem_ImageDerefName( "data\pictures\menu\regen_select.spr"                  ) )
  with0.img[menu_regen_select] = getImageHeader("data/pictures/menu/regen_select.spr")
--       .img( menu_resume_select   ) = LLSystem_ImageDeref( LLSystem_ImageDerefName( "data\pictures\menu\resume_select.spr"                 ) )
  with0.img[menu_resume_select] = getImageHeader("data/pictures/menu/resume_select.spr")
--       .img( menu_sapling         ) = LLSystem_ImageDeref( LLSystem_ImageDerefName( "data\pictures\menu\sapling.spr"                       ) )
  with0.img[menu_sapling] = getImageHeader("data/pictures/menu/sapling.spr")
--       .img( menu_sapling_select  ) = LLSystem_ImageDeref( LLSystem_ImageDerefName( "data\pictures\menu\sapling_select.spr"                ) )
  with0.img[menu_sapling_select] = getImageHeader("data/pictures/menu/sapling_select.spr")
--       .img( menu_square_cursor   ) = LLSystem_ImageDeref( LLSystem_ImageDerefName( "data\pictures\menu\square_cursor.spr"                 ) )
  with0.img[menu_square_cursor] = getImageHeader("data/pictures/menu/square_cursor.spr")
--       .img( menu_star            ) = LLSystem_ImageDeref( LLSystem_ImageDerefName( "data\pictures\menu\star.spr"                          ) )
  with0.img[menu_star] = getImageHeader("data/pictures/menu/star.spr")
--       .img( menu_star_select     ) = LLSystem_ImageDeref( LLSystem_ImageDerefName( "data\pictures\menu\star_select.spr"                   ) )
  with0.img[menu_star_select] = getImageHeader("data/pictures/menu/star_select.spr")
--       .img( menu_cougar          ) = LLSystem_ImageDeref( LLSystem_ImageDerefName( "data\pictures\char\outfits\cougar\icon.spr"           ) )
  with0.img[menu_cougar] = getImageHeader("data/pictures/char/outfits/cougar/icon.spr")
--       .img( menu_lynnity         ) = LLSystem_ImageDeref( LLSystem_ImageDerefName( "data\pictures\char\outfits\lynnity\icon.spr"          ) )
  with0.img[menu_lynnity] = getImageHeader("data/pictures/char/outfits/lynnity/icon.spr")
--       .img( menu_ninja           ) = LLSystem_ImageDeref( LLSystem_ImageDerefName( "data\pictures\char\outfits\ninja\icon.spr"            ) )
  with0.img[menu_ninja] = getImageHeader("data/pictures/char/outfits/ninja/icon.spr")
--       .img( menu_standard        ) = LLSystem_ImageDeref( LLSystem_ImageDerefName( "data\pictures\char\icon.spr"                          ) )
  with0.img[menu_standard] = getImageHeader("data/pictures/char/icon.spr")
--       .img( menu_cougar_select   ) = LLSystem_ImageDeref( LLSystem_ImageDerefName( "data\pictures\char\outfits\cougar\icon_select.spr"    ) )
  with0.img[menu_cougar_select] = getImageHeader("data/pictures/char/outfits/cougar/icon_select.spr")
--       .img( menu_lynnity_select  ) = LLSystem_ImageDeref( LLSystem_ImageDerefName( "data\pictures\char\outfits\lynnity\icon_select.spr"   ) )
  with0.img[menu_lynnity_select] = getImageHeader("data/pictures/char/outfits/lynnity/icon_select.spr")
--       .img( menu_ninja_select    ) = LLSystem_ImageDeref( LLSystem_ImageDerefName( "data\pictures\char\outfits\ninja\icon_select.spr"     ) )
  with0.img[menu_ninja_select] = getImageHeader("data/pictures/char/outfits/ninja/icon_select.spr")
--       .img( menu_standard_select ) = LLSystem_ImageDeref( LLSystem_ImageDerefName( "data\pictures\char\icon_select.spr"                   ) )
  with0.img[menu_standard_select] = getImageHeader("data/pictures/char/icon_select.spr")
--       .img( menu_bikini          ) = LLSystem_ImageDeref( LLSystem_ImageDerefName( "data\pictures\char\outfits\swimsuit\icon.spr"         ) )
  with0.img[menu_bikini] = getImageHeader("data/pictures/char/outfits/swimsuit/icon.spr")
--       .img( menu_bikini_select   ) = LLSystem_ImageDeref( LLSystem_ImageDerefName( "data\pictures\char\outfits\swimsuit\icon_select.spr"  ) )
  with0.img[menu_bikini_select] = getImageHeader("data/pictures/char/outfits/swimsuit/icon_select.spr")
--       .img( menu_rknight         ) = LLSystem_ImageDeref( LLSystem_ImageDerefName( "data\pictures\char\outfits\redknight\icon.spr"        ) )
  with0.img[menu_rknight] = getImageHeader("data/pictures/char/outfits/redknight/icon.spr")
--       .img( menu_rknight_select  ) = LLSystem_ImageDeref( LLSystem_ImageDerefName( "data\pictures\char\outfits\redknight\icon_select.spr" ) )
  with0.img[menu_rknight_select] = getImageHeader("data/pictures/char/outfits/redknight/icon_select.spr")
--
--     End With
--
--     With llg( menu )
  with0 = ll_global.menu
--
--       .menuNames( menu_bridge_select   ) = "Some old scraps."
  with0.menuNames[menu_bridge_select] = "Some old scraps."
--       .menuNames( menu_flare_select    ) = "Flare Powder."
  with0.menuNames[menu_flare_select] = "Flare Powder."
--       .menuNames( menu_ice_select      ) = "Ice Powder."
  with0.menuNames[menu_ice_select] = "Ice Powder."
--       .menuNames( menu_idol_select     ) = "An ancient treasure."
  with0.menuNames[menu_idol_select] = "An ancient treasure."
--       .menuNames( menu_regen_select    ) = "Adrenaline Booster."
  with0.menuNames[menu_regen_select] = "Adrenaline Booster."
--       .menuNames( menu_heal_select     ) = "Healing Symbol."
  with0.menuNames[menu_heal_select] = "Healing Symbol."
--
--       .menuNames( menu_sapling_select  ) = "A small sapling."
  with0.menuNames[menu_sapling_select] = "A small sapling."
--       .menuNames( menu_mace_select     ) = "My old mace."
  with0.menuNames[menu_mace_select] = "My old mace."
--       .menuNames( menu_star_select     ) = "Handcrafted 0wnage."
  with0.menuNames[menu_star_select] = "Handcrafted 0wnage."
--
--       .menuNames( menu_standard_select ) = "Normal outfit."
  with0.menuNames[menu_standard_select] = "Normal outfit."
--       .menuNames( menu_cougar_select   ) = "Mew..."
  with0.menuNames[menu_cougar_select] = "Mew..."
--       .menuNames( menu_lynnity_select  ) = "Tight Leather."
  with0.menuNames[menu_lynnity_select] = "Tight Leather."
--       .menuNames( menu_ninja_select    ) = "..."
  with0.menuNames[menu_ninja_select] = "..."
--       .menuNames( menu_bikini_select   ) = "Not very practical..."
  with0.menuNames[menu_bikini_select] = "Not very practical..."
--       .menuNames( menu_rknight_select  ) = "Regenerative power."
  with0.menuNames[menu_rknight_select] = "Regenerative power."
--
--       .menuNames( menu_menu_select     ) = "Back to title screen."
  with0.menuNames[menu_menu_select] = "Back to title screen."
--       .menuNames( menu_resume_select   ) = "Back to the game."
  with0.menuNames[menu_resume_select] = "Back to the game."
--
--     End With
--
--
--
-- End Sub
end

-- Sub load_hud( h As load_hudImage Ptr )
function load_hud(h)
--
--   With *h
--
--     .img( 0 ) = LLSystem_ImageDeref( LLSystem_ImageDerefName( "data\pictures\hud\HUD_health.spr"  ) )
  h.img[0] = getImageHeader("data/pictures/hud/hud_health.spr")
--     .img( 1 ) = LLSystem_ImageDeref( LLSystem_ImageDerefName( "data\pictures\hud\HUD_items.spr"   ) )
  h.img[1] = getImageHeader("data/pictures/hud/hud_items.spr")
--     .img( 2 ) = LLSystem_ImageDeref( LLSystem_ImageDerefName( "data\pictures\hud\cash.spr"        ) )
  h.img[2] = getImageHeader("data/pictures/hud/cash.spr")
--     .img( 3 ) = LLSystem_ImageDeref( LLSystem_ImageDerefName( "data\pictures\hud\cashnumbers.spr" ) )
  h.img[3] = getImageHeader("data/pictures/hud/cashnumbers.spr")
--     .img( 4 ) = LLSystem_ImageDeref( LLSystem_ImageDerefName( "data\pictures\hud\fullbar.spr"     ) )
  h.img[4] = getImageHeader("data/pictures/hud/fullbar.spr")
--     .img( 5 ) = LLSystem_ImageDeref( LLSystem_ImageDerefName( "data\pictures\hud\key.spr"         ) )
  h.img[5] = getImageHeader("data/pictures/hud/key.spr")
--     .img( 6 ) = LLSystem_ImageDeref( LLSystem_ImageDerefName( "data\pictures\hud\key2.spr"        ) )
  h.img[6] = getImageHeader("data/pictures/hud/key2.spr")
--
--     .img( 7 ) = LLSystem_ImageDeref( LLSystem_ImageDerefName( "data\pictures\hud\materials2.spr"   ) )
  h.img[7] = getImageHeader("data/pictures/hud/materials2.spr")
--     .img( 8 ) = LLSystem_ImageDeref( LLSystem_ImageDerefName( "data\pictures\hud\materials3.spr"   ) )
  h.img[8] = getImageHeader("data/pictures/hud/materials3.spr")
--
--   End With
--
-- End Sub
end

-- Function make_box( txt As String, a_lock As Integer, clr As Short, invis As Short, auto As Double, x As Short, y As Short, spd As Integer ) As boxcontrol_type
function make_box(txt, a_lock, clr, invis, auto, x, y, spd)
--
--   Dim As boxcontrol_type box
  local box = create_boxcontrol_type()
--   Dim As boxcontrol_type Ptr b = @box
  local b = box
--
--     box.ptrs.box  = LLSystem_ImageDeref( LLSystem_ImageDerefName( "data\pictures\textbox.spr"  ) )
  box.ptrs.box = getImageHeader("data/pictures/textbox.spr")
--     box.ptrs.Next = LLSystem_ImageDeref( LLSystem_ImageDerefName( "data\pictures\textdown.spr" ) )
  box.ptrs.Next = getImageHeader("data/pictures/textdown.spr")
--     'box.ptrs.mask = LLSystem_ImageDeref( LLSystem_ImageDerefName( "data\pictures\emptybox.spr" ) )
--
--   init_box( txt, b )
  init_box(txt, b)
--
--   b->layout.speed = .021813
  b.layout.speed = .021813
--
--   If a_lock = 0 Then
  if a_lock == 0 then
--
--     llg( hero_only ).action_lock = -1
    ll_global.hero_only.action_lock = -1
--
--
--   End If
  end
--
--   b->internal.lastFG = llg( fontFG )
  b.internal.lastFG = ll_global.fontFG
--
--   If clr <> 0 Then
  if clr ~= 0 then
--
--     dim as integer shake
    local shake = 0
--     shake = clr
    shake = clr
--     __set_font_fg( cast( any ptr, shake ) )
--
--   End If
  end
--
--
--   If invis <> 0 Then
  if invis ~= 0 then
--
--     b->layout.invis = -1
    b.layout.invis = -1
--
--   End If
  end
--
--   If auto <> 0 Then
  if auto ~= 0 then
--
--     b->internal.auto = -1
    b.internal.auto = -1
--     b->internal.autosleep = auto
    b.internal.autosleep = auto
--
--   End If
  end
--
--
--   If x <> 0 Then
  if x ~= 0 then
--
--     b->layout.x_loc = x
    b.layout.x_loc = x
--
--   End If
  end
--
--   If y <> 0 Then
  if y ~= 0 then
--
--     b->layout.y_loc = y
    b.layout.y_loc = y
--
--   End If
  end
--
--   If spd <> 0 Then
  if spd ~= 0 then
--
--     if spd = conf_Box then
    if spd == conf_Box then
--       b->internal.confBox = TRUE
      b.internal.confBox = TRUE
--
--     else
    else
--       b->layout.speed = spd / 1000
      b.layout.speed = spd / 1000
--
--     end if
    end
--
--   End If
  end
--
--
--
--   b->activated = TRUE
  b.activated = 1
--   b->internal.state = TEXTBOX_REGULAR
  b.internal.state = TEXTBOX_REGULAR

--
--   Return box
  return box
--
-- End Function
end

-- private function parseText( textToParse as string ) as string
function parseText(textToParse)
--
--   dim as string res
  local res = ""
--   dim as integer c
  local c = 1
--
--   do
  repeat
--
--     if textToParse[c] = asc( "{" ) then
    if textToParse:sub(c, c) == '{' then
--       '' special token
--       dim as string tok
      local tok = ""
--       dim as integer c2
      local c2 = 0
--
--       do
      repeat
--
--         tok += " "
--
--         tok[c2] = textToParse[c + c2]
        local char = textToParse:sub(c + c2, c + c2)
        tok = tok..char
--
--         c2 += 1
        c2 = c2 + 1
--         if tok[c2-1] = asc( "}" ) then exit do
--
--       loop
      until char == '}'
--
--       if ucase( tok ) = "{HEALTHPRICE}" then
      if tok:upper() == "{HEALTHPRICE}" then
--         res += str( healthFormula )
        res = res..healthFormula()
--
--       end if
      end
--
--       if ucase( tok ) = "{HEALTHNOW}" then
      if tok:upper() == "{HEALTHNOW}" then
--         res += str( llg( hero ).maxhp )
        res = res..ll_global.hero.maxhp
--
--       end if
      end
--
--       if ucase( tok ) = "{HEALTHUP}" then
      if tok:upper() == "{HEALTHUP}" then
--         res += str( llg( hero ).maxhp + 1 )
        res = res..(ll_global.hero.maxhp + 1)
--
--       end if
      end
--
--       if ucase( tok ) = "{NEWLINE}" then
      if tok:upper() == "{NEWLINE}" then
--         res += "{NEWLINE}"
        res = res.."{NEWLINE}"
--
--       end if
      end
--
--       c += c2
      c = c + c2
--
--     end if
    end
--
--     res += chr( textToParse[c] )
    res = res..textToParse:sub(c, c)
--     c += 1
    c = c + 1
--
--     if c = len( textToParse ) then exit do
    if c == (#textToParse + 1) then break end
--
--   loop
  until false
--
--   return res
  return res
--
-- end function
end

-- Sub init_box( ByVal text As String, b As boxcontrol_type Ptr )
function init_box(text, b)
--
--   dim as string tempBuffer
  local tempBuffer = ""
--
--   tempBuffer = parseText( text )
  tempBuffer = parseText(text)
--
--   Redim As String words( 0 ), lines( 0 )
  local words, lines = {}, {}
--
--   Scope
--
--     Dim As Integer word_num, parse_loc
  local word_num, parse_loc = 0, 0
--     Dim As Integer p_char
  local p_char = 0
--
--       For parse_loc = 0 To Len( tempBuffer ) - 1
  for parse_loc = 1, #tempBuffer do
--
--         Redim Preserve words( word_num )
--
--         p_char = tempBuffer[parse_loc]
    p_char = tempBuffer:sub(parse_loc, parse_loc)
--
--         words( word_num ) += Chr( p_char )
    words[word_num] = (words[word_num] and words[word_num] or "")..p_char
--         If p_char = Asc( " " ) Then word_num += 1
    if p_char == " " then word_num = word_num + 1 end
--
--       Next
  end
--
--   End Scope
--
--
--   Scope
--
--     Dim As String msgline
  local msgline = ""
--     Dim As Integer wordindex, lineindex
  local wordindex, lineindex = 0, 0
--     Dim As Integer getoutflag
  local getoutflag = 0
--
--       Do
  repeat
--
--         If wordindex - 1 <> UBound( words ) Then
    if wordindex - 1 ~= #words then
--           '' not past the last word
--
--           If ( Len( msgline ) + Len( words( wordindex ) ) < 36 ) and ( words( wordindex ) <> "{NEWLINE} " ) Then
      if (#msgline + #words[wordindex] < 36) and (words[wordindex] ~= "{NEWLINE} ") then
--             '' the message length is less than 36 if we add this word
--
--             msgline += words( wordindex )
        msgline = msgline..words[wordindex]
--             wordindex += 1
        wordindex = wordindex + 1
--
--           Else
      else
--             '' the message would exceed box width, start a new line
--             if words( wordindex ) = "{NEWLINE} " then
        if words[wordindex] == "{NEWLINE} " then
--               wordindex += 1
          wordindex = wordindex + 1
--
--             end if
        end
--
--             Redim Preserve lines( lineindex )
--
--             lines( lineindex ) = msgline
        lines[lineindex] = msgline
--             lineindex += 1
        lineindex = lineindex + 1
--
--             msgline = ""
        msgline = ""
--
--           End If
      end
--
--         Else
    else
--           '' past the last word... close it up.
--
--           Redim Preserve lines( lineindex )
--
--           lines( lineindex ) = msgline
      lines[lineindex] = msgline
--           getoutflag = Not 0
      getoutflag = -1
--
--
--         End If
    end
--
--       Loop Until getoutflag
  until getoutflag ~= 0
--
--
--   End Scope
--
--
--   b->internal.numoflines = UBound( lines ) + 1
  b.internal.numoflines = #lines + 1
--
--   b->ptrs.row = CAllocate( ( b->internal.numoflines ) * Len( String ) )
  b.ptrs.row = {}
--
--
--   Scope
--
--     Dim As Integer stuff_lines
  local stuff_lines = 0
--     Dim As Integer leng, diff
  local leng, diff = 0, 0
--
--     For stuff_lines = 0 To b->internal.numoflines - 1
  for stuff_lines = 0, b.internal.numoflines - 1 do
--
--       leng = Len( lines( stuff_lines ) )
    leng = #lines[stuff_lines]
--       diff = 38 - leng
    diff = 38 - leng
--
--
--       Scope
--
--         Dim As uByte lin_msg( 36 )
    local lin_msg = "                                     "
--         MemSet( @lin_msg( 0 ), 0, 37 ) '' <---- ?? fb doesn't clear it...
--
--         Dim As Integer put_ch
    local put_ch = 1
--
--           For put_ch = 0 To leng - 1
    for put_ch = 1, leng do
--
--             lin_msg( put_ch + ( diff \ 2 ) ) = lines( stuff_lines )[put_ch]
      lin_msg = replace_char(put_ch + math.floor(diff / 2), lin_msg, lines[stuff_lines]:sub(put_ch, put_ch))
--
--           Next
    end
--
--           b->ptrs.row[stuff_lines] = cva( @lin_msg( 0 ), 37 )
    b.ptrs.row[stuff_lines] = lin_msg
--
--       End Scope
--
--     Next
  end
--
--   End Scope
--
--
-- End Sub
end

-- Function LLMiniMap_LoadMiniMap( fileName As String, rooms As Integer ) As LL_MiniMapType
function LLMiniMap_LoadMiniMap(fileName, rooms)
--
--
--   Dim As LL_MiniMapType res
  local res = create_LL_MiniMapType()
--
--   Dim As Integer ff = FreeFile
  local ff = 0
--
--   Dim As Integer i, j, k
  local i, j, k = 0, 0, 0
--
--   Open fileName For Binary As #ff
  --NOTE: icefield.mni does not exist for icefield.map. The
  --original codebase doesn't seem to care because it opens
  --the file for binary random access, which does not throw a
  --runtime error for nonexistent files. Instead it reads all
  --zeros from the nonexistent file. In our case, we have to not
  --try to read a nonexistent file and just return the empty minimap,
  --which in theory should be logically equivalent.
  if love.filesystem.getInfo(fileName) then
    ff = loadBlob(fileName)
--
--     With res
    local with0 = res
--
--       .room = CAllocate( rooms * Len( LL_MiniMapRoomType ) )
--       For i = 0 To rooms - 1
    for i = 0, rooms - 1 do
--
--         With .room[i]
      with0.room[i] = create_LL_MiniMapRoomType()
      local with1 = with0.room[i]
--
--           Get #ff, , .location.x
      with1.location.x = readInt(ff)
--           Get #ff, , .location.y
      with1.location.y = readInt(ff)
--           Get #ff, , .floor
      with1.floor = readInt(ff)
--
--           Get #ff, , .doors
      with1.doorsoffset = offset(ff)
      with1.doors = readInt(ff)
--
--           .door = CAllocate( .doors * Len( LL_MiniMapRoomDoorType ) )
      with1.door = {}
--           For j = 0 To .doors - 1
      for j = 0, with1.doors - 1 do
--
--             With .door[j]
        with1.door[j] = create_LL_MiniMapRoomDoorType()
        local with2 = with1.door[j]
--
        with2.offset = offset(ff)
--               Get #ff, , .location.x
        with2.location.x = readInt(ff)
--               Get #ff, , .location.y
        with2.location.y = readInt(ff)
--               Get #ff, , .codes
        with2.codes = readInt(ff)
--
--               If .codes > 0 Then
        if with2.codes > 0 then
--
--                 .code = CAllocate( .codes * Len( Integer ) )
          with2.code = {}
--                 For k = 0 To .codes - 1
          for k = 0, with2.codes - 1 do
--                   Get #ff, , .code[k]
            with2.code[k] = readInt(ff)
--
--                 Next
          end
--
--               End If
        end
--
--               Get #ff, , .id
        with2.id = readInt(ff)
--
--             End With
--
--           Next
      end
--
--         End With
--
--       Next
    end
  end
--
--     End With
--
--   Close #ff
--
--   Return res
  return res
--
-- End Function
end
