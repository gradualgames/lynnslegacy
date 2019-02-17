Option Explicit

#Include "..\headers\ll\headers.bi"



Sub LLObject_MAINAttack( _enemies As Integer, _enemy As _char_type Ptr, hr As _char_type Ptr )
   
  '' ASSUMES: hr->anim[hr->current_anim] contains an attacking anim'.
  '' 
  '' Fixes...
  '' 
  '' Use LLObject_Collision(), change to return multiple collisions
  '' then iterate through, and check for invincible

  Dim As Integer enemy_collide
  Dim As Integer hero_faces, check_fields
  Dim As vector_pair origin, target
  
    For enemy_collide = 0 To _enemies - 1
      '' cycle thru enemies to compare
      
      
      _enemy[enemy_collide].frame_check = LLObject_CalculateFrame( _enemy[enemy_collide] )
      
      hr->frame_check = LLObject_CalculateFrame( hr[0] )
  
      If _enemy[enemy_collide].dead = 0 Then
        '' this entity is still alive
  
        If _enemy[enemy_collide].dmg.id = 0 Then
          '' this entity is unharmed
  
          For hero_faces = 0 To hr->anim[hr->current_anim]->frame[hr->frame_check].faces - 1
            '' cycle thru hero's mace faces
               
            '' hero vector pair
            origin = LLO_VPE( hr, OV_FACE, hero_faces )

            If _enemy[enemy_collide].anim[_enemy[enemy_collide].current_anim]->frame[_enemy[enemy_collide].frame_check].faces = 0 Then
              '' this enemy has only one box

              '' enemy's vector pair
              target = LLO_VP( Varptr( _enemy[enemy_collide] ) )
              With _enemy[enemy_collide]
                
                If check_bounds( origin, target ) = 0 Then
                  
                  If _enemy[enemy_collide].unique_id = u_pmouth Then
                    
                    
                    If _enemy[enemy_collide].funcs.active_state = 0 Then
                      _enemy[enemy_collide].impassable = 0
                      LLObject_ShiftState( Varptr( _enemy[enemy_collide] ), 1 )
                      
                    End If
                  
                  
                  ElseIf _enemy[enemy_collide].unique_id = u_boss5_crystal Then
                    
                    
                    If _enemy[enemy_collide].funcs.active_state = 0 Then
'                      _enemy[enemy_collide].impassable = 0
                      LLObject_ShiftState( Varptr( _enemy[enemy_collide] ), 1 )
                      
                      '' possible vguard spawn
                      
                    End If
                  
                  Else
                
                    '' hero's mace connected with this entity
                    .dmg.id = DF_MAIN_CHAR
                    .dmg.index = 0
  
                    LLObject_DamageCalc( Varptr( _enemy[enemy_collide] ) ) 
      
                    If .dmg.id <> 0 Then   
                    '' ignore the rest of the faces.
                      Exit For               
                                             
                    End If                   
                      
                  end if
                  
                End If

              End With
              
            Else
              '' enemy has multiple boxes
        
              For check_fields = 0 To _enemy[enemy_collide].anim[_enemy[enemy_collide].current_anim]->frame[_enemy[enemy_collide].frame_check].faces - 1
                '' cycle thru this entity's boxes
                
                '' enemy's vector pair
                target = LLO_VPE( Varptr( _enemy[enemy_collide] ), OV_FACE, check_fields ) 
                
                If check_bounds( origin, target ) = 0 Then 
                
                  '' ONLY jumps out if the face is not invincible!
                  With _enemy[enemy_collide]
                  With .anim[.current_anim]->frame[.frame_check].face[check_fields]

                    If .invincible = 0 Then
                      _enemy[enemy_collide].dmg.id       = DF_MAIN_CHAR
                      _enemy[enemy_collide].dmg.index    = 0
                      _enemy[enemy_collide].dmg.specific = check_fields 
      
                      LLObject_DamageCalc( Varptr( _enemy[enemy_collide] ) ) 
        
                      If _enemy[enemy_collide].dmg.id <> 0 Then   
                      '' ignore the rest of the objects.
                        Exit For               
                                               
                      End If                   
                      
                    End If
                    
                  End With
                  End With

                End If
            
              Next
                 
              If _enemy[enemy_collide].dmg.id <> 0 Then 
                '' there was a hit, so jmp the rest of heros frames for this enemy
                
                Exit For
                
              End If
                
            End If
          
          Next

        End If
      
      End If
  
      
      With _enemy[enemy_collide]
      
        If .heal_me <> 0 Then
        
          .hp = .maxhp
          
        End If
        
      End With
  
    
    Next
  
   


