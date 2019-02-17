Option Explicit

#Include "..\headers\ll.bi"

#Include "..\com\xml.bas"
#Include "..\com\vfile.bas"
#Include "..\com\zfb.bas"

#Include "..\com\lists.bas"
#Include "..\com\utility.bas"
#Include "..\com\gfx.bas"
#Include "..\com\ll_build.bas"

Dim Shared As LL_SYSTEM LL_Global


Dim As list_type Ptr quickfix

quickfix = list_files( "c:\doc\prg", "*.*" )

? length( quickfix )


destroy( quickfix )

Sleep






