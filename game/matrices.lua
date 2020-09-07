function create_vector()
  local vector = {}
  vector.x = 0
  vector.y = 0
  vector.clone = function(vector) return {x=vector.x, y=vector.y} end
  return vector
end

function create_vector_pair()
  local vector_pair = {}
  vector_pair.u = create_vector()
  vector_pair.v = create_vector()
  return vector_pair
end

-- Function check_bounds ( m As vector_pair, n As vector_pair ) As Integer
function check_bounds(m, n)
--
--
--   Dim As vector touching
  local touching = create_vector()
--
--
--   If m.u.x + m.v.x > n.u.x Then
  if m.u.x + m.v.x > n.u.x then
--     If m.u.x < ( n.u.x + n.v.x ) Then
    if m.u.x < (n.u.x + n.v.x) then
--       touching.x = Not 0
      touching.x = -1
--
--     End If
    end
--
--   End If
  end
--
--   If m.u.y + m.v.y > n.u.y Then
  if m.u.y + m.v.y > n.u.y then
--     If m.u.y < n.u.y + n.v.y Then
    if m.u.y < n.u.y + n.v.y then
--       touching.y = Not 0
      touching.y = -1
--
--     End If
    end
--
--   End If
  end
--
--
--   If touching.x And touching.y Then
  if (touching.x ~= 0) and (touching.y ~= 0) then
--     Return 0
    return 0
--
--   Else
  else
--     Return -1
    return -1
--
--   End If
  end
--
--
-- End Function
end