End Sub





Sub LLObject_DeriveHurt( h As char_type Ptr )

  Select Case h->dmg.id
  
    Case DF_ROOM_ENEMY
      
      With now_room().enemy[h->dmg.index]
      
        If .anim[.current_anim]->frame[.frame_check].faces = 0 Then
          h->hurt = .strength  
          
        Else
          h->hurt = .anim[.current_anim]->frame[.frame_check].face[h->dmg.specific].strength
          
        End If
      
      End With


    Case DF_TEMP_ENEMY
      
      With now_room().temp_enemy( h->dmg.index )
      
        If .anim[.current_anim]->frame[.frame_check].faces = 0 Then
          h->hurt = .strength  
          
        Else
          h->hurt = .anim[.current_anim]->frame[.frame_check].face[h->dmg.specific].strength
          
        End If
      
      End With

      
    Case DF_ROOM_ENEMY Or DF_PROJ
      
      With now_room().enemy[h->dmg.index]
      
        h->hurt = .projectile->strength

      End With
      
      
    Case DF_MAIN_CHAR
    
'        With _enemy[enemy_collide]
      
      If llg( hero_only ).powder <> 0 Then
        '' sprinkling powder

        If h->invincible <> 0 Then
          '' this enemy is invincible
          
          If llg( hero_only ).selected_item = 1 Then
            '' flare powder selected.
            
            If h->fire_weak <> 0 Then
              '' this enemy is only vulnerable to fire

              If h->torch <> 0 Then
                '' this is a torch
                
                If h->funcs.current_func[h->funcs.active_state] = 0 Then
                  '' torch isn't currently lit                              
                
                  h->jump_timer = 0
                  
                  LLObject_ShiftState( h, h->hit_state )
                  
                  
                End If

              Else
                ''destroy it
                h->hp = 0
                
              End If
              
            End If
            
          Else
            '' ice powder selected

          
            If h->ice_weak <> 0 Then 
              '' this enemy is only destroyable by ice
              
              If h->torch <> 0 Then
                '' this is a torch                             
                
                If ( h->funcs.active_state = h->hit_state ) Then
                  '' torch is currently lit                              
                
                  h->jump_timer = 0

                  LLObject_ShiftState( h, h->reset_state )

                  
                End If
                

              Else
                                    
              
                ''destroy it
                h->hp = 0
                
              End If
              
            End If                                                    
            
          End If
        
          
          '' reset enemy damage flags
          LLObject_ClearDamage( h )
          Exit Sub

        Else
          '' entity is not invincible
        
        
          If llg( hero_only ).selected_item = 1 Then
            '' flare powder selected
            
            
            If h->fire_weak <> 0 Then 
              '' knocked back and stunned with fire powder
              

              If h->melt = 0 Then
                '' it's not a frozen bush

                LLObject_ShiftState( h, h->fire_state )
                LLObject_ClearDamage( h )
                
              Else
                '' thaw the frozen bush
              
                LLObject_ShiftState( h, h->thaw_state )
                LLObject_ClearDamage( h )


              End If

              h->fly = V2_CalcFlyback( _ 
                                        V2_MidPoint( LLObject_VectorPair( h ) ), _ 
                                        V2_MidPoint( LLObject_VectorPair( Varptr( llg( hero ) ) ) ) _ 
                                      )
              
              LLObject_ClearDamage( h )
            

            Else
              '' not susceptible
            
              LLObject_ClearDamage( h )
              
            End If

            
          Else
          

            If h->ice_weak <> 0 Then
              '' ice powder freezes this entity 

              LLObject_ShiftState( h, h->ice_state )
              
              If h->unique_id = u_bush Then 
                '' it's a bush

                h->melt = 1
                LLObject_ClearDamage( h )
                
              End If
              
              h->hurt = 0
              


              h->fly = V2_CalcFlyback( _ 
                                       V2_MidPoint( LLObject_VectorPair( h ) ), _ 
                                       V2_MidPoint( LLObject_VectorPair( Varptr( llg( hero ) ) ) ) _
                                     )
              LLObject_ClearDamage( h )

            Else
              '' not susceptible
            
              LLObject_ClearDamage( h )
              
            End If                                                    
            
          End If
          
        End If

      Else
        '' attacking normally

        If h->invincible <> 0 Then
          '' current enemy is invincible
                                  
                                  
          If llg( hero_only ).weapon >= 1 Then
            '' hero's weapon is mace or better 
            If h->mace_weak <> 0 Then
              '' this entity dies from a mace or better weapon hit.

              h->hp = 0
              LLObject_ClearDamage( h )
              
            End If
          
          End If

          If llg( hero_only ).weapon >= 2 Then 
            '' hero's weapon is the divius star
            If h->star_weak <> 0 Then
              '' this entity dies from a hit with the star
              h->hp = 0
              LLObject_ClearDamage( h )
              
            End If
          
          End If
          
        End If
        

        If h->anim[h->current_anim]->frame[h->frame_check].faces = 0 Then
          '' enemy only has one bound
            
          If h->invincible = 0 Then 
            '' enemy is not invincible
            
            If  ( ( h->mace_weak ) Imp ( llg( hero_only ).weapon >= 1 ) ) And _ 
                ( ( h->star_weak ) Imp ( llg( hero_only ).weapon >= 2 ) ) Then
              '' Imp-i-fied
              
              h->hurt = ( 2 ^ ( llg( hero_only ).weapon ) ) * IIf( llg( hero ).psycho <> 0, 2, 1 )
              
              if llg( hero_only ).adrenaline <> 0 then
                select case as const llg( hero_only ).weapon
                  case 0
                    h->hurt += 1
                  case 1
                    h->hurt += 1
                  case 2
                    h->hurt += 2
                end select
                
              end if

              
            End If
            
            
          End If
            
            
        Else
          '' enemy has multiple faces
        


          If h->anim[h->current_anim]->frame[h->frame_check].face[h->dmg.specific].invincible = 0 Then 
            '' entity face is not invincible
            
            If  ( ( h->mace_weak <> 0 ) Imp ( llg( hero_only ).weapon >= 1 ) ) _ 
            And ( ( h->star_weak <> 0 ) Imp ( llg( hero_only ).weapon >= 2 ) ) Then

              h->hurt = ( 2 ^ ( llg( hero_only ).weapon ) ) * IIf( llg( hero ).psycho <> 0, 2, 1 )

              if llg( hero_only ).adrenaline <> 0 then
                select case as const llg( hero_only ).weapon
                  case 0
                    h->hurt += 1
                  case 1
                    h->hurt += 1
                  case 2
                    h->hurt += 2
                end select
                
              end if

              
              
            End If 
            
          End If
          
          '' reset face  
          h->dmg.specific = 0
          
        End If



        
      End If
      
