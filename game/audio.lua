require("game.engine_enums")

-- Sub init_snd()
function init_snd()
--
--
--
--
--
--   llg( snd ) = c_alloc( llg( f_mem ), Len( hchannel ) * NUM_OF_SOUNDS )
--
--   llg( snd )  [sound_bassdrop]        = load_sample( "bassdrop.ogg"         )
  ll_global.snd[sound_bassdrop] = love.audio.newSource("data/sounds/bassdrop.ogg", "static")
--   llg( snd )  [sound_beam]            = load_sample( "beam.ogg"             )
  ll_global.snd[sound_beam] = love.audio.newSource("data/sounds/beam.ogg", "static")
--   llg( snd )  [sound_bigchest]        = load_sample( "bigchest.ogg"         )
  ll_global.snd[sound_bigchest] = love.audio.newSource("data/sounds/bigchest.ogg", "static")
--   llg( snd )  [sound_boss_hit]        = load_sample( "boss_hit.ogg"         )
  ll_global.snd[sound_boss_hit] = love.audio.newSource("data/sounds/boss_hit.ogg", "static")
--   llg( snd )  [sound_cashget]         = load_sample( "cashget.ogg"          )
  ll_global.snd[sound_cashget] = love.audio.newSource("data/sounds/cashget.ogg", "static")
--   llg( snd )  [sound_doorfkey]        = load_sample( "doorfkey.ogg"         )
  ll_global.snd[sound_doorfkey] = love.audio.newSource("data/sounds/doorfkey.ogg", "static")
--   llg( snd )  [sound_doorsmall]       = load_sample( "doorsmall.ogg"        )
  ll_global.snd[sound_doorsmall] = love.audio.newSource("data/sounds/doorsmall.ogg", "static")
--   llg( snd )  [sound_enemyhit]        = load_sample( "enemyhit.ogg"         )
  ll_global.snd[sound_enemyhit] = love.audio.newSource("data/sounds/enemyhit.ogg", "static")
--   llg( snd )  [sound_enemykill]       = load_sample( "enemykill.ogg"        )
  ll_global.snd[sound_enemykill] = love.audio.newSource("data/sounds/enemykill.ogg", "static")
--   llg( snd )  [sound_explosion]       = load_sample( "explosion.ogg"        )
  ll_global.snd[sound_explosion] = love.audio.newSource("data/sounds/explosion.ogg", "static")
--   llg( snd )  [sound_flare]           = load_sample( "flare.ogg"            )
  ll_global.snd[sound_flare] = love.audio.newSource("data/sounds/flare.ogg", "static")
--   llg( snd )  [sound_healthgrab]      = load_sample( "healthgrab.ogg"       )
  ll_global.snd[sound_healthgrab] = love.audio.newSource("data/sounds/healthgrab.ogg", "static")
--   llg( snd )  [sound_heart]           = load_sample( "heart.ogg"            )
  ll_global.snd[sound_heart] = love.audio.newSource("data/sounds/heart.ogg", "static")
  ll_global.snd[sound_heart]:setLooping(true)
--   llg( snd )  [sound_ice]             = load_sample( "ice.ogg"              )
  ll_global.snd[sound_ice] = love.audio.newSource("data/sounds/ice.ogg", "static")
--   llg( snd )  [sound_portal]          = load_sample( "portal.ogg"           )
  ll_global.snd[sound_portal] = love.audio.newSource("data/sounds/portal.ogg", "static")
--   llg( snd )  [sound_smallchest]      = load_sample( "smallchest.ogg"       )
  ll_global.snd[sound_smallchest] = love.audio.newSource("data/sounds/smallchest.ogg", "static")
--   llg( snd )  [sound_switch]          = load_sample( "switch.ogg"           )
  ll_global.snd[sound_switch] = love.audio.newSource("data/sounds/switch.ogg", "static")
--   llg( snd )  [sound_treepull]        = load_sample( "treepull.ogg"         )
  ll_global.snd[sound_treepull] = love.audio.newSource("data/sounds/treepull.ogg", "static")
--   llg( snd )  [sound_lowhealth]       = load_sample( "lowhealth.ogg"        )
  ll_global.snd[sound_lowhealth] = love.audio.newSource("data/sounds/lowhealth.ogg", "static")
--   llg( snd )  [sound_bush]            = load_sample( "bush.ogg"             )
  ll_global.snd[sound_bush] = love.audio.newSource("data/sounds/bush.ogg", "static")
