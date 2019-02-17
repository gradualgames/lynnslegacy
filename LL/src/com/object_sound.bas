Option Explicit

#Include "..\headers\ll.bi"



Function __stop_sound ( this As _char_type Ptr ) As Integer
  
  #IfDef ll_audio
    BASS_ChannelStop( this->playing_handle )       
    
  #EndIf
  
  Return 1

End Function



Function __fade_off ( this As _char_type Ptr ) As Integer

  llg( song_fade ) = 0

  Return 1
  
End Function



Function __kill_song ( this As _char_type Ptr ) As Integer


  this->fade_out = 0

  this->song_fade_count = 0
  
  LLMusic_Stop()

  Return 1

End Function



Function __play_dead_sound ( this As _char_type Ptr ) As Integer

  play_sample( llg( snd )[this->dead_sound] )

  Return 1

End Function


Function __play_sound ( this As _char_type Ptr ) As Integer
  
  
  With *this
    
    .playing_handle = play_sample( llg( snd )[.sound[.chap]], .vol[.chap] )
  
  End With
  
  Return 1
  


End Function


Function __play_song ( this As _char_type Ptr ) As Integer
  
  With *this
    
    LLMusic_Start( *music_strings( .chap ) )
                                                                           
  End With
  
  Return 1
  


End Function



Function __set_fade ( this As _char_type Ptr ) As Integer


  Dim As Integer hi_r, cols, r, g, b


    For cols = 0 To 255
  
      Palette Get cols, r, g, b
      
      If r > hi_r Then
        hi_r = r
        
      End If
      
    Next

    this->fade_out = hi_r \ 4 

  llg( song_fade ) = -1


  
  Return 1
  


End Function


Function __set_vol_fade ( this As _char_type Ptr ) As Integer

  this->vol_fade_trig = -1
  
  Return 1


End Function


Function __do_vol_fade ( this As _char_type Ptr ) As Integer
  
  Dim As Integer cur_vol
  Dim As Double vol_prec, r
  
  Static As Double vol_fade_time = .3
  
  const as integer slices = 64  

  If this->vol_fade_lock = 0 Then

    #IfDef ll_audio    

      If this->sample_fade_lock = 0 Then
        BASS_ChannelGetAttributes( this->playing_handle, 0, @cur_vol, 0 )
        this->sample_vol_store = cur_vol
        this->sample_fade_lock = -1
        
      End If
      
      

      vol_prec = slices - this->vol_fade
      vol_prec *= ( this->sample_vol_store / slices )
'      vol_prec /= 64
'      r = this->sample_vol_store - vol_prec
  
      BASS_ChannelSetAttributes( this->playing_handle, 0, vol_prec, 0 )
      
    #EndIf

          
    this->vol_fade += 4  
    this->vol_fade_lock = Timer + vol_fade_time
    
  End If
  
  If Timer > this->vol_fade_lock Then this->vol_fade_lock = 0
  
  
  If this->vol_fade = slices Then
    ''done fading, kill it.
    
    #IfDef ll_audio

      BASS_ChannelStop( this->playing_handle )   
      BASS_ChannelSetAttributes( this->playing_handle, 0, this->sample_vol_store, 0 )
      
      
    #EndIf

    this->sample_fade_lock = 0
    this->vol_fade_trig = 0
    this->vol_fade = 0
    this->sample_vol_store = 0
    
  End If
  




  
  Return 1
  


End Function




