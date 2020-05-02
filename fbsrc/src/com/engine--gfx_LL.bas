Option Explicit

#Include "..\headers\ll.bi"

#IfNDef min_int 

  Const min_int = 1 Shl 31 

#EndIf 

#Macro make_mergesort( __the_type, __suffix ) 

  Sub __mergesort_merge##__suffix Overload( a_ary() As __the_type, b_ary() As  __the_type, ByVal low As Integer, ByVal middle As Integer, ByVal hi As Integer ) Static  

    Dim As Integer   i, j, k   

    i = 0
    j = low   

    While j <= middle   

      b_ary( i ) = a_ary( j )   
      i += 1
      j += 1   

    Wend   
    
    i = 0
    k = low   
    
    Do   

      If  k >= j  Then
        Exit Do
        
      End If  
      
      If  j > hi  Then
        Exit Do
        
      End If
        
      If  __mergesort_less_eq( b_ary( i ), a_ary( j ) ) Then   
      
        a_ary( k ) = b_ary( i )   

        k += 1
        i += 1   
        
      Else
         
        a_ary( k ) = a_ary( j )   

        k += 1
        j += 1   

      End If   

    Loop   

    For k = k To j - 1   

      a_ary( k ) = b_ary( i )   

      i += 1   

    Next   

  End Sub   

  Sub __mergesort##__suffix Overload ( a_ary() As __the_type, b_ary() As  __the_type, ByVal low As Integer, ByVal hi As Integer )

    Dim As Integer middle   

    If low < hi  Then   

      middle = ( low + hi ) Shr 1   

      __mergesort##__suffix( a_ary(), b_ary(), low       , middle )   
      __mergesort##__suffix( a_ary(), b_ary(), middle + 1, hi     )
         
      __mergesort_merge##__suffix( a_ary(), b_ary(), low, middle, hi )   

    End If   

  End Sub  
   
  Sub mergesort##__suffix Overload ( a_ary() As  __the_type, ByVal low As Integer = min_int, ByVal high As Integer = min_int ) Static  

    Dim As Integer  n   

    If low = min_int Then 
      low = LBound( a_ary )
      
    End If   

    If high = min_int Then 
      high = UBound( a_ary )
      
    End If   

    n = high - low + 1   

    Redim b_ary( 0 To ( ( n + 1 ) Shr 1 ) - 1 ) As __the_type   

    __mergesort##__suffix( a_ary(), b_ary(), low, high )   

  End Sub 

#EndMacro


'================================================================ 




#UnDef __mergesort_less_eq 
#Define __mergesort_less_eq( a, b ) ( ( ( a->coords.y ) + a->perimeter.y Shr 1 ) <= ( ( b->coords.y ) + b->perimeter.y Shr 1 ) )
make_mergesort( _char_type Ptr , _y ) 

#UnDef __mergesort_less_eq 
#Define __mergesort_less_eq( a, b ) ( a->placed <= b->placed ) 
make_mergesort( _char_type Ptr , _placed ) 




#define LLDebug_ShowEnemyPerimeters()                                                  _
                                                                                       _
  scope                                                                               :_
                                                                                      :_
    dim as integer enems, x, y                                                        :_
                                                                                      :_
    for enems = 0 to now_room().enemies - 1                                           :_
                                                                                      :_
      with now_room().enemy[enems]                                                    :_
                                                                                      :_
        x = .coords.x + .animControl[.current_anim].x_off - llg( this_room ).cx       :_
        y = .coords.y + .animControl[.current_anim].y_off - llg( this_room ).cy       :_
                                                                                      :_
        line( x, y )- step( .perimeter.x - 1, .perimeter.y - 1 ), int( rnd * 256 ), b :_
                                                                                      :_
      end with                                                                        :_
                                                                                      :_
    next                                                                              :_
                                                                                      :_
  end scope


#define LLDebug_ShowEnemyFaces()                                                                                                                                   _
                                                                                                                                                                   _
  scope                                                                                                                                                           :_
                                                                                                                                                                  :_
    dim as integer enems, frames, faces, x, y                                                                                                                     :_
                                                                                                                                                                  :_
    for enems = 0 to now_room().enemies - 1                                                                                                                       :_
      with now_room().enemy[enems]                                                                                                                                :_
                                                                                                                                                                  :_
          With .anim[.current_anim]->frame[LLObject_CalculateFrame(now_room().enemy[enems])]                                                                                                                :_
            for faces = 0 to .faces - 1                                                                                                                           :_
              with .face[faces]                                                                                                                                   :_
                                                                                                                                                                  :_
                x = now_room().enemy[enems].coords.x + .x - now_room().enemy[enems].animControl[now_room().enemy[enems].current_anim].x_off - llg( this_room ).cx :_
                y = now_room().enemy[enems].coords.y + .y - now_room().enemy[enems].animControl[now_room().enemy[enems].current_anim].y_off - llg( this_room ).cy :_
                                                                                                                                                                  :_
                line( x, y )- step( .w - 1, .h - 1 ), int( rnd * 256 ), b                                                                                         :_
                                                                                                                                                                  :_
              end with                                                                                                                                            :_
                                                                                                                                                                  :_
            next                                                                                                                                                  :_
                                                                                                                                                                  :_
          end with                                                                                                                                                :_
                                                                                                                                                                  :_
      end with                                                                                                                                                    :_
                                                                                                                                                                  :_
    next                                                                                                                                                          :_
                                                                                                                                                                  :_
  end scope
  
  

sub graphicalString( printString as string, byval x as integer, byval y as integer, byval col as integer = 15 )
  
  dim as integer letterIteration
  
  for letterIteration = 0 to len( printString ) - 1
  
    put( x, y ), varptr( llg( font )->image[llg( font )->arraysize * printString[letterIteration]] ), trans
    
    x += 8

    if printString[letterIteration] = 10 then 
      y += 16
      x = 0
      
    end if
    
  
  next
  
end sub


Sub blit_scene() Static    


  If llg( do_chap ) = 0 Then
    '' chapter screen is not up
    update_cam( llg( current_cam ) ) 
    blit_room()

  Else
    '' display a chapter screen
    
    select case as const llg( hero ).chap
    '' allows me to hack black screens!

      case 2
        Put ( 88, 28 ), llg( hero ).anim[llg( hero ).chap]->image
      
    end select
  
  End If

  If llg( do_hud ) <> 0 Then 
    blit_hud()

  End If

  blit_box( varptr( llg( t_rect ) ) )


  handle_MiniMap()

  LLEngine_MouseVanish()

  handle_pause_menu()

	handle_fps()  
  screenQuake()

                                                                                                                                                            antiHackCOMPARE( LL_Global.hero_only.healthDummy, LL_Global.hero.hp )
                                                                                                                                                            antiHackCOMPARE( LL_Global.hero_only.weaponDummy, LL_Global.hero_only.has_weapon )
                                                                                                                                                            antiHackCOMPARE( LL_Global.hero_only.moneyDummy, LL_Global.hero.money )
                                                                                                                                                            antiHackCOMPARE2( LL_Global.hero_only.itemDummy, LL_Global.hero_only.hasItem )
                                                                                                                                                            antiHackCOMPARE2( LL_Global.hero_only.outfitDummy, LL_Global.hero_only.hasCostume )
                                                                                                                                                            antiHackCOMPARE( LL_Global.hero_only.maxhealthDummy, LL_Global.hero.maxhp )
                                                                                                                                                            
                                                                                                                                                            llg( hero_only ).randomizer = int( rnd * 100 )
                                                                                                                                                            llg( hero_only ).randomizer2 = int( rnd * 100 )
                                                                                                                                                          
                                                                                                                                                            antiHackASSIGN( LL_Global.hero_only.healthDummy, LL_Global.hero.hp )
                                                                                                                                                            antiHackASSIGN( LL_Global.hero_only.weaponDummy, LL_Global.hero_only.has_weapon )
                                                                                                                                                            antiHackASSIGN( LL_Global.hero_only.moneyDummy, LL_Global.hero.money )
                                                                                                                                                            antiHackASSIGN2( LL_Global.hero_only.itemDummy, LL_Global.hero_only.hasItem )
                                                                                                                                                            antiHackASSIGN2( LL_Global.hero_only.outfitDummy, LL_Global.hero_only.hasCostume )
                                                                                                                                                            antiHackASSIGN( LL_Global.hero_only.maxhealthDummy, LL_Global.hero.maxhp )
  