--   llg( snd )  [sound_crateting]       = load_sample( "crateting.ogg"        )
  ll_global.snd[sound_crateting] = love.audio.newSource("data/sounds/crateting.ogg", "static")
--   llg( snd )  [sound_lynn_attack_1]   = load_sample( "lynn_attack_1.ogg"    )
  ll_global.snd[sound_lynn_attack_1] = love.audio.newSource("data/sounds/lynn_attack_1.ogg", "static")
--   llg( snd )  [sound_lynn_attack_2]   = load_sample( "lynn_attack_2.ogg"    )
  ll_global.snd[sound_lynn_attack_2] = love.audio.newSource("data/sounds/lynn_attack_2.ogg", "static")
--   llg( snd )  [sound_lynn_attack_3]   = load_sample( "lynn_attack_3.ogg"    )
  ll_global.snd[sound_lynn_attack_3] = love.audio.newSource("data/sounds/lynn_attack_3.ogg", "static")
--   llg( snd )  [sound_lynn_attack_4]   = load_sample( "lynn_attack_4.ogg"    )
  ll_global.snd[sound_lynn_attack_4] = love.audio.newSource("data/sounds/lynn_attack_4.ogg", "static")
--   llg( snd )  [sound_lynn_hurt_1]     = load_sample( "lynn_hurt_1.ogg"      )
  ll_global.snd[sound_lynn_hurt_1] = love.audio.newSource("data/sounds/lynn_hurt_1.ogg", "static")
--   llg( snd )  [sound_lynn_hurt_2]     = load_sample( "lynn_hurt_2.ogg"      )
  ll_global.snd[sound_lynn_hurt_2] = love.audio.newSource("data/sounds/lynn_hurt_2.ogg", "static")
--   llg( snd )  [sound_lynn_hurt_3]     = load_sample( "lynn_hurt_3.ogg"      )
  ll_global.snd[sound_lynn_hurt_3] = love.audio.newSource("data/sounds/lynn_hurt_3.ogg", "static")
--   llg( snd )  [sound_mace_0]          = load_sample( "mace0.ogg"            )
  ll_global.snd[sound_mace_0] = love.audio.newSource("data/sounds/mace0.ogg", "static")
--   llg( snd )  [sound_mace_1]          = load_sample( "mace1.ogg"            )
  ll_global.snd[sound_mace_1] = love.audio.newSource("data/sounds/mace1.ogg", "static")
--   llg( snd )  [sound_mace_2]          = load_sample( "mace2.ogg"            )
  ll_global.snd[sound_mace_2] = love.audio.newSource("data/sounds/mace2.ogg", "static")
--   llg( snd )  [sound_texttemp]        = load_sample( "texttemp.ogg"         )
  ll_global.snd[sound_texttemp] = {}
  ll_global.snd[sound_texttemp][0] = love.audio.newSource("data/sounds/texttemp.ogg", "static")
  for i = 1, 3 do
    ll_global.snd[sound_texttemp][i] = ll_global.snd[sound_texttemp][0]:clone()
  end
--   llg( snd )  [sound_torchlight]      = load_sample( "torchlight.ogg"       )
  ll_global.snd[sound_torchlight] = love.audio.newSource("data/sounds/torchlight.ogg", "static")
--   llg( snd )  [sound_gulls2]          = load_sample( "gulls2.ogg"           )
  ll_global.snd[sound_gulls2] = love.audio.newSource("data/sounds/gulls2.ogg", "static")
--   llg( snd )  [sound_rayflap2]        = load_sample( "rayflap2.ogg"         )
  ll_global.snd[sound_rayflap2] = love.audio.newSource("data/sounds/rayflap2.ogg", "static")
--   llg( snd )  [sound_flap]            = load_sample( "flap.ogg"             )
  ll_global.snd[sound_flap] = love.audio.newSource("data/sounds/flap.ogg", "static")
--   llg( snd )  [sound_sploosh]         = load_sample( "sploosh.ogg"          )
  ll_global.snd[sound_sploosh] = love.audio.newSource("data/sounds/sploosh.ogg", "static")
--   llg( snd )  [sound_lynn_die]        = load_sample( "lynn_die3.ogg"        )
  ll_global.snd[sound_lynn_die] = love.audio.newSource("data/sounds/lynn_die3.ogg", "static")
--   llg( snd )  [sound_camera]          = load_sample( "ferus_camera.ogg"     )
  ll_global.snd[sound_camera] = love.audio.newSource("data/sounds/ferus_camera.ogg", "static")
