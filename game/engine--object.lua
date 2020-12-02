require("game/engine--object_XML")
require("game/engine_enums")

--NOTE: One of the most significant departures from the original
--codebase is how object data is loaded and cached. In the original
--codebase, all object XML was loaded into template objects which were
--then deep copied. In our system, all xml files themselves get parsed
--and cached, and when we want a deep copy we actually call the xml loading
--system to get the copy. This is done in place of all of the property and
--pointer loading code. But the basic structure of loading new objects is
--preserved so that we preserve information such as the id, x_origin,
--y_origin and other initial state information that is loaded into objects
--when maps are loaded. So there's no source and destination parameter,
--just destination because we always know the object id from when the
--map is loaded. The "source" is really just the xml which we know from
--the id when we perform the deep copy. There are only two spots where
--deep copies are made in the original code: Here where a new object is
--loaded, and also some special code in set_up_room_enemies which replaces
--an object with the contents of null.xml, but we can simulate that logic
--(see comments in set_up_room_enemies). There's nowhere in the original
--code that I can find where a "deep copy" is made of an object whose
--state has been mutating during gameplay---it is really onhly ever copying
--the original data in xml files. I am fairly confident that we are logically
--doing the same things in the same order.

-- Sub LLSystem_CopyNewObject( objectCopy As char_type )
function LLSystem_CopyNewObject(objectCopy)
--
--   LLSystem_ObjectDeepCopy( objectCopy, *LLSystem_ObjectDeref( LLSystem_ObjectDerefName( objectCopy.id ) ) )
  LLSystem_ObjectDeepCopy(objectCopy)
-- End Sub
end

-- Private Sub LLSystem_ObjectShallowCopy( d As _char_type, s As _char_type )
function LLSystem_ObjectShallowCopy(d)
--
--
-- ' id as string
-- ' spawns_id as string
-- ' to_map as string
  local id, spawns_id, to_map = d.id, d.spawns_id, d.to_map
--
--   MemCpy( Varptr( d ), Varptr( s ), Len( _char_type ) )
-- '  d = s '' same.... but no warning =).
--
--   Clear d.id       , 0, Len( String )
--   Clear d.spawns_id, 0, Len( String )
--   Clear d.to_map   , 0, Len( String )
  init_object(d)
--
--   d.id = s.id
  d.id = id
--   d.spawns_id = s.spawns_id
  d.spawns_id = spawns_id
--   d.to_map = s.to_map
  d.to_map = to_map
--
--   Assert( diffAddress( id ) )
--   Assert( diffAddress( spawns_id ) )
--   Assert( diffAddress( to_map ) )
--
-- End Sub
end
--
--
-- Private Sub LLSystem_ObjectInitialCopy( d As _char_type, s As _char_type )
function LLSystem_ObjectInitialCopy(d)
--
--
--   Dim As Integer x_origin, y_origin, direction, chap, seq_here, ori_dir
  local x_origin, y_origin, direction, chap, seq_here, ori_dir = 0, 0, 0, 0, 0, 0
--
--   Dim As Integer spawn_cond
  local spawn_cond = 0
--
--   Dim As sequence_type Ptr seq
  local seq = {}
--
--   Dim As LLObject_ConditionalSpawn Ptr spawn_info
  local spawn_info = {}
--
--
--   x_origin = d.x_origin
  x_origin = d.x_origin
--   y_origin = d.y_origin
  y_origin = d.y_origin
--   direction = d.direction
  direction = d.direction
--
--   chap = d.chap
  chap = d.chap
--
--   seq_here = d.seq_here
  seq_here = d.seq_here
--   seq = d.seq
  seq = d.seq
--
--   spawn_cond = d.spawn_cond
  spawn_cond = d.spawn_cond
--   spawn_info = d.spawn_info
  spawn_info = d.spawn_info
--
--   ori_dir = d.ori_dir
  ori_dir = d.ori_dir
--
--
--   LLSystem_ObjectShallowCopy( d, s )
  LLSystem_ObjectShallowCopy(d)
--
--
--   d.x_origin = x_origin
  d.x_origin = x_origin
--   d.y_origin = y_origin
  d.y_origin = y_origin
--   d.direction = direction
  d.direction = direction
--
--   d.coords.x = x_origin
  d.coords.x = x_origin
--   d.coords.y = y_origin
  d.coords.y = y_origin