End Sub


Sub blit_enemy_loot()


  Dim As Integer enemy_loot, conf
  Dim As vector_pair origin, target


    For enemy_loot = 0 To now_room().enemies - 1

      With now_room().enemy[enemy_loot]
      
        Dim As Integer drop_check = -1, face_check
        
        drop_check And= Not ( .unique_id = u_gold )
        drop_check And= Not ( .unique_id = u_silver )
        drop_check And= Not ( .unique_id = u_health )

        If drop_check = 0 Then 
          Continue For
          
        End If
      
        If drop_check Then
      
          If .dropped <> 0 Then
          
            Put ( .drop->coords.x - llg( this )_room.cx, .drop->coords.y - llg( this )_room.cy ), .drop->anim[.dropped - 1]->image, Trans
            
            target.u.x = .drop->coords.x
            target.u.y = .drop->coords.y
            target.v.x = 8
            target.v.y = 8

            If llg( hero ).anim[llg( hero ).current_anim]->frame[llg( hero ).frame].faces = 0 Then
              
              conf = ( touched_bound_box( varptr( llg( hero ) ), target ) <> -1 )
              
            Else
              
              conf = ( touched_frame_face( varptr( llg( hero ) ), target ) <> -1 )
              
            End If

            If conf Then
            
              Select Case .dropped
              
                Case 1
                  If llg( hero ).hp < llg( hero ).maxhp Then llg( hero ).hp += 1
                  antiHackASSIGN( LL_Global.hero_only.healthDummy, LL_Global.hero.hp )
                  play_sample( llg( snd )[sound_healthgrab] )
                  
                Case 2 
                  llg( hero ).money += ( .n_gold * 5 ) 
                  antiHackASSIGN( LL_Global.hero_only.moneyDummy, LL_Global.hero.money )
                  play_sample( llg( snd )[sound_cashget] )
                  
                Case 3
                  llg( hero ).money += ( .n_silver ) 
                  antiHackASSIGN( LL_Global.hero_only.moneyDummy, LL_Global.hero.money )
                  play_sample( llg( snd )[sound_cashget] )
                      
              End Select
            
              .dropped = 0
              
            End If  
      
          End If
          
        End If

      End With  
  
    Next

End Sub


Sub blit_object( this As char_type Ptr ) Static


    With *this
  

    If .invisible = 0 Then
      
      dim as integer handShake
      handShake = LLObject_CalculateFrame( this[0] )
      With .anim[.current_anim]->frame[handShake]
  
        If .sound <> 0 Then
        
          If this->animControl[this->current_anim].frame[handShake].sound_lock = 0 Then  
            
            Dim As Integer iifCalc
            iifCalc = Int( Rnd * 30 ) + 70
            
            play_sample( llg( snd )[.sound], IIf( .vol <> 0, .vol, iifCalc  ) )
            this->animControl[this->current_anim].frame[handShake].sound_lock = -1
            
          End If
          
        End If
        
      End With  
      
      blit_object_ex( this )
  
    End If

  End With

End Sub                                           

  
Sub blit_hud( e As _char_type Ptr = 0 )

  If e = 0 Then e = Varptr( llg( hero ) )

  Static As Double ll_low_health
  Dim As Integer key_Put

  With *e
    
    hud_BlitMain( e )
    hud_BlitEnemies()
  
    
    scope  
      
      if llg( hero_only ).selected_item = 3 then
        
      
        if llg( hero_only ).has_weapon = 2 then
          ''templewood
          Put( 132, 8 ), llg( hud ).img(1)->image, Trans
          
        elseif llg( now )[1206] then
          ''templewood
          Put( 132, 8 ), llg( hud ).img(8)->image, Trans
          
        elseif llg( now )[470] then
          
          Put( 132, 8 ), llg( hud ).img(7)->image, Trans
        
        else
          Put( 132, 8 ), @llg( hud ).img(1)->image[llg( hero_only ).selected_item * llg( hud ).img(1)->arraysize], Trans
          
        end if
        
      else
        Put( 132, 8 ), @llg( hud ).img(1)->image[llg( hero_only ).selected_item * llg( hud ).img(1)->arraysize], Trans
        
      end if
  
      '' selected item
      
    end scope
      
      

    
    If llg( map )->isDungeon Then
      '' regular key
      
      If llg( hero_only ).b_key <> 0 Then
        Put( 8, 164 ), llg( hud ).img(6)->image, Trans
        
      End If

      For key_Put = 0 To llg( hero ).key - 1
      
        Put( 8 + (key_Put * 8) , 180 ), llg( hud ).img(5)->image, Trans

      Next
    
    End If
  
    '' dollar sign
    Put( 275, 8 ), @llg( hud ).img(2)->image[0], Trans
    
    if .money < 0 then
      .money = 0
      antiHackASSIGN( LL_Global.hero_only.moneyDummy, LL_Global.hero.money )
      
    end if
    
    if .money > 999 then
      .money = 999
      antiHackASSIGN( LL_Global.hero_only.moneyDummy, LL_Global.hero.money )
      
    end if
    
    Scope
    
      Dim mny As String
  
        mny = String( 3 - Len( Str( .money ) ), "0" )
        mny += Str( .money )
        
      Dim As Integer nums
  
        For nums = 0 To 2
        
          Put ( 289 + ( nums Shl 3 ), 8 ), @llg( hud ).img(3)->image[( mny[nums] - 48 ) * llg( hud ).img(3)->arraysize], Trans
'          Put ( 289 + ( nums * 8 ), 8 ), @llg( hud ).img(3).image[( mny[nums] - 48 ) * llg( hud ).img(3).arraysize], Trans
          
        Next
        
    End Scope
    
    
    If .hp <= int( llg( hero ).maxhp / 3 ) Then
    
      If ll_low_health = 0 Then

        play_sample( llg( snd )[sound_lowhealth] )
        
        
  
        ll_low_health = Timer + 1.5
  
        If .hp <= cint( llg( hero ).maxhp / 6.5 ) Then
          ll_low_health = Timer + .75      
  
  
        End If
        
      End If
      
    End If
    
      
    If Timer > ll_low_health Then 
      ll_low_health = 0
      
    End If
  
    if llg( hero_only ).adrenaline = NULL then
      Put( 12, 24 ), llg( hud ).img(4)->image, Trans
      
      Dim As Integer crazy_Ceiling = llg( hero_only ).crazy_points
      If crazy_Ceiling > 100 Then
        crazy_Ceiling = 100
        
      End If
      '' 15, 27
      If ( llg( hero_only ).crazy_points ) > 0 Then
      
        Line( 15, 27 )-( 15 + ( crazy_Ceiling ), 30 ), 26, bf
        
      End If
      
    end if

  End With
    
  