--   llg( snd )  [sound_ferusstep]       = load_sample( "ferus_step.ogg"       )
  ll_global.snd[sound_ferusstep] = love.audio.newSource("data/sounds/ferus_step.ogg", "static")
--   llg( snd )  [sound_ferusbeep]       = load_sample( "ferus_beepsound.ogg"  )
  ll_global.snd[sound_ferusbeep] = love.audio.newSource("data/sounds/ferus_beepsound.ogg", "static")
--   llg( snd )  [sound_ferusgarbled]    = load_sample( "garbled.ogg"          )
  ll_global.snd[sound_ferusgarbled] = love.audio.newSource("data/sounds/garbled.ogg", "static")
--   llg( snd )  [sound_gunfire]         = load_sample( "gunfire.ogg"          )
  ll_global.snd[sound_gunfire] = love.audio.newSource("data/sounds/gunfire.ogg", "static")
--   llg( snd )  [sound_coreclunk]       = load_sample( "coreclunk.ogg"        )
  ll_global.snd[sound_coreclunk] = love.audio.newSource("data/sounds/coreclunk.ogg", "static")
--   llg( snd )  [sound_corealarm2]      = load_sample( "single_alarm.ogg"     )
  ll_global.snd[sound_corealarm2] = love.audio.newSource("data/sounds/single_alarm.ogg", "static")
--   llg( snd )  [sound_podopen]         = load_sample( "pod_open.ogg"         )
  ll_global.snd[sound_podopen] = love.audio.newSource("data/sounds/pod_open.ogg", "static")
--   llg( snd )  [sound_turret]          = load_sample( "turret.ogg"           )
  ll_global.snd[sound_turret] = love.audio.newSource("data/sounds/turret.ogg", "static")
--   llg( snd )  [sound_heal]            = load_sample( "heal.ogg"             )
  ll_global.snd[sound_heal] = love.audio.newSource("data/sounds/heal.ogg", "static")
--   llg( snd )  [sound_build]           = load_sample( "build.ogg"            )
  ll_global.snd[sound_build] = love.audio.newSource("data/sounds/build.ogg", "static")
--   llg( snd )  [sound_mothdie]           = load_sample( "mothdie.ogg"            )
  ll_global.snd[sound_mothdie] = love.audio.newSource("data/sounds/mothdie.ogg", "static")
--
--   llg( snd )  [sound_greystatic]      = load_sample( "greystatic.ogg"  , sound_loop )
  ll_global.snd[sound_greystatic] = love.audio.newSource("data/sounds/greystatic.ogg", "static")
  ll_global.snd[sound_greystatic]:setLooping(true)
--   llg( snd )  [sound_crickets]        = load_sample( "crickets.ogg"    , sound_loop )
  ll_global.snd[sound_crickets] = love.audio.newSource("data/sounds/crickets.ogg", "static")
  ll_global.snd[sound_crickets]:setLooping(true)
--   llg( snd )  [sound_sea]             = load_sample( "sea.ogg"         , sound_loop )
  ll_global.snd[sound_sea] = love.audio.newSource("data/sounds/sea.ogg", "static")
  ll_global.snd[sound_sea]:setLooping(true)
--   llg( snd )  [sound_beamcharge]      = load_sample( "beam_charge.ogg" , sound_loop )
  ll_global.snd[sound_beamcharge] = love.audio.newSource("data/sounds/beam_charge.ogg", "static")
  ll_global.snd[sound_beamcharge]:setLooping(true)
--   llg( snd )  [sound_corealarm]       = load_sample( "alarm_loop.ogg"  , sound_loop )
  ll_global.snd[sound_corealarm] = love.audio.newSource("data/sounds/alarm_loop.ogg", "static")
  ll_global.snd[sound_corealarm]:setLooping(true)
--   llg( snd )  [sound_rumble]          = load_sample( "rumble.ogg"      , sound_loop )
  ll_global.snd[sound_rumble] = love.audio.newSource("data/sounds/rumble.ogg", "static")
  ll_global.snd[sound_rumble]:setLooping(true)
--   llg( snd )  [sound_limboloop]       = load_sample( "limboloop.ogg"   , sound_loop )
  ll_global.snd[sound_limboloop] = love.audio.newSource("data/sounds/limboloop.ogg", "static")
  ll_global.snd[sound_limboloop]:setLooping(true)
