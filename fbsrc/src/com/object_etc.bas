Option Explicit




#Include "..\headers\ll\headers.bi"




Function __do_proj( this As _char_type Ptr ) As Integer


  With *this

    If .dead Then 
      
      If ( Not ( .unique_id = u_ibug ) ) And ( Not ( .unique_id = u_fbug ) ) Then
        LLObject_ClearProjectiles( *this )
    
        Return 1
        
      End If
        
    End If

    If .projectile->refreshTime = 0 Then
    
      If .proj_style = PROJECTILE_BEAM Then
      
        If .projectile->sound = 0 Then

          play_sample( llg( snd )[sound_beam] )
          .projectile->sound = -1
        
        End If
      
      End If

      If .projectile->travelled = 0 Then
        LLObject_InitializeProjectiles( *this )

      Else
        LLObject_IncrementProjectiles( *this )

      End If

      .projectile->travelled += 1
      
      If .projectile->travelled >= .projectile->length Then 
      
        LLObject_ClearProjectiles( *this )
        If this->unique_id = u_divine_ball Then
          Dim As Integer i
          
          For i = 0 To now_room().enemy[20].anim[0]->frame[0].faces - 1
            now_room().enemy[20].anim[0]->frame[0].face[i].invincible = 0
            
          Next
          
        End If
          
          
          
      End If

      .projectile->refreshTime = Timer + .animControl[.proj_anim].rate
      
    End If                       

    If Timer >= .projectile->refreshTime Then .projectile->refreshTime = 0
                   
  End With                 

 
End Function



Function __change_room ( this As _char_type Ptr ) As Integer

  llg( seq ) = 0


  llg( hero ).coords.x = now_room().teleport[this->switch_room].dx
  llg( hero ).coords.y = now_room().teleport[this->switch_room].dy



  del_room_enemies now_room().enemies, now_room().enemy
  del_room_enemies now_room().temp_enemies, @now_room().temp_enemy( 0 )
  
  now_room().temp_enemies = 0


  llg( this )_room.i = now_room().teleport[this->switch_room].to_room


  set_up_room_enemies now_room().enemies, now_room().enemy
  
  If now_room().seq <> 0 Then
    llg( seq ) = now_room().seq
    
  End If 


  Return 1

 
End Function


Function __do_menu ( this As _char_type Ptr ) As Integer

  
  With *this


    If .menu_lock Then
      '' if enter was pressed
      
      If Not MultiKey ( sc_enter ) Then
        '' let go of enter
                              
        If .menu_sel = 0 Then 
          '' menu off
          llg( hero ).menu_sel = 0
          .return_trig = 1
          Exit Function
          
        End If
        
        If .menu_sel = 1 Then 
          '' menu off
          llg( hero ).menu_sel = 2
          .menu_sel = 0
          .state_shift = 2
          .menu_lock = 0
          Exit Function
          
          
        End If
        
        
        .menu_lock = 0
        
        
      End If
      
    End If
    
    
  
    
    llg( hero ).menu_sel = 1
  
  
    If MultiKey ( sc_right ) Then 
    

      If .walk_hold = 0 Then

      
        .menu_sel += 1
        If .menu_sel = 3 Then .menu_sel = 0


        .walk_hold = Timer + .walk_speed


        
      End If
      
    ElseIf MultiKey ( sc_left ) Then 
    

      If .walk_hold = 0 Then

      
        .menu_sel -= 1
        If .menu_sel = -1 Then .menu_sel = 2


        .walk_hold = Timer + .walk_speed


        
      End If
      
    Else          
    

      .walk_hold = 0

      
    End If
    

    If Timer >= .walk_hold Then .walk_hold = 0
    
    If MultiKey( sc_escape ) Then
      End
          
    End If
    
    If MultiKey( sc_enter ) Then 

      If .menu_sel = 2 Then 
        
        End
  
      End If
        
      .menu_lock = 1
      
    End If
  

  End With  
  
  Return 0
 
End Function


