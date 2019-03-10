require("blob")

--Loads a palette file and returns a table with all of the rgb triplets
--of the file as tables. Each r,g,b component is transformed into the
--proper float 0 to 1 range that Love2D expects. If there is a problem
--loading the file, nil is returned. The palette file stores rgb triplets
--as b,g,r (backwards), and this is taken care of by this function.
function loadPalette(fileName)

    paletteBlob = loadBlob(fileName)

    if paletteBlob then
        palette = {}
        for x = 1,256 do
            local b,g,r = readByte(paletteBlob),
                          readByte(paletteBlob),
                          readByte(paletteBlob)
            table.insert(palette,{r/255,g/255,b/255})
        end
        return palette
    else
        return nil
    end

end

--Loads a .spr spritesheet file. These are stored in FreeBASIC/QBasic
--GET/PUT format. It starts with a 16 byte header stating the width and height
--of the sprites, arraySize (unused?), and number of frames. Following this
--is each frame, each of which have a 4 byte header consisting of two unsigned
--short integers, the first being 8 times the width and the second being the height.
--Following this is one byte per pixel of the frame, being an index into a 256
--color palette.
--It returns a table with all the frames of the spritesheet. Each frame
--is just an array of pixels where each pixel has x, y, r, g, b, a components in
--a simple Lua table. This data can be processed by a platform specific function
--later for transforming into a usable sprite object for display on the screen,
--but this function should never have to be modified for any future ports.
function loadSpriteSheet(fileName)

    --Load binary data of the .spr file all at once.
    local blob = loadBlob(fileName)
    if blob then

        --Create a table that can contain everything in the file.
        local spriteSheet = {}
        spriteSheet.width = readInt(blob)
        spriteSheet.height = readInt(blob)
        spriteSheet.arraySize = readInt(blob)
        spriteSheet.frameCount = readInt(blob)
        spriteSheet.frames = {}

        for frameIndex = 1, spriteSheet.frameCount do

            --Create this frame.
            local frame = {}
            frame.frameWidth = readShort(blob) / 8
            frame.frameHeight = readShort(blob)
            frame.pixels = {}

            --Copy the image data pixel by pixel, converting to our monochrome red format.
            for y=0,frame.frameHeight-1 do
                for x=0,frame.frameWidth-1 do
                    local bt = readByte(blob)
                    table.insert(frame.pixels, {x,y, bt/255, 0, 0, 1})
                end
            end
            table.insert(spriteSheet.frames, frame)
        end

        return spriteSheet
    end

end

