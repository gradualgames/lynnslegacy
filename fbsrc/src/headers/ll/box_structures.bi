Type boxlayout_type

  invis As Byte' if set, box is invisible.

  x_loc As Integer
  y_loc As Integer

  speed As Double
  _timer As Double

End Type

Type boxpointer_type

  box As LLSystem_ImageHeader Ptr' box itself.
  Next As LLSystem_ImageHeader Ptr' the flashy arrow.

  row As String Ptr' the text, broken into formatted lines.

End Type

Type boxinternal_type

  state As Integer' state of the box engine (0-3).

  opcount As Integer' counts total iterations.
  current_line As uShort' current processed line. 
  jump_switch As Integer' jump off point.
  numoflines As Integer' total number of formatted lines.

  flashhook As Double' stores hooked node, for flash.
  flashbox As Byte' actual arrow state.

  auto As Byte' take keypress or auto.
  autohook As Double' destination node.
  autosleep As Double' how long to actually disply the box before closing.

  hold_box As Double
  sound As Integer
  
  txtcolor As Integer' hmMmm
  
  confBox as integer
  
  as integer lastFG', lastBG

End Type
  
Type boxcontrol_type

  internal As boxinternal_type
  ptrs As boxpointer_type
  layout As boxlayout_type
  activated As Byte 'Ptr
  
  selected as Ubyte
  
  
End Type


