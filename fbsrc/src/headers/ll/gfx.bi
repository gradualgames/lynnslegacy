Declare Sub blit_scene()    
Declare Sub handle_fps()

Declare Sub blit_layer( lyr As Integer, holder As Any Ptr = 0, flag As Integer = -1, rs_x As Integer = 0, rs_y As Integer = 0 )
Declare Sub blit_room()
Declare Sub blit_object( this As char_type Ptr )
Declare Sub shift_pal()


Declare Sub blit_enemy_proj( _enemy As char_type Ptr )

Declare Sub blit_enemy( _enemy As char_type )
Declare Sub blit_enemy_loot()
Declare Sub blit_y_sorted()



Declare Sub blit_hud( e As _char_type Ptr = 0 )
Declare Sub blit_box( t_box As boxcontrol_type Ptr )

Declare Function sort_index( ary() As char_type Ptr, bank As char_type Ptr Ptr, bank_size As Integer Ptr, banks As Integer ) As Integer



Declare Sub top_rows( b As boxcontrol_type Ptr )
Declare Sub current_row( b As boxcontrol_type Ptr )
  Declare Function load_pal( filename As String, As Integer = 0 ) As Integer Ptr  

Declare Function blit_image( x As Integer, y As Integer, img As LLSystem_ImageHeader, directional As Integer = 0, frame As Integer = 0 )

Declare Sub LLEngine_MouseVanish()