'        End With
    
      
  End Select

End Sub     


Sub LLObject_ProcessHurt( h As char_type Ptr )



  h->hp -= h->hurt
  '' take away the damage from the hp .
  
  if h->unique_id = u_lynn then
    antiHackASSIGN( LL_Global.hero_only.healthDummy, LL_Global.hero.hp )
    
  end if
    
  
  If h->hurt < 0 Then
    '' reset damaged status.
    LLObject_ClearDamage( h )
    Exit Sub

  End If
  
  
  Dim As vector flyback
  Dim As vector_pair origin, target
  
  If h->hp > 0 Then
    '' lynn's still alive. 
    

    Select Case h->dmg.id
    
      Case DF_ROOM_ENEMY
        
        with now_room().enemy[h->dmg.index]
          If .anim[.current_anim]->frame[.frame_check].faces = 0 Then
            origin = LLObject_VectorPair( @now_room().enemy[h->dmg.index] ) 
            
          Else
          
            origin.u.x = .coords.x
            origin.u.y = .coords.y
            
            with .animControl[.current_anim]

              origin.u.x -= .x_off
              origin.u.y -= .y_off
              
            end with
            
            with .anim[.current_anim]->frame[.frame_check]

              with .face[h->dmg.specific]
                origin.u.x += .x
                origin.u.y += .y
                origin.v.x = .w
                origin.v.y = .h
                
              end with
              
            end with
            
          End If
          
        end with

        
      Case DF_TEMP_ENEMY
        origin = LLObject_VectorPair( @now_room().temp_enemy( h->dmg.index ) ) 
    
        
      Case DF_ROOM_ENEMY Or DF_PROJ
      
        With now_room().enemy[h->dmg.index]

          origin.u.x = .projectile->coords[h->dmg.specific].x
          origin.u.y = .projectile->coords[h->dmg.specific].y
          origin.v.x = .anim[.proj_anim]->x
          origin.v.y = .anim[.proj_anim]->y
          
        End With
        
      Case DF_TEMP_ENEMY Or DF_PROJ
    
        With now_room().temp_enemy( h->dmg.index )
    
          origin.u.x = .projectile->coords[h->dmg.specific].x
          origin.u.y = .projectile->coords[h->dmg.specific].y
          origin.v.x = .anim[.proj_anim]->x
          origin.v.y = .anim[.proj_anim]->y
          
        End With
        
        
      Case DF_MAIN_CHAR
  
        Dim As Integer unhurt_enemies = -1
        unhurt_enemies = -1
      
        unhurt_enemies And= ( Not ( h->unique_id = u_bush ) ) 
        unhurt_enemies And= ( Not ( h->unique_id = u_crate ) ) 
        unhurt_enemies And= ( Not ( h->unique_id = u_crate_health ) )
        unhurt_enemies And= ( Not ( h->unique_id = u_greyrock ) )
        unhurt_enemies And= ( Not ( h->unique_id = u_bombrock ) )
        unhurt_enemies And= ( Not ( h->unique_id = u_goldblock ) )
        
        If unhurt_enemies <> 0 Then                                                    
          llg( hero_only ).crazy_cache += IIf( llg( hero_only ).isWearing = 2, 20, 10 )
          
        End If
        
        If ( h->unique_id = u_anger ) Or ( h->unique_id = u_sterach ) Then
          h->shifty_state = 0
          h->hit = -1
        
        Else
          
          LLObject_ShiftState( h, h->hit_state )
          origin = LLO_VP( @llg( hero ) ) 
          If h->unique_id = u_dyssius Then
            h->fly_count = 0
            
          End If
          If h->unique_id = u_steelstrider Then
            h->fly_count = 0
            
          End If
          If h->unique_id = u_grult Then 
            h->fly_count = 0
            
          End If
          If h->unique_id = u_divine Then 
            h->fly_count = 0
            
          End If
          If (h->unique_id = u_dyssius) or (h->unique_id = u_anger) Then
            h->shifty_state = 0
            h->slide_hold   = 0 
            
          end if
          
          
        End If
            
  
    End Select

    If h->unique_id = u_lynn Then
