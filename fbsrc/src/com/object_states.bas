Option Explicit

#Include "..\headers\ll\headers.bi"


Function __do_nothing ( this As _char_type Ptr ) As Integer


  Return 1    
  

 
End Function
 


 
Function __cond_trigger_projectile ( this As _char_type Ptr ) As Integer


  

  Dim As Integer per
  
  per = Int ( Rnd * 10 )
  
  If per >= 2 Then this->projectile->active = this->proj_style
 

  Return 1

 
End Function


 
Function __infinity ( this As _char_type Ptr ) As Integer
  
  Return 0

End Function


Function __lunge ( this As _char_type Ptr ) As Integer
  
  Dim As Integer x_move, y_move
  
  

  If this->walk_hold = 0 Then

 
      If ( llg( hero ).coords.y + ( llg( hero ).perimeter.y \ 2 )) > ( this->coords.y + ( this->perimeter.y \ 2 )) Then y_move = 1 Else If  ( llg( hero ).coords.y + ( llg( hero ).perimeter.y \ 2 )) < ( this->coords.y + ( this->perimeter.y \ 2 )) Then y_move = -1
  
      If y_move = -1 Then this->direction = 0
      If y_move = 1 Then this->direction = 2
  
      If y_move <> 0 Then  move_object( this )

     If ( llg( hero ).coords.x + ( llg( hero ).perimeter.x \ 2 )) > ( this->coords.x + ( this->perimeter.x \ 2 )) Then x_move = 1 Else If  ( llg( hero ).coords.x + ( llg( hero ).perimeter.x \ 2 )) < ( this->coords.x + ( this->perimeter.x \ 2 )) Then x_move = -1
    
      If x_move = -1 Then this->direction = 3
      If x_move = 1 Then this->direction = 1
  
      If x_move <> 0 Then move_object( this )


    this->walk_steps +=  1

    If this->walk_steps = this->walk_length Then 

      this->walk_hold = 0

      this->walk_steps = 0
      Return 1
      
    End If
      



    this->walk_hold = Timer + this->mad_walk_speed



    
  Else
  

    If Timer >= this->walk_hold Then this->walk_hold = 0

    
  End If
      

End Function



Function __lunge_return ( this As _char_type Ptr ) As Integer

  Dim As Integer x_move, y_move  
  

  If this->walk_hold = 0 Then

 
      If this->y_origin > this->coords.y Then y_move = 1 Else If  this->y_origin < this->coords.y  Then y_move = -1
  
      If y_move = -1 Then this->direction = 0
      If y_move = 1 Then this->direction = 2
  
      If y_move <> 0 Then  move_object( this )

      If this->x_origin > this->coords.x Then x_move = 1 Else If  this->x_origin < this->coords.x  Then x_move = -1
    
      If x_move = -1 Then this->direction = 3
      If x_move = 1 Then this->direction = 1
  
      If x_move <> 0 Then move_object( this )



    If this->coords.x = this->x_origin And this->coords.y = this->y_origin Then 
'      this->direction = this->stand_dir

      this->walk_hold = 0

      this->mad = 0
      Return 1
      
    End If
      


    this->walk_hold = Timer + this->walk_speed


    
  Else
  

    If Timer >= this->walk_hold Then this->walk_hold = 0

    
  End If
      

End Function




Function __trigger_projectile ( this As _char_type Ptr ) As Integer


  this->projectile->active = this->proj_style

  Return 1

 
End Function