--Loads a sequence from an already loaded map binary blob.
function loadSeq(mapBlob, numSeqs, seqs, seqType, seqIndex)

    -- For 1 to seqs do
    for grabSeq = 1, numSeqs do

        local sequence = {}
        sequence.seqType = seqType
        sequence.seqIndex = seqIndex

        -- Load .ents Integer
        sequence.numEnts = readInt(mapBlob)
        print("sequence.numEnts: "..sequence.numEnts)
        sequence.entCode = {}

        -- For loop_ents is 1 to ents do
        for loopEnts = 1, sequence.numEnts do

            -- Load ent_code[loop_ents] Integer
            local entCode = readInt(mapBlob)
            print("entCode: "..entCode)
            table.insert(sequence.entCode, entCode)

        end

        -- Load .commands Integer

        sequence.numCommands = readInt(mapBlob)
        print("sequence.numCommands: "..sequence.numCommands)

        sequence.command = {}

        -- For loop_commands is 1 to commands do
        for loopCommands = 1, sequence.numCommands do

            local command = {}
            -- load .ents Integer
            command.numEnts = readInt(mapBlob)
            print("command.numEnts: "..command.numEnts)
            command.ent = {}

            -- For loop_command_ents is 1 to ents do
            for loopCommandEnts = 1, command.numEnts do

                local commandData = {}

                -- Load .active_ent (command_data type)  Integer
                commandData.activeEnt = readInt(mapBlob)
                print("commandData.activeEnt: "..commandData.activeEnt)
                -- Load .ent_state Integer
                commandData.entState = readInt(mapBlob)
                print("commandData.entState: "..commandData.entState)
                -- Load .text String
                commandData.text = readString(mapBlob)
                print("commandData.text: "..commandData.text)
                -- Load .walk_speed Double (TODO: this may be tricky to load and interpret in Lua)
                commandData.walkSpeed = readDouble(mapBlob)
                print("commandData.walkSpeed: "..commandData.walkSpeed)
                -- Load .dest_y Short
                commandData.destY = readShort(mapBlob)
                print("commandData.destY: "..commandData.destY)
                -- Load .dest_x Short
                commandData.destX = readShort(mapBlob)
                print("commandData.destX: "..commandData.destX)
                -- Load .abs_x Short
                commandData.absX = readShort(mapBlob)
                print("commandData.absX: "..commandData.absX)
                -- Load .abs_y Short
                commandData.absY = readShort(mapBlob)
                print("commandData.absY: "..commandData.absY)
                -- Load .mod_y Short
                commandData.modY = readShort(mapBlob)
                print("commandData.modY: "..commandData.modY)
                -- Load .mod_x Short
                commandData.modX = readShort(mapBlob)
                print("commandData.modX: "..commandData.modX)
                -- Load .to_map Integer
                commandData.toMap = readInt(mapBlob)
                print("commandData.toMap: "..commandData.toMap)
                -- Load .to_entry Integer
                commandData.toEntry = readInt(mapBlob)
                print("commandData.toEntry: "..commandData.toEntry)
                -- Load .jump_count Integer
                commandData.jumpCount = readInt(mapBlob)
                print("commandData.jumpCount: "..commandData.jumpCount)
                -- Load .water_align Integer
                commandData.waterAlign = readInt(mapBlob)
                print("commandData.waterAlign: "..commandData.waterAlign)
                -- Load .chap Integer
                commandData.chap = readInt(mapBlob)
                print("commandData.chap: "..commandData.chap)
                -- Load .carries_all Integer
                commandData.carriesAll = readInt(mapBlob)
                print("commandData.carriesAll: "..commandData.carriesAll)
                -- Load .nocam Integer
                commandData.nocam = readInt(mapBlob)
                print("commandData.nocam: "..commandData.nocam)
                -- Load .modify_direction Integer
                commandData.modifyDirection = readInt(mapBlob)
                print("commandData.modifyDirection: "..commandData.modifyDirection)
                -- Load .seq_pause Integer
                commandData.seqPause = readInt(mapBlob)
                print("commandData.seqPause: "..commandData.seqPause)
                -- Load .reserved_3 Integer
                commandData.reserved3 = readInt(mapBlob)
                print("commandData.reserved3: "..commandData.reserved3)
                -- Load .reserved_4 Integer
                commandData.reserved4 = readInt(mapBlob)
                print("commandData.reserved4: "..commandData.reserved4)
                -- Load .free_to_move Integer
                commandData.freeToMove = readInt(mapBlob)
                print("commandData.freeToMove: "..commandData.freeToMove)
                -- Load .display_hud Integer
                commandData.displayHud = readInt(mapBlob)
                print("commandData.displayHud: "..commandData.displayHud)
                -- 'Load .reserved_7 Integer COMMENTED OUT?
                -- 'Load .reserved_8 Integer COMMENTED OUT?
                -- Load .reserved_9 Integer
                commandData.reserved9 = readInt(mapBlob)
                print("commandData.reserved9: "..commandData.reserved9)
                -- Load .reserved_10 Integer
                commandData.reserved10 = readInt(mapBlob)
                print("commandData.reserved10: "..commandData.reserved10)

                table.insert(command.ent, commandData)
            end
        end

        table.insert(seqs, sequence)

    end
end

