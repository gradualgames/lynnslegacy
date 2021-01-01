require("game/engine_enums")
require("game/matrices")

-- Function LLObject_VectorPair( o As char_type Ptr ) As vector_pair
function LLObject_VectorPair(o)
--
--    Dim As vector_pair res
  local res = get_next_vector_pair()
--
--    res.u =  o->coords
  res.u.x = o.coords.x
  res.u.y = o.coords.y
--    res.v = o->perimeter
  res.v.x = o.perimeter.x
  res.v.y = o.perimeter.y
--
--    Return res
  return res
--
--
-- End Function
end

-- Function LLObject_VectorPairEx( o As char_type Ptr, op As Integer = 0, par As Integer = 0 ) As vector_pair
function LLObject_VectorPairEx(o, op, par)
  local op = op and op or 0
  local par = par and par or 0
--
--   Dim As vector_pair res
  local res = get_next_vector_pair()
--
--   Select Case op
--
--   Case OV_ONEBOX
  if op == OV_ONEBOX then
--
--     Return Type <vector_pair> ( o->coords, o->perimeter )
    local vector_pair = get_next_vector_pair()
    vector_pair.u.x = o.coords.x
    vector_pair.u.y = o.coords.y
    vector_pair.v.x = o.perimeter.x
    vector_pair.v.y = o.perimeter.y
    return vector_pair
--
--   Case OV_FACE
  elseif op == OV_FACE then
--
--     res.u = o->coords
    res.u.x = o.coords.x
    res.u.y = o.coords.y
--     With o->animControl[o->current_anim]
--       res.u.x -= .x_off
    res.u.x = res.u.x - o.animControl[o.current_anim].x_off
--       res.u.y -= .y_off
    res.u.y = res.u.y - o.animControl[o.current_anim].y_off
--
--     End With
--
--     With *( o->anim[o->current_anim] )
--
--       With .frame[o->frame_check]
--         With .face[par]
--
--           res.u.x += .x
    res.u.x = res.u.x + o.anim[o.current_anim].frame[o.frame_check].face[par].x
--           res.u.y += .y
    res.u.y = res.u.y + o.anim[o.current_anim].frame[o.frame_check].face[par].y
--           res.v.x = .w
    res.v.x = o.anim[o.current_anim].frame[o.frame_check].face[par].w
--           res.v.y = .h
    res.v.y = o.anim[o.current_anim].frame[o.frame_check].face[par].h
--
--         End With
--       End With
--
--     End With
--
--
--
--     Return res
    return res
--
--   End Select
  end
--
-- End Function
end

-- Sub LLObject_ShiftState( h As char_type Ptr, s As Integer )
function LLObject_ShiftState(h, s)
--
--   h->funcs.current_func[h->funcs.active_state] = 0
  h.funcs.current_func[h.funcs.active_state] = 0
--   h->funcs.active_state = s
  h.funcs.active_state = s
--   h->funcs.current_func[h->funcs.active_state] = 0
  h.funcs.current_func[h.funcs.active_state] = 0
--
-- End Sub
end
