Option Explicit

#Include "..\headers\ll\headers.bi"



Type key_config
  
  As Integer ukey, rkey, lkey, dkey, atkkey, actkey, itmkey
  
End Type

#Define ckb ClearKeyBuffer()
#Define ClearKeyBuffer() Do: Sleep 1: Loop Until Len( Inkey ) = 0


function isFullscreen() as integer

  dim as integer fullScreen
  
  if open( "ll.ini", for input, as #1 ) = 0 then
  
    dim as string isFull  
    
    input #1, isFull
    
    if instr( ucase( isFull ), "FULLSCREEN" ) then
  
      if instr( ucase( isFull ), "YES" ) then
        fullScreen = 1
        
      end if
      
    end if

    close #1
  
    
  end if
  
  return fullScreen

end function



#undef blit_image
sub blit_image( x As Integer, y As Integer, img As LLSystem_ImageHeader, directional As Integer = 0, frame As Integer = 0 )

  Put( x - img.x_off, y - img.y_off ), @img.image[( directional + frame ) * img.arraysize]


End sub

Dim shared As LLSystem_ImageHeader lynn_dir, lynn_attack, lynn_powder, lynn_speak, fonty, full, windowed', full, windowed
dim shared as integer fullscreen
fullscreen = isFullscreen()


Dim Shared As key_config key_chart


Function LLSystem_ImageLoad( image_tag As LLSystem_ImageHeader ) As Integer

  
  Dim As Integer o = FreeFile, i, get_frames, get_faces

  With image_tag

    If Dir ( .filename ) = "" Then
      '' file doesn't exist. 
      Return 0
      
    End If
  
    If Open( Trim( .filename ), For Binary Access Read, As o ) = 0 Then
    
      Get #o, , .x
      Get #o, , .y
      Get #o, , .arraysize
      Get #o, , .frames
      
      .image = CAllocate( .frames * .arraysize * Len ( Short )  )
      
      Get #o, , *.image, .frames * .arraysize
          
      Close o
      
    End If

    .frame = CAllocate( Len ( LLSystem_FrameShell ) * ( .frames ) )

    If Dir ( kfe( .filename ) + ".col" ) <> "" Then 

      o = FreeFile
      If Open( kfe( .filename ) + ".col", For Binary Access Read, As o ) = 0 Then

        For get_frames = 0 To .frames - 1

          With .frame[get_frames]
          
            Get #o, , .faces

            .face = CAllocate( Len( LLSystem_FaceType ) * ( .faces ) )
            
            For get_faces = 0 To .faces - 1
              
              With .face[get_faces]

                Get #o, , .x  
                Get #o, , .y
                Get #o, , .w
                Get #o, , .h
                Get #o, , .strength
                Get #o, , .invincible
                Get #o, , .impassable
                
              End With
              
            Next
            
          End With

        Next

        Close o
      
      End If
      
    End If

  End With
  
  Return -1

End Function


Function return_code_string( c As Integer ) As String

  Select Case As Const c
    
    Case 0               : Return "null"
    Case SC_ESCAPE       : Return "esc"
    Case SC_1            : Return "1" 
    Case SC_2            : Return "2" 
    Case SC_3            : Return "3" 
    Case SC_4            : Return "4" 
    Case SC_5            : Return "5" 
    Case SC_6            : Return "6" 
    Case SC_7            : Return "7" 
    Case SC_8            : Return "8" 
    Case SC_9            : Return "9" 
    Case SC_0            : Return "0" 
    Case SC_MINUS        : Return "-" 
    Case SC_EQUALS       : Return "=" 
    Case SC_BACKSPACE    : Return "bs" 
    Case SC_TAB          : Return "tab" 
    Case SC_Q            : Return "q" 
    Case SC_W            : Return "w" 
    Case SC_E            : Return "e" 
    Case SC_R            : Return "r" 
    Case SC_T            : Return "t" 
    Case SC_Y            : Return "y" 
    Case SC_U            : Return "u" 
    Case SC_I            : Return "i" 
    Case SC_O            : Return "o" 
    Case SC_P            : Return "p" 
    Case SC_LEFTBRACKET  : Return "[" 
    Case SC_RIGHTBRACKET : Return "]" 
    Case SC_ENTER        : Return "enter" 
    Case SC_CONTROL      : Return "ctrl" 
    Case SC_A            : Return "a" 
    Case SC_S            : Return "s" 
    Case SC_D            : Return "d" 
    Case SC_F            : Return "f" 
    Case SC_G            : Return "g" 
    Case SC_H            : Return "h" 
    Case SC_J            : Return "j" 
    Case SC_K            : Return "k" 
    Case SC_L            : Return "l" 
    Case SC_SEMICOLON    : Return ";" 
    Case SC_QUOTE        : Return "'" 
    Case SC_TILDE        : Return "~" 
    Case SC_LSHIFT       : Return "l shft" 
    Case SC_BACKSLASH    : Return "\" '" 
    Case SC_Z            : Return "z" 
    Case SC_X            : Return "x" 
    Case SC_C            : Return "c" 
    Case SC_V            : Return "v" 
    Case SC_B            : Return "b" 
    Case SC_N            : Return "n" 
    Case SC_M            : Return "m" 
    Case SC_COMMA        : Return "," 
    Case SC_PERIOD       : Return "." 
    Case SC_SLASH        : Return "/" 
    Case SC_RSHIFT       : Return "r shft" 
    Case SC_MULTIPLY     : Return "*" 
    Case SC_ALT          : Return "alt" 
    Case SC_SPACE        : Return "space" 
    Case SC_CAPSLOCK     : Return "caps" 
    Case SC_F1           : Return "f1" 
    Case SC_F2           : Return "f2" 
    Case SC_F3           : Return "f3" 
    Case SC_F4           : Return "f4" 
    Case SC_F5           : Return "f5" 
    Case SC_F6           : Return "f6" 
    Case SC_F7           : Return "f7" 
    Case SC_F8           : Return "f8" 
    Case SC_F9           : Return "f9" 
    Case SC_F10          : Return "f10" 
    Case SC_NUMLOCK      : Return "num" 
    Case SC_SCROLLLOCK   : Return "scrl" 
    Case SC_HOME         : Return "home" 
    Case SC_UP           : Return Chr( 24 )
    Case SC_PAGEUP       : Return "pg up" 
    Case SC_LEFT         : Return "<-" 
    Case SC_RIGHT        : Return "->" 
    Case SC_PLUS         : Return "+" 
    Case SC_END          : Return "end" 
    Case SC_DOWN         : Return Chr( 25 )
    Case SC_PAGEDOWN     : Return "pg dn" 
    Case SC_INSERT       : Return "ins" 
    Case SC_DELETE       : Return "del" 
    Case SC_F11          : Return "f11" 
    Case SC_F12          : Return "f12" 
    Case SC_LWIN         : Return "l m$" 
    Case SC_RWIN         : Return "r m$" 
    Case SC_MENU         : Return "menu" 
    
  End Select

  
End Function
  


Function key_get

  Dim As uByte cyc
  
  For cyc = 0 To 255
    If MultiKey( cyc ) Then 
      ckb
      
      hold_key( sc_escape )

      Return cyc
      
    End If

    If cyc And 3 = 0 Then Sleep 1
    
  Next

  
End Function



Function check_all_codes( code As Integer ) As Integer

  Dim As Integer Ptr c
  Dim As Integer i
  c = cptr( Integer Ptr, @key_chart )
  For i = 0 To ( Len( key_config ) Shr 2 ) - 1
    If code = c[i] Then Return 0
    
  Next
  
  If code = sc_enter Then Return 0
  If code = sc_escape Then Return 0
  If code = sc_period Then Return 0
  If code = sc_comma Then Return 0
  
  Return -1
  
End Function
  
  

sub clickable_area( x As Integer, y As Integer, i As LLSystem_ImageHeader, code As Integer, d As Integer = 0, f As Integer = 0 )
  
  Dim As Integer mx, my, mw, mb, ret
  GetMouse( mx, my, mw, mb )
  
  if code = 256 then
    
'    blit_image( x, y, i, 0, 0 )
    if y = 10 then
      '' full
      
      gfxprint( "Full", x, y, iif( fullScreen, 114, 15 ) )
      
      If mx > x Then
        If my > y Then
          If mx < x + 32 Then
            If my < y + 16 Then
              Line( x, y )-( x + 31, y + 15 ), 15, b
              If mb And sc_leftbutton Then
                fullScreen = -1
              end if
              
            end if
            
          end if
          
        end if
        
      end if
       
      
    elseif y = 30 then
      '' windowed
'      dim as integer col
      gfxprint( "Windowed", x, y, iif( fullScreen, 15, 114 ) )

      If mx > x Then
        If my > y Then
          If mx < x + 64 Then
            If my < y + 16 Then
              Line( x, y )-( x + 63, y + 15 ), 15, b
              If mb And sc_leftbutton Then
                fullScreen = 0
              end if
              
            end if
            
          end if
          
        end if
        
      end if
       
      
    end if
    
    exit sub
    
  end if
  
  
  Dim As String cstr 
  cstr = return_code_string( code )

  blit_image( x + 16, y + 16, i, d, f )
  
  Dim As mat_int calc
  
  calc.x = x + 24
  calc.y = y + 38
  
  calc.x -= ( ( Len( cstr ) Shr 1 ) Shl 3 )
  If Len( cstr ) And 1 Then calc.x -= 4
  
  Draw String( calc.x, calc.y ), cstr
  
  
  If mx > x Then
    If my > y Then
      If mx < x + 48 Then
        If my < y + 48 Then
          Line( x, y )-( x + 47, y + 47 ), 15, b
          If mb And sc_leftbutton Then 
            ret = key_get
            If check_all_codes( ret ) Then
              code = ret
              
            End If
          
          End If
          
        End If
        
      End If
      
    End If
    
  End If
  
  
End sub




Screen 13, , 2', iif( fullScreen, 1, 0 )
ScreenInfo llg( sx ), llg( sy )








Dim As ll_system ll_global

fb_Global.display.pal = load_pal( "data\palette\ll.pal" )
Palette Using fb_Global.display.pal


lynn_dir.filename = "data\pictures\char\lynn24.spr"
lynn_attack.filename = "data\pictures\char\Lynnattack_NEW.spr"
lynn_powder.filename = "data\pictures\char\Lynn_flare.spr"
lynn_speak.filename = "data\pictures\char\lynn_cfg.spr"


'llg( font ) = callocate( len( LLSystem_ImageHeader ) )
fonty.filename = "data\pictures\llfont.spr"


LLSystem_ImageLoad( lynn_dir )
LLSystem_ImageLoad( lynn_attack )
LLSystem_ImageLoad( lynn_powder )
LLSystem_ImageLoad( lynn_speak )

LLSystem_ImageLoad( fonty )


lynn_dir.y_off = 8
lynn_attack.x_off = 16
lynn_attack.y_off = 20
lynn_powder.x_off = 16
lynn_powder.y_off = 20
lynn_speak.x_off = 8
lynn_speak.y_off = 16


'full.image = imagecreate( 32, 16 )
'graphicalString( "Full", 0, 0 )
'get( 0, 0 )-( 31, 15 ), full.image
'cls
'windowed.image = imagecreate( 48, 16 )
'graphicalString( "Window", 0, 0 )
'get( 0, 0 )-( 47, 15 ), windowed.image
'




llg( v_page ) = 1

Dim As xml_type Ptr last_controls, action_controls, attack_controls, item_controls, up_controls, down_controls, left_controls, right_controls
last_controls = xml_Load( "data\controls.xml" )

  If last_controls <> 0 Then

    key_chart.actkey = Val( xml_TagValue( last_controls, "key_map->action" ) )
    key_chart.atkkey = Val( xml_TagValue( last_controls, "key_map->attack" ) )
    key_chart.itmkey = Val( xml_TagValue( last_controls, "key_map->item" ) )
    key_chart.ukey   = Val( xml_TagValue( last_controls, "key_map->move_up" ) )
    key_chart.rkey   = Val( xml_TagValue( last_controls, "key_map->move_right" ) )
    key_chart.dkey   = Val( xml_TagValue( last_controls, "key_map->move_down" ) )
    key_chart.lkey   = Val( xml_TagValue( last_controls, "key_map->move_left" ) )

    xml_Destroy( last_controls ) 
    
  Else


    key_chart.actkey = sc_space
    key_chart.atkkey = sc_control 
    key_chart.itmkey = sc_alt            
    key_chart.ukey   = sc_up 
    key_chart.rkey   = sc_right 
    key_chart.dkey   = sc_down
    key_chart.lkey   = sc_left

  End If

ScreenSet llg( a_page ), llg( v_page )


Do
  
  fb_GetKey()
  Draw String( 106, 8 ), "Lynn's Legacy"
  Draw String( 122, 16 ), "Key Setup"
  

  clickable_area( 48, 0, lynn_dir, key_chart.ukey )
  clickable_area( 96, 48, lynn_dir, key_chart.rkey, 1 * 8, 1 )
  clickable_area( 48, 96, lynn_dir, key_chart.dkey, 2 * 8, 2 )
  clickable_area( 0, 48, lynn_dir, key_chart.lkey, 3 * 8, 3 )
  
  clickable_area( 180, 35, lynn_powder, key_chart.itmkey, 3 * 5, 3 )
  clickable_area( 180, 120, lynn_attack, key_chart.atkkey, 1 * 6, 3 )
  clickable_area( 260, 120, lynn_speak, key_chart.actkey )

  clickable_area( 240, 10, full, 256 )
  clickable_area( 240, 30, windowed, 256 )


  Draw String( 8, 164 ), "Click an action,"
  Draw String( 8, 172 ), "then hit a button for that action."

  Draw String( 8, 184 ), "Esc to exit saving changes."
  Draw String( 8, 192 ), "Backspace to exit discarding changes.."
  
  flip
  cls
  Sleep 1
  
  If MultiKey( sc_backspace ) Then
    end
    
  End If
  if fb_WindowKill() then
    end
    
  end if
  

Loop Until MultiKey( 1 )

action_controls = CAllocate( Len( xml_type ) ) 
attack_controls = CAllocate( Len( xml_type ) ) 
item_controls   = CAllocate( Len( xml_type ) ) 

up_controls     = CAllocate( Len( xml_type ) ) 
right_controls  = CAllocate( Len( xml_type ) ) 
down_controls   = CAllocate( Len( xml_type ) ) 
left_controls   = CAllocate( Len( xml_type ) ) 

last_controls   = CAllocate( Len( xml_type ) )
last_controls->key = "key_map"

action_controls->key = "action"
action_controls->eol = -1
action_controls->list = list_push( action_controls->list, Str( key_chart.actkey ) )
last_controls->list = list_append( last_controls->list, action_controls )

attack_controls->key = "attack"
attack_controls->eol = -1
attack_controls->list = list_push( attack_controls->list, Str( key_chart.atkkey ) )
last_controls->list = list_append( last_controls->list, attack_controls )

item_controls->key = "item"
item_controls->eol = -1
item_controls->list = list_push( item_controls->list, Str( key_chart.itmkey ) )
last_controls->list = list_append( last_controls->list, item_controls )

up_controls->key = "move_up"
up_controls->eol = -1
up_controls->list = list_push( up_controls->list, Str( key_chart.ukey ) )
last_controls->list = list_append( last_controls->list, up_controls )

right_controls->key = "move_right"
right_controls->eol = -1
right_controls->list = list_push( right_controls->list, Str( key_chart.rkey ) )
last_controls->list = list_append( last_controls->list, right_controls )

down_controls->key = "move_down"
down_controls->eol = -1
down_controls->list = list_push( down_controls->list, Str( key_chart.dkey ) )
last_controls->list = list_append( last_controls->list, down_controls )

left_controls->key = "move_left"
left_controls->eol = -1
left_controls->list = list_push( left_controls->list, Str( key_chart.lkey ) )
last_controls->list = list_append( last_controls->list, left_controls )


Dim As Integer ff
ff = FreeFile
Open "data\controls.xml" For Output As #ff
  xml_FileWrite( last_controls, ff )
  
Close

ff = FreeFile
Open "ll.ini" For Output As #ff
  print #ff, "Fullscreen = " & *iif( fullScreen, @"Yes", @"No" )
  
Close



xml_Destroy( action_controls )
xml_Destroy( attack_controls )
xml_Destroy( item_controls ) 
               
xml_Destroy( up_controls )   
xml_Destroy( right_controls )
xml_Destroy( down_controls ) 
xml_Destroy( left_controls ) 
               
xml_Destroy( last_controls )


