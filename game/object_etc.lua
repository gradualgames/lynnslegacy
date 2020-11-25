-- Function __do_menu ( this As _char_type Ptr ) As Integer
function __do_menu(this)
--
--
--   With *this
  local with0 = this
--
--
--     If .menu_lock Then
--       '' if enter was pressed
--
--       If Not MultiKey ( sc_enter ) Then
--         '' let go of enter
--
--         If .menu_sel = 0 Then
--           '' menu off
--           llg( hero ).menu_sel = 0
--           .return_trig = 1
--           Exit Function
--
--         End If
--
--         If .menu_sel = 1 Then
--           '' menu off
--           llg( hero ).menu_sel = 2
--           .menu_sel = 0
--           .state_shift = 2
--           .menu_lock = 0
--           Exit Function
--
--
--         End If
--
--
--         .menu_lock = 0
--
--
--       End If
--
--     End If
--
--
--
--
--     llg( hero ).menu_sel = 1
--
--
--     If MultiKey ( sc_right ) Then
--
--
--       If .walk_hold = 0 Then
--
--
--         .menu_sel += 1
--         If .menu_sel = 3 Then .menu_sel = 0
--
--
--         .walk_hold = Timer + .walk_speed
--
--
--
--       End If
--
--     ElseIf MultiKey ( sc_left ) Then
--
--
--       If .walk_hold = 0 Then
--
--
--         .menu_sel -= 1
--         If .menu_sel = -1 Then .menu_sel = 2
--
--
--         .walk_hold = Timer + .walk_speed
--
--
--
--       End If
--
--     Else
--
--
--       .walk_hold = 0
--
--
--     End If
--
--
--     If Timer >= .walk_hold Then .walk_hold = 0
  if timer >= with0.walk_hold then with0.walk_hold = 0 end
--
--     If MultiKey( sc_escape ) Then
--       End
--
--     End If
--
--     If MultiKey( sc_enter ) Then
--
--       If .menu_sel = 2 Then
--
--         End
--
--       End If
--
--       .menu_lock = 1
--
--     End If
--
--
--   End With
--
--   Return 0
  return 0
--
-- End Function
end

-- Function __drop ( this As _char_type Ptr ) As Integer
function __drop(this)
  log.debug("__drop called.")
--
--
--
--   If this->d_health > Int( Rnd * 100 ) Then
  if this.d_health > math.floor(math.random() * 100) then
    log.debug("Dropping health.")
--     this->dropped = 1
    this.dropped = 1
--
--     this->drop->coords.x = this->coords.x + Int( Rnd * ( this->perimeter.x - 8 )  )
    this.drop.coords.x = this.coords.x + math.floor(math.random() * (this.perimeter.x - 8))
--     this->drop->coords.y = this->coords.y + Int( Rnd * ( this->perimeter.y - 8 )  )
    this.drop.coords.y = this.coords.y + math.floor(math.random() * (this.perimeter.y - 8))
--
--     Return 1
    return 1
--
--   End If
  end
--
--
--   If this->d_gold > Int( Rnd * 100 ) Then
  if this.d_gold > math.floor(math.random() * 100) then
--     this->dropped = 2
    this.dropped = 2
--
--     this->drop->coords.x = this->coords.x + Int( Rnd * ( this->perimeter.x - 8 )  )
    this.drop.coords.x = this.coords.x + math.floor(math.random() * (this.perimeter.x - 8))
--     this->drop->coords.y = this->coords.y + Int( Rnd * ( this->perimeter.y - 8 )  )
    this.drop.coords.y = this.coords.y + math.floor(math.random() * (this.perimeter.y - 8))
--
--     Return 1
    return 1
--
--   End If
  end
--
--
--   If this->d_silver > Int( Rnd * 100 ) Then
  if this.d_silver > math.floor(math.random() * 100) then
--     this->dropped = 3
    this.dropped = 3
--
--     this->drop->coords.x = this->coords.x + Int( Rnd * ( this->perimeter.x - 8 )  )
    this.drop.coords.x = this.coords.x + math.floor(math.random() * (this.perimeter.x - 8))
--     this->drop->coords.y = this->coords.y + Int( Rnd * ( this->perimeter.y - 8 )  )
    this.drop.coords.y = this.coords.y + math.floor(math.random() * (this.perimeter.y - 8))
--
--     Return 1
    return 1
--
--   End If
  end
--
--
--
--   Return 1
  return 1
--
--
--
-- End Function
end

-- Function __return_trig ( this As _char_type Ptr ) As Integer
function __return_trig(this)
--
--
--   this->return_trig = 1
  this.return_trig = 1
--
-- '  ? "HO"
-- '  reveal()
-- '  sleep
--
--
--   Return 1
  return 1
--
--
-- End Function
end
