require("game/object_time")
require("game/object--gfx_animation")

-- Loads enemy xml and sprite image files. Assumes enemy.id has at least
-- been initialized with the relative path of an object xml file.
function LLSystem_ObjectFromXML(enemy)

  -- Load enemy properties defined in enemy's object xml.
  log.debug("Loading enemy xml.")
  local enemyXml = getObjectXml(enemy.id)
  log.debug("Loading enemy sprite sheets.")
  local spriteXml = ensureTable(enemyXml.sprite)

  for spriteKey, spriteValue in pairs(spriteXml) do
    if spriteValue.filename then
      log.debug(" spriteValue.filename: "..spriteValue.filename)
      local fixedFileName = string.gsub(spriteValue.filename, "\\", "/")
      log.debug(" fixedFileName: "..fixedFileName)
      local anim = getImageHeader(fixedFileName)
      local animControl = create_LLObject_ImageHeader()
      if spriteValue.rate then
        log.debug(" spriteValue.rate: "..spriteValue.rate)
        animControl.rate = tonumber(spriteValue.rate)
      end
      if spriteValue.dir_frames then
        log.debug(" spriteValue.dir_frames: "..spriteValue.dir_frames)
        animControl.dir_frames = tonumber(spriteValue.dir_frames)
      end
      table.insert(enemy.anim, anim)
      table.insert(enemy.animControl, animControl)
    end
  end
  if enemyXml.fp then
    enemy.fpIndex = 1
    enemy.funcIndex = 1
    enemy.fp = {}
    local fp = {}
    fp.func = {}
    local fpXml = ensureTable(enemyXml.fp)
    for fpKey, fpValue in pairs(fpXml) do
      if fpValue.proc_id then
        local procIdXml = ensureTable(fpValue.proc_id)
        log.debug("  fpValue.proc_id: "..procIdXml[1])
        fp.procId = procIdXml[1]
      end
      if fpValue.func then
        local funcXml = ensureTable(fpValue.func)
        for funcKey, funcValue in pairs(funcXml) do
          log.debug("  funcValue: "..funcValue)
          if funcValue == "second_pause" then
            log.debug( "  Installing second_pause function.")
            table.insert(fp.func, second_pause)
          end
        end
      end
      table.insert(enemy.fp, fp)
    end
  end
end
