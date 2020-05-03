--Loads a sequence from an already loaded map binary blob.
function loadSeq(mapBlob, numSeqs, seqs, seqType, seqIndex)

  -- For 1 to seqs do
  for grabSeq = 1, numSeqs do

    local sequence = {}
    sequence.seqType = seqType
    sequence.seqIndex = seqIndex

    -- Load .ents Integer
    sequence.numEnts = readInt(mapBlob)
    log.debug("sequence.numEnts: "..sequence.numEnts)
    sequence.entCode = {}

    -- For loop_ents is 1 to ents do
    for loopEnts = 1, sequence.numEnts do

      -- Load ent_code[loop_ents] Integer
      local entCode = readInt(mapBlob)
      log.debug("entCode: "..entCode)
      table.insert(sequence.entCode, entCode)

    end

    -- Load .commands Integer

    sequence.numCommands = readInt(mapBlob)
    log.debug("sequence.numCommands: "..sequence.numCommands)

    sequence.command = {}

    -- For loop_commands is 1 to commands do
    for loopCommands = 1, sequence.numCommands do

      local command = {}
      -- load .ents Integer
      command.numEnts = readInt(mapBlob)
      log.debug("command.numEnts: "..command.numEnts)
      command.ent = {}

      -- For loop_command_ents is 1 to ents do
      for loopCommandEnts = 1, command.numEnts do

        local commandData = {}

        -- Load .active_ent (command_data type)  Integer
        commandData.activeEnt = readInt(mapBlob)
        log.debug("commandData.activeEnt: "..commandData.activeEnt)
        -- Load .ent_state Integer
        commandData.entState = readInt(mapBlob)
        log.debug("commandData.entState: "..commandData.entState)
        -- Load .text String
        commandData.text = readString(mapBlob)
        log.debug("commandData.text: "..commandData.text)
        -- Load .walk_speed Double (TODO: this may be tricky to load and interpret in Lua)
        commandData.walkSpeed = readDouble(mapBlob)
        log.debug("commandData.walkSpeed: "..commandData.walkSpeed)
        -- Load .dest_y Short
        commandData.destY = readShort(mapBlob)
        log.debug("commandData.destY: "..commandData.destY)
        -- Load .dest_x Short
        commandData.destX = readShort(mapBlob)
        log.debug("commandData.destX: "..commandData.destX)
        -- Load .abs_x Short
        commandData.absX = readShort(mapBlob)
        log.debug("commandData.absX: "..commandData.absX)
        -- Load .abs_y Short
        commandData.absY = readShort(mapBlob)
        log.debug("commandData.absY: "..commandData.absY)
        -- Load .mod_y Short
        commandData.modY = readShort(mapBlob)
        log.debug("commandData.modY: "..commandData.modY)
        -- Load .mod_x Short
        commandData.modX = readShort(mapBlob)
        log.debug("commandData.modX: "..commandData.modX)
        -- Load .to_map Integer
        commandData.toMap = readString(mapBlob)
        log.debug("commandData.toMap: "..commandData.toMap)
        -- Load .to_entry Integer
        commandData.toEntry = readInt(mapBlob)
        log.debug("commandData.toEntry: "..commandData.toEntry)
        -- Load .jump_count Integer
        commandData.jumpCount = readInt(mapBlob)
        log.debug("commandData.jumpCount: "..commandData.jumpCount)
        -- Load .water_align Integer
        commandData.waterAlign = readInt(mapBlob)
        log.debug("commandData.waterAlign: "..commandData.waterAlign)
        -- Load .chap Integer
        commandData.chap = readInt(mapBlob)
        log.debug("commandData.chap: "..commandData.chap)
        -- Load .carries_all Integer
        commandData.carriesAll = readInt(mapBlob)
        log.debug("commandData.carriesAll: "..commandData.carriesAll)
        -- Load .nocam Integer
        commandData.nocam = readInt(mapBlob)
        log.debug("commandData.nocam: "..commandData.nocam)
        -- Load .modify_direction Integer
        commandData.modifyDirection = readInt(mapBlob)
        log.debug("commandData.modifyDirection: "..commandData.modifyDirection)
        -- Load .seq_pause Integer
        commandData.seqPause = readInt(mapBlob)
        log.debug("commandData.seqPause: "..commandData.seqPause)
        -- Load .reserved_3 Integer
        commandData.reserved3 = readInt(mapBlob)
        log.debug("commandData.reserved3: "..commandData.reserved3)
        -- Load .reserved_4 Integer
        commandData.reserved4 = readInt(mapBlob)
        log.debug("commandData.reserved4: "..commandData.reserved4)
        -- Load .free_to_move Integer
        commandData.freeToMove = readInt(mapBlob)
        log.debug("commandData.freeToMove: "..commandData.freeToMove)
        -- Load .display_hud Integer
        commandData.displayHud = readInt(mapBlob)
        log.debug("commandData.displayHud: "..commandData.displayHud)
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

        table.insert(command.ent, commandData)
      end
    end

    table.insert(seqs, sequence)

  end
