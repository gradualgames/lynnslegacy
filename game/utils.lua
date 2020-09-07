function testbit(n, b)
  return bit.band(n, bit.lshift(1, b))
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
