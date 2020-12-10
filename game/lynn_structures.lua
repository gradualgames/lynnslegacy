-- Type songFading_type
function create_songFading_type()
--
  local songFading_type = {}
--   pulse As Double
  songFading_type.pulse = 0.0
--   pulseLength As Double
  songFading_type.pulseLength = 0.0
--
--   travelled As Integer
  songFading_type.travelled = 0
--
--
--
  return songFading_type
-- End Type
end

function create_main_char_type()
  local main_char_type = {}
-- Type main_char_type
--
--   action As Integer
--   action_lock As Integer
  main_char_type.action_lock = 0
--
--   attacking As Integer
  main_char_type.attacking = 0
--   b_key As Integer
  main_char_type.b_key = 0
--   crazy_points As Integer
  main_char_type.crazy_points = 0
--   crazy_cache As Integer
  main_char_type.crazy_cache = 0
--   crazy_dcache As Integer
  main_char_type.crazy_dcache = 0
--
--   has_bar As Integer
--   has_item As Integer
  main_char_type.has_item = 0
--   hasItem( 5 ) as integer
  main_char_type.hasItem = {[0] = 0, 0, 0, 0, 0}
--
--
--   has_weapon As Integer
  main_char_type.has_weapon = 0
--
--
--   powder As Integer
  main_char_type.powder = 0
--
--   selected_item As Integer
  main_char_type.selected_item = 0
--
--   weapon As Integer
  main_char_type.weapon = 0
--
--   invisibleEntry As Integer
  main_char_type.invisibleEntry = 0
--
--   hasCostume( 8 ) As Byte
  main_char_type.hasCostume = {[0] = 0, 0, 0, 0, 0, 0, 0, 0}
--   isWearing As Integer
  main_char_type.isWearing = 0
--
--   fadeStyle As Integer
  main_char_type.fadeStyle = 0
--
--   isLoading As Integer
  main_char_type.isLoading = 0
--
--   dropoutSequence As Integer
  main_char_type.dropoutSequence = false
--
--   quakeViolence As Integer
--
--   songFade As songFading_type Ptr
  main_char_type.songFade = nil
--
--   healTimer as double
--
--   specialSequence as sequence_type ptr
--
--   adrenaline as double
  main_char_type.adrenaline = 0.0
  --NOTE: adrenalineState was originally a static variable within the hero_main
  --function in engine-LL.bas. Moved it in here instead.
  main_char_type.adrenalineState = 0
--
--   healing as integer
--   healingFrame as integer
--   healingImage as LLSystem_ImageHeader ptr
--
--   roomVisited as byte ptr
  --NOTE: I do not understand where this is initially allocated nor how many
  --entries there ought to be.
  main_char_type.roomVisited = {}
  for i = 0, 255 do
    main_char_type.roomVisited[i] = 0
  end
--
--   healthdummy( 3 ) as integer
--   maxhealthdummy( 3 ) as integer
--   weapondummy( 3 ) as integer
--   itemdummy  ( 5, 3 ) as integer
--   outfitdummy( 5, 3 ) as integer
--   moneydummy ( 3 ) as integer
--
--   randomizer as integer
--   randomizer2 as integer
--
--   randomized as integer
--
-- End Type
  return main_char_type
end