Function __do_menu_continue ( this As _char_type Ptr ) As Integer
  
  
  
  If ( this->menu_lock <> 0 ) Then
  
    If Not MultiKey ( sc_escape ) Then
                            
      this->menu_lock = 0
      this->menu_sel = 0

      this->read_lock = 0
      this->state_shift = 1
      
      
    End If
    
  End If

  Dim As Integer i

  If this->read_lock = 0 Then
  
    
    this->save( 0 ).link = LLSystem_ReadSaveFile( "ll_save1.sav" )
    this->save( 1 ).link = LLSystem_ReadSaveFile( "ll_save2.sav" )
    this->save( 2 ).link = LLSystem_ReadSaveFile( "ll_save3.sav" )
    this->save( 3 ).link = LLSystem_ReadSaveFile( "ll_save4.sav" )

    this->read_lock = -1

  End If
        
        
        

  If MultiKey ( sc_down ) Then 
  

    If this->walk_hold = 0 Then

    
      this->menu_sel += 1
      If this->menu_sel = 4 Then this->menu_sel = 0


      this->walk_hold = Timer + this->walk_speed


      
    End If
    
  ElseIf MultiKey ( sc_up ) Then 
  

    If this->walk_hold = 0 Then

    
      this->menu_sel -= 1
      If this->menu_sel = -1 Then this->menu_sel = 3


      this->walk_hold = Timer + this->walk_speed


      
    End If
    
  Else          
  

    this->walk_hold = 0

    
  End If
  

  If Timer >= this->walk_hold Then this->walk_hold = 0


  
  If MultiKey( sc_enter ) Then 

    If this->save( this->menu_sel ).link <> NULL Then
    
      llg( hero_only ).isLoading = TRUE
      
    End If
    
  End If

  If MultiKey( sc_escape ) Then 
    this->menu_lock = 1
    
  End If

  
  Return 0

 
End Function




Function __do_menu_save ( this As _char_type Ptr ) As Integer
  

  llg( hero ).menu_sel = 2
  llg( do )_hud = 0

  llg( hero )_only.action_lock = -1

  
  If ( this->menu_lock <> 0 ) Then
  
    If Not MultiKey ( sc_escape ) Then

                            
      this->menu_lock = 0
      this->menu_sel = 0

      this->read_lock = 0
      
      llg( hero ).menu_sel = 0
      llg( do )_hud = -1

      llg( hero )_only.action_lock = 0

      
      Return -2
      
    End If
    
  End If

  Dim op As Integer

  If this->read_lock = 0 Then
  

    this->save( 0 ).link = LLSystem_ReadSaveFile( "ll_save1.sav" )
    this->save( 1 ).link = LLSystem_ReadSaveFile( "ll_save2.sav" )
    this->save( 2 ).link = LLSystem_ReadSaveFile( "ll_save3.sav" )
    this->save( 3 ).link = LLSystem_ReadSaveFile( "ll_save4.sav" )
    
    this->read_lock = -1

  End If
          
        
        

  If MultiKey ( sc_down ) Then 
  

    If this->walk_hold = 0 Then

    
      this->menu_sel += 1
      If this->menu_sel = 4 Then this->menu_sel = 0


      this->walk_hold = Timer + this->walk_speed


      
    End If
    
  ElseIf MultiKey ( sc_up ) Then 
  

    If this->walk_hold = 0 Then

    
      this->menu_sel -= 1
      If this->menu_sel = -1 Then this->menu_sel = 3


      this->walk_hold = Timer + this->walk_speed


      
    End If
    
  Else          
  

    this->walk_hold = 0

    
  End If
  

  If Timer >= this->walk_hold Then this->walk_hold = 0


          
  If MultiKey( sc_enter ) Then 
    
    Dim flr As String
    flr = Str( this->menu_sel + 1 )
    
    LLSystem_WriteSaveFile( "ll_save" + flr + ".sav", this->chap )
    
    this->read_lock = 0
    
  End If

  If MultiKey( sc_escape ) Then 
    this->menu_lock = 1
    
  End If



 
End Function



Function __change_map ( this As _char_type Ptr ) As Integer

  llg( hero_only ).dropoutSequence = TRUE  
  
  llg( hero ).switch_room = this->chap

  llg( hero ).to_map = now_room().teleport[llg( hero ).switch_room].to_map
  llg( hero ).to_entry = now_room().teleport[llg( hero ).switch_room].to_room

  change_room( 0, -1, 1 )

  llg( hero ).fade_time = .003
  llg( hero ).seq = 0

  Return 1

 