--Loads a Lynn's Legacy .map file. Assumes it is an uncompressed .map file.
--The original set of files were zlib compressed. I ran them through the
--offzip utility to decompress them.
--At the time of this writing, this function will be incomplete as we are only
--concerned with loading all the data in the map file; we will then slowly
--piece together how to use all that data later (such as loading and placing
--enemies, determining what sequences are, etc.)
function loadMap(fileName)

    local map = {}

    local mapBlob = loadBlob(fileName)

    if mapBlob then

        map.fileName = readString(mapBlob)
        print("map.fileName: "..map.fileName)
        map.numEntries = readInt(mapBlob)
        print("map.numEntries: "..map.numEntries)
        map.numRooms = readInt(mapBlob)
        print("map.numRooms: "..map.numRooms)
        map.tileSetFileName = readString(mapBlob)
        print("map.tileSetFileName: "..map.tileSetFileName)

        map.rooms = {}

        for roomIndex = 1, map.numRooms do

            local room = {}

            room.x = readInt(mapBlob)
            print("room.x: "..room.x)
            room.y = readInt(mapBlob)
            print("room.y: "..room.y)
            room.parallax = readInt(mapBlob)
            print("room.parallax: "..room.parallax)
            --TODO if parallax is nonzero, load parallax image.
            room.dark = readInt(mapBlob)
            print("room.dark: "..room.dark)
            room.numTeleports = readInt(mapBlob)
            print("room.numTeleports: "..room.numTeleports)
            room.song = readInt(mapBlob)
            print("room.song: "..room.song)
            room.songChanges = readInt(mapBlob)
            print("room.songChanges: "..room.songChanges)
            room.changeTo = readInt(mapBlob)
            print("room.changeTo: "..room.changeTo)
            room.reserved = readC(readInt, mapBlob, 18)
            print("#room.reserved: "..#room.reserved)

            room.teleports = {}

            for teleportIndex = 1, room.numTeleports do

                local teleport = {}

                teleport.x = readInt(mapBlob)
                print("teleport.x: "..teleport.x)
                teleport.y = readInt(mapBlob)
                print("teleport.y: "..teleport.y)
                teleport.w = readInt(mapBlob)
                print("teleport.w: "..teleport.w)
                teleport.h = readInt(mapBlob)
                print("teleport.h: "..teleport.h)
                teleport.toRoom = readInt(mapBlob)
                print("teleport.toRoom: "..teleport.toRoom)

                print("offset is: "..offset(mapBlob))

                teleport.toMap = readString(mapBlob)
                print("teleport.toMap: "..teleport.toMap)

                print("offset is: "..offset(mapBlob))

                teleport.dx = readInt(mapBlob)
                print("teleport.dx: "..teleport.dx)
                teleport.dy = readInt(mapBlob)
                print("teleport.dy: "..teleport.dy)
                teleport.dd = readInt(mapBlob)
                print("teleport.dd: "..teleport.dd)
                teleport.toSong = readInt(mapBlob)
                print("teleport.toSong: "..teleport.toSong)
                teleport.reserved = readC(readInt, mapBlob, 20)
                print("#teleport.reserved: "..#teleport.reserved)

                table.insert(room.teleports, teleport)
            end

            room.seqHere = readInt(mapBlob)
            print("room.seqHere: "..room.seqHere)

            room.seq = {}

            loadSeq(mapBlob, room.seqHere, "room", roomIndex)

            room.numEnemies = readInt(mapBlob)

            room.enemies = {}

            for enemyIndex = 1, room.numEnemies do

                local enemy = {}
                enemy.xOrigin = readInt(mapBlob)
                print("enemy.xOrigin: "..enemy.xOrigin)
                enemy.yOrigin = readInt(mapBlob)
                print("enemy.yOrigin: "..enemy.yOrigin)
                enemy.id = readString(mapBlob)
                print("enemy.id: "..enemy.id)
                enemy.direction = readInt(mapBlob)
                print("enemy.direction: "..enemy.direction)
                enemy.seqHere = readInt(mapBlob)
                print("enemy.seqHere: "..enemy.seqHere)
                enemy.spawnH = readShort(mapBlob)
                print("enemy.spawnH: "..enemy.spawnH)
                enemy.isHSet = readShort(mapBlob)
                print("enemy.isHSet: "..enemy.isHSet)
                enemy.chap = readInt(mapBlob)
                print("enemy.chap: "..enemy.chap)
                enemy.spawnD = readInt(mapBlob)
                print("enemy.spawnD: "..enemy.spawnD)
                enemy.isDSet = readInt(mapBlob)
                print("enemy.isDSet: "..enemy.isDSet)
                enemy.reserved_5 = readInt(mapBlob)
                print("enemy.reserved_5: "..enemy.reserved_5)
                enemy.seq = {}
                loadSeq(mapBlob, enemy.seqHere, enemy.seq, "enemy", enemyIndex)

                enemy.spawnCond = readInt(mapBlob)
                print("enemy.spawnCond: "..enemy.spawnCond)

                if enemy.spawnCond ~= 0 then

                    enemy.spawnInfo = {}
                    enemy.spawnInfo.waitN = readInt(mapBlob)
                    print("enemy.spawnInfo.waitN: "..enemy.spawnInfo.waitN)
                    enemy.spawnInfo.waitSpawn = {}

                    for loopSpawns = 1, enemy.spawnInfo.waitN do
                        local waitSpawn = {}
                        waitSpawn.codeIndex = readShort(mapBlob)
                        print("waitSpawn.codeIndex: "..waitSpawn.codeIndex)
                        waitSpawn.codeState = readInt(mapBlob)
                        print("waitSpawn.codeState: "..waitSpawn.codeState)
                        table.insert(enemy.spawnInfo.waitSpawn, waitSpawn)
                    end

                    enemy.spawnInfo.killN = readInt(mapBlob)
                    print("enemy.spawnInfo.killN: "..enemy.spawnInfo.killN)
                    enemy.spawnInfo.killSpawn = {}

                    for loopSpawns = 1, enemy.spawnInfo.killN do
                        local waitSpawn = {}
                        waitSpawn.codeIndex = readShort(mapBlob)
                        print("waitSpawn.codeIndex: "..waitSpawn.codeIndex)
                        waitSpawn.codeState = readInt(mapBlob)
                        print("waitSpawn.codeState: "..waitSpawn.codeState)
                        table.insert(enemy.spawnInfo.killSpawn, waitSpawn)
                    end

                    enemy.spawnInfo.activeN = readInt(mapBlob)
                    print("enemy.spawnInfo.activeN: "..enemy.spawnInfo.activeN)
                    enemy.spawnInfo.activeSpawn = {}

                    for loopSpawns = 1, enemy.spawnInfo.activeN do
                        local waitSpawn = {}
                        waitSpawn.codeIndex = readShort(mapBlob)
                        print("waitSpawn.codeIndex: "..waitSpawn.codeIndex)
                        waitSpawn.codeState = readInt(mapBlob)
                        print("waitSpawn.codeState: "..waitSpawn.codeState)
                        table.insert(enemy.spawnInfo.activeSpawn, waitSpawn)
                    end

                end

                enemy.coords = {}
                enemy.coords.x = enemy.xOrigin
                enemy.coords.y = enemy.yOrigin

                enemy.oriDir = enemy.direction

            end

            room.layout = {}

            --This calculation for the number of room elements represents the
            --upper bound (ubound) of a buffer from the original source code.
            --When declaring an array in FreeBASIC, you declare it with the
            --upper bound, which means the actual number of elements is the
            --upper bound plus one. To read the data correctly, we add one
            --to this number of elements (see the readC call below).

            room.roomElem = room.x * (room.y + 1) + 1
            print("roomElem: "..room.roomElem)

            print("Offset prior to reading layer data: "..offset(mapBlob))

            for getNCpy = 1, 3 do

                local layer = readC(readShort, mapBlob, room.roomElem + 1)
                print("Read layer data.")
                table.insert(room.layout, layer)
                --function readC(readF, blob, count)

            end

        end

        map.entry = {}

        for loopEntries = 1, map.numEntries do

            local entry = {}

            entry.x = readInt(mapBlob)
            entry.y = readInt(mapBlob)
            entry.room = readInt(mapBlob)
            entry.direction = readByte(mapBlob)
            entry.seqHere = readInt(mapBlob)
            entry.reserved = readStringL(mapBlob, 80)
            entry.seq = {}
            loadSeq(mapBlob, entry.seqHere, entry.seq, "entry", loopEntries)
        end

        --TODO: There is some post processing here running a function
        --called seq_id. For the purposes of loading a map file and getting
        --interesting data out of it, we don't need to transcribe that right now.

    end

    return map

end
