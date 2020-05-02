Option Explicit


#Define llg(__x__) ll_global.##__x__
#Define ll_current_room(__x__) llg( map )->room[llg( this_room ).i].##__x__ 
#define stillPlaying() ( llg( xxyxx ) = 0 )
#Define now_room() llg( map )->room[llg( this_room ).i]

#define healthFormula ( 50 + ( ( llg( hero ).maxhp - 6 ) * 5 ) )

#Define tile_char_on(c)                                                                                                 _
                                                                                                                        _
  IIf( c.coords.y > -1, ( ( c.coords.y + ( c.perimeter.y \ 2 ) ) \ llg( map )->tileset->y ) * ll_current_room( x ), 0 ) _ 
  +                                                                                                                     _ 
  IIf( c.coords.x > -1, ( ( c.coords.x + ( c.perimeter.x \ 2 ) ) \ llg( map )->tileset->x ), 0 )

'' #EndDefine tile_char_on



#Define check_ice(c)                                                  _                                                                                    
                                                                      _                                                                                    
  If Bit( ll_current_room( layout[0][tile_char_on( c )] ), 8 ) Then : _
    c.on_ice = -1                                                   : _                                                                                    
                                                                    : _                                                                                    
  End If

'' #EndDefine check_ice



#Define rl_key()                             _
                                             _
  (                                          _ 
    (                                        _ 
      MultiKey( ll_global.l_key.code )       _ 
    )                                        _ 
      Or (                                   _ 
            MultiKey( ll_global.r_key.code ) _ 
         )                                   _ 
  )

'' #EndDefine rl_key



#Define ud_key()                             _
                                             _
  (                                          _ 
    (                                        _ 
      MultiKey( ll_global.u_key.code )       _ 
    )                                        _ 
      Or (                                   _
            MultiKey( ll_global.d_key.code ) _ 
         )                                   _ 
  )

'' EndIf ud_key



#Define in_dir_small(__d) _ 
  __d = IIf( __d < 0, 3, IIf( __d > 3, 0, __d ) )
  
'' #EndDefine in_dir_small



#macro reveal()                  
                                 
  Palette Using fb_Global.display.pal

  Flip
  
#Endmacro



#Define quad_calc(x,y)                          _
                                                _
  ( ( Abs( y And 1 ) Shl 1 ) + Abs( x And 1 ) ) 
  

'' #EndDefine quad_calc


#Define set_debug() llg( catch_dbg ) = Not 0
#Define debug_off() llg( catch_dbg ) = 0


#Define debug_checkpoint()                                                    _
  If llg( catch_dbg ) Then                                                :_
    ? "passed line <" & __Line__ & "> in function <" & __Function__ & ">" :_
    reveal()                                                              :_
                                                                          :_
  End If
  


#Define LLImage_FromName(x) LLSystem_ImageDeref( LLSystem_ImageDerefName( x ) )


#macro quick_text(__x__) 

  ? __x__                

  reveal()           
  Sleep              
  
#endmacro


#Define LLO_VPE LLObject_VectorPairEx
#Define LLO_VP LLObject_VectorPair


#Define LLMiniMap_CenterX() ( llg( miniMap ).room[llg( this_room ).i].loc_x + ( llg( miniMap ).room[llg( this_room ).i].x Shr 1 ) ) 
#Define LLMiniMap_CenterY() ( llg( miniMap ).room[llg( this_room ).i].loc_y + ( llg( miniMap ).room[llg( this_room ).i].y Shr 1 ) ) 

#Define hero_OnFloor() ( llg( miniMap ).room[llg( this_room ).i].floor ) 




#Define obj_XInBound(__THISCHAR__) _                                                                  
  ( Abs( IIf( (__THISCHAR__)->no_cam = 0, llg( this_room ).cx, 0 ) + 160 - (__THISCHAR__)->coords.x ) < ( 200 + (__THISCHAR__)->anim[(__THISCHAR__)->current_anim]->x ) ) 

