function second_pause(this)
  local timer = love.timer.getTime()

  if this.pause == 0 then
    this.pause = timer + 1
  end

  if timer >= this.pause then
    log.debug("secondPause completed for enemy: "..this.id)
    this.pause = 0
    return 1
  end

  return 0
end
