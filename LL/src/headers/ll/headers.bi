
#IfNDef LL_INCLUDE
  #Define LL_INCLUDE
  
  #Include "crt.bi"
  #Include "..\generic\fb_Global.bi"
  
  #Include "constants.bi"
  
  #IfDef ll_audio
  
    #Include Once "..\headers\stripped_bass.bi"
  
  #EndIf  
  
  #Include Once "..\headers\lists.bi"
  #Include Once "..\headers\xml.bi"
  
  #Include Once "..\headers\vfile.bi"
                                                    
  #Include Once "..\headers\matrices.bi"
  
  #Include Once"..\headers\utility.bi"
  #Include Once "..\modified_fbgfx.bi" 
  
  #Include Once "..\headers\zlibfb.bi"
  
          
  Type _xml_type As xml_type
  Type _char_type As char_type
  
  Type b_sub As Sub( As Integer Ptr, As Integer Ptr )
  Type fp As Function ( As _char_type Ptr ) As Integer
  
  
  
  
  #Include "macros.bi" 
  #Include "engine_enums.bi" 
  
  
  #Include "image_structures.bi" 
  
  #Include "sequence_structures.bi" 
  
  #Include "object_structures.bi" 
  
  #Include "map_structures.bi" 
  
  #Include "lynn_structures.bi" 
  
  #Include "box_structures.bi" 
  
  #Include "global_structures.bi" 
  
  #IfDef ll_audio
  
    #Include "audio.bi" 
    
  #EndIf
  
  
  Extern ll_global As ll_system
  
  #IfDef __gmap__
    Extern gmap_global As gmap_system
    
  #EndIf
  
  
  #Include "ll_declares.bi" 
  
  #Include "..\headers\ll\object_control.bi"
  #Include "..\headers\ll\gfx.bi"
  
  #IfDef __gmap__
    #Include "..\headers\gmap\headers.bi"
    
  #EndIf
  
  Dim Shared As zString Ptr sound_path = @"data\sounds"


#EndIf '' LL_INCLUDE
