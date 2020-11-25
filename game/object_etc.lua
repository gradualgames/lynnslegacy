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
  ll_global.hero.menu_sel = 1
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

-- Function __handle_menu( this As _char_type Ptr ) As Integer
function __handle_menu(this)
--
--
--
--
--   With *this
  local with0 = this
--
--     Select Case llg( hero ).menu_sel
--
--       Case 1
  if ll_global.hero.menu_sel == 1 then
--         '' Start Continue Quit menu.
--
--
--         Put( 32, 32 ), @.anim[0]->image[0], Trans
    love.graphics.draw(with0.anim[0].image, 32, 32)
--
--         Scope
--
--           Dim As Integer menu_sels
    local menu_sels = 0
--
--             For menu_sels = 0 To 2
    for menu_sels = 0, 2 do
--               '' isn't that such beautiful?
--
--               Put( 64 * ( menu_sels + 1 ), 96 ), @.anim[menu_sels * 2 + 1 + ( Abs( .menu_sel = menu_sels ) )]->image[0], Trans
      local offs = (with0.menu_sel == menu_sels) and 1 or 0
      love.graphics.draw(with0.anim[menu_sels * 2 + 1 + offs].image, 64 * (menu_sels + 1), 96)
--
--             Next
    end
--
--         End Scope
--
--
--       Case 2
  elseif ll_global.hero.menu_sel == 2 then
--
--         Scope
--
--           Dim As Integer menu_sels, m_opt
--
--             For menu_sels = 0 To 3
--               m_opt = ( menu_sels * 50 )
--
--               '' more beauty...
--               Put( 0, menu_sels * 50 ), @.anim[menu_sels * 2 + 7 + ( Abs( .menu_sel = menu_sels ) )]->image[0], Trans
--
--
--               If .save( menu_sels ).link <> 0 Then
--
--                 Dim As Integer weap
--
--
--                 weap = .save( menu_sels ).link->weapon Mod 3
--                 If weap < 0 Then weap = 0
--
--                 Put( 32, ( menu_sels * 50 ) ), @llg( savImages ).img( weap )->image[0], Trans
--
--
--                 Scope
--
--                   Dim As Integer put_h
--
--                     For put_h = 0 To 5'.save( menu_sels ).link->item - 1
--
--                       if .save( menu_sels ).link->hasItem( put_h ) then
--                         Put( 57 + ( put_h * 16 ), ( menu_sels * 50 ) + 26 ), @llg( hud ).img(1)->image[ ( put_h + 1 ) * llg( hud ).img(1)->arraysize ], Trans
--
--                       end if
--
--                     Next
--
--                 End Scope
--
--
--                 Scope
--
--                   Dim As Integer p, x_opt, y_opt
--
--                     For p = 0 To 29
--
--                       x_opt = ((p Mod 15 ) * 8) + 8
--                       y_opt = (( p \ 15) * 8) + 8
--
--                       If ( .save( menu_sels ).link->hp > p ) Then
--                         Put( 49 + x_opt, y_opt + m_opt ), @llg( hud ).img(0)->image[0], Trans
--
--                       ElseIf (.save( menu_sels ).link->maxhp ) > p Then
--                         Put( 49 + x_opt, y_opt + m_opt ), @llg( hud ).img(0)->image[34], Trans
--
--                       Else
--                         Put( 49 + x_opt, y_opt + m_opt ), @llg( hud ).img(0)->image[68], Trans
--
--
--                       End If
--
--                     Next
--
--                 End Scope
--
--
--                 Put ( 275, ( 16 ) + m_opt), @llg( hud ).img(2)->image[0], Trans
--
--                 Scope
--
--                   Dim mny As String
--
--                     mny = String(  3 - Len( Str( .save( menu_sels ).link->gold ) ), "0" )
--                     mny += Str( .save( menu_sels ).link->gold )
--
--                   Dim As Integer nums
--
--                     For nums = 0 To 2
--
--                       Put ( 289 + ( nums * 8 ), ( 16 ) + m_opt ), @llg( hud ).img(3)->image[( mny[nums] - 48 ) * llg( hud ).img(3)->arraysize], Trans
--
--                     Next
--
--                 End Scope
--
--               End If
--
--
--             Next
--
--         End Scope
--
--     End Select
  end
--
--   End With
--
--   Return 0
--
-- End Function
end
