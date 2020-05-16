require("game/load/loadxml")
require("game/cache")

function updateEnemies()
  for i, enemy in pairs(enemies) do
    if enemy.fp then
      local fp = enemy.fp[enemy.fpIndex]
      if fp.func then
        local func = fp.func
        if func[enemy.funcIndex] then
          if func[enemy.funcIndex](enemy) == 1 then
            --advance to next func of the current fp state
            enemy.funcIndex = enemy.funcIndex + 1
          end
        end
      end
    end
  end
end
