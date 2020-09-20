require("game/cache")
require("game/object_time")
require("game/object--gfx")
require("game/object--gfx_animation")
require("game/object_move")
SLAXML = require 'lib/SLAXML/slaxml'

-- Loads enemy xml and sprite image files. Assumes enemy.id has at least
-- been initialized with the relative path of an object xml file.
function LLSystem_ObjectFromXML(enemy)
  --   #Define func_drop objectLoad.funcs.func[objectLoad.funcs.active_state][objectLoad.funcs.current_func[objectLoad.funcs.active_state]]
  local function func_drop(func)
    local funcList = enemy.funcs.func[enemy.funcs.active_state]
    funcList[enemy.funcs.current_func[enemy.funcs.active_state]] = func
  end
--   #Define inc_func  objectLoad.funcs.current_func[objectLoad.funcs.active_state] += 1:
--                       If objectLoad.funcs.current_func[objectLoad.funcs.active_state] = objectLoad.funcs.func_count[objectLoad.funcs.active_state] Then
--                         objectLoad.funcs.current_func[objectLoad.funcs.active_state] = 0
  local function inc_func()
    log.debug("inc_func called.")
    enemy.funcs.current_func[enemy.funcs.active_state] = enemy.funcs.current_func[enemy.funcs.active_state] + 1
    -- log.debug("enemy.funcs.current_func[enemy.funcs.active_state]: "..enemy.funcs.current_func[enemy.funcs.active_state])
    -- log.debug("enemy.funcs.func_count[enemy.funcs.active_state]: "..enemy.funcs.func_count[enemy.funcs.active_state])
    -- if enemy.funcs.current_func[enemy.funcs.active_state] == enemy.funcs.func_count[enemy.funcs.active_state] then
    --   log.debug("Resetting current_func to 1 for active state: "..enemy.funcs.active_state)
    --   enemy.funcs.current_func[enemy.funcs.active_state] = 1
    -- end
  end

  local path = {}

  local text = function(text, cdata)
    -- log.debug("Processing text: "..text)
    -- log.debug("At path:")
    -- for key, value in pairs(path) do
    --   log.debug(value)
    -- end
    if path[2] == "sprite" then
      if path[3] == "filename" then
        log.debug(" Processing sprite/filename: "..text)
        local fixedFileName = string.gsub(text, "\\", "/")
        enemy.anim[enemy.current_anim] = getImageHeader(fixedFileName)
        enemy.animControl[enemy.current_anim] = create_LLObject_ImageHeader()
      elseif path[3] == "dir_frames" then
        log.debug( " Processing sprite/dir_frames: "..text)
        enemy.animControl[enemy.current_anim].dir_frames = tonumber(text)
      elseif path[3] == "rate" then
        log.debug( " Processing sprite/rate: "..text)
        enemy.animControl[enemy.current_anim].rate = tonumber(text)
      elseif path[3] == "x_off" then
        log.debug( " Processing sprite/x_off: "..text)
        enemy.animControl[enemy.current_anim].x_off = tonumber(text)
      elseif path[3] == "y_off" then
        log.debug( " Processing sprite/y_off: "..text)
        enemy.animControl[enemy.current_anim].y_off = tonumber(text)
      end
    elseif path[2] == "fp" then
      if path[3] == "proc_id" then
        log.debug(" proc_id text: "..text)
