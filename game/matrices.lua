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

-- Function V2_Subtract( hi As vector, lo As vector ) As vector
function V2_Subtract(hi, lo)
--
--   Function = Type( hi.x - lo.x, hi.y - lo.y )
  return {x = hi.x - lo.x, y = hi.y - lo.y}
--
-- End Function
end

-- Function V2_Midpoint( m As vector_pair ) As vector
function V2_MidPoint(m)
--
--   Function = V2_Add( m.u, V2_Scale( m.v, .5 ) )
  return V2_Add(m.u, V2_Scale(m.v, .5))
--
-- End Function
end

-- Function V2_DotProduct( v As vector, v2 As vector ) As Double
function V2_DotProduct(v, v2)
--
--   Function = v.x * v2.x + v.y * v2.y
  return v.x * v2.x + v.y * v2.y
--
-- End Function
end
--
-- Function V2_Scale( v As vector, k As Double ) As vector
function V2_Scale(v, k)
--
--   Function = Type( v.x * k, v.y * k )
  return {x = v.x * k, y = v.y *k}
--
-- End Function
end

-- '' Great code from CoderJeff at http://freebasic.net/forum
-- ''
-- ''
-- '' An Approximation
-- '' m = V3_DotProduct(distance, distance) / (Abs(distance.x) + Abs(distance.y) + Abs(distance.z))
--
-- '' Exact
-- '' m = sqr( V3_DotProduct(distance, distance) )
-- Function V2_CalcFlyback( m As vector, n As vector ) As vector
function V2_CalcFlyback(m, n)
--
-- Dim As vector distance = V2_Subtract( m, n )
  local distance = V2_Subtract(m, n)
-- Dim As vector res = V2_Scale( distance, 1 / Sqr( V2_DotProduct( distance, distance ) ) )
  local res = V2_Scale(distance, 1 / math.sqrt(V2_DotProduct(distance, distance)))
--
  --FIXME: The following tests for legal numbers are not yet ported.
  --I don't know what the differences are between Lua and FreeBASIC here when
  --handling divide by zero, NaN, and so forth. So I'm just going to wait for
  --crashes or odd behavior to decide how to handle these cases.
-- If is_LegalNumber( res.x ) = 0 Then
--   res.x = 0
--
-- End If
--
-- If is_LegalNumber( res.y ) = 0 Then
--   res.y = 0
--
-- End If
--
--
-- Return res
  return res
--
-- End Function
end
-- ''
