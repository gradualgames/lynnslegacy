function second_pause(this)
  --log.debug("second_pause called.")
  local timer = love.timer.getTime()

  if this.pause == 0 then
    this.pause = timer + 1
  end

  if timer >= this.pause then
    --log.debug("second_pause completed for enemy: "..this.id)
    this.pause = 0
    return 1
  end

  return 0
end