End Function

Function __drop ( this As _char_type Ptr ) As Integer



  If this->d_health > Int( Rnd * 100 ) Then 
    this->dropped = 1

    this->drop->coords.x = this->coords.x + Int( Rnd * ( this->perimeter.x - 8 )  )
    this->drop->coords.y = this->coords.y + Int( Rnd * ( this->perimeter.y - 8 )  )
    
    Return 1
    
  End If

      
  If this->d_gold > Int( Rnd * 100 ) Then 
    this->dropped = 2

    this->drop->coords.x = this->coords.x + Int( Rnd * ( this->perimeter.x - 8 )  )
    this->drop->coords.y = this->coords.y + Int( Rnd * ( this->perimeter.y - 8 )  )
    
    Return 1
    
  End If

      
  If this->d_silver > Int( Rnd * 100 ) Then 
    this->dropped = 3

    this->drop->coords.x = this->coords.x + Int( Rnd * ( this->perimeter.x - 8 )  )
    this->drop->coords.y = this->coords.y + Int( Rnd * ( this->perimeter.y - 8 )  )
    
    Return 1
    
  End If

      
  
  Return 1
  


End Function



Function __give_b_key ( this As _char_type Ptr ) As Integer

 
  llg( hero_only ).b_key += 1

  Return 1
  


End Function


Function __drop_b_key ( this As _char_type Ptr ) As Integer

 
  llg( hero_only ).b_key = 0

  Return 1
  


End Function


Function __bridge_chasm ( this As _char_type Ptr ) As Integer

  
  If llg( now )[357] <> 0 Then
    

    LLObject_ShiftState( this, this->reset_state )
    this->impassable = 0
    Return 0
  
  
  
  End If
'  llg( hero_only ).b_key = 0

  Return 1
  


End Function


Function __give_item ( this As _char_type Ptr ) As Integer

  
'  llg( hero_only ).has_item += 1
  llg( hero_only ).hasItem( this->chap ) = TRUE
  antiHackASSIGN2( LL_Global.hero_only.itemDummy, LL_Global.hero_only.hasItem )

  Return 1
  


End Function


Function __give_key ( this As _char_type Ptr ) As Integer

  llg( hero ).key += 1

  
  Return 1
  


End Function


Function __give_weapon ( this As _char_type Ptr ) As Integer
  
  
'  ? llg( hero_only ).weapon
'  ? llg( hero_only ).has_weapon
'  reveal()
'  Sleep
'  
  
  llg( hero_only ).has_weapon += 1

'  Select Case llg( hero_only ).has_weapon
'  
'    Case 1
      llg( hero_only ).weapon = llg( hero_only ).has_weapon

'    Case 2
'      llg( hero_only ).weapon = 1
'
'    Case 3
'      llg( hero_only ).weapon = 2
'      
'  End Select

  antiHackASSIGN( LL_Global.hero_only.weaponDummy, LL_Global.hero_only.has_weapon )

  Return 1
  


End Function

Function __give_weapon2 ( this As _char_type Ptr ) As Integer

  
  llg( hero_only ).has_weapon += 1

  llg( hero_only ).weapon = llg( hero_only ).has_weapon
  antiHackASSIGN( LL_Global.hero_only.weaponDummy, LL_Global.hero_only.has_weapon )


  Return 1
  


End Function



Function __off_happen ( this As _char_type Ptr ) As Integer

  llg( now )[this->chap] = 0

      
  
  Return 1
  


End Function


'Function __off_killtrig ( this As _char_type Ptr ) As Integer
'
'  this->spawn_kill_trig = 0
'
'      
'  
'  Return 1
'  
'
'
'End Function


Function __play_seq ( this As _char_type Ptr ) As Integer

  llg( seq ) = this->seq + this->sel_seq
  

  
  Return 1
 
End Function



Function __set_happen ( this As _char_type Ptr ) As Integer

  
  llg( now )[this->chap] = Not 0

      
  
  Return 1


End Function



Function __invis_entry ( this As _char_type Ptr ) As Integer
  
  llg( hero_only ).invisibleEntry = -1

      
  
  Return 1


End Function





