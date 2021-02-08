require("game.utils")

function LLObject_IgnoreDirectional(this)
--   With *( this )
--     If ( .animating <> 0 ) Then
  if this.animating ~= 0 then
--       Return -1
    return -1
--     End If
  end
--     If ( ( .uni_directional <> 0 ) ) Then
  if this.uni_directional ~= 0 then
-- '      If ( .unique_id <> u_mole ) ) Then
--         Return -1
    return -1
-- '      End If
--     End If
  end
--   End With
  return 0
end

function LLObject_IncrementFrame(this)
  -- '' Increments an object's frame, doesn't fail.
  -- '' Returns a finished state (1) when ".frame"
  -- '' meets the edge of its range, directional
  -- '' or non-diretcional.
  --
  -- Dim As Double tet
  -- With *( this )
  --   If .frame_hold = 0 Then
  if this.frame_hold == 0 then
  --     dim as integer frameTransfer
    local frameTransfer = 0
  --     frameTransfer = LLObject_CalculateFrame( this[0] )
    frameTransfer = LLObject_CalculateFrame(this)
  --     .animControl[.current_anim].frame[frameTransfer].sound_lock = 0
    this.animControl[this.current_anim].frame[frameTransfer].sound_lock = 0
  --     .frame += 1
    this.frame = this.frame + 1
  --     If .frame = IIf( LLObject_IgnoreDirectional( this ), .anim[.current_anim]->frames, .animControl[.current_anim].dir_frames ) Then
    if this.frame == ((LLObject_IgnoreDirectional(this) == -1) and (this.anim[this.current_anim].frames) or (this.animControl[this.current_anim].dir_frames)) then
  --       Return 1
      return 1
  --     End If
    end
  --     With .animControl[.current_anim]
    local with0 = this.animControl[this.current_anim]
  --       tet = IIf( ( this->mad = 0 ) Or ( this->dead ), .rate, .rateMad )
    local tet = iif((this.mad == 0 or this.dead ~= 0), with0.rate, with0.rateMad)
  --     End With
  --     .frame_hold = Timer + tet
    this.frame_hold = timer + tet
  --   End If
  end
  --   If Timer > .frame_hold Then .frame_hold = 0
  if timer > this.frame_hold then
    this.frame_hold = 0
  end
  -- End With
  return 0
end

-- Function __reset_frame ( this As _char_type Ptr ) As Integer
function __reset_frame(this)
--
--   this->frame = 0
  this.frame = 0
--
--   Return 1
  return 1
--
-- End Function
end
