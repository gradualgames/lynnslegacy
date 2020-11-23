function rgb(r, g, b)
  return {[0] = r, g, b}
end

function palette_get_255(index)
  local r, g, b
  r = palette[index][0] * 255
  g = palette[index][1] * 255
  b = palette[index][2] * 255
  return r, g, b
end

function palette_set_63(index, rgbtriplet)
  palette[index][0] = rgbtriplet[0] / 63
  palette[index][1] = rgbtriplet[1] / 63
  palette[index][2] = rgbtriplet[2] / 63
end