End Sub


Sub blit_box( t_box As boxcontrol_type Ptr )


  #define currentChar() .ptrs.row[.internal.current_line][.internal.opcount]
  
  #macro text_sound()

    If .internal.sound = 0 Then
    
      If currentChar() <> 0 Then

        If currentChar() <> 32 Then
  
          play_sample( llg( snd )[sound_texttemp], 25 )
  
          .internal.sound = -1
          
        End If

      End If
    
    End If
    
  #endmacro
                      
  Dim As Integer lup, s_a_d
    
    With *t_box

      If .internal.hold_box <> 0 Then
      
        If .layout.invis = 0 Then 
          Put( .layout.x_loc, .layout.y_loc ), .ptrs.box->image, Trans
          
        End If
        
        
      End If
      
      If Timer > .internal.hold_box Then
        .internal.hold_box = 0
    
      End If
    
    
      If .activated Then
        '' box active
        If llg( hero )_only.action Then 
          '' pressed space
          If .internal.state <> TEXTBOX_CONFIRMATION Then
            '' not waitin..
            With .internal
            
              Do
                '' jump to the end of this "page" 
                If .current_line = ( .numoflines - 1 ) Then
                  .jump_switch = box_kill_switch
                  Exit Do
                  
                End If
        
                If ( .current_line And 3 ) = 3 Then
                  Exit Do
                  
                End If
                
                .current_line += 1
                
              Loop
              
              .opcount = Len( t_box->ptrs.row[.current_line] ) - 1
              .state = TEXTBOX_CONFIRMATION
            
            End With
            
            llg( hero_only ).action = 0
            
          End If
          
        End If
          
        If Not .layout.invis Then Put(.layout.x_loc, .layout.y_loc), @.ptrs.box->image[0], Trans
    
        Select Case as const .internal.state
        
          Case TEXTBOX_REGULAR
            
            top_rows( t_box )  
            current_row( t_box )  
          
            text_sound()
    
            If .internal.opcount = Len( .ptrs.row[.internal.current_line] ) Then
              '' current char is at the end of the current line.
              If .internal.current_line = ( .internal.numoflines - 1 ) Then
                '' last line of the message
                            
                .internal.opcount -= 1
                .internal.state = TEXTBOX_CONFIRMATION
                .internal.jump_switch = box_kill_switch
                
              else

                If ( .internal.current_line And 3 ) = 3 Then 
                  '' last line of the page
                  .internal.opcount -= 1
                  .internal.state = TEXTBOX_CONFIRMATION
                  .internal.jump_switch = box_jump_back
                  
                else
                  
                  .internal.opcount = 0
                  .internal.current_line += 1
                  
                End If
              
              End If
    
            End If        
    
          
          Case TEXTBOX_CONFIRMATION
    
            top_rows( t_box )
            current_row( t_box )

            If .internal.confBox = TRUE Then
              
              dim as integer fg
              
              fg = llg( fontFG )
              
              
              if .selected = 0 then
                
                __set_font_fg( cast( any ptr, 92 ) )
                
              end if
                
              graphicalString( "Yes", _ 
                               .layout.x_loc + 9 + ( 10 shl 3 ), _ 
                               .layout.y_loc + 8 + ( 3 Shl 4 ), _ 
                               .internal.txtcolor _
                             )
                             
              if .selected = 0 then
                             
                __set_font_fg( cast( any ptr, fg ) )
                if multikey( sc_right ) then
                  
                  .selected = 1
                  
                end if
                
                
              end if               


              if .selected = 1 then
                
                __set_font_fg( cast( any ptr, 92 ) )
                
              end if
              graphicalString( "No", _ 
                               .layout.x_loc + 9 + ( 26 shl 3 ), _ 
                               .layout.y_loc + 8 + ( 3 Shl 4 ), _ 
                               .internal.txtcolor _
                             )

              if .selected = 1 then
                
                __set_font_fg( cast( any ptr, fg ) )
                if multikey( sc_left ) then
                  
                  .selected = 0
                  
                end if
                
              end if

              If multikey( sc_enter ) Then 
      
                .internal.state = TEXTBOX_SHUTDOWN
    
              End If
              
            else
            
              
              If .internal.flashbox = TRUE then

                If( .layout.invis = FALSE ) Then 

                  Put (.layout.x_loc + 304, .layout.y_loc + 64 ), .ptrs.next->image, Trans
                  
                End If

              End if
              
              If Timer >= .internal.flashhook Then 
      
                .internal.flashhook = Timer + .18
                .internal.flashbox = iif( .internal.flashbox = FALSE, TRUE, FALSE )
              
              End If

              If .internal.auto = TRUE Then
      
                If .internal.autohook = NULL Then
                  .internal.autohook = Timer + .internal.autosleep
      
                End If 
                
                If Timer >= .internal.autohook Then 
                  .internal.state = TEXTBOX_SHUTDOWN
                  .internal.autohook = NULL
                  
                End If
      
                
              End If
    
              If llg( hero_only ).action Then 
      
                Select Case as const .internal.jump_switch
    
                  Case box_kill_switch
                    .internal.state = TEXTBOX_SHUTDOWN
      
                  Case box_jump_back
                    .internal.state = TEXTBOX_REGULAR
                    .internal.current_line += 1
                    .internal.opcount = 0
                    
                End Select
    
              End If
  
            End If
            
          Case TEXTBOX_SHUTDOWN
  
            .activated = FALSE
            .internal.hold_box = Timer + .03
            __set_font_fg( cast( any ptr, llg( t_rect ).internal.lastFG ) )
    
        End Select
    
        If .internal.state <> TEXTBOX_CONFIRMATION Then

          If Timer > .layout._timer Then
            .internal.opcount += 1 
            
            .internal.sound = 0
            .layout._timer = Timer + .layout.speed
      
          End If

          dim as integer destroySpace

          do
            #define seekChar(__x__) .ptrs.row[.internal.current_line][.internal.opcount + __x__]
            
            if destroySpace + .internal.opcount = Len( .ptrs.row[.internal.current_line] ) then
              '' hit the end of the line
              exit do
            
            end if
            
            if( seekChar( destroySpace ) <> 0 ) then
            
              if( seekChar( destroySpace ) <> 32 ) then
                '' regular char, increment
                exit do
                
              end if
              
            end if
            
            destroySpace += 1
          
          loop
          
          .internal.opcount += destroySpace
          
        End If
  
      End If
      
    End With
  
End Sub


