function now_room()
  return map.rooms[curRoom]
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
  --FIXME: We are hacking this to mark a single gcopter object as the only object
  --to make this function return true. We are doing this to narrow the problem space
  --of porting enemy function logic by narrowing it down to a single gcopter enemy.
--data/object/gcopter.xml
  if object.id == "data/object/gcopter.xml" then
    if not foundcopter then
      foundcopter = true
      object.onlycopter = true
    end
  end
  if object.onlycopter == true then
    --log.debug("Running the only copter object.")
    return true
  end
  return false
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
