#Define CR_LF (Chr( 13 ) + Chr( 10 ))

#Define chance_Percent(x) ( ( Rnd * 100 ) < x )
#Define chance_OneIn(x) IIf( x = 0, 0, ( ( Rnd * x ) < 1 ) )

#Define is_QNAN(__CHECKME__) ( ( Cast( Integer Ptr, Varptr( __CHECKME__ ) )[1] = &h7FF80000UL ) Or ( Cast( Integer Ptr, Varptr( __CHECKME__ ) )[1] = &hFFF80000UL ) )
#Define is_INF(__CHECKME__) ( Cast( Integer Ptr, Varptr( __CHECKME__ ) )[1] = &h7FF00000UL )
#Define is_LegalNumber(__CHECKME__) ( Not ( is_QNAN( __CHECKME__ ) Or is_INF( __CHECKME__ ) ) )

#Define clean_Deallocate(x) _
                            _
  Deallocate( x )          :_
  x = 0                  


#Define value_Smaller(__x,__y) ( IIf( __x < __y, __x, __y ) )
#Define value_Larger(__x,__y) ( IIf( __x < __y, __y, __x ) )


Const As Double pi = Atn(1) * 4
Const As Double rad = ( pi / 180 )

#Define deg_2_rad(x) ( x * rad )  



#Define hold_button(x)                          _
                                                _
  Scope                                        :_
                                               :_
    Dim As Integer jnk, mb                     :_
    GetMouse jnk, jnk, jnk, mb                 :_
                                               :_
    Do While( mb And x )                       :_
      GetMouse jnk, jnk, jnk, mb               :_
      Sleep 1                                  :_
                                               :_
    Loop                                       :_
                                               :_
  End Scope


#Define hold_key(x)                           _
                                              _
  While MultiKey( x )                        :_
    Sleep 1                                  :_
    Dim As String k = Inkey                  :_
  Wend







#IfNDef Arg_Types
  Enum Arg_Types
  
    ARG_INT = 1
    ARG_UINT
    ARG_STR
    ARG_SNG
    ARG_DBL
    ARG_ULNG
    ARG_LNG
    ARG_PTR
  
  End Enum
  
#EndIf




Type fb_GfxImg

  As Short d:3
  As Short w:13
  
  As Short h
  
End Type








Type _control_type


  x        As Integer     '' x location ( char relative ( pixel \ 8 ))
  y        As Integer     '' y location ( char relative ( pixel \ 8 )) 
  real_x   As Integer     '' x location ( pixel relative )
  real_y   As Integer     '' y location ( pixel relative )
  
  Name     As String      '' displayed text    
  
  state    As Integer     '' state to trigger    
  
  lm       As Integer     '' less-more option 
  ad       As Integer     '' add/delete option
  
  e_sel    As Integer Ptr '' selected element
  e_num    As Integer Ptr '' total elements
  
  d_delay  As Double      '' delay on control's.. controls :P      
  d_timer  As Double      '' delay on control's.. controls :P      

  ct_len As Integer
  ct_odd As Integer
  
  insertFlag As Byte  
  
End Type 
        
        
Type my_control_type

  
  controls As Integer
  control As _control_type Ptr
  
  
End Type


'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
''' ' ' ' ' ' ' ' '' '' '' ' ' '''' ' ' '' ' '' ' ' '' ''  '' '' ' ' '' ' '
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''


Type easy_vector

  As Integer elements

  Union
    As uByte Ptr dat
    As uShort Ptr sdat
    As uInteger Ptr idat
    
  End Union
  
End Type



Type fb_FontType

  w As Integer
  h As Integer
  Data As uByte Ptr

End Type

'Extern fb_FontData Alias "fb_font_8x8" As fb_FontType
Extern fb_FontData Alias "fb_font_8x16" As fb_FontType









Type mat

  As Double x, y
  
End Type


Type mat_int
  
  As Integer x, y

End Type

Type tile_quad

  x As Integer
  y As Integer
  quad As Integer
  
End Type

















Declare Function file_ptr( nm As String ) As easy_vector


Declare Function Cva ( f As uByte Ptr, As Integer, As Integer = 0 ) As String 

Declare Function load_h_string( ff As Integer ) As String
Declare Sub      save_h_string( ff As Integer, s As String )

Declare Function kfp Alias "KILLFILEPATH" ( fname As String ) As String
Declare Function kfe Alias "KILLFILEEXT" ( fname As String ) As String






Declare Sub GfxPrint( ByRef text As String, ByVal x As Integer = 0, ByVal y As Integer = 0, ByVal col As Integer = 15, ByVal buffer As Any Ptr = 0 )
                                                                                                       

                                                                                                       
Declare Function uplf_box_bound( y As Integer, x As Integer ) As mat_int
Declare Function btrt_box_bound( y As Integer, x As Integer ) As mat_int
                                                                                                       



Declare Sub init_snd()
Declare Sub init_sng()













Dim Shared As zString Ptr music_strings( 25 ) => _
  { _
    /'0'/ @"",                    _
    /'1'/ @"data\music\amb.it", _
    /'2'/ @"data\music\apox.it", _
    /'3'/ @"data\music\beneath.it", _
    /'4'/ @"data\music\boss.it", _
    /'5'/ @"data\music\boss2.it", _
    /'6'/ @"data\music\core.it", _
    /'7'/ @"data\music\cryspool.it", _
    /'8'/ @"data\music\dimension2.it", _
    /'9'/ @"data\music\dimhole.it", _
   /'10'/ @"data\music\dream.it", _
   /'11'/ @"data\music\evernight.it", _
   /'12'/ @"data\music\final.it", _
   /'13'/ @"data\music\forest.it", _
   /'14'/ @"data\music\fsun.it", _
   /'15'/ @"data\music\holy.it", _
   /'16'/ @"data\music\limbo.it", _
   /'17'/ @"data\music\logosta.it", _
   /'18'/ @"data\music\master.it", _
   /'19'/ @"data\music\sdesert.it", _
   /'20'/ @"data\music\title.it", _
   /'21'/ @"data\music\town.it", _
   /'22'/ @"data\music\valley.it", _
   /'23'/ @"data\music\world.it", _
   /'24'/ @"data\music\after.it", _
   /'25'/ @"data\music\faulty.it" _
  }



Declare Sub LLSystem_MemSwap( swap_1 As Any Ptr, swap_2 As Any Ptr, sz As uInteger )
Declare Function fb_ImgFromBMP( fileName As String ) As Any Ptr


Declare Sub ptrArray_Append( addressing As Any Ptr, ByRef max As Integer, size As uInteger )
Declare Sub ptrArray_Insert( addressing As Any Ptr, ByRef max As Integer, selected As Integer, size As uInteger )
Declare Sub ptrArray_Delete( addressing As Any Ptr, ByRef max As Integer, selected As Integer, size As uInteger )