Sub blit_enemy( _enemy As char_type ) Static
  
 


  With _enemy

    Dim As Integer temp_x_cam, temp_y_cam

    temp_x_cam = 0
    temp_y_cam = 0
    
    If .no_cam = 0 Then

      '' this object is not camera relative
      temp_x_cam = llg( this )_room.cx
      temp_y_cam = llg( this )_room.cy
    
    End If

    If llg( hero ).menu_sel <> 0 Then 
        '' menu showing

      If .unique_id = u_menu Or .unique_id = u_savepoint Then
        '' the menu is the active "enemy" 
        
        llg( box_entity ) = Varptr( _enemy ) 

                    
      End If
      

    Else
      '' no menu
      
      llg( box_entity ) = 0
      
      If .projectile Then

        If .projectile->overChar = FALSE Then
          '' this enemy's projectiles are under it.
          blit_enemy_proj( Varptr( _enemy ) )
  
        End If  
        
      End If

      
      
      If Not ( .unique_id = u_menu ) Then
        '' put the enemy on screen    

        blit_object( VarPtr( _enemy ) )
        
      End If
        

      If .projectile Then

        If .projectile->overChar Then
          '' this enemy's projectiles are over it.
          blit_enemy_proj( Varptr( _enemy ) )
        
        End If  
        
      End If
      
      
      
      If .grult_proj_trig <> 0 Then
        
        Put( .projectile->coords[0].x - llg( this )_room.cx, .projectile->coords[0].y - llg( this )_room.cy ), @.anim[.proj_anim]->image[( .projectile->travelled Mod .anim[.proj_anim]->frames ) * (.anim[.proj_anim]->arraysize)], Trans

      End If

      If .anger_proj_trig <> 0 Then
        
        Put( .projectile->coords[0].x - llg( this )_room.cx, .projectile->coords[0].y - llg( this )_room.cy ), @.anim[.proj_anim]->image[( .projectile->travelled Mod .anim[.proj_anim]->frames ) * (.anim[.proj_anim]->arraysize)], Trans

      End If

      
      If .cur_expl > 0 Then  
        
        Dim As Integer px, py, pf, pa, do_expl

        For do_expl = 0 To .cur_expl - 1
          '' cycle through active explosions
        
          With .explosion( do_expl )
          
            px = .x
            py = .y
            pf = .frame
            pa = .alive
            
          End With
        
          If pa <> 0 Then
            '' this explosion is animating
            
            With *( .anim[.expl_anim] )
              
              Put ( px - temp_x_cam, py - temp_y_cam ), @.image[pf * ( .arraysize )], Trans
              
            End With
  
          End If
          
        Next
          
      End If  

    End If

  End With  
      

End Sub



Sub blit_room() Static


  If llg( tilesDisabled ) = FALSE Then
    If now_room().parallax <> 0 Then
    '' this room uses parallax
    
       Put( 0 - ( llg( this_room ).cx \ 12 ), 0 - ( llg( this_room ).cy \ 12 ) ), @now_room().para_img->image[0]
    
    End If
    
  End If

  Dim As mat_int on_tile, on_offset, optimization_matrix_2                                  
  Dim As Integer save_tile_calcs, save_y_calcs, tile_blit_x, tile_blit_y                                    

  #Macro LLEngine_BlitLayer(lyr)                                                                                                 
                                                                                                                                 
    on_tile.x   = llg( this_room ).cx Shr 4                                                                                      
    on_offset.x = llg( this_room ).cx And &hf                                                                                    
                                                                                                                                 
    on_tile.y   = llg( this_room ).cy Shr 4                                                                                      
    on_offset.y = llg( this_room ).cy And &hf                                                                                    
                                                                                                                                 
    save_tile_calcs = on_tile.y * now_room().x + on_tile.x                                                                       
    save_y_calcs = 0 - on_offset.y                                                                                               
                                                                                                                                 
    For tile_blit_y = 0 To 208 Step llg( map )->tileset->y                                                                       
                                                                                                                                 
      For tile_blit_x = 0 To 320 Step llg( map )->tileset->x                                                                     
                                                                                                                                 
        If ( now_room().layout[ lyr ][ save_tile_calcs ] <> 0 ) Then                                                             
          optimization_matrix_2.y = CPtr( uByte Ptr, Varptr( now_room().layout[lyr][save_tile_calcs] ) )[0]                      
          optimization_matrix_2.x = ( optimization_matrix_2.y Shl 7 ) + ( optimization_matrix_2.y Shl 1 )                        
                                                                                                                                 
          Put( tile_blit_x - on_offset.x, save_y_calcs ), Varptr( llg( map )->tileset->image[optimization_matrix_2.x] ), Trans   
                                                                                                                                 
        End If                                                                                                                   
                                                                                                                                 
        save_tile_calcs += 1                                                                                                     
                                                                                                                                 
      Next                                                                                                                       
                                                                                                                                 
      save_y_calcs += 16                                                                                                         
      save_tile_calcs += now_room().x                                                                                            
      save_tile_calcs -= 21                                                                                                      
                                                                                                                                 
    Next                                                                                                                         
  
  #EndMacro
  
  If llg( tilesDisabled ) = FALSE Then
    '' bottom layers    
    LLEngine_BlitLayer( 0 )      
    LLEngine_BlitLayer( 1 )      
    
  End If
  
  
  '' draw all the entities
  
  blit_y_sorted()

  if llg( hero_only ).healing <> NULL then
    
    put( llg( hero ).coords.x - llg( this_room ).cx, llg( hero ).coords.y - llg( this_room ).cy - 8 ), @llg( hero_only ).healingImage->image[llg( hero_only ).healingImage->arraysize * llg( hero_only ).healingFrame], trans
    
  end if

  blit_enemy_loot()      
  
  
  If llg( tilesDisabled ) = FALSE Then

      '' top layer  
    LLEngine_BlitLayer( 2 )      
    
  End If
  
  If llg( box_entity ) <> 0 Then
    __handle_menu( llg( box_entity ) )
    
  End If


End Sub




Sub blit_y_sorted() Static


  Redim As char_type Ptr y_sort( 0 )
  
  Redim As char_type Ptr srt_Char( 0 )
  Redim As Integer srt_CharNum( 0 )
  Dim As Integer srt_Num, ac
  
  srt_Num = 0
  
  srt_Num += 1 '' enemy bank
  srt_Num += 1 '' temp enemy bank


  
  Redim srt_CharNum( srt_Num - 1 )
  Redim srt_Char( srt_Num - 1 )
  
  srt_CharNum( 0 ) = now_room().enemies
  srt_Char( 0 ) = now_room().enemy
  
  srt_CharNum( 1 ) = now_room().temp_enemies
  srt_Char( 1 ) = @now_room().temp_enemy( 0 )
  

  '' Add concurrents to y-sorting list
  
  Dim As Integer i, it
  For i = 0 To now_room().enemies - 1
    
    If LLObject_IsWithin( Varptr( now_room().enemy[i] ) ) = 0 Then
      Continue For
      
    End If
    
    With now_room().enemy[i]

      If .animControl[.current_anim].frame[.frame].concurrents <> 0 Then

        For it = 0 To .animControl[.current_anim].frame[.frame].concurrents - 1
          '' add one.
          
          srt_Num += 1

          Redim Preserve srt_CharNum( srt_Num - 1 )
          Redim Preserve srt_Char( srt_Num - 1 )

          srt_CharNum( srt_Num - 1 ) = 1

          With .animControl[.current_anim].frame[.frame].concurrent[it]
            srt_Char( srt_Num - 1 ) = .char 

          End With
          
        Next

      End If

    End With

  Next

  ac = sort_index( y_sort(), Varptr( srt_Char( 0 ) ), Varptr( srt_CharNum( 0 ) ), srt_Num )
  
  Dim As Integer _blit_em
  
  For _blit_em = 0 To ac - 1
  
    If LLObject_IsWithin( y_sort( _blit_em ) ) Then
      
      blit_enemy( *y_sort( _blit_em ) )    
      
    End If
    
  Next