end

--Loads a Lynn's Legacy .map file. Assumes it is an uncompressed .map file.
--The original set of files were zlib compressed. I ran them through the
--offzip utility to decompress them.
function loadMap(fileName)

  local map = {}

  local mapBlob = loadBlob(fileName)

  if mapBlob then

    map.fileName = readString(mapBlob)
    log.debug("map.fileName: "..map.fileName)
    map.numEntries = readInt(mapBlob)
    log.debug("map.numEntries: "..map.numEntries)
    map.numRooms = readInt(mapBlob)
    log.debug("map.numRooms: "..map.numRooms)
    map.tileSetFileName = readString(mapBlob)
    log.debug("map.tileSetFileName: "..map.tileSetFileName)

    map.rooms = {}

    for roomIndex = 1, map.numRooms do

      local room = {}

      room.x = readInt(mapBlob)
      log.debug("room.x: "..room.x)
      room.y = readInt(mapBlob)
      log.debug("room.y: "..room.y)
      room.parallax = readInt(mapBlob)
      log.debug("room.parallax: "..room.parallax)
      if room.parallax ~= 0 then
        room.paraFileName = readString(mapBlob)
        log.debug("room.paraFileName: "..room.paraFileName)
      end
      room.dark = readInt(mapBlob)
      log.debug("room.dark: "..room.dark)
      room.numTeleports = readInt(mapBlob)
      log.debug("room.numTeleports: "..room.numTeleports)
      room.song = readInt(mapBlob)
      log.debug("room.song: "..room.song)
      room.songChanges = readInt(mapBlob)
      log.debug("room.songChanges: "..room.songChanges)
      room.changeTo = readInt(mapBlob)
      log.debug("room.changeTo: "..room.changeTo)
      room.reserved = readC(readInt, mapBlob, 18)
      log.debug("#room.reserved: "..#room.reserved)

      room.teleports = {}

      for teleportIndex = 1, room.numTeleports do

        local teleport = {}

        teleport.x = readInt(mapBlob)
        log.debug("teleport.x: "..teleport.x)
        teleport.y = readInt(mapBlob)
        log.debug("teleport.y: "..teleport.y)
        teleport.w = readInt(mapBlob)
        log.debug("teleport.w: "..teleport.w)
        teleport.h = readInt(mapBlob)
        log.debug("teleport.h: "..teleport.h)
        teleport.toRoom = readInt(mapBlob)
        log.debug("teleport.toRoom: "..teleport.toRoom)

        log.debug("offset is: "..offset(mapBlob))

        teleport.toMap = readString(mapBlob)
        log.debug("teleport.toMap: "..teleport.toMap)

        log.debug("offset is: "..offset(mapBlob))

        teleport.dx = readInt(mapBlob)
        log.debug("teleport.dx: "..teleport.dx)
        teleport.dy = readInt(mapBlob)
        log.debug("teleport.dy: "..teleport.dy)
        teleport.dd = readInt(mapBlob)
        log.debug("teleport.dd: "..teleport.dd)
        teleport.toSong = readInt(mapBlob)
        log.debug("teleport.toSong: "..teleport.toSong)
        teleport.reserved = readC(readInt, mapBlob, 20)
        log.debug("#teleport.reserved: "..#teleport.reserved)

        table.insert(room.teleports, teleport)
      end

      room.seqHere = readInt(mapBlob)
      log.debug("room.seqHere: "..room.seqHere)

      room.seq = {}

      loadSeq(mapBlob, room.seqHere, room.seq, "room", roomIndex)

      room.numEnemies = readInt(mapBlob)

      room.enemies = {}

      for enemyIndex = 1, room.numEnemies do

        local enemy = {}
        enemy.xOrigin = readInt(mapBlob)
        log.debug("enemy.xOrigin: "..enemy.xOrigin)
        enemy.yOrigin = readInt(mapBlob)
        log.debug("enemy.yOrigin: "..enemy.yOrigin)
        enemy.id = readString(mapBlob)
        log.debug("enemy.id: "..enemy.id)
        enemy.direction = readInt(mapBlob)
        log.debug("enemy.direction: "..enemy.direction)
        enemy.seqHere = readInt(mapBlob)
        log.debug("enemy.seqHere: "..enemy.seqHere)
        enemy.spawnH = readShort(mapBlob)
        log.debug("enemy.spawnH: "..enemy.spawnH)
        enemy.isHSet = readShort(mapBlob)
        log.debug("enemy.isHSet: "..enemy.isHSet)
        enemy.chap = readInt(mapBlob)
        log.debug("enemy.chap: "..enemy.chap)
        enemy.spawnD = readInt(mapBlob)
        log.debug("enemy.spawnD: "..enemy.spawnD)
        enemy.isDSet = readInt(mapBlob)
        log.debug("enemy.isDSet: "..enemy.isDSet)
        enemy.reserved_5 = readInt(mapBlob)
        log.debug("enemy.reserved_5: "..enemy.reserved_5)
        enemy.seq = {}
        loadSeq(mapBlob, enemy.seqHere, enemy.seq, "enemy", enemyIndex)

        enemy.spawnCond = readInt(mapBlob)
        log.debug("enemy.spawnCond: "..enemy.spawnCond)

        if enemy.spawnCond ~= 0 then

          enemy.spawnInfo = {}
          enemy.spawnInfo.waitN = readInt(mapBlob)
          log.debug("enemy.spawnInfo.waitN: "..enemy.spawnInfo.waitN)
          enemy.spawnInfo.waitSpawn = {}

          for loopSpawns = 1, enemy.spawnInfo.waitN do
            local spawn = {}
            spawn.codeIndex = readShort(mapBlob)
            log.debug("spawn.codeIndex: "..spawn.codeIndex)
            spawn.codeState = readInt(mapBlob)
            log.debug("spawn.codeState: "..spawn.codeState)
            table.insert(enemy.spawnInfo.waitSpawn, spawn)
          end

          enemy.spawnInfo.killN = readInt(mapBlob)
          log.debug("enemy.spawnInfo.killN: "..enemy.spawnInfo.killN)
          enemy.spawnInfo.killSpawn = {}

          for loopSpawns = 1, enemy.spawnInfo.killN do
            local spawn = {}
            spawn.codeIndex = readShort(mapBlob)
            log.debug("spawn.codeIndex: "..spawn.codeIndex)
            spawn.codeState = readInt(mapBlob)
            log.debug("spawn.codeState: "..spawn.codeState)
            table.insert(enemy.spawnInfo.killSpawn, spawn)
          end

          enemy.spawnInfo.activeN = readInt(mapBlob)
          log.debug("enemy.spawnInfo.activeN: "..enemy.spawnInfo.activeN)
          enemy.spawnInfo.activeSpawn = {}

          for loopSpawns = 1, enemy.spawnInfo.activeN do
            local spawn = {}
            spawn.codeIndex = readShort(mapBlob)
            log.debug("spawn.codeIndex: "..spawn.codeIndex)
            spawn.codeState = readInt(mapBlob)
            log.debug("spawn.codeState: "..spawn.codeState)
            table.insert(enemy.spawnInfo.activeSpawn, spawn)
          end

        end

        enemy.coords = {}
        enemy.coords.x = enemy.xOrigin
        enemy.coords.y = enemy.yOrigin

        enemy.oriDir = enemy.direction

        table.insert(room.enemies, enemy)

      end

      room.layout = {}

      --This calculation for the number of room elements represents the
      --upper bound (ubound) of a buffer from the original source code.
      --When declaring an array in FreeBASIC, you declare it with the
      --upper bound, which means the actual number of elements is the
      --upper bound plus one. To read the data correctly, we add one
      --to this number of elements (see the readC call below).

      room.roomElem = room.x * (room.y + 1) + 1
      log.debug("roomElem: "..room.roomElem)

      log.debug("Offset prior to reading layer data: "..offset(mapBlob))

      for getNCpy = 1, 3 do

        local layer = readC(readShort, mapBlob, room.roomElem + 1)
        log.debug("Read layer data.")
        table.insert(room.layout, layer)
        --function readC(readF, blob, count)

      end

      table.insert(map.rooms, room)

    end

    map.entry = {}

    for loopEntries = 1, map.numEntries do

      local entry = {}

      entry.x = readInt(mapBlob)
      log.debug("entry.x: "..entry.x)
      entry.y = readInt(mapBlob)
      log.debug("entry.y: "..entry.y)
      entry.room = readInt(mapBlob)
      log.debug("entry.room: "..entry.room)
      entry.direction = readByte(mapBlob)
      log.debug("entry.direction: "..entry.direction)
      entry.seqHere = readInt(mapBlob)
      log.debug("entry.seqHere: "..entry.seqHere)
      entry.reserved = readStringL(mapBlob, 84)
      log.debug("entry.reserved: "..entry.reserved)
      entry.seq = {}
      loadSeq(mapBlob, entry.seqHere, entry.seq, "entry", loopEntries)
    end

    --TODO: There is some post processing here running a function
    --called seq_id. For the purposes of loading a map file and getting
    --interesting data out of it, we don't need to transcribe that right now.

  end

  return map

end
