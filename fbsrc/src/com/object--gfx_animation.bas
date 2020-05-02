Option Explicit

#Include "..\headers\ll\headers.bi"

Function __active_animate ( this As _char_type Ptr ) As Integer


  this->animating = 1

  If LLObject_IncrementFrame( this ) <> 0 Then


      this->frame -= 1

      this->frame_hold = Timer + this->animControl[this->current_anim].rate

      this->animating = 0

      Return 1
      
   End If

 
End Function     

Function __active_animate_x ( this As _char_type Ptr ) As Integer


  this->animating = 1

  If LLObject_IncrementFrame( this ) <> 0 Then


    this->frame -= 1

    this->frame_hold = Timer + this->animControl[this->current_anim].rate

    this->animating = 0

    Return 1
    
  End If

 
End Function     



Function __dead_animate ( this As _char_type Ptr ) As Integer


  this->animating = 1
  
  If LLObject_IncrementFrame( this ) <> 0 Then


    this->frame -= 1

    this->frame_hold = Timer + this->animControl[this->current_anim].rate

    this->animating = 0
    
    Function = 1

  End If
    
End Function
 

Function __directional_animate ( this As _char_type Ptr ) As Integer

  '' no "animating" for direction
  If LLObject_IncrementFrame( this ) <> 0 Then

    this->frame -= 1

    this->frame_hold = Timer + this->animControl[this->current_anim].rate
    Return 1

  End If
  
 
End Function     



Function __directional_animate_x ( this As _char_type Ptr ) As Integer


  If LLObject_IncrementFrame( this ) <> 0 Then
    
    this->frame = 0
    this->frame_hold = Timer + this->animControl[this->current_anim].rate

    Return 1

  End If


End Function     


Function __idle_animate ( this As _char_type Ptr ) As Integer
  
  this->animating = 1


  If LLObject_IncrementFrame( this ) <> 0 Then

    this->animating = 0

    this->frame = 0
    this->frame_hold = Timer + this->animControl[this->current_anim].rate

    Function = 1
    
  End If


End Function


Function __true_active_animate ( this As _char_type Ptr ) As Integer


  this->animating = 1

  If LLObject_IncrementFrame( this ) <> 0 Then

    this->animating = 0

    this->frame = 0
    this->frame_hold = Timer + this->animControl[this->current_anim].rate

  End If
    
  Return 1

 
End Function     




Function __explode_lynn( this As _char_type Ptr ) As Integer
  
  Static As Integer explo
  
  If explo = 0 Then
    play_sample( llg( snd )[sound_explosion] )
    explo += 1
    
  End If
  
  
  
  this->coords.x = llg( hero ).coords.x - 24
  this->coords.y = llg( hero ).coords.y - 24

  If LLObject_IncrementFrame( this ) <> 0 Then

    this->frame = 0
    this->frame_hold = Timer + this->animControl[this->current_anim].rate
    explo = 0
    Return 1
    
  End If


End Function
