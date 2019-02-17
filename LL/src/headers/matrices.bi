Type vector

  As Double x, y

End Type

Type vector_Integer

  As Integer x, y

End Type

Type vector_pair

  As vector u, v

End Type

Type vector3D

  As Double x, y, z

End Type

Type vector_pair3D

  As vector3D u, v

End Type


'#Define V2_Subtract(__U__,__V__) _
'  Type<vector>( (@__U__)->x - (@__V__)->x, (@__U__)->y - (@__V__)->y )
'
'#Define V2_Add(__U__,__V__) _
'  Type<vector>( (@__U__)->x + (@__V__)->x, (@__U__)->y + (@__V__)->y )
'
'#Define V2_MidPoint(__PAIR__) _
'  V2_Add( (@__PAIR__)->u, V2_Scale( (@__PAIR__)->v, .5 ) )
'
'#Define V2_DotProduct(__U__,__V__) _
'  ( (@__U__)->x * (@__V__)->x + (@__U__)->y * (@__V__)->y )
'
'#Define V2_Scale(__U__,__K__) _
'  Type<vector>( (@__U__)->x * __K__, (@__U__)->y * __K__ )


Declare Function V2_Add( hi As vector, lo As vector ) As vector
Declare Function V2_DotProduct( v As vector, v2 As vector ) As Double
Declare Function V2_Midpoint( m As vector_pair ) As vector
Declare Function V2_Scale( v As vector, k As Double ) As vector
Declare Function V2_Subtract( hi As vector, lo As vector ) As vector

Declare Function V3_Add( hi As vector3D, lo As vector3D ) As vector3d
Declare Function V3_DotProduct( v As vector3D, v2 As vector3D ) As Double
Declare Function V3_Midpoint( m As vector_pair3D ) As vector3D
Declare Function V3_Scale( v As vector3D, k As Double ) As vector3d
Declare Function V3_Subtract( hi As vector3D, lo As vector3D ) As vector3d


Declare Function V2_Absolute( v As vector ) As vector
Declare Function V3_Absolute( v As vector3D ) As vector3d


Declare Function V2_CalcFlyback( m As vector, n As vector ) As vector




Declare Function Get_Angle(u As vector, v As vector) As Double 



Declare Function check_bounds( m As vector_pair, n As vector_pair ) As Integer
  
'#IfNDef pi
'  #Define pi ( 3.1415926535897932384626433832795 )
'
'#EndIf 
'
'#IfNDef rad
'  #Define rad ( pi / 180 )
'  
'#EndIf
'




