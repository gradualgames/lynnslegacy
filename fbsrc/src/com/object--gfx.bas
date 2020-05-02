Option Explicit

#Include "..\headers\ll\headers.bi"




Function __flicker ( this As _char_type Ptr ) As Integer


  
  If this->flash_timer = 0 Then
    '' flash timer is initialized
    
    this->invisible = IIf( this->invisible = 0, -1, 0 )
    
    this->flash_timer = Timer + this->flash_time
    this->flash_count += 1
    
    
  End If
    
    
  If Timer >= this->flash_timer Then 
    '' flash timer has expired, initialize it
    
    this->flash_timer = 0
    
  End If
    
    
  If this->flash_count >= this->flash_length Then
    '' flash counter filled up
  
    '' reset  damage flags
    this->flash_count = 0
    this->flash_timer = 0 
    this->invisible = 0
'    LLObject_ClearDamage( this )
'    this->damaged_by = -1

    Return 1

  End If
  
  If this->dead <> 0 then

    If this->isBoss Or ( this->unique_id = u_charger ) Or ( this->unique_id = u_swordie ) Then '( this->unique_id = u_grult ) Or ( this->unique_id = u_dyssius ) Or ( this->unique_id = u_steelstrider ) Or ( this->unique_id = u_anger ) Or ( this->unique_id = u_sterach ) Or ( this->unique_id = u_swordie ) Or ( this->unique_id = u_divine ) Or ( this->unique_id = u_divine_bug ) Then 
      Return 1
      
    End If
        
  End If


 
End Function



Function __flashy ( this As _char_type Ptr ) As Integer

  If this->flash_timer = 0 Then
    '' flash timer is initialized
  
    this->invisible = Not this->invisible
    this->flash_timer = Timer + this->flash_time
    this->flash_count += 1
    
    
  End If
    
    
  If Timer >= this->flash_timer Then 
    '' flash timer has expired, initialize it
    
    this->flash_timer = 0
    
  End If
    
    
  If this->flash_count >= this->flash_length Then
  
    '' reset damage & flash flags
    this->flash_count = 0
    this->flash_timer = 0 
    this->invisible = 0
    
    this->dmg.id = 0
    If this->unique_id <> u_pekkle_grey Then
    
      LLObject_ClearDamage( this )
      
    End If


  End If
  
  Return 0

End Function




Function __weapon_anim ( this As _char_type Ptr ) As Integer
  this->current_anim = llg( hero_only ).weapon + 3 
  this->frame = 0

  Return 1

 
End Function


Function __active_anim_1 ( this As _char_type Ptr ) As Integer


  this->current_anim = 1  
  this->frame = 0

  Return 1

 
End Function


Function __active_anim_2 ( this As _char_type Ptr ) As Integer

  this->current_anim = 2  
  this->frame = 0

  Return 1

 
End Function


Function __active_anim_3 ( this As _char_type Ptr ) As Integer


  this->current_anim = 3  
  this->frame = 0

  Return 1

 
End Function


Function __active_anim_4 ( this As _char_type Ptr ) As Integer
  this->current_anim = 4  
  this->frame = 0

  Return 1

 
End Function


Function __active_anim_5 ( this As _char_type Ptr ) As Integer
  this->current_anim = 5  
  this->frame = 0

  Return 1

 
End Function


Function __active_anim_6 ( this As _char_type Ptr ) As Integer
  this->current_anim = 6  
  this->frame = 0

  Return 1

 
End Function


Function __active_anim_7 ( this As _char_type Ptr ) As Integer
  this->current_anim = 7  
  this->frame = 0

  Return 1

 
End Function


Function __active_anim_8 ( this As _char_type Ptr ) As Integer
  this->current_anim = 8  
  this->frame = 0

  Return 1

 
End Function


Function __active_anim_9 ( this As _char_type Ptr ) As Integer
  this->current_anim = 9  
  this->frame = 0

  Return 1

 
End Function


Function __active_anim_10 ( this As _char_type Ptr ) As Integer
  this->current_anim = 10  
  this->frame = 0

  Return 1

 
End Function


Function __active_anim_0 ( this As _char_type Ptr ) As Integer
  

  this->current_anim = 0  
  this->frame = 0

  Return 1

 
End Function


