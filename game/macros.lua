require("game/engine--etc")

--#Define now_room() llg( map )->room[llg( this_room ).i]
function now_room()
  return ll_global.map.room[ll_global.this_room.i]
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

--#Define LLObject_IsWithin(__THISCHAR__) ( iif( (__THISCHAR__)->isBoss, -1, IIf( obj_NoProjectile(__THISCHAR__), IIf( obj_XInBound(__THISCHAR__) And obj_YInBound(__THISCHAR__), -1, 0 ), -1 ) ) )
function LLObject_IsWithin(object)
  --TODO: Actually port this when it becomes relevant.
  return true
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

-- #Define check_ice(c)
function check_ice(c)
--                                                                       _
--   If Bit( ll_current_room( layout[0][tile_char_on( c )] ), 8 ) Then : _
--     c.on_ice = -1                                                   : _
--                                                                     : _
--   End If
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
  return love.keyboard.isDown("left") or love.keyboard.isDown("right")
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
  return love.keyboard.isDown("up") or love.keyboard.isDown("down")
end

LLO_VPE = LLObject_VectorPairEx
LLO_VP = LLObject_VectorPair