End Sub


Sub LLEngine_MouseVanish()

  If fb_MouseOffScreen() Then
    SetMouse , , 1
  Else
    SetMouse , , 0
      
  end if

End Sub



Sub blit_enemy_proj( _enemy As char_type Ptr )

  Dim As Integer show_proj

  With *_enemy

    Select Case .proj_style
  
      Case PROJECTILE_ORB, PROJEcTILE_BEAM

        If .projectile->invisible = 0 Then
          '' this projectile is visible  
          If .projectile->coords[0].x <> 0 Or .projectile->coords[0].y <> 0 Then
            '' this projectile is active
            If .proj_style = PROJECTILE_ORB Then
              '' the projectile is uni-directional
              If ( .projectile->travelled <> 1 ) Then
                '' projectile->travelled has incremented at least twice (once, kind of <.<)
                Put ( .projectile->coords[0].x - llg( this )_room.cx, .projectile->coords[0].y - llg( this )_room.cy ), @.anim[.proj_anim]->image[( .projectile->travelled Mod .anim[.proj_anim]->frames ) * (.anim[.proj_anim]->arraysize)], Trans
                
              End If
              
            ElseIf .proj_style = PROJECTILE_BEAM Then
              '' this projectile changes based on direction
              If ( .projectile->travelled <> 1 ) Or ( .unique_id = u_dyssius ) Or ( .unique_id = u_steelstrider ) Then 
                '' projectile->travelled has incremented at least twice (once, kind of <.<), disregarded for boss 2
                For show_proj = 0 To 1

                  Put ( .projectile->coords[show_proj].x - llg( this )_room.cx, .projectile->coords[show_proj].y - llg( this )_room.cy  ), @.anim[.proj_anim]->image[( .projectile->direction And 1 ) * .anim[.proj_anim]->arraysize], Trans
                  
                Next
              
              End If
              
            End If
            
          End If
          
        End If
        
      Case Else ' PROJECTILE_CROSS, PROJECTILE_DIAGONAL, PROJECTILE_8WAY, PROJECTILE_SCHIZO, PROJECTILE_SPIRAL, PROJECTILE_SUN
  
        For show_proj = 0 To .projectile->projectiles - 1
          '' cycle thru the projectiles
          If .projectile->coords[show_proj].x <> 0 Or .projectile->coords[show_proj].y <> 0  Then
            '' this projectile is active
            If .projectile->invisible = 0 Then
              '' this projectile is visible
              Put ( .projectile->coords[show_proj].x - llg( this )_room.cx, .projectile->coords[show_proj].y - llg( this )_room.cy  ), @.anim[.proj_anim]->image[(.projectile->travelled Mod .anim[.proj_anim]->frames ) * ( .anim[.proj_anim]->arraysize )], Trans
               
            End If
       
          End If
        
        Next
  
    End Select
    
  End With

End Sub


Function sort_index( ary() As char_type Ptr, bank As char_type Ptr Ptr, bank_size As Integer Ptr, banks As Integer ) As Integer Static


  Dim As Integer i, it, j
  Dim As char_type Ptr transfer
  
  j = 0
  For i = 0 To banks - 1
    j += bank_size[i]
  
  Next
  
  j = iif( j = 0, 1, j )
  Redim ary( j - 1 )
  
  j = 0
  For i = 0 To banks - 1

    For it = 0 To bank_size[i] - 1
      
      transfer = Varptr( bank[i][it] )
      If LLObject_IsWithin( transfer ) <> 0 Then 
    
        ary( j ) = transfer
        j += 1
        
      End If
      
    Next
  
  Next
  
  Redim Preserve ary( j )

  ary( j ) = Varptr( llg( hero ) )
  
  mergesort_y( ary() )
  mergesort_placed( ary() )

  Return j + 1
  
End Function

Sub top_rows( b As boxcontrol_type Ptr )


  Dim As Integer line_loop, b_opt

    For line_loop = 1 To b->internal.current_line And 3
      
      b_opt = b->internal.current_line - line_loop 
    
      graphicalString( _ 
                       b->ptrs.row[b_opt], _ 
                       b->layout.x_loc + 9, _ 
                       b->layout.y_loc + 8 + ( ( b_opt And 3 ) Shl 4 ), _ 
                       b->internal.txtcolor _ 
                     )
    Next
    

End Sub


Sub current_row( b As boxcontrol_type Ptr )

  static as string bufferString
  bufferString = "                                    "
  
  dim as integer i
  for i = 0 to 35
    bufferString[i] = asc( " " )
  
  next

  for i = 0 to b->internal.opcount
    bufferString[i] = b->ptrs.row[b->internal.current_line][i]
  
  next

  graphicalString( bufferString, _ 
                   b->layout.x_loc + 9, _ 
                   b->layout.y_loc + 8 + ( ( b->internal.current_line And 3 ) Shl 4 ), _ 
                   b->internal.txtcolor _
                 )

End Sub



Sub blit_object_ex( this As char_type Ptr ) Static

  With *( this )
        
    Dim As Integer f_opt, x_opt, y_opt


      x_opt = .coords.x
      y_opt = .coords.y

      If .no_cam = 0 Then

        x_opt -= llg( this_room ).cx
        y_opt -= llg( this_room ).cy
  
      End If
      
      f_opt = .frame 
      
      With *( .anim[.current_anim] )
                 
        x_opt -= this->animControl[this->current_anim].x_off
        y_opt -= this->animControl[this->current_anim].y_off
        
        f_opt *= .arraysize
                                             
        If LLObject_IgnoreDirectional( this ) = 0 Then 
          f_opt += this->direction * ( this->animControl[this->current_anim].dir_frames * .arraysize )
        
        End If

        Put( x_opt, y_opt ), varptr( .image[f_opt] ), Trans
        
      End With
      
  End With


End Sub
           

Sub hud_BlitMain( this As char_type Ptr )


  With *( this )
      
    Dim As Integer p, x_opt, y_opt
  
      For p = 0 To 29
      
        x_opt = ( ( p Mod 15 ) Shl 3 ) + 8
        y_opt = ( ( p  \  15 ) Shl 3 ) + 8 
  
        If ( .hp  > p )Then 
          Put( x_opt, y_opt ), varptr( llg( hud ).img(0)->image[0] ), Trans 
    
        ElseIf (.maxhp ) > p Then 
          Put( x_opt, y_opt ), varptr( llg( hud ).img(0)->image[34] ), Trans 
    
        Else 
          Put( x_opt, y_opt ), varptr( llg( hud ).img(0)->image[68] ), Trans 
      
        End If
        
      Next

      
  End With


End Sub


