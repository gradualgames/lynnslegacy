Option Explicit

#Include "..\headers\ll.bi"

ChDir ExePath

Randomize Timer

  Dim Shared As ll_system ll_global
  init_splash()

  engine_init()
    ll_main_entry()
    
    
    Do


      fb_GetMouse()
      fb_GetKey()

      enemy_main()
      hero_main()

      play_sequence( llg( seq ) )
      blit_scene()
      
      
      fb_ScreenRefresh()

      If llg( fps_hold ) > 200 Then
        Sleep 1

      End If

      if not( stillPlaying() ) then exit do

    Loop Until fb_WindowKill()


    LL_RollCredits()



Public Sub ll_end() Destructor

  Dim As Integer i
  For i = 0 To menu_MAX

    llg( menu ).menuNames( i ) = ""

  Next


  clean_Deallocate( llg( dir_hint ) )
  clean_Deallocate( llg( now ) )
  clean_Deallocate( llg( hero_only ).songFade )

  BinObj_Destroy( llg( atk_key )         )
  BinObj_Destroy( llg( act_key )         )
  BinObj_Destroy( llg( conf_key )        )
  BinObj_Destroy( llg( item_l_key )      )
  BinObj_Destroy( llg( item_r_key )      )
  BinObj_Destroy( llg( weap_switch_key ) )

  LLSystem_ClearObjectStrings( llg( hero ) )
  LLSystem_ObjectRelease( llg( hero ) )
  map_Destroy( llg( map ) )

  LLSystem_ClearObjectCache()
  LLSystem_ClearImageCache()

  llg( dungeonName ) = ""

  #IfDef ll_audio

    BASS_Stop
    BASS_Free

  #EndIf

  ImageDestroy( llg( menu_ScreenSave ) )

  sequence_Destroy( llg( hero_only ).specialSequence[0] )

End Sub

