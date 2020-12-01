require("game/map_structures")
require("game/object_structures")

-- Function ctor_hero( l As char_type Ptr = 0 ) As char_type Ptr
function ctor_hero(l)
--
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
  --log.level = "debug"
  LLSystem_ObjectLoad(l)
  --log.level = "fatal"
--
--     l->dead_sound = sound_lynn_die
--
--     .num = -1
  l.num = -1
--
--     .hp = 6
  l.hp = 3
--     .maxhp = 6
  l.maxhp = 6
--
--     llg( hero_only ).weapon = -1
  ll_global.hero_only.weapon = -1
--     llg( hero_only ).has_weapon = -1
  ll_global.hero_only.has_weapon = -1
--
--     llg( hero_only ).hasCostume( 0 ) = -1
--     llg( hero ).fade_time = .003
--
--   End With
--
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
    log.debug("s[grab_seq].ent_code[loop_ents]: "..s[grab_seq].ent_code[loop_ents])
--       If s[grab_seq].ent_code[loop_ents] = -1 Then
      if s[grab_seq].ent_code[loop_ents] == -1 then
--
--         s[grab_seq].ent[loop_ents] = @llg( hero )
        s[grab_seq].ent[loop_ents] = ll_global.hero
--
--       Else
      else
        log.debug("Getting entity for sequence ent array.")
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
  log.debug("numSeqs: "..numSeqs)
  log.debug("seqType: "..seqType)
  -- For 0 to seqs - 1 do
  for grabSeq = 0, numSeqs - 1 do

    local sequence = create_sequence_type()
    sequence.seq_type = seqType
    sequence.seq_index = seqIndex

    -- Load .ents Integer
    sequence.ents = readInt(mapBlob)
    log.debug("sequence.ents: "..sequence.ents)
    sequence.ent_code = {}

    -- For loop_ents is 0 to ents - 1 do
    for loopEnts = 0, sequence.ents - 1 do

      -- Load ent_code[loop_ents] Integer
      local ent_code = readInt(mapBlob)
      log.debug("ent_code: "..ent_code)
      sequence.ent_code[loopEnts] = ent_code
    end

    -- Load .commands Integer

    sequence.commands = readInt(mapBlob)
    log.debug("sequence.commands: "..sequence.commands)

    sequence.Command = {}

    -- For loop_commands is 0 to commands - 1 do
    for loopCommands = 0, sequence.commands - 1 do

      local command = create_command_type()
      -- load .ents Integer
      command.ents = readInt(mapBlob)
      log.debug("command.ents: "..command.ents)
      command.ent = {}

      -- For loop_command_ents is 0 to ents - 1 do
      for loopCommandEnts = 0, command.ents - 1 do

        local commandData = create_command_data()

        -- Load .active_ent (command_data type)  Integer
        commandData.active_ent = readInt(mapBlob)
        log.debug("commandData.active_ent: "..commandData.active_ent)
        -- Load .ent_state Integer
        commandData.ent_state = readInt(mapBlob)
        log.debug("commandData.ent_state: "..commandData.ent_state)
        -- Load .text String
        commandData.text = readString(mapBlob)
        log.debug("commandData.text: "..commandData.text)
        -- Load .walk_speed Double (TODO: this may be tricky to load and interpret in Lua)
        commandData.walk_speed = readDouble(mapBlob)
        log.debug("commandData.walk_speed: "..commandData.walk_speed)
        -- Load .dest_y Short
        commandData.dest_y = readShort(mapBlob)
        log.debug("commandData.dest_y: "..commandData.dest_y)
        -- Load .dest_x Short
        commandData.dest_x = readShort(mapBlob)
        log.debug("commandData.dest_x: "..commandData.dest_x)
        -- Load .abs_x Short
        commandData.abs_x = readShort(mapBlob)
        log.debug("commandData.abs_x: "..commandData.abs_x)
        -- Load .abs_y Short
        commandData.abs_y = readShort(mapBlob)
        log.debug("commandData.abs_y: "..commandData.abs_y)
        -- Load .mod_y Short
        commandData.mod_y = readShort(mapBlob)
        log.debug("commandData.mod_y: "..commandData.mod_y)
        -- Load .mod_x Short
        commandData.mod_x = readShort(mapBlob)
        log.debug("commandData.mod_x: "..commandData.mod_x)
        -- Load .to_map Integer
        commandData.to_map = readString(mapBlob)
        log.debug("commandData.to_map: "..commandData.to_map)
        -- Load .to_entry Integer
        commandData.to_entry = readInt(mapBlob)
        log.debug("commandData.to_entry: "..commandData.to_entry)
        -- Load .jump_count Integer
        commandData.jump_count = readInt(mapBlob)
        log.debug("commandData.jump_count: "..commandData.jump_count)
        -- Load .water_align Integer
        commandData.water_align = readInt(mapBlob)
        log.debug("commandData.water_align: "..commandData.water_align)
        -- Load .chap Integer
        commandData.chap = readInt(mapBlob)
        log.debug("commandData.chap: "..commandData.chap)
        -- Load .carries_all Integer
        commandData.carries_all = readInt(mapBlob)
        log.debug("commandData.carries_all: "..commandData.carries_all)
        -- Load .nocam Integer
        commandData.nocam = readInt(mapBlob)
        log.debug("commandData.nocam: "..commandData.nocam)
        -- Load .modify_direction Integer
        commandData.modify_direction = readInt(mapBlob)
        log.debug("commandData.modify_direction: "..commandData.modify_direction)
        -- Load .seq_pause Integer
        commandData.seq_pause = readInt(mapBlob)
        log.debug("commandData.seq_pause: "..commandData.seq_pause)
        -- Load .reserved_3 Integer
        commandData.reserved_3 = readInt(mapBlob)
        log.debug("commandData.reserved_3: "..commandData.reserved_3)
        -- Load .reserved_4 Integer
        commandData.reserved_4 = readInt(mapBlob)
        log.debug("commandData.reserved_4: "..commandData.reserved_4)
        -- Load .free_to_move Integer
        commandData.free_to_move = readInt(mapBlob)
        log.debug("commandData.free_to_move: "..commandData.free_to_move)
        -- Load .display_hud Integer
        commandData.display_hud = readInt(mapBlob)
        log.debug("commandData.display_hud: "..commandData.display_hud)
        -- Load .fadeTime Integer
        commandData.fadeTime = readDouble(mapBlob)
        log.debug("commandData.fadeTime: "..commandData.fadeTime)
        -- 'Load .reserved_7 Integer COMMENTED OUT?
        -- 'Load .reserved_8 Integer COMMENTED OUT?
        -- Load .reserved_9 Integer
        commandData.reserved9 = readInt(mapBlob)
        log.debug("commandData.reserved9: "..commandData.reserved9)
        -- Load .reserved_10 Integer
        commandData.reserved10 = readInt(mapBlob)
        log.debug("commandData.reserved10: "..commandData.reserved10)

        command.ent[loopCommandEnts] = commandData
      end
      sequence.Command[loopCommands] = command
    end
    seqs[grabSeq] = sequence
  end