Function __return_trig ( this As _char_type Ptr ) As Integer


  this->return_trig = 1
  
'  ? "HO"
'  reveal()
'  sleep
  
  
  Return 1

 
End Function


Function __eat_lynn_action ( this As _char_type Ptr ) As Integer
  

  llg( hero )_only.action = 0


  Return 1

 
End Function


Function __end ( this As _char_type Ptr ) As Integer

  Function = 0
     
  End


End Function



Function __handle_menu( this As _char_type Ptr ) As Integer
  
  
  
  
  With *this

    Select Case llg( hero ).menu_sel
    
      Case 1
        '' Start Continue Quit menu.
  
                                                    
        Put( 32, 32 ), @.anim[0]->image[0], Trans

        Scope    
        
          Dim As Integer menu_sels
        
            For menu_sels = 0 To 2
              '' isn't that such beautiful?
    
              Put( 64 * ( menu_sels + 1 ), 96 ), @.anim[menu_sels * 2 + 1 + ( Abs( .menu_sel = menu_sels ) )]->image[0], Trans 
      
            Next              
            
        End Scope
  
  
      Case 2
  
        Scope
        
          Dim As Integer menu_sels, m_opt
  
            For menu_sels = 0 To 3
              m_opt = ( menu_sels * 50 ) 
            
              '' more beauty...
              Put( 0, menu_sels * 50 ), @.anim[menu_sels * 2 + 7 + ( Abs( .menu_sel = menu_sels ) )]->image[0], Trans 
              
              
              If .save( menu_sels ).link <> 0 Then 
              
                Dim As Integer weap
                
                
                weap = .save( menu_sels ).link->weapon Mod 3
                If weap < 0 Then weap = 0
                
                Put( 32, ( menu_sels * 50 ) ), @llg( savImages ).img( weap )->image[0], Trans

                                               
                Scope 
                  
                  Dim As Integer put_h
                 
                    For put_h = 0 To 5'.save( menu_sels ).link->item - 1
                      
                      if .save( menu_sels ).link->hasItem( put_h ) then
                        Put( 57 + ( put_h * 16 ), ( menu_sels * 50 ) + 26 ), @llg( hud ).img(1)->image[ ( put_h + 1 ) * llg( hud ).img(1)->arraysize ], Trans
                        
                      end if
                    
                    Next
                    
                End Scope  

                
                Scope
                  
                  Dim As Integer p, x_opt, y_opt
                  
                    For p = 0 To 29
                    
                      x_opt = ((p Mod 15 ) * 8) + 8 
                      y_opt = (( p \ 15) * 8) + 8
                    
                      If ( .save( menu_sels ).link->hp > p ) Then 
                        Put( 49 + x_opt, y_opt + m_opt ), @llg( hud ).img(0)->image[0], Trans 
                  
                      ElseIf (.save( menu_sels ).link->maxhp ) > p Then 
                        Put( 49 + x_opt, y_opt + m_opt ), @llg( hud ).img(0)->image[34], Trans 
                  
                      Else 
                        Put( 49 + x_opt, y_opt + m_opt ), @llg( hud ).img(0)->image[68], Trans 
                  
                    
                      End If
          
                    Next
                    
                End Scope
      
                  
                Put ( 275, ( 16 ) + m_opt), @llg( hud ).img(2)->image[0], Trans
                
                Scope

                  Dim mny As String
                  
                    mny = String(  3 - Len( Str( .save( menu_sels ).link->gold ) ), "0" ) 
                    mny += Str( .save( menu_sels ).link->gold )
                  
                  Dim As Integer nums
                  
                    For nums = 0 To 2
                    
                      Put ( 289 + ( nums * 8 ), ( 16 ) + m_opt ), @llg( hud ).img(3)->image[( mny[nums] - 48 ) * llg( hud ).img(3)->arraysize], Trans
                      
                    Next
                  
                End Scope
                
              End If
      
      
            Next              
            
        End Scope
  
    End Select 
    
  End With
  
  Return 0
    
End Function


