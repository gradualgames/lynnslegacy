require("game.engine_etc")
require("game.utils")

--#Define now_room() llg( map )->room[llg( this_room ).i]
function now_room()
  return ll_global.map.room[ll_global.this_room.i]
end

-- #define stillPlaying() ( llg( xxyxx ) = 0 )
function stillPlaying()
  return ll_global.xxyxx == 0
end

function LLObject_CalculateFrame(this)
--( IIf( __THISCHAR__##.uni_directional = 0,
--__THISCHAR__##.frame + ( __THISCHAR__##.direction And 3 ) * __THISCHAR__##.animControl[__THISCHAR__##.current_anim].dir_frames,
--__THISCHAR__##.frame ) )
  if this.uni_directional == 0 then
    return this.frame + (this.direction % 4) * this.animControl[this.current_anim].dir_frames
  else
    return this.frame
  end
end

-- #Define obj_XInBound(__THISCHAR__) _
function obj_XInBound(__THISCHAR__)
--   ( Abs( IIf( (__THISCHAR__)->no_cam = 0, llg( this_room ).cx, 0 ) + 160 - (__THISCHAR__)->coords.x ) < ( 200 + (__THISCHAR__)->anim[(__THISCHAR__)->current_anim]->x ) )
  return math.abs(iif(__THISCHAR__.no_cam == 0, ll_global.this_room.cx, 0) + 160 - __THISCHAR__.coords.x) < (200 + __THISCHAR__.anim[__THISCHAR__.current_anim].x)
end
--
-- #Define obj_YInBound(__THISCHAR__) _
function obj_YInBound(__THISCHAR__)
--   ( Abs( IIf( (__THISCHAR__)->no_cam = 0, llg( this_room ).cy, 0 ) + 100 - (__THISCHAR__)->coords.y ) < ( 150 + (__THISCHAR__)->anim[(__THISCHAR__)->current_anim]->y ) )
  return math.abs(iif(__THISCHAR__.no_cam == 0, ll_global.this_room.cy, 0) + 100 - __THISCHAR__.coords.y) < (150 + __THISCHAR__.anim[__THISCHAR__.current_anim].y)
end
--
-- #Define obj_NoProjectile(__THISCHAR__) ( (__THISCHAR__)->proj_style = 0 )
function obj_NoProjectile(__THISCHAR__)
  return __THISCHAR__.proj_style == 0
end

--#Define LLObject_IsWithin(__THISCHAR__) ( iif( (__THISCHAR__)->isBoss, -1, IIf( obj_NoProjectile(__THISCHAR__), IIf( obj_XInBound(__THISCHAR__) And obj_YInBound(__THISCHAR__), -1, 0 ), -1 ) ) )
function LLObject_IsWithin(__THISCHAR__)
  return iif(__THISCHAR__.isBoss ~= 0, -1, iif(obj_NoProjectile(__THISCHAR__), iif(obj_XInBound(__THISCHAR__) and obj_YInBound(__THISCHAR__), -1, 0), -1))
end

-- #Define LLObject_isTouching(__CHR_X__,__CHR_Y__)                                                     _
function LLObject_isTouching(__CHR_X__, __CHR_Y__)
--                                                                                                      _
  local vector1, vector2 = get_next_vector(), get_next_vector()
  vector1.x = 1
  vector1.y = 1
  vector2.x = 2
  vector2.y = 2
  local vector_pair = get_next_vector_pair()
  vector_pair.u = V2_Subtract(__CHR_Y__.coords, vector1)
  vector_pair.v = V2_Add(__CHR_Y__.perimeter, vector2)
--     (                                                                                                _
  return (
--       check_bounds(                                                                                  _
    check_bounds(
--                     LLObject_VectorPair( Varptr( __CHR_X__ ) ),                                      _
      LLObject_VectorPair(__CHR_X__),
--                     Type <vector_pair> (                                                             _
--                                          V2_Subtract( __CHR_Y__.coords,    Type <vector> ( 1, 1 ) ), _
      vector_pair
--                                          V2_Add     ( __CHR_Y__.perimeter, Type <vector> ( 2, 2 ) )  _
--                                        )                                                             _
--                   )                                                                                  _
      )
--     )
  )
end


function quad_calc(x, y)
-- #Define quad_calc(x,y)                          _
--                                                 _
--   ( ( Abs( y And 1 ) Shl 1 ) + Abs( x And 1 ) )
  return math.abs(bit.lshift(bit.band(y, 1), 1)) + math.abs(bit.band(x, 1))
--
--
-- '' #EndDefine quad_calc
end

-- #Define tile_char_on(c)                                                                                                 _
function tile_char_on(c)
--                                                                                                                         _
--   IIf( c.coords.y > -1, ( ( c.coords.y + ( c.perimeter.y \ 2 ) ) \ llg( map )->tileset->y ) * ll_current_room( x ), 0 ) _
  return iif(c.coords.y > -1, math.floor((c.coords.y + math.floor(c.perimeter.y / 2)) / ll_global.map.tileset.y) * now_room().x, 0)
--   +                                                                                                                     _
    +
--   IIf( c.coords.x > -1, ( ( c.coords.x + ( c.perimeter.x \ 2 ) ) \ llg( map )->tileset->x ), 0 )
         iif(c.coords.x > -1, math.floor((c.coords.x + math.floor(c.perimeter.x / 2)) / ll_global.map.tileset.x), 0)
--
-- '' #EndDefine tile_char_on
end

-- #Define check_ice(c)
function check_ice(c)
--                                                                       _
--   If Bit( ll_current_room( layout[0][tile_char_on( c )] ), 8 ) Then : _
  if testbit(now_room().layout[0][tile_char_on(c) + 1], 8) ~= 0 then
--     c.on_ice = -1                                                   : _
    c.on_ice = -1
--                                                                     : _
--   End If
  end
--
-- '' #EndDefine check_ice
end

-- #Define quad_calc(x,y)                          _
function quad_calc(x, y)
--                                                 _
--   ( ( Abs( y And 1 ) Shl 1 ) + Abs( x And 1 ) )
  --return math.abs(bit.lshift(bit.band(y, 1), 1) + math.abs(bit.band(x, 1)))
  return bit.lshift(math.abs(bit.band(y, 1)), 1) + math.abs(bit.band(x, 1))
--
--
-- '' #EndDefine quad_calc
end

-- #Define in_dir_small(__d) _
-- NOTE: Changed this to return the result rather than modify the parameter.
function in_dir_small(d)
--   __d = IIf( __d < 0, 3, IIf( __d > 3, 0, __d ) )
  return (d < 0) and 3 or ((d > 3) and 0 or d)
-- '' #EndDefine in_dir_small
end

-- #Define rl_key()                             _
function rl_key()
--                                              _
--   (                                          _
--     (                                        _
--       MultiKey( ll_global.l_key.code )       _
--     )                                        _
--       Or (                                   _
--             MultiKey( ll_global.r_key.code ) _
--          )                                   _
--   )
  return input:down("left") or input:down("right")
--
-- '' #EndDefine rl_key
end

-- #Define ud_key()                             _
function ud_key()
--                                              _
--   (                                          _
--     (                                        _
--       MultiKey( ll_global.u_key.code )       _
--     )                                        _
--       Or (                                   _
--             MultiKey( ll_global.d_key.code ) _
--          )                                   _
--   )
--
-- '' EndIf ud_key
  return input:down("up") or input:down("down")
end

LLO_VPE = LLObject_VectorPairEx
LLO_VP = LLObject_VectorPair

--#define healthFormula ( 50 + ( ( llg( hero ).maxhp - 6 ) * 5 ) )
function healthFormula()
  return (50 + ((ll_global.hero.maxhp - 6) * 5))
end
