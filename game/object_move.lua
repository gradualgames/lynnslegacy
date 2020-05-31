require("game/engine_enums")

function copter_path(this)
  local exit_cond, c = 0, 0
--
--   this->walk_buffer = this->walk_length
  this.walk_buffer = this.walk_length
--
--   Dim As Integer exit_cond, c
--
--
--   Do
  repeat
--
--     Dim rand_dir As Integer = Int ( Rnd * 8 ) - 1
    local rand_dir = math.floor(love.math.random() * 8) - 1
--
--     this->direction += rand_dir
    this.direction = this.direction + rand_dir
--     If this->direction = -1 Then this->direction = 7
    if this.direction == -1 then this.direction = 7 end
--     this->direction = Abs( this->direction ) And 7
    this.direction = bit.band(math.abs(this.direction), 7)
--
--
--     If move_object( this, MO_JUST_CHECKING ) = 0 Then
    if move_object(this, MO_JUST_CHECKING) == 0 then
--     Else
    else
--       exit_cond = -1
      exit_cond = -1
--
--     End If
    end
--
--     c+= 1
    c = c + 1
--     If c = 20 Then
    if c == 20 then
--       exit_cond = -1
      exit_cond = -1
--
--     End If
    end
--
--
--   Loop While exit_cond = 0
  until exit_cond ~= 0
--
-- '  this->direction = Int ( Rnd * 8 )
--
--
--   Return 1
  return 1
--
end
