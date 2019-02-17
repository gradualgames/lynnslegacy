Option Explicit

#Include "..\headers\ll\headers.bi"




Function LLObject_LocationVector( o As char_type Ptr ) As vector

  With *o
  
  
    Return Type( .coords.x, .coords.y )
    
  End With
  
End Function


Function LLObject_VectorPair( o As char_type Ptr ) As vector_pair

   Dim As vector_pair res
   
   res.u =  o->coords
   res.v = o->perimeter
   
   Return res
    
  
End Function

Function LLObject_VectorPairEx( o As char_type Ptr, op As Integer = 0, par As Integer = 0 ) As vector_pair
  
  Dim As vector_pair res
  
  Select Case op
  
  Case OV_ONEBOX

    Return Type <vector_pair> ( o->coords, o->perimeter )
    
  Case OV_FACE
  
    res.u = o->coords
    With o->animControl[o->current_anim]    
      res.u.x -= .x_off
      res.u.y -= .y_off
      
    End With

    With *( o->anim[o->current_anim] )
      
      With .frame[o->frame_check]
        With .face[par]

          res.u.x += .x
          res.u.y += .y
          res.v.x = .w
          res.v.y = .h
      
        End With
      End With
      
    End With
      
    

    Return res
  
  End Select
  
End Function


Sub LLObject_ShiftState( h As char_type Ptr, s As Integer )

  h->funcs.current_func[h->funcs.active_state] = 0
  h->funcs.active_state = s
  h->funcs.current_func[h->funcs.active_state] = 0

End Sub