#Define obj_YInBound(__THISCHAR__) _                                                                  
  ( Abs( IIf( (__THISCHAR__)->no_cam = 0, llg( this_room ).cy, 0 ) + 100 - (__THISCHAR__)->coords.y ) < ( 150 + (__THISCHAR__)->anim[(__THISCHAR__)->current_anim]->y ) )

#Define obj_NoProjectile(__THISCHAR__) ( (__THISCHAR__)->proj_style = 0 )

#Define LLObject_IsWithin(__THISCHAR__) ( iif( (__THISCHAR__)->isBoss, -1, IIf( obj_NoProjectile(__THISCHAR__), IIf( obj_XInBound(__THISCHAR__) And obj_YInBound(__THISCHAR__), -1, 0 ), -1 ) ) )


#Define LLObject_CalculateFrame(__THISCHAR__) ( IIf( __THISCHAR__##.uni_directional = 0, __THISCHAR__##.frame + ( __THISCHAR__##.direction And 3 ) * __THISCHAR__##.animControl[__THISCHAR__##.current_anim].dir_frames, __THISCHAR__##.frame ) )


#Define LLObject_isTouching(__CHR_X__,__CHR_Y__)                                                     _ 
                                                                                                     _
    (                                                                                                _ 
      check_bounds(                                                                                  _ 
                    LLObject_VectorPair( Varptr( __CHR_X__ ) ),                                      _ 
                    Type <vector_pair> (                                                             _ 
                                         V2_Subtract( __CHR_Y__.coords,    Type <vector> ( 1, 1 ) ), _ 
                                         V2_Add     ( __CHR_Y__.perimeter, Type <vector> ( 2, 2 ) )  _
                                       )                                                             _
                  )                                                                                  _ 
    )



#macro antiHackASSIGN( __array, __vari )

  __array( 0 ) = __vari
  __array( 1 ) = __vari * ( ( llg( hero_only ).randomizer ) * 2 )
  __array( 2 ) = __vari * ( ( llg( hero_only ).randomizer ) * 3 )
  __array( 3 ) = __vari * __vari
  
#endmacro

#macro antiHackASSIGN2( __array, __vari )
  
  scope
    dim as integer i_
    for i_ = 0 to 5
      __array( i_, 0 ) = __vari( i_ )
      __array( i_, 1 ) = __vari( i_ ) * ( ( llg( hero_only ).randomizer2 ) * 2 )
      __array( i_, 2 ) = __vari( i_ ) * ( ( llg( hero_only ).randomizer2 ) * 3 )
      __array( i_, 3 ) = __vari( i_ ) * __vari( i_ )
      
    next
    
  end scope
  
#endmacro

#macro antiHackCOMPARE( __array, __vari )

  scope

    dim as integer allGood
    
    allGood = TRUE
    allGood and= ( __array( 0 ) = __vari          )
    allGood and= ( __array( 1 ) = __vari * ( ( llg( hero_only ).randomizer ) * 2 )    )
    allGood and= ( __array( 2 ) = __vari * ( ( llg( hero_only ).randomizer ) * 3 )    )
    allGood and= ( __array( 3 ) = __vari * __vari )
    
    if allGood = FALSE then end
      
  end scope
  
#endmacro
  
#macro antiHackCOMPARE2( __array, __vari )

  scope
    dim as integer i
    dim as integer allGood
    
    for i = 0 to 5
    
      allGood = TRUE
      allGood and= ( __array( i, 0 ) = __vari( i )          )
      allGood and= ( __array( i, 1 ) = __vari( i ) * ( ( llg( hero_only ).randomizer2 ) * 2 )    )
      allGood and= ( __array( i, 2 ) = __vari( i ) * ( ( llg( hero_only ).randomizer2 ) * 3 )    )
      allGood and= ( __array( i, 3 ) = __vari( i ) * __vari( i ) )
      
      if allGood = FALSE then end
        
    next
      
  end scope
  
#endmacro
  