--
--   Dim As Integer vol_tweak
--
--
--   #Define lazy_macro(x) BASS_ChannelSetAttributes( llg( snd )[x], 0, vol_tweak, 0 )
--
--     vol_tweak = 45
--     lazy_macro( sound_lynn_attack_1 )
  ll_global.snd[sound_lynn_attack_1]:setVolume(.45)
--     lazy_macro( sound_lynn_attack_2 )
  ll_global.snd[sound_lynn_attack_2]:setVolume(.45)
--     lazy_macro( sound_lynn_attack_3 )
  ll_global.snd[sound_lynn_attack_3]:setVolume(.45)
--     lazy_macro( sound_lynn_attack_4 )
  ll_global.snd[sound_lynn_attack_4]:setVolume(.45)
--
--     vol_tweak = 75
--     lazy_macro( sound_mace_0 )
  ll_global.snd[sound_mace_0]:setVolume(.75)
--     lazy_macro( sound_mace_1 )
  ll_global.snd[sound_mace_1]:setVolume(.75)
--     lazy_macro( sound_mace_2 )
  ll_global.snd[sound_mace_2]:setVolume(.75)
--
--     vol_tweak = 75
--     lazy_macro( sound_lynn_hurt_1 )
  ll_global.snd[sound_lynn_hurt_1]:setVolume(.75)
--     lazy_macro( sound_lynn_hurt_2 )
  ll_global.snd[sound_lynn_hurt_2]:setVolume(.75)
--     lazy_macro( sound_lynn_hurt_3 )
  ll_global.snd[sound_lynn_hurt_3]:setVolume(.75)
--
--     lazy_macro( sound_rayflap2 )
  ll_global.snd[sound_rayflap2]:setVolume(.75)
-- '
-- '
--     vol_tweak = 35
--     lazy_macro( sound_flare )
  ll_global.snd[sound_flare]:setVolume(.35)
--     lazy_macro( sound_ice )
  ll_global.snd[sound_ice]:setVolume(.35)
--
-- '
--     vol_tweak = 45
--     lazy_macro( sound_explosion )
  ll_global.snd[sound_explosion]:setVolume(.45)
-- '
--     vol_tweak = 75
--     lazy_macro( sound_sea )
  ll_global.snd[sound_sea]:setVolume(.75)
-- '
-- '
--     vol_tweak = 45
--     lazy_macro( sound_texttemp )
  for i = 0, 3 do
    ll_global.snd[sound_texttemp][i]:setVolume(.45)
  end
-- '
-- '
-- '    lazy_macro( sound_bush )
  ll_global.snd[sound_bush]:setVolume(.45)
-- '
-- '
--     vol_tweak = 45
--     lazy_macro( sound_crickets )
  ll_global.snd[sound_crickets]:setVolume(.45)
-- '
-- '
--     vol_tweak = 55
--     lazy_macro( sound_gulls2 )
  ll_global.snd[sound_gulls2]:setVolume(.55)
-- '
-- '
-- '    lazy_macro( sound_flap )
--
--
-- End Sub
end

-- Sub check_env_sounds()
function check_env_sounds()
--
--   Static As hchannel ret
--   Dim As Integer env_ver, check_env
  local env_ver, check_env = 0, 0
--   env_ver = 0
  env_ver = 0
--
--   For check_env = 0 To now_room().enemies - 1
  for check_env = 0, now_room().enemies - 1 do
--
--     With now_room().enemy[check_env]
    local with0 = now_room().enemy[check_env]
--       If .unique_id = u_static Then
    if with0.unique_id == u_static then
--
--         If .dead <> 0 Then Continue For
      if with0.dead ~= 0 then goto continue end
--
--         If check_bounds( llo_vp( Varptr( llg( hero ) ) ),  llo_vp( Varptr( now_room().enemy[check_env] ) ) ) = 0 Then
      if check_bounds(LLO_VP(ll_global.hero), LLO_VP(now_room().enemy[check_env])) == 0 then
--           env_ver = -1
        env_ver = -1
--
--           If BASS_ChannelIsActive( ret ) = 0 Then
--             ret = play_sample( llg( snd )[sound_greystatic], 50 )
        ll_global.snd[sound_greystatic]:setVolume(.5)
        ll_global.snd[sound_greystatic]:play()
--
--           End If
--
--         End If
      end
--
--       End If
    end
--
--     End With
--
--   Next
  ::continue::
  end
--
--   If env_ver = 0 Then
--     BASS_ChannelStop( ret )
--
--   End If
  if env_ver == 0 then
    ll_global.snd[sound_greystatic]:stop()
  end
--
--
-- End Sub
end