'      If h->dmg.id = DF_ROOM_ENEMY Then
        If now_room().enemy[h->dmg.index].unique_id <> u_beetle Then
          Dim As Integer lynn_yell
          lynn_yell = CInt( sound_lynn_hurt_1 ) + Int( Rnd * 3 )

          play_sample( llg( snd )[lynn_yell], 50 )
          
        End If
        
'      End If

    Else
      
      If h->hit_sound <> 0 Then
         
        #IfDef ll_audio
'          If h->hit_sound_vol <> 0 Then
            play_sample( llg( snd )[h->hit_sound], IIf( h->hit_sound_vol <> 0, h->hit_sound_vol, 100 ) )
            
'          End If
          
        #EndIf
      
      End If
      
    End If

    flyback = V2_CalcFlyback( V2_MidPoint( LLO_VP( h ) ), V2_MidPoint( origin ) )
    
    If llg( hero ).psycho <> 0 Then
      
      If h->unique_id <> u_lynn Then
      
        flyback = V2_CalcFlyback( V2_MidPoint( LLO_VP( h ) ), V2_MidPoint( origin ) )
        flyback = V2_Scale( flyback, 4 )
        
      End If
      
    End If
    
    If ( h->unique_id <> u_anger ) And ( h->unique_id <> u_grult ) Then
      '' his fireballs are affected by fly_?, and he doesn't fly back.
      h->fly = flyback
      
    End If
    

  Else
    '' hp is 0 or below, dead.
    
    If h->dead = 0 Then
      '' first time initialization.

      If h->dead_sound <> 0 Then

        If h->unique_id <> u_lynn Then
          play_sample( llg( snd )[h->dead_sound] )

        else
          play_sample( llg( snd )[h->dead_sound], 30 )
            
        End If
        
      End If

      if h->unique_id = u_battleseed then
        now_room().enemy[2].hp = 0
      	
      end if
      
      LLObject_ClearProjectiles( *h )
      LLObject_ShiftState( h, h->death_state )  

      h->dead = 1
      h->fade_time = .07
      
    End If
    
    '' reset damaged status.
    LLObject_ClearDamage( h )
   
  End If