Function hud_IsShowing( this As char_type Ptr ) As Integer

  With *( this )

    Dim As Integer dmgd, dying, hpgone, nodead, elit, flick, no_change, show_enemies
  
      dmgd   = .dmg.id <> 0
      dying  = ( .dead = -1 ) And ( ( .unique_id <> u_boss5_right ) And ( .unique_id <> u_boss5_left ) And ( .unique_id <> u_boss5_down ) )
      flick  = .invisible = 0
      hpgone = .hp <= 0 
      nodead = .total_dead = 0
      
      elit   = ( ( .unique_id = u_core ) Imp llg( now )[725] ) And ( .isBoss )' Or ( .unique_id = u_dyssius ) Or ( .unique_id = u_steelstrider ) Or ( .unique_id = u_anger ) Or ( .unique_id = u_sterach ) Or ( .unique_id = u_divine )Or ( .unique_id = u_divine_bug )
'      elit   = ( .unique_id = u_grult ) Or ( .unique_id = u_dyssius ) Or ( .unique_id = u_steelstrider ) Or ( .unique_id = u_anger ) Or ( .unique_id = u_sterach ) Or ( .unique_id = u_divine )Or ( .unique_id = u_divine_bug )
      no_change = llg( hero.switch_room ) = -1
  
      show_enemies = -1
      show_enemies And= ( Not ( .unique_id = u_hotrock ) )
      show_enemies And= ( Not ( .unique_id = u_coldrock ) )
      show_enemies And= ( Not ( .unique_id = u_bush ) ) 
      show_enemies And= ( Not ( .unique_id = u_crate ) ) 
      show_enemies And= ( Not ( .unique_id = u_crate_health ) )
      show_enemies And= ( Not ( .unique_id = u_greyrock ) )
      show_enemies And= ( Not ( .unique_id = u_bombrock ) )
      show_enemies And= ( Not ( .unique_id = u_beetle ) )
      show_enemies And= ( Not ( .unique_id = u_charger ) )
      show_enemies And= ( Not ( .unique_id = u_swordie ) )
      show_enemies And= ( Not ( .unique_id = u_antiwall ) )
      show_enemies And= ( Not ( .unique_id = u_antiwall2 ) )
      show_enemies And= ( Not ( .unique_id = u_goldblock ) )
'      show_enemies And= ( Not ( .unique_id =  ) )
      
                                                                                    
      Return ( ( ( dmgd Or elit Or ( dying And flick And hpgone ) ) And nodead And no_change ) And show_enemies )                                                                                   
      
  End With
      
    
End Function 


Sub hud_BlitEnemy( this As char_type Ptr, ctr As Integer )

  With *( this )

    Dim As Integer p, x_opt, y_opt
    
      For p = 0 To 59

        x_opt = ( ( p Mod 15 ) Shl 3 ) + 8
        y_opt = ( ( p  \  15 ) Shl 3 ) + 8 
  
        If ( .hp ) > p Then 
          Put( x_opt + ( 146 ), y_opt + ( ctr Shl 4 ) ), varptr( llg( hud ).img(0)->image[0] ), Trans 
    
        ElseIf ( .maxhp ) > p Then 
          Put( x_opt + ( 146 ), y_opt + ( ctr Shl 4 ) ), varptr( llg( hud ).img(0)->image[34] ), Trans 
    
        Else 
      
        End If
  
      Next   
      
  End With

    
End Sub


Sub hud_BlitEnemies() Static


  Dim As Integer ctr, dmg_by
  
  ctr = 0
  For dmg_by = 0 To ll_current_room( enemies ) - 1
    
    If LLObject_IsWithin( Varptr( ll_current_room( enemy[dmg_by] ) ) ) = 0 Then
      Continue For

    End If


    If hud_IsShowing( Varptr( ll_current_room( enemy[dmg_by] ) ) ) Then 
      hud_BlitEnemy( Varptr( ll_current_room( enemy[dmg_by] ) ), ctr )
  
      ctr += 1

    End If
  
  Next


End Sub


Sub menu_Blit()
  
  #Define menu_BlitImage(x,y,i) Put( x, y ), .img( i )->image, Trans
  
  With llg( menu )  
    With .menuimages
      Put( 0, 0 ), .img( menu_full_background )->image, Trans
      
      
      If llg( hero_only ).has_weapon >= 0 Then
        If llg( hero_only ).weapon = 0 Then
          menu_BlitImage( 18, 18, menu_sapling_select )
        Else
          menu_BlitImage( 18, 18, menu_sapling )
        End If
      Else
        menu_BlitImage( 18, 18, menu_blankspace )
      End If
      
      If llg( hero_only ).has_weapon >= 1 Then
        If llg( hero_only ).weapon = 1 Then
          menu_BlitImage( 42, 18, menu_mace_select )
        Else
          menu_BlitImage( 42, 18, menu_mace )
        End If
      Else
        menu_BlitImage( 42, 18, menu_blankspace )
      End If
      
      If llg( hero_only ).has_weapon >= 2 Then
        If llg( hero_only ).weapon = 2 Then
          menu_BlitImage( 66, 18, menu_star_select )
        Else
          menu_BlitImage( 66, 18, menu_star )
        End If
      Else
        menu_BlitImage( 66, 18, menu_blankspace )
      End If
      

