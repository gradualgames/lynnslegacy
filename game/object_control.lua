require("game/utility")

-- Function in_proximity( this As char_type Ptr ) As Integer
function in_proximity(this)
--
--   Dim As Integer shifty_gen
  local shifty_gen = 0
--
--   Dim As mat_int hero_middle, this_middle, more
  local hero_middle, this_middle, more = create_mat_int(), create_mat_int(), create_mat_int()
--
--   With *this
  local with0 = this
--
--     hero_middle.x = llg( hero ).coords.x + ( llg( hero ).perimeter.x Shr 1 )
  hero_middle.x = ll_global.hero.coords.x + bit.rshift(ll_global.hero.perimeter.x, 1)
--     hero_middle.y = llg( hero ).coords.y + ( llg( hero ).perimeter.y Shr 1 )
  hero_middle.y = ll_global.hero.coords.y + bit.rshift(ll_global.hero.perimeter.y, 1)
--
--     this_middle.x = .coords.x + ( .perimeter.x Shr 1 )
  this_middle.x = with0.coords.x + bit.rshift(with0.perimeter.x, 1)
--     this_middle.y = .coords.y + ( .perimeter.y Shr 1 )
  this_middle.y = with0.coords.y + bit.rshift(with0.perimeter.y, 1)
--
--     more.x = Abs( hero_middle.x - this_middle.x )
  more.x = math.abs(hero_middle.x - this_middle.x)
--     more.y = Abs( hero_middle.y - this_middle.y )
  more.y = math.abs(hero_middle.y - this_middle.y)
--
--
--     If (more.x < .vision_field) Then
  if (more.x < with0.vision_field) then
--
--       If (more.y < .vision_field) Then
    if (more.y < with0.vision_field) then
--
--
--         If .shifty <> 0 Then
      if with0.shifty ~= 0 then
--
--           If .shifty_lock = 0 Then
        if with0.shifty_lock == 0 then
--
--             .shifty_state = Int ( Rnd * 2 )
          with0.shifty_state = math.floor(math.random() * 2)
--             .shifty_lock = 1
          with0.shifty_lock = 1
--
--           End If
        end
--
--         End If
      end
--
--
--         If ( .shifty <> 0 ) Imp ( .shifty_state = 0 ) Then
      if imp(with0.shifty ~= 0 and -1 or 0, with0.shifty_state == 0 and -1 or 0) ~= 0 then
--           '' this doesn't happen if( shifty <> 0 and shifty_state <> 0 )
--
--           If .must_align Then
        if with0.must_align ~= 0 then
--
--             If ( ( more.x < IIf( .side_vision <> 0 , .side_vision, 4 ) ) And ( more.y < .vision_field ) ) Or ( ( more.x < .vision_field ) And ( more.y < IIf( .side_vision <> 0, .side_vision, 4 ) ) ) Then
          if ((more.x < iif(with0.side_vision ~= 0, with0.side_vision, 4)) and (more.y < with0.vision_field)) or ((more.x < with0.vision_field) and (more.y < iif(with0.side_vision ~= 0, with0.side_vision, 4))) then
--
--               .mad = 1
            with0.mad = 1
--
--               .reset_delay = 0
            with0.reset_delay = 0
--               .pause_hold = 0
            with0.pause_hold = 0
--
--               .funcs.current_func[.funcs.active_state] = 0
            with0.funcs.current_func[with0.funcs.active_state] = 0
--               Return .jump_state
            return with0.jump_state
--
--             End If
          end
--
--             Return .funcs.active_state
          return with0.funcs.active_state
--
--           End If
        end
--
--           .mad = 1
        with0.mad = 1
--
--           .reset_delay = 0
        with0.reset_delay = 0
--           .pause_hold = 0
        with0.pause_hold = 0
--
--           .funcs.current_func[.funcs.active_state] = 0
        with0.funcs.current_func[with0.funcs.active_state] = 0
--
--           Return .jump_state
        return with0.jump_state
--
--         Else
      else
--
--           Return .funcs.active_state
        return with0.funcs.active_state
--
--         End If
      end
--
--       Else
    else
--
--         .shifty_lock = 0
      with0.shifty_lock = 0
--         .shifty_state = 0
      with0.shifty_state = 0
--
--       End If
    end
--
--     End If
  end
--
--     Return .funcs.active_state
  return with0.funcs.active_state
--
--   End With
--
--
-- End Function
end
