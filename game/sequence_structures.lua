-- Type command_data
function create_command_data()
--
  local command_data = {}
--
--   active_ent  As Integer
  command_data.active_ent = 0
--   ent_func    As Integer
  command_data.ent_func = 0
--   ent_state  As Integer
  command_data.ent_state = 0
--   hold_state  As Integer
  command_data.hold_state = 0
--
--
--   text        As String
  command_data.text = ""
--
--   chap        As Integer
  command_data.chap = 0
--   jump_count  As Integer
  command_data.jump_count = 0
--
--   mod_x As Short
  command_data.mod_x = 0
--   mod_y As Short
  command_data.mod_y = 0
--
-- '  to_map      As Integer
--   to_map      As String
  command_data.to_map = ""
--
--
--
--
--   to_entry    As Integer
  command_data.to_entry = 0
--   Union
--     walk_speed As Double
  command_data.walk_speed = 0.0
--     auto_box   As Double
  command_data.auto_box = 0.0
--
--   End Union
--
--   Union
--     water_align As Integer
  command_data.water_align = 0
--     text_speed As Integer
  command_data.text_speed = 0
--
--   End Union
--
--   dest_xy     As uInteger
  command_data.dest_xy = 0
--   Union
--     dest_x     As Short
  command_data.dest_x = 0
--     text_color As Short
  command_data.text_color = 0
--   End Union
--   Union
--     dest_y    As Short
  command_data.dest_y = 0
--     box_invis As Short
  command_data.box_invis = 0
--   End Union
--
--   nocam       As Integer
  command_data.nocam = 0
--
--   carries_all As Integer
  command_data.carries_all = 0
--
--   abs_x As Short
  command_data.abs_x = 0
--   abs_y As Short
  command_data.abs_y = 0
--   Union
  --NOTE: Removed .reserved_1 because it is a union with .modify_direction
--     reserved_1       As Integer ''direction...
--     modify_direction As Integer
  command_data.modify_direction = 0
--
--   End Union
--
--   Union
  --NOTE: Removed .reserved_2 because it is a union with .seq_pause
--     reserved_2 As Integer '' paused
--     seq_pause  As Integer '' paused
  command_data.seq_pause = 0
--
--   End Union
--
--   reserved_3 As Integer '' affect in
  command_data.reserved_3 = 0
--   reserved_4 As Integer '' affect out
  command_data.reserved_4 = 0
--
--
--   Union
--NOTE: Removed .reserved_5 because it is a union with .free_to_move
--     reserved_5 As Integer '' action-lock
--     free_to_move As Integer
  command_data.free_to_move = 0
--   End Union
--   Union
--NOTE: Removed .reserved_6 because it is a union with .display_hud
--     reserved_6 As Integer '' hud display
--     display_hud As Integer
  command_data.display_hud = 0
--   End Union
--
--   fadeTime as double
  command_data.fadeTime = 0.0
--
-- '  reserved_7 As Integer
-- '  reserved_8 As Integer
--
--   reserved_9 As Integer
  command_data.reserved_9 = 0
--   reserved_10 As Integer
  command_data.reserved_10 = 0
--
--
--   reserved_11 As Integer ' don't touch
  command_data.reserved_11 = 0
--
--
  return command_data
-- End Type
end
--
--
-- Type command_type
function create_command_type()
--
  local command_type = {}
--   ents As Integer
  command_type.ents = 0
--   ent As command_data Ptr
  command_type.ent = {}
--
--
  return command_type
-- End Type
end
--
--
-- Type sequence_type
function create_sequence_type()
--
  local sequence_type = {}
--   ents As Integer
  sequence_type.ents = 0
--   ent_code As Integer Ptr
  sequence_type.ent_code = {}
--   ent As _char_type Ptr Ptr
  sequence_type.ent = {}
--
--   commands As Integer
  sequence_type.commands = 0
--   Command As command_type Ptr
  sequence_type.Command = {}
--   current_command As Integer
  sequence_type.current_command = 0
--
--   seq_type As String
  sequence_type.seq_type = ""
--   seq_index As Integer
  sequence_type.seq_index = 0
--
  return sequence_type
-- End Type
end
--
--
