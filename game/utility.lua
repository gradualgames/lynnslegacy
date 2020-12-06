-- Type mat_int
function create_mat_int()
--
  local mat_int = {}
--   As Integer x, y
  mat_int.x = 0
  mat_int.y = 0
--
  return mat_int
-- End Type
end

music_strings = {
-- Dim Shared As zString Ptr music_strings( 25 ) => _
--   { _
--     /'0'/ @"",                    _
  [0] = "",
--     /'1'/ @"data\music\amb.it", _
  "data/music/amb.it",
--     /'2'/ @"data\music\apox.it", _
  "data/music/apox.it",
--     /'3'/ @"data\music\beneath.it", _
  "data/music/beneath.it",
--     /'4'/ @"data\music\boss.it", _
  "data/music/boss.it",
--     /'5'/ @"data\music\boss2.it", _
  "data/music/boss2.it",
--     /'6'/ @"data\music\core.it", _
  "data/music/core.it",
--     /'7'/ @"data\music\cryspool.it", _
  "data/music/cryspool.it",
--     /'8'/ @"data\music\dimension2.it", _
  "data/music/dimension2.it",
--     /'9'/ @"data\music\dimhole.it", _
  "data/music/dimhole.it",
--    /'10'/ @"data\music\dream.it", _
  "data/music/dream.it",
--    /'11'/ @"data\music\evernight.it", _
  "data/music/evernight.it",
--    /'12'/ @"data\music\final.it", _
  "data/music/amb.it",
--    /'13'/ @"data\music\forest.it", _
  "data/music/forest.it",
--    /'14'/ @"data\music\fsun.it", _
  "data/music/fsun.it",
--    /'15'/ @"data\music\holy.it", _
  "data/music/holy.it",
--    /'16'/ @"data\music\limbo.it", _
  "data/music/limbo.it",
--    /'17'/ @"data\music\logosta.it", _
  "data/music/logosta.it",
--    /'18'/ @"data\music\master.it", _
  "data/music/master.it",
--    /'19'/ @"data\music\sdesert.it", _
  "data/music/sdesert.it",
--    /'20'/ @"data\music\title.it", _
  "data/music/title.it",
--    /'21'/ @"data\music\town.it", _
  "data/music/town.it",
--    /'22'/ @"data\music\valley.it", _
  "data/music/valley.it",
--    /'23'/ @"data\music\world.it", _
  "data/music/world.it",
--    /'24'/ @"data\music\after.it", _
  "data/music/after.it",
--    /'25'/ @"data\music\faulty.it" _
  "data/music/faulty.it"
--   }
}

--Const As Double pi = Atn(1) * 4
pi = math.atan(1) * 4
--Const As Double rad = ( pi / 180 )
rad = (pi / 180)

-- Type tile_quad
function create_tile_quad()
  local tile_quad = {}
--
--   x As Integer
  tile_quad.x = 0
--   y As Integer
  tile_quad.y = 0
--   quad As Integer
  tile_quad.quad = 0
--
  return tile_quad
-- End Type
end
