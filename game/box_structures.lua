require("game/image_structures")

-- Type boxlayout_type
function create_boxlayout_type()
--
  local boxlayout_type = {}
--   invis As Byte' if set, box is invisible.
  boxlayout_type.invis = 0
--
--   x_loc As Integer
  boxlayout_type.x_loc = 0
--   y_loc As Integer
  boxlayout_type.y_loc = 0
--
--   speed As Double
  boxlayout_type.speed = 0.0
--   _timer As Double
  boxlayout_type._timer = 0.0
--
  return boxlayout_type
-- End Type
end
--
-- Type boxpointer_type
function create_boxpointer_type()
--
  local boxpointer_type = {}
--   box As LLSystem_ImageHeader Ptr' box itself.
  boxpointer_type.box = create_LLSystem_ImageHeader()
--   Next As LLSystem_ImageHeader Ptr' the flashy arrow.
  boxpointer_type.Next = create_LLSystem_ImageHeader()
--
--   row As String Ptr' the text, broken into formatted lines.
  boxpointer_type.row = {}
--
  return boxpointer_type
-- End Type
end
--
-- Type boxinternal_type
function create_boxinternal_type()
--
  local boxinternal_type = {}
--   state As Integer' state of the box engine (0-3).
  boxinternal_type.state = 0
--
--   opcount As Integer' counts total iterations.
  boxinternal_type.opcount = 0
--   current_line As uShort' current processed line.
  boxinternal_type.current_line = 0
--   jump_switch As Integer' jump off point.
  boxinternal_type.jump_switch = 0
--   numoflines As Integer' total number of formatted lines.
  boxinternal_type.numoflines = 0
--
--   flashhook As Double' stores hooked node, for flash.
  boxinternal_type.flashhook = 0.0
--   flashbox As Byte' actual arrow state.
  boxinternal_type.flashbox = 0
--
--   auto As Byte' take keypress or auto.
  boxinternal_type.auto = 0
--   autohook As Double' destination node.
  boxinternal_type.autohook = 0.0
--   autosleep As Double' how long to actually disply the box before closing.
  boxinternal_type.autosleep = 0.0
--
--   hold_box As Double
  boxinternal_type.hold_box = 0.0
--   sound As Integer
  boxinternal_type.sound = 0
--
--   txtcolor As Integer' hmMmm
  boxinternal_type.txtcolor = 0
--
--   confBox as integer
  boxinternal_type.confBox = 0
--
--   as integer lastFG', lastBG
  boxinternal_type.lastFG = 0
--
  return boxinternal_type
-- End Type
end
--
-- Type boxcontrol_type
function create_boxcontrol_type()
--
  local boxcontrol_type = {}
--   internal As boxinternal_type
  boxcontrol_type.internal = create_boxinternal_type()
--   ptrs As boxpointer_type
  boxcontrol_type.ptrs = create_boxpointer_type()
--   layout As boxlayout_type
  boxcontrol_type.layout = create_boxlayout_type()
--   activated As Byte 'Ptr
  boxcontrol_type.activated = 0
--
--   selected as Ubyte
  boxcontrol_type.selected = 0
--
--
  return boxcontrol_type
-- End Type
end
--
--