end

function LLSystem_LoadMap(fileName)
  log.debug("LLSystem_LoadMap called.")
  local map = load_mapV(fileName)
  return map
end

-- Sub load_entrypoint()
function load_entrypoint()
--
--   llg( start_map ) = "data\map\title.map"
  ll_global.start_map = "data/map/forest_fall.map"
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
    log.debug("map.filename: "..map.filename)
    map.entries = readInt(mapBlob)
    log.debug("map.entries: "..map.entries)
    map.rooms = readInt(mapBlob)
    log.debug("map.rooms: "..map.rooms)

    --NOTE: Load the tileset and set up sprite batches for
    --map specific 3 layer handling.
    map.tileset_filename = readString(mapBlob)
    log.debug("map.tileset_filename: "..map.tileset_filename)
    map.tileset = getImageHeader(map.tileset_filename)
    map.tileset.spriteBatches = {}
    map.tileset.spriteBatches[0] = imageToSpriteBatch(map.tileset.image)
    map.tileset.spriteBatches[1] = imageToSpriteBatch(map.tileset.image)
    map.tileset.spriteBatches[2] = imageToSpriteBatch(map.tileset.image)

    map.room = {}

    for roomIndex = 0, map.rooms - 1 do

      local room = create_room_type()

      room.x = readInt(mapBlob)
      log.debug("room.x: "..room.x)
      room.y = readInt(mapBlob)
      log.debug("room.y: "..room.y)
      room.parallax = readInt(mapBlob)
      log.debug("room.parallax: "..room.parallax)
      if room.parallax ~= 0 then
        room.para_filename = readString(mapBlob)
        log.debug("room.para_filename: "..room.para_filename)
        room.para_img = getImageHeader(room.para_filename)
      end
      room.dark = readInt(mapBlob)
      log.debug("room.dark: "..room.dark)
      room.teleports = readInt(mapBlob)
      log.debug("room.teleports: "..room.teleports)
      room.song = readInt(mapBlob)
      log.debug("room.song: "..room.song)
      room.song_changes = readInt(mapBlob)
      log.debug("room.song_changes: "..room.song_changes)
      room.changes_to = readInt(mapBlob)
      log.debug("room.changes_to: "..room.changes_to)
      room.reserved = readC(readInt, mapBlob, 18)
      log.debug("#room.reserved: "..#room.reserved)

      room.teleport = {}

      for teleportIndex = 0, room.teleports - 1 do

        local teleport = {}

        teleport.x = readInt(mapBlob)
        log.debug("teleport.x: "..teleport.x)
        teleport.y = readInt(mapBlob)
        log.debug("teleport.y: "..teleport.y)
        teleport.w = readInt(mapBlob)
        log.debug("teleport.w: "..teleport.w)
        teleport.h = readInt(mapBlob)
        log.debug("teleport.h: "..teleport.h)
        teleport.to_room = readInt(mapBlob)
        log.debug("teleport.to_room: "..teleport.to_room)

        log.debug("offset is: "..offset(mapBlob))

        teleport.to_map = readString(mapBlob)
        log.debug("teleport.to_map: "..teleport.to_map)

        log.debug("offset is: "..offset(mapBlob))

        teleport.dx = readInt(mapBlob)
        log.debug("teleport.dx: "..teleport.dx)
        teleport.dy = readInt(mapBlob)
        log.debug("teleport.dy: "..teleport.dy)
        teleport.dd = readInt(mapBlob)
        log.debug("teleport.dd: "..teleport.dd)
        teleport.to_song = readInt(mapBlob)
        log.debug("teleport.to_song: "..teleport.to_song)
        teleport.reserved = readC(readInt, mapBlob, 20)
        log.debug("#teleport.reserved: "..#teleport.reserved)

        room.teleport[teleportIndex] = teleport
      end

      room.seq_here = readInt(mapBlob)
      log.debug("room.seq_here: "..room.seq_here)

      room.seq = {}
      room.seqi = 0

      load_seqV(mapBlob, room.seq_here, room.seq, "room", roomIndex)

      room.enemies = readInt(mapBlob)

      room.enemy = {}

      for enemyIndex = 0, room.enemies - 1 do
        local enemy = create_Object()
        enemy.x_origin = readInt(mapBlob)
        log.debug("enemy.x_origin: "..enemy.x_origin)
        enemy.y_origin = readInt(mapBlob)
        log.debug("enemy.y_origin: "..enemy.y_origin)
        enemy.id = readString(mapBlob)
        log.debug("enemy.id: "..enemy.id)
        enemy.direction = readInt(mapBlob)
        log.debug("enemy.direction: "..enemy.direction)
        enemy.seq_here = readInt(mapBlob)
        log.debug("enemy.seq_here: "..enemy.seq_here)
        enemy.spawn_h = readShort(mapBlob)
        log.debug("enemy.spawn_h: "..enemy.spawn_h)
        enemy.is_h_set = readShort(mapBlob)
        log.debug("enemy.is_h_set: "..enemy.is_h_set)
        enemy.chap = readInt(mapBlob)
        log.debug("enemy.chap: "..enemy.chap)
        enemy.spawn_d = readInt(mapBlob)
        log.debug("enemy.spawn_d: "..enemy.spawn_d)
        enemy.is_d_set = readInt(mapBlob)
        log.debug("enemy.is_d_set: "..enemy.is_d_set)
        enemy.reserved_5 = readInt(mapBlob)
        log.debug("enemy.reserved_5: "..enemy.reserved_5)
        enemy.seq = {}
        enemy.seqi = 0
        load_seqV(mapBlob, enemy.seq_here, enemy.seq, "enemy", enemyIndex)

        enemy.spawn_cond = readInt(mapBlob)
        log.debug("enemy.spawn_cond: "..enemy.spawn_cond)

        if enemy.spawn_cond ~= 0 then

          enemy.spawn_info = {}
          enemy.spawn_info.wait_n = readInt(mapBlob)
          log.debug("enemy.spawn_info.wait_n: "..enemy.spawn_info.wait_n)
          enemy.spawn_info.wait_spawn = {}

          for loopSpawns = 0, enemy.spawn_info.wait_n - 1 do
            local spawn = {}
            spawn.code_index = readShort(mapBlob)
            log.debug("spawn.code_index: "..spawn.code_index)
            spawn.code_state = readInt(mapBlob)
            log.debug("spawn.code_state: "..spawn.code_state)
            enemy.spawn_info.wait_spawn[loopSpawns] = spawn
          end

          enemy.spawn_info.kill_n = readInt(mapBlob)
          log.debug("enemy.spawn_info.kill_n: "..enemy.spawn_info.kill_n)
          enemy.spawn_info.kill_spawn = {}

          for loopSpawns = 0, enemy.spawn_info.kill_n - 1 do
            local spawn = {}
            spawn.code_index = readShort(mapBlob)
            log.debug("spawn.code_index: "..spawn.code_index)
            spawn.code_state = readInt(mapBlob)
            log.debug("spawn.code_state: "..spawn.code_state)
            enemy.spawn_info.kill_spawn[loopSpawns] = spawn
          end

          enemy.spawn_info.active_n = readInt(mapBlob)
          log.debug("enemy.spawn_info.active_n: "..enemy.spawn_info.active_n)
          enemy.spawn_info.active_spawn = {}

          for loopSpawns = 0, enemy.spawn_info.active_n - 1 do
            local spawn = {}
            spawn.code_index = readShort(mapBlob)
            log.debug("spawn.code_index: "..spawn.code_index)
            spawn.code_state = readInt(mapBlob)
            log.debug("spawn.code_state: "..spawn.code_state)
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
      log.debug("room_elem: "..room.room_elem)

      log.debug("Offset prior to reading layer data: "..offset(mapBlob))

      for getNCpy = 0, 2 do

        local layer = readC(readShort, mapBlob, room.room_elem + 1)
        log.debug("Read layer data.")
        room.layout[getNCpy] = layer
        --function readC(readF, blob, count)

      end
      map.room[roomIndex] = room
    end

    map.entry = create_map_entry_type()

    for loopEntries = 0, map.entries - 1 do

      local entry = {}

      entry.x = readInt(mapBlob)
      log.debug("entry.x: "..entry.x)
      entry.y = readInt(mapBlob)
      log.debug("entry.y: "..entry.y)
      entry.room = readInt(mapBlob)
      log.debug("entry.room: "..entry.room)
      entry.direction = readByte(mapBlob)
      log.debug("entry.direction: "..entry.direction)
      entry.seq_here = readInt(mapBlob)
      log.debug("entry.seq_here: "..entry.seq_here)
      entry.reserved = readStringL(mapBlob, 84)
      log.debug("entry.reserved: "..entry.reserved)
      entry.seq = {}
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
      log.debug("Running seq_id on map entry: "..loop_entries)
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

  return map

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