Function __make_enemy ( this As _char_type Ptr ) As Integer

  If now_room().temp_enemies <> MAX_TEMP_ENEMIES Then


    
    now_room().temp_enemy( now_room().temp_enemies ).id = this->spawns_id 
     
    LLSystem_CopyNewObject( now_room().temp_enemy( now_room().temp_enemies ) )

    now_room().temp_enemy( now_room().temp_enemies ).coords.y = this->spawn_y + this->coords.y
    now_room().temp_enemy( now_room().temp_enemies ).coords.x = this->spawn_x + this->coords.x
    
    now_room().temp_enemies += 1
  
    
  End If
  
  Return 1
 
 
End Function
                                                                       
Function __kill_all_temps ( this As _char_type Ptr ) As Integer
  
  Dim As Integer i
  For i = 0 To now_room().temp_enemies - 1
    now_room().temp_enemy( i ).hp = 0
  
  Next  
  Return 1
 
 
End Function
                                                                       
Function __give_100_gold ( this As _char_type Ptr ) As Integer
  
  
  llg( hero ).money += 100
  antiHackASSIGN( LL_Global.hero_only.moneyDummy, LL_Global.hero.money )
  Return 1
 
 
End Function
                                                                       

Function __melt ( this As _char_type Ptr ) As Integer

  this->melt = 0
  
  Return 0
 
End Function



Function __after_moenia_townspeople( this As char_type Ptr ) As Integer 

  If llg( now )[199] <> 0 Then
    
    LLObject_ShiftState( this, this->reset_state )
    Return 0
  
  
  End If

  If this->shifty_lock = 0 Then
  
    this->coords.x = 800
    this->coords.y = 800
    
    this->shifty_lock = -1
    
  End If



End Function 


Function __after_slime( this As char_type Ptr ) As Integer 

  If llg( now )[1150] <> 0 Then
    
    this->sel_seq = 3
    Return 1
  
  
  End If


End Function 


Function __set_camera( this As char_type Ptr ) As Integer 
  
  
  llg( current_cam ) = this

  Return 1

End Function 


Function __templewood_bridge( this As char_type Ptr ) As Integer 
  
  
  '' if event not set, then 
  if llg( now )[1206] = 0 then

    this->anim[this->current_anim]->frame[0].face[0].impassable = 1
    
    if multikey( llg( conf_key ).code ) then
    
      if LLObject_isTouching( llg( hero ), this[0] ) = 0 then
      '' if touching then
        
        if llg( hero_only ).hasItem( 2 ) then
        '' if has bridge box then
          
          llg( seq ) = this->seq
        else
        
          if llg( now )[1208] = 0 then
            llg( seq ) = this->seq + 1
            llg( now )[1208] = -1
            
          end if
    
        end if
        
    
      end if
    
    
    end if

  else

    this->invisible = 0
    this->anim[this->current_anim]->frame[0].face[0].impassable = 0
    return 1  
  
  end if
  
  Return 0

End Function 


Function __arx_bridge( this As char_type Ptr ) As Integer 
  
  
  '' if event not set, then 
  if llg( now )[470] = 0 then
    this->anim[this->current_anim]->frame[0].face[0].impassable = 1
    
    if multikey( llg( conf_key ).code ) then
    
      if LLObject_isTouching( llg( hero ), this[0] ) = 0 then
      '' if touching then
        
        if llg( hero_only ).hasItem( 2 ) then
        '' if has bridge box then
          
          llg( seq ) = this->seq
        else
        
          if llg( now )[471] = 0 then
            llg( seq ) = this->seq + 1
            llg( now )[471] = -1
            
          end if
    
        end if
        
    
      end if
    
    
    end if

  else

    this->invisible = 0
    this->anim[this->current_anim]->frame[0].face[0].impassable = 0
    return 1  
  
  end if
  
  Return 0

End Function 



function __check_lynn_contact( this As char_type Ptr ) as integer
  
  if check_bounds( LLO_VP( this ), LLO_VP( varptr( llg( hero ) ) ) ) = 0 then
    '' lynn's on this
    
    with llg( hero )
      
      If .dmg.id = 0 Then
        .hp -= 1
        antiHackASSIGN( LL_Global.hero_only.healthDummy, LL_Global.hero.hp )
        .hurt = 1
        .dmg.id = 1
        
        .fly.x = 0
        .fly.y = 0
        
        If .hp < 1 Then
    
      
          If .dead = 0 Then
            '' first time initialization.
      
            LLObject_ShiftState( Varptr( llg( hero ) ), .death_state )  
      
            .dead = 1
            .fade_time = .07
            
          End If
        
        
          '' reset damaged status.
          LLObject_ClearDamage( Varptr( llg( hero ) ) )
          
        End If
        
      End If
      
    end with



    LLObject_ShiftState( this, 1 )
    
    
  else
    this->impassable = 1
    LLObject_ShiftState( this, 0 )
  
  
  
  end if
  
  function = 0
  

