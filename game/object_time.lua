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