End Sub


Sub LLObject_DamageCalc( h As _char_type Ptr )

  With *h



    LLObject_DeriveHurt( h )
    
    If .hurt <> 0 Then
      '' got hurt.
      If h->dmg.id = DF_ROOM_ENEMY Then
      
        If( now_room().enemy[h->dmg.index].unique_id = u_gshape ) _
                                   Or                             _
          ( now_room().enemy[h->dmg.index].unique_id = u_bshape ) Then
    
          __make_dead( Varptr( now_room().enemy[h->dmg.index] ) )
          __cripple( Varptr( now_room().enemy[h->dmg.index] ) )
          
        End If
        
        If ( now_room().enemy[h->dmg.index].unique_id = u_beetle ) Then
          
          With now_room().enemy[h->dmg.index]
            
            .hp = 0
            
            LLObject_ShiftState( Varptr( now_room().enemy[h->dmg.index] ), now_room().enemy[h->dmg.index].death_state )  
      
            now_room().enemy[h->dmg.index].dead = 1
            now_room().enemy[h->dmg.index].fade_time = .07
            
            play_sample( llg( snd )[.dead_sound], IIf( .dead_sound_vol <> 0, .dead_sound_vol, 100 ) )
            
          End With
          
          dim as integer saveIndex
          saveIndex = h->dmg.index

          h->hurt = 0
          LLObject_ClearDamage( h )
          
          h->dmg.index = saveIndex
          
        End If
      
      End If
      
      LLObject_ProcessHurt( h )
  
    Else
      '' took 0 damage.
    
      '' reset damaged status.
      LLObject_ClearDamage( h )

    End If
  
    .frame_check = 0

  End With

End Sub


Sub LLObject_ProjectileDamage( _objects As Integer, _object As _char_type Ptr, h As _char_type Ptr )


  Dim As Integer chk_proj, do_stuff
  
  Dim As vector_pair origin, target

  For do_stuff = 0 To _objects - 1
    '' loop through all objects
    
    With _object[do_stuff]
    
      If ( .dead = 0 ) Or ( .unique_id = u_ibug ) Or ( .unique_id = u_fbug ) Then
    
        If .projectile Then

          If ( .projectile->active <> 0 ) Or _ 
             ( .unique_id = u_dyssius ) Or ( .unique_id = u_steelstrider ) Or _ 
             ( .unique_id = u_grult     ) Or _ 
             ( .unique_id = u_anger     ) Then   

            For chk_proj = 0 To .projectile->projectiles - 1
              
              origin.u = .projectile->coords[chk_proj]
              origin.v.x = .anim[.proj_anim]->x           
              origin.v.y = .anim[.proj_anim]->y           
                                                          
              target.u = h->coords                        
              target.v = h->perimeter                     
              
              If check_bounds( origin, target ) = 0 Then 
                
                Select Case h->unique_id                                  
                                                                          
                  Case u_boss5_left, u_boss5_right, u_boss5_down                                             
                                                                          
                    If .unique_id = h->unique_id Then                                         
                                                                          
                      If h->shifty Then                                   
                                                                          
                        LLObject_ShiftState( h, h->hit_state )                                         
                        LLObject_ClearProjectiles( _object[do_stuff] )                           
                                                                          
                        h->hp -=1                                         
                        .shifty = 0                                         
                                                                          
                      End If                                              
                                                                          
                    End If                                                
                                                                          
                    Continue For                                          
                                                                          
                                                                          
                  Case u_boss5_crystal                                                
                                                                          
                    If h->funcs.active_state = 1 Then                     
                                                                          
                      LLObject_ShiftState( h, 2 )                                         
                                                                                             
                      .projectile->direction += 2                           
                      .projectile->direction And= 3                       
                                                                          
                      Swap .projectile->coords[0], .projectile->coords[1]    
                                                                          
                      LLObject_IncrementProjectiles( _object[do_stuff] )                                          
                                                                          
                      .shifty = -1                                        
                                                                          
                    Else                                                  
                                                                          
                      If .unique_id <> u_boss5_crystal Then                                         
                        LLObject_ClearProjectiles( _object[do_stuff] )                           
                                                                          
                      End If                                              
                                                                          
                    End If                                                
                                                                          
                    Continue For                                          
                                                                          
                                                                          
                  Case u_beamcrystal                                                
                                                                          
                    LLObject_ClearProjectiles( _object[do_stuff] )                           
                                                                          
                                                                          
                  Case Else                                               
                                                                          
                    If h->dmg.id = 0 Then                                 
                      h->dmg.id       = DF_ROOM_ENEMY Or DF_PROJ                
                      h->dmg.index    = do_stuff                             
                      h->dmg.specific = chk_proj                          
                                                                          
                      LLObject_DamageCalc( h )                            
                      If h->dmg.id <> 0 Then                              
                        Exit Sub                                          
                                                                          
                      End If                                              
                                                                          
                    End If                                                
                                                                          
                End Select                                                
                
              End If
      
            Next
      
          End If  
          
        End If
      
      End If
  
    End With
  
  Next

 