end function


Function __bandit_check( this As char_type Ptr ) As Integer 


  If llg( hero_only ).hasItem( 3 ) Then
  
    this->sel_seq = 1
  
  End If
  
  Function = 0


End Function


Function __healthguy_branch( this As char_type Ptr ) As Integer 
  
  
  if llg( hero ).money < healthFormula then
    this->sel_seq = 2
    
  end if
  
  if llg( hero ).maxhp = 30 then
    this->sel_seq = 1
    
  end if
  
  Function = 1


End Function

Function __outfit_branch( this As char_type Ptr ) As Integer 
  
  
  if llg( hero ).money < this->chap then
    this->sel_seq = 1
    
  end if
  
  Function = 1


End Function



Function __give_gold_amount( this As char_type Ptr ) As Integer 
  
  
  llg( hero ).money += this->chap
  antiHackASSIGN( LL_Global.hero_only.moneyDummy, LL_Global.hero.money )

  Function = 1


End Function


Function __dec_sel_seq( this As char_type Ptr ) As Integer 
  
  
  this->sel_seq -= 1

  Function = 1


End Function
Function __poondodge_branch( this As char_type Ptr ) As Integer 
  
  
  if llg( now )[1220] = 0 then
    if llg( now )[1221] then
      this->sel_seq = 1
      
    end if
  end if

  Function = 1


End Function




Function __give_outfit( this As char_type Ptr ) As Integer 
  
  
  llg( hero_only ).hasCostume( this->chap ) = TRUE
  antiHackASSIGN2( LL_Global.hero_only.outfitDummy, LL_Global.hero_only.hasCostume )
  
  select case as const this->chap
    case 1
      llg( hero ).money -= 10
    case 2
      llg( hero ).money -= 35
    case 3
    case 4
      llg( hero ).money -= 70
    case 5
      llg( hero ).money -= 50

  
  end select

  antiHackASSIGN( LL_Global.hero_only.moneyDummy, LL_Global.hero.money )
    

  Function = 1


End Function


Function __fade_music_out( this As char_type Ptr ) As Integer 
                                              
  llg( hero_only ).songFade = CAllocate( Len( songFading_type ) )
  llg( hero_only ).songFade->pulseLength = ( 4 / 64 ) 

  Function = 1

End Function


Function __give_costume( this As char_type Ptr ) As Integer 
  
  
  llg( hero_only ).hasCostume( this->chap ) = TRUE
  antiHackASSIGN2( LL_Global.hero_only.outfitDummy, LL_Global.hero_only.hasCostume )

  Function = 1


End Function

Function __heal_lynn( this As char_type Ptr ) As Integer 
  
  
  llg( hero ).hp = llg( hero ).maxhp
  antiHackASSIGN( LL_Global.hero_only.healthDummy, LL_Global.hero.hp )

  Function = 1


End Function

Function __turn_off_tiles( this As char_type Ptr ) As Integer 
  
  
  llg( tilesDisabled ) = TRUE

  Function = 1


End Function

Function __buy_health( this As char_type Ptr ) As Integer 
  
  dim as integer hPrice = healthFormula
  
  llg( hero ).money -= hPrice
  antiHackASSIGN( LL_Global.hero_only.moneyDummy, LL_Global.hero.money )
  llg( hero ).maxhp += 1
  antiHackASSIGN( LL_Global.hero_only.maxhealthDummy, LL_Global.hero.maxhp )
  Function = 1


End Function

