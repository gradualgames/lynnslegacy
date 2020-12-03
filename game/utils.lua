--NOTE: IIf is a ternary operator that FreeBASIC
--provides. Lua's ternary idiom is a and b or c. Most of
--the port we just used this idiom directly. But in cases
--where IIf is heavily nested, I felt it would be easier
--to port the code if we could follow the structure more
--or less exactly, so this exists for that need.
function iif(a, b, c)
  return a and b or c
end

function testbit(n, b)
  return bit.band(n and n or -1, bit.lshift(1, b))
end

function imp(a, b)
  return bit.bor(bit.bnot(a), b)
end

function bitstring(n)
  local bstring = ""
  for i=15,0,-1 do
    if testbit(n, i) ~= 0 then
      bstring = bstring.."1"
    else
      bstring = bstring.."0"
    end
  end
  return bstring
end

function replace_char(pos, str, r)
    return str:sub(1, pos-1) .. r .. str:sub(pos+1)
end

function printentdata()
  if ll_global.seq ~= nil and ll_global.seqi ~= nil and ll_global.seq[ll_global.seqi] ~= nil then
    log.debug("Full readout of all ents in the seq.")
    if ll_global.seq[ll_global.seqi].ent ~= nil then
      for k,v in pairs(ll_global.seq[ll_global.seqi].ent) do
        for ek,ev in pairs(v) do
          if type(ev) ~= "table" then
            log.debug("seq ent key: "..ek.." seq value: "..ev)
          end
        end
      end
    end
    log.debug("Full readout of all commands and entities.")
    for ck,cv in pairs(ll_global.seq[ll_global.seqi].Command) do
      for k,v in pairs(cv.ent) do
        for ek,ev in pairs(v) do
          if type(ev) ~= "table" then
            log.debug("command ent key: "..ek.." command value: "..ev)
          end
        end
      end
    end
  end
end