--
--           #Define LLObject_ProcIDLoad(__Proc_ID__) _
--             Case ###__Proc_ID__: objectLoad.##__Proc_ID__ = objectLoad.funcs.active_state
--
--           Select Case LCase( thr->dat.s )
--
--             LLObject_ProcIDLoad( hit_state    )
--             LLObject_ProcIDLoad( attack_state )
--             LLObject_ProcIDLoad( death_state  )
--             LLObject_ProcIDLoad( fire_state   )
--             LLObject_ProcIDLoad( hit_state    )
--             LLObject_ProcIDLoad( ice_state    )
--             LLObject_ProcIDLoad( jump_state   )
--             LLObject_ProcIDLoad( proj_state   )
--             LLObject_ProcIDLoad( reset_state  )
--             LLObject_ProcIDLoad( stun_state   )
--             LLObject_ProcIDLoad( thaw_state   )
--             LLObject_ProcIDLoad( thrust_state )
--
--           End Select
        --NOTE: I think this one line is equivalent to the above select case.
        --In lua, we table["property"] is equivalent to table.property. We can
        --use the proc_id text directly from the xml to set it to the value of the
        --current active state, which is what is being done above.
        enemy[text] = enemy.funcs.active_state
        log.debug(" active_state is: "..enemy[text])
      elseif path[3] == "func" then
        enemy.funcs.func_count[enemy.funcs.active_state] = enemy.funcs.func_count[enemy.funcs.active_state] + 1
        local funcName = "__"..text
        local func = _G[funcName]
        if func then
          log.debug("Installing func: "..funcName)
          func_drop(_G[funcName])
          inc_func()
        else
          log.debug("Installing no-op func for: "..funcName)
          func_drop(
            function()
              log.debug("TODO: Implement: "..funcName)
              return 0
            end)
          inc_func()
        end
      end
    elseif #path == 2 then
      local attribute = path[2]
      log.debug("Found attribute: "..attribute)
      local convertedValue = tonumber(text)
      if convertedValue == nil then
        log.debug("Attribute string value: "..text)
        enemy[attribute] = text
      else
        log.debug("Attribute number value: "..text)
        enemy[attribute] = convertedValue
      end
    end
  end

  local startElement = function(name, nsURI, nsPrefix)
    table.insert(path, name)
    if name == "sprite" then
      log.debug("Processing sprite tag.")
      enemy.current_anim = enemy.anims
      enemy.anims = enemy.anims + 1
    elseif name == "fp" then
      log.debug("Processing fp tag.")
      --NOTE: This chunk comes from a select statement higher up
      --in the FB code that performs allocation and counting. It
      --makes more sense here due to how we are processing the xml.
      --         .funcs.states += 1
      --
      --         .funcs.func_count   = Reallocate( .funcs.func_count,   .funcs.states * Len( Integer ) )
      --         .funcs.current_func = Reallocate( .funcs.current_func, .funcs.states * Len( Integer ) )
      --
      --         .funcs.func         = Reallocate( .funcs.func,         .funcs.states * Len( fp Ptr )  )
      --
      --         .funcs.active_state = .funcs.states - 1
      --
      --         .funcs.func_count[.funcs.active_state] = 0
      --         .funcs.current_func[.funcs.active_state] = 0
      enemy.funcs.active_state = enemy.funcs.states
      enemy.funcs.func[enemy.funcs.active_state] = {}
      enemy.funcs.func_count[enemy.funcs.active_state] = 0
      enemy.funcs.current_func[enemy.funcs.active_state] = 0
      enemy.funcs.states = enemy.funcs.states + 1
    end
  end

  local closeElement = function(name, nsURI)
    table.remove(path)
    if name == "fp" then
      log.debug("fp tag closed, resetting current_func for that state.")
      enemy.funcs.current_func[enemy.funcs.active_state] = 0
    end
  end

  local xmlData = getObjectXml(enemy.id)
  -- Specify as many/few of these as you like
  local parser = SLAXML:parser{
    startElement = startElement, -- When "<foo" or <x:foo is seen
    attribute    = function(name,value,nsURI,nsPrefix) end, -- attribute found on current element
    closeElement = closeElement, -- When "</foo>" or </x:foo> or "/>" is seen
    text         = text, -- text and CDATA nodes (cdata is true for cdata nodes)
    comment      = function(content)                   end, -- comments
    pi           = function(target,content)            end, -- processing instructions e.g. "<?yes mon?>"
  }
  parser:parse(xmlData, {stripWhitespace=true})

  --Some attributes have different names from xml when they become part of
  --an enemy.
  enemy.perimeter.x = enemy.real_x
  enemy.perimeter.y = enemy.real_y

  --TODO: Find out where Lynn's Legacy actually resets these
  --values. They are used while loading XML, but are clearly
  --reset before actual play begins.
  enemy.current_anim = 0
  enemy.funcs.active_state = 0
  enemy.funcs.current_func[enemy.funcs.active_state] = 0

end
