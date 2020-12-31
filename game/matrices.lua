require("game/utility")

function create_vector()
  local vector = {}
  vector.x = 0
  vector.y = 0
  return vector
end

function init_vector_pool()
  vector_pool = {}
  for i = 1, 65536 do
    vector_pool[i] = create_vector()
  end
  vector_pool_index = 1
end

function get_next_vector()
  local vector = vector_pool[vector_pool_index]
  vector.x = 0
  vector.y = 0
  vector_pool_index = vector_pool_index + 1
  return vector
end

function reset_vector_pool()
  vector_pool_index = 1
end

function create_vector_pair()
  local vector_pair = {}
  return vector_pair
end

function init_vector_pair_pool()
  vector_pair_pool = {}
  for i = 1, 65536 do
    vector_pair_pool[i] = create_vector_pair()
  end
  vector_pair_pool_index = 1
end

function get_next_vector_pair()
  local vector_pair = vector_pair_pool[vector_pair_pool_index]
  vector_pair.u = get_next_vector()
  vector_pair.v = get_next_vector()
  vector_pair_pool_index = vector_pair_pool_index + 1
  return vector_pair
end

function reset_vector_pair_pool()
  vector_pair_pool_index = 1
end

-- Function check_bounds ( m As vector_pair, n As vector_pair ) As Integer
function check_bounds(m, n)
--
--
--   Dim As vector touching
  local touching = get_next_vector()
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

-- Function V2_Add( hi As vector, lo As vector ) As vector
function V2_Add(hi, lo)
--
--   Function = Type( hi.x + lo.x, hi.y + lo.y )
  local result = get_next_vector()
  result.x = hi.x + lo.x
  result.y = hi.y + lo.y
  return result
--
-- End Function
end

-- Function V2_Subtract( hi As vector, lo As vector ) As vector
function V2_Subtract(hi, lo)
--
--   Function = Type( hi.x - lo.x, hi.y - lo.y )
  local result = get_next_vector()
  result.x = hi.x - lo.x
  result.y = hi.y - lo.y
  return result
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
--NOTE: In general I follow the exact casing of everything in the
--original FreeBASIC source. So I don't lose my mind, I'm just aliasing
--this function with casing differences...
V2_Midpoint = V2_MidPoint

-- Function V2_Absolute( v As vector ) As vector
function V2_Absolute(v)
--
--   Function = Type( Abs( v.x ), Abs( v.y ) )
  local result = get_next_vector()
  result.x = math.abs(v.x)
  result.y = math.abs(v.y)
  return result
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
  local result = get_next_vector()
  result.x = v.x * k
  result.y = v.y * k
  return result
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
-- Function Get_Angle( u As vector, v As vector ) As Double
function get_angle(u, v)
--
--
--   Dim As Double o, a
  local o, a = 0.0, 0.0
--
--     o = Abs( v.y - u.y )
  o = math.abs(v.y - u.y)
--     a = Abs( v.x - u.x )
  a = math.abs(v.x - u.x)
--
--     If v.y = u.y And ( v.x > u.x ) Then Return 90
  if v.y == u.y and (v.x > u.x) then return 90 end
--     If v.y = u.y And ( v.x < u.x ) Then Return 270
  if v.y == u.y and (v.x < u.x) then return 270 end
--
--     If v.x = u.x And ( v.y > u.y ) Then Return 180
  if v.x == u.x and (v.y > u.y) then return 180 end
--     If v.x = u.x And ( v.y < u.y ) Then Return 0
  if v.x == u.x and (v.y < u.y) then return 0 end
--
--     If ( v.y < u.y ) And ( v.x > u.x ) Then
  if (v.y < u.y) and (v.x > u.x) then
--       Return 180 - ( ( Atn( o / a ) / rad ) + 90 )
    return 180 - ((math.atan(o / a) / rad) + 90)
--
--     ElseIf ( v.y > u.y ) And ( v.x > u.x ) Then
  elseif (v.y > u.y) and (v.x > u.x) then
--       Return ( ( Atn( o / a ) / rad ) + 90 )
    return ((math.atan(o / a) / rad) + 90)
--
--     End If
  end
--
--     If ( v.y < u.y ) And ( v.x < u.x ) Then
  if (v.y < u.y) and (v.x < u.x) then
--       Return 180 + ( ( Atn( o / a ) / rad ) + 90 )
    return 180 + ((math.atan(o / a) / rad) + 90)
--
--     ElseIf ( v.y > u.y ) And ( v.x < u.x ) Then
  elseif (v.y > u.y) and (v.x < u.x) then
--       Return 360 - ( ( Atn( o / a ) / rad ) + 90 )
    return 360 - ((math.atan(o / a) / rad) + 90)
--
--     End If
  end
--
--
-- End Function
end
--
--