--
--   d.chap = chap
  d.chap = chap
--
--   d.seq_here = seq_here
  d.seq_here = seq_here
--   d.seq = seq
  d.seq = seq
--
--   d.spawn_cond = spawn_cond
  d.spawn_cond = spawn_cond
--   d.spawn_info = spawn_info
  d.spawn_info = spawn_info
--
--   d.ori_dir = ori_dir
  d.ori_dir = ori_dir
--
--
-- End Sub
end

-- Sub LLSystem_ObjectDeepCopy( d As _char_type, s As _char_type )
function LLSystem_ObjectDeepCopy(d, s)
--
--
-- ' id as string
-- ' spawns_id as string
-- ' to_map as string
--
--   Dim As Integer i, j, k
--
--   #Define copy_Pointer(pnt,sz,elem)                 _
--                                                     _
--     If s.##pnt <> 0 Then                           :_
--       d.##pnt = CAllocate( sz * Len( elem ) )      :_
--       MemCpy( d.##pnt, s.##pnt, sz * Len( elem ) ) :_
--                                                    :_
--     End If
--
--   #Define dbg_PrintSidebyside(x) ? d.##x, s.##x
--
--
--   LLSystem_ObjectInitialCopy( d, s )
  LLSystem_ObjectInitialCopy(d)
--
--   copy_Pointer( sound, s.sounds, Integer )
--   Assert( diffAlloc( sound ) )
--
--   copy_Pointer( vol,   s.sounds, Integer )
--   Assert( diffAlloc( vol ) )
--
--   copy_Pointer( funcs.func_count,   s.funcs.states, Integer )
--   Assert( diffAlloc( funcs.func_count ) )
--
--   copy_Pointer( funcs.current_func, s.funcs.states, Integer )
--   Assert( diffAlloc( funcs.current_func ) )
--
--   d.funcs.func = CAllocate( s.funcs.states * Len( fp Ptr ) )
--
--   For i = 0 To s.funcs.states - 1
--     copy_Pointer( funcs.func[i], s.funcs.func_count[i], fp )
--     Assert( diffAlloc( funcs.func[i] ) )
--
--   Next
--
--   copy_Pointer( anim, s.anims, LLSystem_ImageHeader Ptr )
--   Assert( diffAlloc( anim ) )
--
--   copy_Pointer( animControl, s.anims, LLObject_ImageHeader )
--   Assert( diffAlloc( animControl ) )
--
--   If s.projectile Then
--
--     copy_Pointer( projectile, 1, ll_entity_projectile )
--     Assert( diffAlloc( projectile ) )
--
--     copy_Pointer( projectile->coords, s.projectile->projectiles, vector )
--     Assert( diffAlloc( projectile->coords ) )
--
--   End If
--
--   For i = 0 To s.anims - 1
--
--     copy_Pointer( animControl[i].frame, s.anim[i]->frames, LLObject_FrameControl )
--     Assert( diffAlloc( animControl[i].frame ) )
--
--     For j = 0 To s.anim[i]->frames - 1
--
--       If s.animControl[i].frame[j].concurrents > 0 Then
--         copy_Pointer( animControl[i].frame[j].concurrent, s.animControl[i].frame[j].concurrents, LLObject_FrameConcurrent )
--         Assert( diffAlloc( animControl[i].frame[j].concurrent ) )
--
--         ''
--         For k = 0 To s.animControl[i].frame[j].concurrents - 1
--
--           With s.animControl[i].frame[j].concurrent[k]
--
--             LLSystem_CopyNewObject( *.char )
--
--           End With
--
--         Next
--
--       End If
--
--     Next
--
--   Next
--
  --NOTE: All of the deep copy code above is simulated here by loading
  --directly from cached XML.
  LLSystem_ObjectLoad(d)
--
--   d.drop = CAllocate( Len( _char_type ) )
  d.drop = create_Object()
--   d.drop->anims = 3
  d.drop.anims = 3
--
--   d.drop->anim = CAllocate( d.drop->anims * Len( LLSystem_ImageHeader Ptr ) )
  d.drop.anim = {}
--
--   d.drop->anim[0] = LLSystem_ImageDeref( LLSystem_ImageDerefName( "data\pictures\char\helth.spr"  ) )
  d.drop.anim[0] = getImageHeader("data/pictures/char/helth.spr")
--   d.drop->anim[1] = LLSystem_ImageDeref( LLSystem_ImageDerefName( "data\pictures\char\gold.spr"   ) )
  d.drop.anim[1] = getImageHeader("data/pictures/char/gold.spr")
--   d.drop->anim[2] = LLSystem_ImageDeref( LLSystem_ImageDerefName( "data\pictures\char\silver.spr" ) )
  d.drop.anim[2] = getImageHeader("data/pictures/char/silver.spr")
--
--   d.direction = d.ori_dir
  d.direction = d.ori_dir
--
--
--   #IfNDef LL_Minimal
--
--     If d.unique_id = u_angerfireball Then
--       __anger_fireball_lock( Varptr( d ) )
--
--     End If
--
--     If d.unique_id = u_cell Then
--       d.direction = int( rnd * 4 ) + 4
--
--     End If
--
--   #EndIf
--
--
-- End Sub
end

-- Private Sub LLObject_UniqueCheck( c As char_type )
function LLObject_UniqueCheck(c)

  --NOTE: I think the entire function below can be done just by extracting the
  --name of the object from its id (xml file path) and removing all but the name
  --then prefixing it with u_. Then, the global enums for unique ids should be
  --able to be looked up in _G.
  local name = string.gsub(c.id, "data/object/", "")
  name = string.gsub(name, ".xml", "")
  name = "u_"..name
  if _G[name] then
    c.unique_id = _G[name]
    --log.level = "debug"
    --log.debug("Object name: "..name)
    --log.debug("Object unique id: "..c.unique_id)
    --log.level = "fatal"
  end

--
--   #Define this_object(x) _
--
--
--   #Define check_object_id(__x__)                                                _
--                                                                                 _
--     If ( Right( .id, Len( ###__x__ & ".xml" ) ) = ( ###__x__ & ".xml" ) ) Then :_
--       .unique_id = u_##__x__                                                   :_
--       Exit Sub                                                                 :_
--                                                                                :_
--     End If                                                                     :_
--
--
--   With c
--
--     check_object_id( beamcrystal   )
--     check_object_id( bluechest     )
--     check_object_id( chest         )
--     check_object_id( bluechestitem )
--     check_object_id( gbutton       )
--     check_object_id( button        )
--     check_object_id( bshape        )
--     check_object_id( gshape        )
--     check_object_id( bush          )
--     check_object_id( tguard        )
--     check_object_id( bguard        )
--     check_object_id( eguard        )
--     check_object_id( cguard        )
--     check_object_id( ltorch        )
--     check_object_id( gtorch        )
--     check_object_id( torch         )
--     check_object_id( ibug          )
--     check_object_id( beetle        )
--     check_object_id( fbug          )
--     check_object_id( gold          )
--     check_object_id( silver        )
--     check_object_id( crate_health  )
--     check_object_id( charger       )
--     check_object_id( health        )
--     check_object_id( fkeydoor      )
--     check_object_id( keydoor       )
--     check_object_id( bardoor       )
--     check_object_id( static        )
--     check_object_id( pushrock      )
--     check_object_id( menu          )
--     check_object_id( savepoint     )
--     check_object_id( crate         )
--     check_object_id( grult         )
--     check_object_id( ghut          )
--     check_object_id( hotrock       )
--     check_object_id( coldrock      )
--     check_object_id( greyrock      )
--     check_object_id( bombrock      )
--     check_object_id( mole          )
--     check_object_id( sign          )
--     check_object_id( dyssius       )
--     check_object_id( anger         )
--     check_object_id( angerfireball )
--     check_object_id( sparkle       )
--     check_object_id( sterach       )
--     check_object_id( swordie       )
--     check_object_id( lynn          )
--     check_object_id( slimeman      )
--     check_object_id( antiwall2     )
--     check_object_id( antiwall      )
--     check_object_id( pmouth        )
--     check_object_id( boss5_right   )
--     check_object_id( boss5_left    )
--     check_object_id( boss5_down    )
--     check_object_id( boss5_crystal )
--
--     check_object_id( pekkle_blue )
--     check_object_id( pekkle_red )
--     check_object_id( pekkle_grey )
--     check_object_id( pekkle_red )
--     check_object_id( pekkle_big )
--     check_object_id( pekkle_bomb )
--
--     check_object_id( goldblock )
--
--     check_object_id( divine_ball )
--     check_object_id( divine_bug )
--     check_object_id( divine )
--
--     check_object_id( kambot )
--     check_object_id( auto )
--     check_object_id( mech )
--     check_object_id( godstat )
--     check_object_id( haywire )
--     check_object_id( biglarva )
--     check_object_id( cell )
--     check_object_id( statue )
--     check_object_id( battleseed )
--     check_object_id( healthguy )
--
--     If .id = ( "data\object\ferus.xml" ) Then
--       .unique_id = u_ferus
--       Exit Sub
--
--     End If
--
--     check_object_id( steelstrider )
--
--     check_object_id( core )
--
--   End With
--
-- End Sub
end

-- Loads an object and its images from xml and spr files. Assumes that
-- objectLoad.id has been initialized with the relative path of an object
-- xml file.
function LLSystem_ObjectLoad(objectLoad)
  --   Dim As Integer op1, op2, i, it, itt
  --   Dim As String dblquote = """"""
  --
  --   op1 = ( objectLoad.id = "" )
  --   op2 = ( Dir( objectLoad.id ) = "" )
  --
  --   If op1 Or op2 Then
  --
  --     Return 0
  --
  --   End If
  --
  --   Dim As xml_type Ptr clean_up
  --
  --
  --   clean_up = xml_Load( objectLoad.id )
  --
  --
  --   #IfDef LL_OBJECTLOADPROGRESS
  --     LLSystem_Log( "XML loaded.", "objectload.txt" )
  --
  --   #EndIf
  --
  --   objectLoad.flash_time = .02
  objectLoad.flash_time = .02
  --   objectLoad.flash_length = 30
  objectLoad.flash_length = 30
  --
  --   objectLoad.hit_sound = sound_enemyhit
  objectLoad.hit_sound = sound_enemyhit
  --   objectLoad.dead_sound = sound_enemykill
  objectLoad.dead_sound = sound_enemykill
  --
  --
  --   LLSystem_ObjectFromXML( clean_up, objectLoad )
  LLSystem_ObjectFromXML(objectLoad)
  --
  --   #IfDef LL_OBJECTLOADPROGRESS
  --     LLSystem_Log( "Object extracted from XML.", "objectload.txt" )
  --
  --   #EndIf
  --
  --   xml_Destroy( clean_up )
  --
  --   #IfDef LL_OBJECTLOADPROGRESS
  --     LLSystem_Log( "Destroyed XML tree.", "objectload.txt" )
  --
  --   #EndIf
  --
  --
  --   For i = 0 To objectLoad.anims - 1
  --
  --     For it = 0 To objectLoad.anim[i]->frames - 1
  --
  --       For itt = 0 To objectLoad.animControl[i].frame[it].concurrents - 1
  --
  --         With objectLoad.animControl[i].frame[it].concurrent[itt]
  --           '' one day...
  --           '' .char.location = V2_Add( objectLoad.location, V2_Subtract( .origin, V2_Scale( .char->perimeter, .5 ) ) )
  --           ''
  --           '' hehe dreams come true through hard work and diligence.
  --
  -- '          .char->x_origin = objectLoad.coords.x + .origin.x - ( .char->perimeter.x * .5 )
  -- '          .char->y_origin = objectLoad.coords.y + .origin.y - ( .char->perimeter.y * .5 )
  -- '          .char->coords.x = .char->x_origin
  -- '          .char->coords.y = .char->y_origin
  --
  --           .char->coords = V2_Add( objectLoad.coords, V2_Subtract( .origin, V2_Scale( .char->perimeter, .5 ) ) )
  --
  --           .char->x_origin = .char->coords.x
  --           .char->y_origin = .char->coords.y
  --
  --         End With
  --
  --       Next
  --
  --     Next
  --
  --   Next
  --
  --   objectLoad.funcs.active_state = 0
  objectLoad.funcs.active_state = 0
  --   objectLoad.current_anim = 0
  objectLoad.current_anim = 0
  --   objectLoad.frame = 0
  objectLoad.frame = 0
  --
  --   objectLoad.maxhp = objectLoad.hp
  objectLoad.maxhp = objectLoad.hp
  --   objectLoad.switch_room = -1
  objectLoad.switch_room = -1
  --
  --   LLObject_UniqueCheck( objectLoad )
  LLObject_UniqueCheck(objectLoad)
  --
  --
  --
  --   Return 1
  return 1
end