'      If llg( hero_only ).has_item > 0 Then
      If llg( hero_only ).hasItem( 0 ) Then
        If llg( hero_only ).selected_item = 1 Then 
          menu_BlitImage( 18, 54, menu_flare_select )
        Else
          menu_BlitImage( 18, 54, menu_flare )
        End If
        
      Else
        menu_BlitImage( 18, 54, menu_blankspace )
      End If
      If llg( hero_only ).hasItem( 1 ) Then
        If llg( hero_only ).selected_item = 2 Then 
          menu_BlitImage( 42, 54, menu_ice_select )
        Else
          menu_BlitImage( 42, 54, menu_ice )
        End If
        
      Else
        menu_BlitImage( 42, 54, menu_blankspace )
      End If
      If llg( hero_only ).hasItem( 2 ) Then

        dim as integer currentBridge, currentBridgeSelect
        
        currentBridge = menu_bridge
        currentBridgeSelect = menu_bridge_select
        
        
        if llg( hero_only ).has_weapon = 2 then
        
          currentBridge = menu_blank
          currentBridgeSelect = menu_blank_select

        elseif llg( now )[1206] then
          ''templewood
          currentBridge = menu_bridge3
          currentBridgeSelect = menu_bridge3_select
          
        elseif llg( now )[470] then
          
          currentBridge = menu_bridge2
          currentBridgeSelect = menu_bridge2_select
          
        end if
          
      
        
        If llg( hero_only ).selected_item = 3 Then 
          menu_BlitImage( 66, 54, currentBridgeSelect )
        Else
          menu_BlitImage( 66, 54, currentBridge )
        End If
        
      Else
        menu_BlitImage( 66, 54, menu_blankspace )
      End If
      
      If llg( hero_only ).hasItem( 3 ) Then
        
        dim as integer currentIdol, currentIdolSelect
        
        currentIdol = menu_idol
        currentIdolSelect = menu_idol_select
        
        if llg( now )[1212] then

          currentIdol = menu_blank
          currentIdolSelect = menu_blank_select
          
        end if


        If llg( hero_only ).selected_item = 4 Then 
          menu_BlitImage( 18, 78, currentIdolSelect )
        Else
          menu_BlitImage( 18, 78, currentIdol )
        End If
        
      Else
        menu_BlitImage( 18, 78, menu_blankspace )
      End If  
      If llg( hero_only ).hasItem( 4 ) Then

        If llg( hero_only ).selected_item = 5 Then 
          menu_BlitImage( 42, 78, menu_regen_select )
        Else
          menu_BlitImage( 42, 78, menu_regen )
        End If
        
      Else
        menu_BlitImage( 42, 78, menu_blankspace )
      End If
      If llg( hero_only ).hasItem( 5 ) Then

        If llg( hero_only ).selected_item = 6 Then
          menu_BlitImage( 66, 78, menu_heal_select )
        Else
          menu_BlitImage( 66, 78, menu_heal )
        End If
        
      Else
        menu_BlitImage( 66, 78, menu_blankspace )
      End If




      '' Outfits

      If llg( hero_only ).hasCostume( 0 ) <> 0 Then

        If llg( hero_only ).isWearing = 0 Then 
          menu_BlitImage( 18, 121, menu_standard_select )

        Else
          menu_BlitImage( 18, 121, menu_standard )

        End If

      Else
        menu_BlitImage( 18, 121, menu_blankspace ) 

      End If

      If llg( hero_only ).hasCostume( 1 ) <> 0 Then

        If llg( hero_only ).isWearing = 1 Then 
          menu_BlitImage( 42, 121, menu_cougar_select )

        Else
          menu_BlitImage( 42, 121, menu_cougar )

        End If

      Else
        menu_BlitImage( 42, 121, menu_blankspace )

      End If

                              
      If llg( hero_only ).hasCostume( 2 ) <> 0 Then

        If llg( hero_only ).isWearing = 2 Then 
          menu_BlitImage( 66, 121, menu_lynnity_select )

        Else
          menu_BlitImage( 66, 121, menu_lynnity )

        End If

      Else
        menu_BlitImage( 66, 121, menu_blankspace )

      End If

                              
      If llg( hero_only ).hasCostume( 3 ) <> 0 Then

        If llg( hero_only ).isWearing = 3 Then 
          menu_BlitImage( 18, 157, menu_ninja_select )

        Else
          menu_BlitImage( 18, 157, menu_ninja )

        End If                    

      Else
        menu_BlitImage( 18, 157, menu_blankspace )

      End If

                              
      If llg( hero_only ).hasCostume( 4 ) <> 0 Then

        If llg( hero_only ).isWearing = 4 Then 
          menu_BlitImage( 42, 157, menu_bikini_select )

        Else
          menu_BlitImage( 42, 157, menu_bikini )

        End If                    

      Else
        menu_BlitImage( 42, 157, menu_blankspace )

      End If

                              
      If llg( hero_only ).hasCostume( 5 ) <> 0 Then

        If llg( hero_only ).isWearing = 5 Then 
          menu_BlitImage( 66, 157, menu_rknight_select )

        Else
          menu_BlitImage( 66, 157, menu_rknight )

        End If                    

      Else
        menu_BlitImage( 66, 157, menu_blankspace )

      End If
      


      '' Square Cursors
                              
      
      Select Case As Const llg( menu ).selectedItem
        Case 0

          If llg( hero_only ).has_weapon >= 0 Then
            graphicalString( llg( menu ).menuNames( menu_sapling_select ), 134, 154, 114 )

          End If
          menu_BlitImage( 18, 18 , menu_square_cursor )

        Case 1                   

          If llg( hero_only ).has_weapon >= 1 Then
            graphicalString( llg( menu ).menuNames( menu_mace_select ), 134, 154, 114 )

          End If
          menu_BlitImage( 42, 18 , menu_square_cursor )

        Case 2                   

          If llg( hero_only ).has_weapon >= 2 Then
            graphicalString( llg( menu ).menuNames( menu_star_select ), 134, 154, 114 )

          End If
          menu_BlitImage( 66, 18 , menu_square_cursor )

        Case 3                   

          If llg( hero_only ).hasItem( 0 ) Then
            graphicalString( llg( menu ).menuNames( menu_flare_select ), 134, 154, 114 )

          End If
          menu_BlitImage( 18, 54 , menu_square_cursor )

        Case 4                   

          If llg( hero_only ).hasItem( 1 ) Then
            graphicalString( llg( menu ).menuNames( menu_ice_select ), 134, 154, 114 )

          End If
          menu_BlitImage( 42, 54 , menu_square_cursor )

        Case 5                   

          If llg( hero_only ).hasItem( 2 ) Then

            if llg( hero_only ).has_weapon = 2 then
            
              graphicalString( "Nothing left!", 134, 154, 114 )
    
            elseif llg( now )[1206] then
              ''templewood
              graphicalString( "A sturdy rope.", 134, 154, 114 )

            else
              graphicalString( llg( menu ).menuNames( menu_bridge_select ), 134, 154, 114 )
              
            end if
            
          End If
          menu_BlitImage( 66, 54 , menu_square_cursor )

        Case 6                   

          
          If llg( hero_only ).hasItem( 3 ) Then

            if llg( now )[1212] then
            
              graphicalString( "Gave it away...", 134, 154, 114 )
    
            else
              graphicalString( llg( menu ).menuNames( menu_idol_select ), 134, 154, 114 )
              
            end if
            
          End If
          menu_BlitImage( 18, 78 , menu_square_cursor )

        Case 7                   

          If llg( hero_only ).hasItem( 4 ) Then
            graphicalString( llg( menu ).menuNames( menu_regen_select ), 134, 154, 114 )

          End If
          menu_BlitImage( 42, 78 , menu_square_cursor )

        Case 8                   

          If llg( hero_only ).hasItem( 5 ) Then
            graphicalString( llg( menu ).menuNames( menu_heal_select ), 134, 154, 114 )

          End If
          menu_BlitImage( 66, 78 , menu_square_cursor )

        Case 9

          If llg( hero_only ).hasCostume(0) <> 0 Then
            graphicalString( llg( menu ).menuNames( menu_standard_select ), 134, 154, 114 )

          End If
          menu_BlitImage( 18, 121, menu_square_cursor )

        Case 10

          If llg( hero_only ).hasCostume(1) <> 0 Then
            graphicalString( llg( menu ).menuNames( menu_cougar_select ), 134, 154, 114 )

          End If
          menu_BlitImage( 42, 121, menu_square_cursor )

        Case 11

          If llg( hero_only ).hasCostume(2) <> 0 Then
            graphicalString( llg( menu ).menuNames( menu_lynnity_select ), 134, 154, 114 )

          End If

          menu_BlitImage( 66, 121, menu_square_cursor )

        Case 12

          If llg( hero_only ).hasCostume(3) <> 0 Then

            graphicalString( llg( menu ).menuNames( menu_ninja_select ), 134, 154, 114 )
          End If

          menu_BlitImage( 18, 157, menu_square_cursor )

        Case 13

          If llg( hero_only ).hasCostume(4) <> 0 Then

            graphicalString( llg( menu ).menuNames( menu_bikini_select ), 134, 154, 114 )
          End If

          menu_BlitImage( 42, 157, menu_square_cursor )

        Case 14

          If llg( hero_only ).hasCostume(5) <> 0 Then

            graphicalString( llg( menu ).menuNames( menu_rknight_select ), 134, 154, 114 )
          End If

          menu_BlitImage( 66, 157, menu_square_cursor )

