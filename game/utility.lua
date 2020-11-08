--Const As Double pi = Atn(1) * 4
pi = math.atan(1) * 4
--Const As Double rad = ( pi / 180 )
rad = (pi / 180)

-- Type tile_quad
function create_tile_quad()
  local tile_quad = {}
--
--   x As Integer
  tile_quad.x = 0
--   y As Integer
  tile_quad.y = 0
--   quad As Integer
  tile_quad.quad = 0
--
  return tile_quad
-- End Type
end
