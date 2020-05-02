'#IncLib "zFB"
#IncLib "z"

Enum z_Operations

  z_NULLARG

  z_STRTOSTR
  z_STRTOARRAY
  z_ARRAYTOSTR
  z_ARRAYTOARRAY

  z_Comp
  z_Decomp
  
End Enum


Declare Function zLib_DeCompress Overload Alias "_zLib_XXFlate" ( insrc As String,  outsrc As String,  l As Integer = 9, operation As Integer = z_STRTOSTR    , job As Integer = z_DeComp ) As Integer
Declare Function zLib_DeCompress Overload Alias "_zLib_XXFlate" ( insrc As String,  outsrc() As uByte, l As Integer = 9, operation As Integer = z_STRTOARRAY  , job As Integer = z_DeComp ) As Integer
Declare Function zLib_DeCompress Overload Alias "_zLib_XXFlate" ( insrc() As uByte, outsrc As String,  l As Integer = 9, operation As Integer = z_ARRAYTOSTR  , job As Integer = z_DeComp ) As Integer
Declare Function zLib_DeCompress Overload Alias "_zLib_XXFlate" ( insrc() As uByte, outsrc() As uByte, l As Integer = 9, operation As Integer = z_ARRAYTOARRAY, job As Integer = z_DeComp ) As Integer

Declare Function zLib_Compress   Overload Alias "_zLib_XXFlate" ( insrc As String,  outsrc As String,  l As Integer = 9, operation As Integer = z_STRTOSTR    , job As Integer = z_Comp   ) As Integer
Declare Function zLib_Compress   Overload Alias "_zLib_XXFlate" ( insrc As String,  outsrc() As uByte, l As Integer = 9, operation As Integer = z_STRTOARRAY  , job As Integer = z_Comp   ) As Integer
Declare Function zLib_Compress   Overload Alias "_zLib_XXFlate" ( insrc() As uByte, outsrc As String,  l As Integer = 9, operation As Integer = z_ARRAYTOSTR  , job As Integer = z_Comp   ) As Integer
Declare Function zLib_Compress   Overload Alias "_zLib_XXFlate" ( insrc() As uByte, outsrc() As uByte, l As Integer = 9, operation As Integer = z_ARRAYTOARRAY, job As Integer = z_Comp   ) As Integer

Declare Function zlib_Error( e As Integer ) As String