Function __active_anim_dead ( this As _char_type Ptr ) As Integer
  

  this->frame = 0
  this->current_anim = this->dead_anim

  Return 1

 
End Function





Function __explode ( this As _char_type Ptr ) As Integer

  If this->expl_timer = 0 Then

    this->cur_expl += 1
    If this->cur_expl >= this->explosions Then 
      this->cur_expl = this->explosions
    Else
      
    End If

    this->expl_timer = Timer + this->expl_delay + ( Rnd * .1 )
    
  End If
  
  If Timer >= this->expl_timer Then this->expl_timer = 0

  Dim As Integer do_expl

  For do_expl = 0 To this->cur_expl - 1
    
    
    If ( this->explosion( do_expl ).x = 0 ) And ( this->explosion( do_expl ).y = 0 ) Then
      
      this->explosion( do_expl ).alive = -1
      
      Dim As Integer _xo = this->expl_x_off, _yo = this->expl_y_off, _xs = this->expl_x_size, _ys = this->expl_y_size
      
      this->explosion( do_expl ).x = this->coords.x + _xo - ( ( this->anim[this->expl_anim]->x ) \ 2 ) '(this->coords.x + this->animControl[this->current_anim].x_off ) + _xo
      this->explosion( do_expl ).y = this->coords.y + _yo - ( ( this->anim[this->expl_anim]->y ) \ 2 ) '(this->coords.y + this->animControl[this->current_anim].y_off ) + _yo
      
      
      If _xs <> 0 Then
        this->explosion( do_expl ).x += Int(Rnd * _xs)
        
      Else
        this->explosion( do_expl ).x += Int(Rnd * this->perimeter.x)
        
      End If

      If _ys <> 0 Then
        this->explosion( do_expl ).y += Int(Rnd * _ys)
        
      Else
        this->explosion( do_expl ).y += Int(Rnd * this->perimeter.y)
        
      End If

    End If

    If this->explosion( do_expl ).alive <> 0 Then

      If this->explosion( do_expl ).frame <= Int( Rnd * this->anim[this->expl_anim]->frames ) Then

        If this->explosion( do_expl ).sound = 0 Then

          this->explosion( do_expl ).sound = -1

          play_sample( llg( snd )[sound_explosion], 70 )
            
          
        End If
          
      End If
    
      If this->explosion( do_expl ).frame_hold = 0 Then
      
        this->explosion( do_expl ).frame += 1
        
        If this->explosion( do_expl ).frame = this->anim[this->expl_anim]->frames Then 
          this->explosion( do_expl ).frame = 0
          this->explosion( do_expl ).alive = 0
          
        End If

        this->explosion( do_expl ).frame_hold = Timer + this->animControl[this->expl_anim].rate
        
      End If

      If Timer >= this->explosion( do_expl ).frame_hold Then 
        this->explosion( do_expl ).frame_hold = 0
        
      End If

    End If
  
  Next      

  Dim ver As Integer = -1
  
  For do_expl = 0 To this->explosions - 1 

    ver = ver And ( this->explosion( do_expl ).alive = 0 )
    
  Next

      
  If ver Then
    
    For do_expl = 0 To this->explosions - 1 

      this->explosion( do_expl ).x = 0
      this->explosion( do_expl ).y = 0
      this->explosion( do_expl ).frame = 0
      this->explosion( do_expl ).alive = 0
      this->explosion( do_expl ).sound = 0
      
    Next

    this->cur_expl = 0
    this->expl_timer = 0
    
    If this->isBoss Or ( this->unique_id = u_charger ) Or ( this->unique_id = u_swordie ) Then '( this->unique_id = u_grult ) Or ( this->unique_id = u_dyssius ) Or ( this->unique_id = u_steelstrider ) Or ( this->unique_id = u_anger ) Or ( this->unique_id = u_sterach ) Or ( this->unique_id = u_swordie ) Or ( this->unique_id = u_charger ) Or ( this->unique_id = u_divine ) Or ( this->unique_id = u_divine_bug ) Then 
      Return 3
      
    End If

    '' if you put "fireworks" on, then the explosion waits until now to advance.

    If this->fireworks <> 0 Then
      Return 1
      
    End If
      
  End If
  
  
  If this->fireworks = 0 Then
    Return 1
    
  End If
    
    
  
  
End Function 



