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
    return str:sub(1, pos-1)..r..str:sub(pos+1)
end

function space(num)
  local result = ""
  for i = 1, num do
    result = result.." "
  end
  return result
end

function sleep(ms)
  love.timer.sleep(ms/1000)
end
