Option Explicit

Enum
  list_reverse = -1
  list_dealloc = 1
  list_strlist = 2

  list_search_instr = -1
  
End Enum

Enum dir_calls

  fb_DirNormal
  fb_DirReadOnly = 1
  fb_DirHidden = 2
  fb_DirSystem = 4
  fb_DirDirectories = 16
  fb_DirArchive = 32
   
  
End Enum
                            

#IfNDef Arg_Types
  Enum Arg_Types
  
    ARG_AMBIGUOUS
    ARG_INT
    ARG_UINT
    ARG_STR
    ARG_SNG
    ARG_DBL
    ARG_ULNG
    ARG_LNG
    ARG_PTR
  
  End Enum
  
#EndIf

Union list_value
  i As Integer
  ui As uInteger
  sn As Single
  s As String
  d As Double
  l As LongInt
  ul As uLongInt
  pnt As Any Ptr
  
End Union

Type list_type
  
  dat As list_value
  nxt As list_type Ptr  
  
End Type


'' lists
'' !!!!!!!!!!!!!!!!!!!!!!!!!!!

Declare Function length                   ( node As list_type Ptr ) As Integer                           
Declare Sub      destroy                  ( node As list_type Ptr, dalloc As Integer = 0 )
Declare Function list_Cancel Overload Alias "ListCancel" ( m As list_type Ptr, l As list_type Ptr, value As String, id As Integer = ARG_STR ) As list_type Ptr
Declare Function list_files ( pth As String = ".", spec As String = "*.*", mask As Integer = 0 ) As list_type Ptr
Declare Sub iterate_through_list( l As list_type Ptr, fp As Sub( l As list_type Ptr ) )                


#IncLib "lists"


Sub list_print( l As list_type Ptr )

  If l = 0 Then Exit Sub
  ? l->dat.s
  
End Sub

Function cha0s_dir( pth As String = ".", spec As String = "*.*", flags As Integer = fb_DirNormal ) As list_type Ptr

  Dim As list_type Ptr normal, masked, res
  
  normal = list_Files( pth, spec, fb_DirNormal )
  masked = list_Files( pth, spec, flags )
  
  
  res = list_Cancel( masked, normal, " " )
  
  ? length( res )
  Sleep

  destroy( normal, list_strlist )
  destroy( masked, list_strlist )
  
  
  Return res
  
End Function

Dim As list_type Ptr hidden_files, archive_files, readonly_files

hidden_files = cha0s_dir( "d:\prg\ll\data\object","*.xml" , fb_DirHidden )
archive_files = cha0s_dir( , , fb_DirArchive )
readonly_files = cha0s_dir( , , fb_DirReadOnly )

? "hidden files:"
iterate_through_list( hidden_files, @list_print )

? "archive files:"
iterate_through_list( archive_files, @list_print )

? "read_only files:"
iterate_through_list( readonly_files, @list_print )

Sleep

destroy( hidden_files, list_strlist )
destroy( archive_files, list_strlist )
destroy( readonly_files, list_strlist )