'        Case 15
'          If llg( hero_only ).hasCostume(6) <> 0 Then
'            graphicalString( llg( menu ).menuNames( menu_sapling_select ), 134, 154, 114 )
'          End If
'          menu_BlitImage( 18, 162, menu_square_cursor )
'        Case 16
'          If llg( hero_only ).hasCostume(7) <> 0 Then
'            graphicalString( llg( menu ).menuNames( menu_sapling_select ), 134, 154, 114 )
'          End If
'          menu_BlitImage( 42, 162, menu_square_cursor )
'        Case 17
'          If llg( hero_only ).hasCostume(8) <> 0 Then
'            graphicalString( llg( menu ).menuNames( menu_sapling_select ), 134, 154, 114 )
'          End If
'          menu_BlitImage( 66, 162, menu_square_cursor )

        Case 18

          If llg( hero_only ).has_weapon >= 0 Then
            graphicalString( llg( menu ).menuNames( menu_resume_select ), 134, 154, 114 )

          End If
          menu_BlitImage( 126, 54, menu_resume_select )

        Case 19

          If llg( hero_only ).has_weapon >= 0 Then
            graphicalString( llg( menu ).menuNames( menu_menu_select ), 134, 154, 114 )

          End If
          menu_BlitImage( 126, 90, menu_menu_select )
        
      End Select
      
      

      
      
        
      
    
    
    
    
    End With
    
    
  End With

End Sub


Sub minimap_Blit()
  
  
  Static As Integer color_Current( 9 ) => {36, 38, 40, 41, 43, 44, 43, 41, 40, 38}, index_Current
  Static As Double shiftDelay = .05, shiftTimer
  
  Const As Integer minimap_Offset = 20
  Const As Integer minimap_Size = 160
  
  Dim As Integer floor_Current, i, j, k, eventsAchieved
  floor_Current = llg( minimapFloor )
  
  Dim As Integer gx, gy
  
  Dim As Integer roomX, roomY
  Dim As Integer doorX, doorY
  
  gx = LLMiniMap_SizeX()
  gy = LLMiniMap_SizeY()

  If gx < 320 Then
    gx = ( 320 - gx ) Shr 1
    
  Else
    gx = 0
    
  End If  
  
  If gy < minimap_Size Then
    gy = ( minimap_Size - gy ) Shr 1

  Else
    gy = 0

  End If  
  
  
  graphicalString( llg( dungeonName ), 160 - ( Len( llg( dungeonName ) ) Shl 2 ), 2 )  

  View Screen( 0, 20 )-( 319, 179 )
  For i = 0 To llg( map )->rooms - 1


    With llg( minimap ).room[i]
      
      If .hasVisited Then
      
        If .floor = floor_Current Then
          
          roomX = gx + .location.x - llg( minimap ).camera.x
          roomY = gy + .location.y + minimap_Offset - llg( minimap ).camera.y
          
          If i = llg( this_room ).i Then

            Line( roomX, roomY )-( roomX + llg( map )->room[i].x - 1, roomY + llg( map )->room[i].y - 1 ), color_Current( index_Current ), bf
            If shiftTimer = 0 Then

              index_Current += 1
              If index_Current = 10 Then index_Current = 0
              
              shiftTimer = Timer + shiftDelay
              
            End If
            
            If Timer > shiftTimer Then shiftTimer = 0
  
          Else
            Line( roomX, roomY )-( roomX + llg( map )->room[i].x - 1, roomY + llg( map )->room[i].y - 1 ), 36, bf
            
          End If
          Line( roomX, roomY )-( roomX + llg( map )->room[i].x - 1, roomY + llg( map )->room[i].y - 1 ), 15, b
          
          
          
          For j = 0 To .doors - 1
            
            With .door[j]
              
              doorX = .location.x + roomX
              doorY = .location.y + roomY
              
              If .codes = 0 Then

                Select Case .id
                  
                  Case DOOR_OPEN
                    Line( doorX - 1, doorY - 1 )-( doorX + 1, doorY + 1 ), 36, bf
                  
                  Case DOOR_STAIR
                    Line( doorX - 1, doorY - 1 )-( doorX + 1, doorY + 1 ), 170, bf
                  
                End Select

              Else
                
                eventsAchieved = -1
                For k = 0 To .codes - 1

                  If .code[k] <> -1 Then
                    eventsAchieved And= ( llg( now )[.code[k]] <> 0 )
                    
                  Else
                    eventsAchieved = 0
                    
                  End If
                
                Next
                
                If eventsAchieved <> 0 Then
                  Line( doorX - 1, doorY - 1 )-( doorX + 1, doorY + 1 ), 36, bf
                
                Else
                
                  Select Case .id
                    
                    Case DOOR_LOCKED
                      Line( doorX - 1, doorY - 1 )-( doorX + 1, doorY + 1 ), 15, bf
                    
                    Case DOOR_BARRED
                      Line( doorX - 1, doorY - 1 )-( doorX + 1, doorY + 1 ), 245, bf
                    
                    Case DOOR_FKEYLOCKED
                      Line( doorX - 1, doorY - 1 )-( doorX + 1, doorY + 1 ), 27, bf
                    
                  End Select
                  
                End If
                
              End If
              
            End With
          
          Next
          
          
          
        End If
        
      End If
      
    End With
    
  Next
  View Screen( 0, 0 )-( 319, 199 )

  graphicalString( "Floor dn: [", 8, 182 )
  If floor_Current > -1 Then
    graphicalString( "F" + Str( floor_Current + 1 ), 160 - ( Len( "F" + Str( floor_Current + 1 ) ) Shl 2 ), 182 )    
  Else
    graphicalString( "B" + Str( -floor_Current ), 160 - ( Len( "B" + Str( -floor_Current ) ) Shl 2 ), 182 )    
  End If  
  
  graphicalString( "Floor up: ]", 224, 182 )


End Sub



Sub shift_pal()


  Dim As Integer cols, jmper, res( 255 )

  For cols = 0 To 255
  
    For jmper = 0 To 16 Step 8
      
      res( cols ) Or= Int(                                              _ 
                           (                                            _ 
                             ( 5 - ( llg( dark ) * .66 ) ) / 5          _ 
                           ) *                                          _ 
                             (                                          _ 
                               ( fb_Global.display.pal[cols] Shr jmper ) And &hff _ 
                             )                                          _ 
                         ) Shl( jmper )
      
    Next

  Next

  Palette Using res
    
  
End Sub


Sub screenQuake()
  
  Const As Double frequency = .1
  
  Static As Double tripPosition
  Static As vector tripOffset
  
  If llg( hero_only ).quakeViolence = 0 Then
    Exit Sub
    
  End If
  
  If Timer > tripPosition Then
    
    Dim As Double calcTrip
    tripOffset.x = llg( hero_only ).quakeViolence
    tripOffset.y = llg( hero_only ).quakeViolence
    
    calcTrip = ( Rnd * 3 )
    calcTrip -= 1
    
    tripOffset.x *= calcTrip

    calcTrip = ( Rnd * 3 )
    calcTrip -= 1
    
    tripOffset.y *= calcTrip
    
    tripPosition = frequency + ( Rnd / 3 )
    
  End If
  
  Get( 0, 0 )-( 319, 199 ), llg( menu_ScreenSave )
  Cls
  Put( tripOffset.x, tripOffset.y ), llg( menu_ScreenSave ), Trans
  


End Sub