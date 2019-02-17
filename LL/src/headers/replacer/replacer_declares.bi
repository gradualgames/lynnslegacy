Type replacer_DataType

  As String toWord, fromWord

End Type


declare Function get_words_to_replace( ByRef replacerData As replacer_DataType ) As Integer
'Declare Function get_words_to_replace() As String Ptr
'Declare Function stretch_to_find_word( f As Any Ptr, w As String Ptr, n As Integer = 0 ) As Integer
'Declare Function scan_file( w As String Ptr, file_handle As easy_vector ) As Integer

Declare Function scan_file( wordData As replacer_DataType, file_handle As easy_vector ) As Integer
Declare Function stretch_to_find_word( f As Any Ptr, w As String, n As Integer = 0 ) As Integer
Declare Sub edit_file( l As list_type Ptr )