Function __translate_result( this As char_type Ptr ) As Integer 
  
  sequence_FullReset( *llg( seq ) )

  select case llg( t_rect ).selected
  
    case 0
      llg( seq ) = this->seq + this->dest_x
      this->dest_x = 0
    
    case 1
      llg( seq ) = this->seq + this->dest_y
      this->dest_y = 0
    
  End Select
  
  
  llg( hero_only ).dropoutSequence = TRUE
  
  Function = 0


End Function

Function __set_font_fg( this As char_type Ptr ) As Integer 

  dim as integer charIter, pixIter, hColIn
  dim as ubyte ptr hPixLoc
  
  if this < 256 then
    hColIn = cint( this )
  
  else
    hColIn = this->chap
    
  end if
  
  for charIter = 0 to 255
    
    hPixLoc = varptr( cast( ubyte ptr, llg( font )->image )[charIter * llg( font )->arraysize + 4] )
    
    for pixIter = 0 to 127
      
      if *hPixLoc = llg( fontFG ) then
        *hPixLoc = hColIn
        
      end if
      hPixLoc += 1
      
    next
  
  next
  
  llg( fontFG ) = hColIn

  Function = 1

End Function


Function __set_font_bg( this As char_type Ptr ) As Integer 
  
  dim as integer charIter, pixIter, hColIn
  dim as ubyte ptr hPixLoc
  
  if this < 256 then
    hColIn = cint( this )
  
  else
    hColIn = this->chap
    
  end if
  
  for charIter = 0 to 255
    
    hPixLoc = varptr( cast( ubyte ptr, llg( font )->image )[charIter * llg( font )->arraysize + 4] )
    
    for pixIter = 0 to 127
      
      if *hPixLoc = llg( fontBG ) then
        *hPixLoc = hColIn
        
      end if
      hPixLoc += 1
      
    next
  
  next
  
  llg( fontBG ) = hColIn
  
  Function = 1

End Function

Function __turn_on_tiles( this As char_type Ptr ) As Integer 
  
  
  llg( tilesDisabled ) = FALSE

  Function = 1


End Function



Function __quake( this As char_type Ptr ) As Integer 
  
  
  llg( hero_only ).quakeViolence = IIf( this->chap = -1, 0, this->chap )

  Function = 1


End Function


Function __set_finish( this As char_type Ptr ) As Integer 
  
	llg( xxyxx ) = -1

  Function = 1


End Function



Function __logosta_console( this As char_type Ptr ) As Integer 
  
  Const As String consolePrompt = "PASS> ", passWord = "FerUs686"
  Const As Integer maxEntry = 10
  Const As Double cursorRate = .6
  
  Dim As Integer cursorOn, outty
  Dim As Double cursorToggle
  
  Dim As String inputString
  Get( 0, 0 )-( 319, 199 ), llg( menu_ScreenSave )
  fb_ScreenRefresh()
  shift_pal()
  
  Dim As String gfxDump
  
  Do
    
    fb_GetKey()
    
    If StrPtr( fb_Global.keyBuffer ) <> NULL Then
      
      Select Case fb_Global.keyBuffer[0]
      
        Case 8
          '' backspace
          inputString = Left( inputString, Len( inputString ) - 1 )
          
        Case 13
          '' enter
          
          sequence_FullReset( *llg( seq ) )

          If inputString = passWord Then
            '' correct
            llg( seq ) = this->seq + 2
            
          Else
            '' incorrect
            llg( seq ) = this->seq + 1
            
            
          End If
          llg( hero_only ).dropoutSequence = TRUE
          outty = TRUE
          
        Case Else
          
          If Len( inputString ) <> maxEntry Then
            inputString += Chr( fb_Global.keyBuffer[0] )
          
          End If
          
      End Select
        
    End If
    
    If fb_WindowKill() Then End
    
    If Timer > cursorToggle Then
      cursorOn = Not cursorOn
      cursorToggle = Timer + cursorRate
      
    End If
    
    
    gfxDump = consolePrompt + inputString
    If cursorOn Then
      gfxDump += "_"
      
    End If
    
    gfxprint( gfxDump, 0, 48 ) 
    fb_ScreenRefresh()
  
  Loop Until outty
  Put( 0, 0 ), llg( menu_ScreenSave )

  Function = 0


End Function


Function __set_song( this As char_type Ptr ) As Integer 

  llg( song ) = this->chap  
  
  Function = 1


End Function


