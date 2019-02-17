Option Explicit
#Include "..\headers\ll.bi"

Function LLObject_IgnoreDirectional( this As char_type Ptr ) As Integer


  With *( this )
    
    If ( .animating <> 0 ) Then
      Return -1
      
    End If
    
    If ( ( .uni_directional <> 0 ) ) Then

'      If ( .unique_id <> u_mole ) ) Then
        Return -1
        
'      End If
      
    End If

  End With


End Function

Function LLObject_IncrementFrame( this As char_type Ptr ) As Integer

  '' Increments an object's frame, doesn't fail.
  '' Returns a finished state (1) when ".frame"
  '' meets the edge of its range, directional
  '' or non-diretcional.

  Dim As Double tet

  With *( this )


    If .frame_hold = 0 Then
      
      dim as integer frameTransfer
      frameTransfer = LLObject_CalculateFrame( this[0] )
      .animControl[.current_anim].frame[frameTransfer].sound_lock = 0
    
      .frame += 1
      
      If .frame = IIf( LLObject_IgnoreDirectional( this ), .anim[.current_anim]->frames, .animControl[.current_anim].dir_frames ) Then 
        Return 1
        
      End If
      
      With .animControl[.current_anim]
        tet = IIf( ( this->mad = 0 ) Or ( this->dead ), .rate, .rateMad )
        
      End With
      
      .frame_hold = Timer + tet
      
      
    End If
    
    If Timer > .frame_hold Then .frame_hold = 0
  
  
  End With


End Function




Function __reset_frame ( this As _char_type Ptr ) As Integer
  
  this->frame = 0
  
  Return 1    
 
End Function


