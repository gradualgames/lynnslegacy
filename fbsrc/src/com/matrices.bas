Option Explicit

#Include "..\headers\ll.bi"

'#Include "..\headers\matrices.bi"

#IfNDef is_QNAN
  #Define is_QNAN(__CHECKME__) ( ( Cast( Integer Ptr, Varptr( __CHECKME__ ) )[1] = &h7FF80000UL ) Or ( Cast( Integer Ptr, Varptr( __CHECKME__ ) )[1] = &hFFF80000UL ) )

#EndIf

#IfNDef is_INF
  #Define is_INF(__CHECKME__) ( Cast( Integer Ptr, Varptr( __CHECKME__ ) )[1] = &h7FF00000UL )

#EndIf

#IfNDef is_LegalNumber
  #Define is_LegalNumber(__CHECKME__) ( Not ( is_QNAN( __CHECKME__ ) Or is_INF( __CHECKME__ ) ) )
  
#EndIf



Function V2_Subtract( hi As vector, lo As vector ) As vector

  Function = Type( hi.x - lo.x, hi.y - lo.y )

End Function

Function V3_Subtract( hi As vector3D, lo As vector3D ) As vector3d

  Function = Type( hi.x - lo.x, hi.y - lo.y, hi.z - lo.z )

End Function

Function V2_Add( hi As vector, lo As vector ) As vector

  Function = Type( hi.x + lo.x, hi.y + lo.y )

End Function

Function V3_Add( hi As vector3D, lo As vector3D ) As vector3d

  Function = Type( hi.x + lo.x, hi.y + lo.y, hi.z + lo.z )

End Function

Function V2_Midpoint( m As vector_pair ) As vector
                 
  Function = V2_Add( m.u, V2_Scale( m.v, .5 ) )
  
End Function

Function V3_Midpoint( m As vector_pair3D ) As vector3D

  Function = V3_Add( m.u, V3_Scale( m.v, .5 ) )

End Function

Function V2_DotProduct( v As vector, v2 As vector ) As Double

  Function = v.x * v2.x + v.y * v2.y
  
End Function 

Function V3_DotProduct( v As vector3D, v2 As vector3D ) As Double

  Function = v.x * v2.x + v.y * v2.y + v.z * v2.z
  
End Function 

Function V2_Scale( v As vector, k As Double ) As vector

  Function = Type( v.x * k, v.y * k )
  
End Function 

Function V3_Scale( v As vector3D, k As Double ) As vector3d

  Function = Type( v.x * k, v.y * k, v.z * k )
  
End Function 

Function V2_Absolute( v As vector ) As vector

  Function = Type( Abs( v.x ), Abs( v.y ) )
  
End Function 

Function V3_Absolute( v As vector3D ) As vector3d

  Function = Type( Abs( v.x ), Abs( v.y ), Abs( v.z ) )
  
End Function 

  
  '' Great code from CoderJeff at http://freebasic.net/forum
  ''                                      
  ''
  '' An Approximation
  '' m = V3_DotProduct(distance, distance) / (Abs(distance.x) + Abs(distance.y) + Abs(distance.z))

  '' Exact
  '' m = sqr( V3_DotProduct(distance, distance) )
Function V2_CalcFlyback( m As vector, n As vector ) As vector
  
  Dim As vector distance = V2_Subtract( m, n )
  Dim As vector res = V2_Scale( distance, 1 / Sqr( V2_DotProduct( distance, distance ) ) )
  
  If is_LegalNumber( res.x ) = 0 Then
    res.x = 0 
    
  End If 
  
  If is_LegalNumber( res.y ) = 0 Then
    res.y = 0 
    
  End If
  
  
  Return res
  
End Function
  ''


Function check_bounds ( m As vector_pair, n As vector_pair ) As Integer
  

  Dim As vector touching


  If m.u.x + m.v.x > n.u.x Then 
    If m.u.x < ( n.u.x + n.v.x ) Then 
      touching.x = Not 0
      
    End If

  End If
     
  If m.u.y + m.v.y > n.u.y Then 
    If m.u.y < n.u.y + n.v.y Then 
      touching.y = Not 0
      
    End If
  
  End If
  

  If touching.x And touching.y Then 
    Return 0 
  
  Else 
    Return -1

  End If


End Function


Function Get_Angle( u As vector, v As vector ) As Double 


  Dim As Double o, a 

    o = Abs( v.y - u.y ) 
    a = Abs( v.x - u.x ) 
    
    If v.y = u.y And ( v.x > u.x ) Then Return 90 
    If v.y = u.y And ( v.x < u.x ) Then Return 270 
    
    If v.x = u.x And ( v.y > u.y ) Then Return 180 
    If v.x = u.x And ( v.y < u.y ) Then Return 0    
    
    If ( v.y < u.y ) And ( v.x > u.x ) Then 
      Return 180 - ( ( Atn( o / a ) / rad ) + 90 ) 

    ElseIf ( v.y > u.y ) And ( v.x > u.x ) Then 
      Return ( ( Atn( o / a ) / rad ) + 90 ) 

    End If 

    If ( v.y < u.y ) And ( v.x < u.x ) Then 
      Return 180 + ( ( Atn( o / a ) / rad ) + 90 ) 

    ElseIf ( v.y > u.y ) And ( v.x < u.x ) Then 
      Return 360 - ( ( Atn( o / a ) / rad ) + 90 ) 

    End If 


End Function  


