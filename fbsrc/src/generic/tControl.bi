#IfNDef __TCONTROL_BI__
#Define __TCONTROL_BI__

  
  Enum tControl_OPTIONS
  
    TC_SELECT = 1
    TC_RESIZE = 2
    
  End Enum
  
  
  Enum tControl_MESSAGES
  
  
    TC_LEFTARROW  = 1
    TC_RIGHTARROW = 2
    TC_ADD        = 4
    TC_INSERT     = 8
    TC_DELETE     = 16
  
  
  End Enum
  
  
  Type tControl_Coords
    
    As Integer x, y
    
  End Type
  
  Type tControl_ButtonLoc
  
    As tControl_Coords leftArrow, rightArrow
    As tControl_Coords plus, x
  
  End Type
  

  Type tControl_Type As _tControl_Type
  Type tControl_CallbackProc As Function( As tControl_Type Ptr ) As Integer
  Type tControl_WaitbackProc As Function() As Integer
  
  
  Type _tControl_Type
  
  
    x          As Integer                       
    y          As Integer                       
    pixel_x    As Integer                       
    pixel_y    As Integer                       
    
    id         As String                        
    
    menuSelect As Integer                       
    menuResize As Integer                       
    
    selPtr     As Integer Ptr     
    numPtr     As Integer Ptr     
    
    elemSize   As Integer                       
    container  As Any Ptr Ptr 
    
    d_delay    As Double                        
    d_timer    As Double                        
    
    idLength_2 As Integer                       
    idIsEven   As Integer                       
    
    insertFlag As Byte                          
    
    
    callback   As tControl_CallbackProc         
    
    message    As tControl_MESSAGES             
    
    button     As tControl_ButtonLoc            
  
    waitfor    As tControl_WaitbackProc
    
    
  End Type 
          
  
          
  Type tControl_Data
  
    
    controls As Integer
    control As tControl_Type Ptr
    
    control_selected As Integer
    
    
  End Type
  
  Extern controlManager Alias "TCONTROL_GLOBAL" As tControl_Data
  
  
  Declare Sub tControl_Update( tVector As tControl_Data Ptr = @controlManager )
  
  Declare Function tControl_Init( y As Integer, x As Integer,                       _ 
                                  id As String,                                     _ 
                                  callback As tControl_CallbackProc,                _ 
                                  waitfor  As tControl_WaitbackProc = 0,            _ 
                                  flg As uInteger = 0,                              _ 
                                  tVector  As tControl_Data Ptr = @controlManager )
                         
  Declare Sub tControl_Scroll( selectedControl As Integer    , _ 
                               selPtr          As Integer Ptr, _ 
                               numPtr          As Integer Ptr, _ 
                               tVector As tControl_Data Ptr = @controlManager )
  
  Declare Sub tControl_Vector( selectedControl As Integer    , _ 
                               elemSize        As Integer    , _ 
                               container       As Any Ptr Ptr, _ 
                               tVector As tControl_Data Ptr = @controlManager )
            
  
  
#EndIf '' __TCONTROL_BI__
