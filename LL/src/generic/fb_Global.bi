#IfNDef FB_GLOBAL_BI
#Define FB_GLOBAL_BI

  #Include "crt.bi"
  #Include "fbgfx.bi"

  Option Explicit

  Type fb_MouseInfo
    
    As Integer x, y, w, b
    
  End Type
  
  Type fb_ScreenPageInfo
    
    As Integer active, working
    
  End Type
  
  Type fb_ScreenInfo
    
    As Integer w, h, depth, refreshRate
    As String driver
    page As fb_ScreenPageInfo
    
    Union

      bit32 As uInteger Ptr
      bit24 As uInteger Ptr
      bit16 As uShort Ptr
      bit8 As uByte Ptr
      
    End Union
    
    As uInteger sizePreCalc
    
    pal As Integer Ptr
    
  End Type
  
  Type fb_GlobalData 
  
    As Double cursorSpeed, cursorLock
    mouse       As fb_MouseInfo
    display     As fb_ScreenInfo
    keyBuffer   As String
    
  End Type
  
  Extern fb_Global Alias "FB_GLOBAL" As fb_GlobalData
 
  Declare Sub fb_StartGlobal  ( globalData As fb_GlobalData Ptr = @fb_Global )  


    Declare Function simpleQuery_Integer     ( y As Integer, x As Integer, flags As uInteger )

    Declare Sub      simpleQuery_BinarySwitch( value As Integer )


    Declare Sub fb_ScreenRefresh( globalData As fb_GlobalData Ptr = @fb_Global ) 

  Declare Sub fb_CloseGlobal( globalData As fb_GlobalData Ptr = @fb_Global ) 



  #Define fb_GetMouse()        _
    With fb_Global.mouse      :_
      GetMouse .x, .y, .w, .b :_
                              :_
    End With

  #Define fb_GetKey() fb_Global.keyBuffer = Inkey

  #Define fb_ScreenPause() ScreenSet fb_Global.display.page.working, fb_Global.display.page.working
  #Define fb_ScreenUnPause() ScreenSet fb_Global.display.page.working, fb_Global.display.page.active
  
  #Define fb_LeftClick ( fb_Global.mouse.b And sc_leftbutton )
  #Define fb_RightClick ( fb_Global.mouse.b And sc_rightbutton )

  #Define fb_ClearKey()          _
                                 _
    fb_Global.keyBuffer = Inkey :_
    fb_Global.keyBuffer = ""    :_
  

  #Define fb_FreezeKey(x) _
                          _
    While MultiKey( x )  :_
      Sleep 1            :_
                         :_
    Wend

  
  #Define fb_FreezeButton(x)     _             
                                 _
    Scope                       :_
                                :_
      Dim As Integer mb, i      :_
      GetMouse( i, i, i, mb )   :_
                                :_              
      While ( mb And x )        :_ 
                                :_                
        GetMouse( i, i, i, mb ) :_
        Sleep 1                 :_                
                                :_                
      Wend                      :_
                                :_
    End Scope

  
  #Define mouse_On8(__Y__,__X__)                             _
    IIf(                                                     _
         fb_Global.mouse.x > ( __X__ Shl 3 ) - 8,            _
         IIf(                                                _
              fb_Global.mouse.x < ( __X__ Shl 3 ),           _
              IIf(                                           _
                   fb_Global.mouse.y > ( __Y__ Shl 3 ) - 8,  _
                   IIf(                                      _
                        fb_Global.mouse.y < ( __Y__ Shl 3 ), _
                        -1,                                  _
                        0                                    _
                      ),                                     _
                   0                                         _
                 ),                                          _
              0                                              _
            ),                                               _
         0                                                   _
       )                                                   
  
  
                                
  
  
  #Define mouse_OnQuad8(__Y__,__X__,__Y2__,__X2__)                                                                                                                             _
    (                                                                                                                                                                          _
      IIf(                                                                                                                                                                     _
           fb_Global.mouse.x > ( value_Smaller( __X2__, __X__ ) Shl 3 ) - 8,                                                                                                   _
           IIf(                                                                                                                                                                _
                fb_Global.mouse.x < ( ( value_Smaller( __X2__, __X__ ) Shl 3 ) + ( ( ( value_Larger( __X2__, __X__ ) - value_Smaller( __X2__, __X__ ) ) ) Shl 3 ) ),           _ 
                IIf(                                                                                                                                                           _
                     fb_Global.mouse.y > ( value_Smaller( __Y2__, __Y__ ) Shl 3 ) - 8,                                                                                         _
                     IIf(                                                                                                                                                      _
                          fb_Global.mouse.y < ( ( value_Smaller( __Y2__, __Y__ ) Shl 3 ) + ( ( ( value_Larger( __Y2__, __Y__ ) - value_Smaller( __Y2__, __Y__ ) ) ) Shl 3 ) ), _ 
                          -1,                                                                                                                                                  _
                          0                                                                                                                                                    _
                        ),                                                                                                                                                     _
                     0                                                                                                                                                         _
                   ),                                                                                                                                                          _
                0                                                                                                                                                              _
              ),                                                                                                                                                               _
           0                                                                                                                                                                   _
         )                                                                                                                                                                     _
    )
  
  #Define mouse_OnQuad(__X__,__Y__,__X2__,__Y2__)                                                                                                      _
    (                                                                                                                                                  _
      IIf(                                                                                                                                             _
           fb_Global.mouse.x >= value_Smaller( __X2__, __X__ ),                                                                                        _
           IIf(                                                                                                                                        _
                fb_Global.mouse.x < ( value_Smaller( __X2__, __X__ ) + ( value_Larger( __X2__, __X__ ) - value_Smaller( __X2__, __X__ ) ) ),           _ 
                IIf(                                                                                                                                   _
                     fb_Global.mouse.y >= ( value_Smaller( __Y2__, __Y__ ) ) ,                                                                         _
                     IIf(                                                                                                                              _
                          fb_Global.mouse.y < ( value_Smaller( __Y2__, __Y__ ) + ( value_Larger( __Y2__, __Y__ ) - value_Smaller( __Y2__, __Y__ ) ) ), _ 
                          -1,                                                                                                                          _
                          0                                                                                                                            _
                        ),                                                                                                                             _
                     0                                                                                                                                 _
                   ),                                                                                                                                  _
                0                                                                                                                                      _
              ),                                                                                                                                       _
           0                                                                                                                                           _
         )                                                                                                                                             _
    )


  
  #Define sc_leftbutton 1
  #Define sc_rightbutton 2
  #Define sc_middlebutton 4
  
  #Define fb_WindowKill() ( fb_Global.keyBuffer = Chr( 255 ) + "k" )
  
  #Define fb_MouseOffScreen() ( ( fb_Global.mouse.x < 0 ) or ( fb_Global.mouse.y < 0 ) )


  #Define SQ_ThresholdLevel(__X__) ( __X__ Shl 16 )    
  Enum SQ_FLAGS
  
    SQ_NOCHECK    = 0
    SQ_POSITIVE   = 1
    SQ_THRESHOLD  = 2
    
  End Enum
  

#EndIf