End Sub



Sub LLObject_ObjectDamage( _enemies As Integer, _enemy As _char_type Ptr, hr As _char_type Ptr, e_type As Integer = DF_ROOM_ENEMY )

  If hr->invincible <> 0 Then Exit Sub
  
  Dim As Integer enemy_collide, check_fields
  Dim As vector_pair origin

  For enemy_collide = 0 To _enemies - 1
    '' loop through all enemies in this room.

    With _enemy[enemy_collide]
      
      If LLObject_IsWithin( Varptr( _enemy[enemy_collide] ) ) = 0 Then
        Continue For
      
      End If
        
      
      If .strength = 0 Then
        Continue For
        
      End If

      .frame_check = LLObject_CalculateFrame( _enemy[enemy_collide] )

      If .anim[.current_anim]->frame[.frame_check].faces = 0 Then
        '' this enemy only has a single box boundary.

        If check_bounds( LLObject_VectorPair( Varptr( _enemy[enemy_collide] ) ), _ 
                         LLObject_VectorPair( hr ) ) = 0 Then
          
          '' hit by the current enemy.
          hr->dmg.id    = e_type
          hr->dmg.index = enemy_collide
           
          LLObject_DamageCalc( hr ) 

          If hr->dmg.id <> 0 Then   
          '' ignore the rest of the objects.
            Exit For               
                                   
          End If                   
          
        End If
          

      Else
        '' this enemy has multiple box boundaries.
        
  
        For check_fields = 0 To .anim[.current_anim]->frame[.frame_check].faces - 1
          '' loop thru all of the current enemy's box boundaries.
          
          origin = LLO_VPE( Varptr( _enemy[enemy_collide] ), OV_FACE, check_fields )
          
          If check_bounds( origin, LLObject_VectorPair( hr ) ) = 0 Then
            '' got damaged by the object that owns this face. 

            hr->dmg.id       = e_type
            hr->dmg.index    = enemy_collide
            hr->dmg.specific = check_fields

            LLObject_DamageCalc( hr ) 

            If hr->dmg.id <> 0 Then   
            '' ignore the rest of the objects.
              Exit For               
                                     
            End If                   
  
          End If 
               
        Next 
          
      End If
  
    End With

  Next 

End Sub


Sub LLObject_MAINDamage( hr As _char_type Ptr )

  
  If hr->invincible <> 0 Then Exit Sub
  
  With now_room()

    If ( hr->dmg.id = 0 ) Then
      LLObject_ProjectileDamage( .enemies, .enemy, hr )

    End If
      If ( hr->dmg.id = 0 ) Then
        LLObject_ObjectDamage( .enemies, .enemy, hr, DF_ROOM_ENEMY )        

      End If    
        If ( hr->dmg.id = 0 ) Then
          LLObject_ObjectDamage( .temp_enemies, @.temp_enemy( 0 ), hr, DF_TEMP_ENEMY )
  
        End If

      

  End With  


End Sub





Sub LLObject_ClearDamage( h As char_type Ptr )

  h->hurt         = 0
  
  h->dmg.id       = 0
  h->dmg.index    = 0
  h->dmg.specific = 0

End Sub
