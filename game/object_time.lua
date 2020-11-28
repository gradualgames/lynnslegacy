-- Function __half_second_pause ( this As _char_type Ptr ) As Integer
function __half_second_pause(this)
  log.debug("__half_second_pause called on: "..this.id)
--
--   this->frame = 0
  this.frame = 0
--
--
--
--
--   If this->pause = 0 Then
  if this.pause == 0 then
--
--     this->pause = Timer + .5
    this.pause = timer + .5
--
--
--   End If
  end
--
--   If Timer >= this->pause Then
  if timer >= this.pause then
--     this->pause = 0
    this.pause = 0
--
--     Return 1
    return 1
--
--
--   End If
  end
--
--
  return 0
-- End Function
end

function __second_pause(this)
  --log.debug("__second_pause called.")
  if this.pause == 0 then
    this.pause = timer + 1
  end

  if timer >= this.pause then
    --log.debug("__second_pause completed for enemy: "..this.id)
    this.pause = 0
    return 1
  end

  return 0
end

-- Function __counted_jump ( this As _char_type Ptr ) As Integer
function __counted_jump(this)
--
--
--   If this->jump_count = this->jump_counter Then
  if this.jump_count == this.jump_counter then
--
--     this->jump_counter = 0
    this.jump_counter = 0
--
--     Return 1
    return 1
--
--   End If
  end
--   this->jump_counter += 1
  this.jump_counter = this.jump_counter + 1
--
--   Return -1
  return -1
--
--
--
-- End Function
end
--
--
--
-- Function __counted_jump_2 ( this As _char_type Ptr ) As Integer
function __counted_jump_2(this)
--
--
--
--   If this->jump_count = this->jump_counter Then
  if this.jump_count == this.jump_counter then
--
--     this->jump_counter = 0
    this.jump_counter = 0
--
--     Return 1
    return 1
--
--   End If
  end
--
--   this->jump_counter += 1
  this.jump_counter = this.jump_counter + 1
--
--   Return -2
  return -2
--
--
--
-- End Function
end

-- Function __return_reset ( this As _char_type Ptr ) As Integer
function __return_reset(this)
  log.debug("__return_reset called.")
--
--   this->funcs.current_func[this->funcs.active_state] = 0
  this.funcs.current_func[this.funcs.active_state] = 0
--
--   this->funcs.active_state = this->reset_state
  this.funcs.active_state = this.reset_state
--
--   Return 0
  return 0
--
-- End Function
end

-- Function __return_idle ( this As _char_type Ptr ) As Integer
function __return_idle(this)
  log.debug("__return_idle called on "..this.id)
  log.debug("this.return_trig: "..this.return_trig)
--
--
--   this->funcs.current_func[this->funcs.active_state] = 0
  this.funcs.current_func[this.funcs.active_state] = 0
--   this->funcs.active_state = 0
  this.funcs.active_state = 0
--   this->funcs.current_func[this->funcs.active_state] = 0
  this.funcs.current_func[this.funcs.active_state] = 0
--
--   Return 0
  return 0
--
--
-- End Function
end
