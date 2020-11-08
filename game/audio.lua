require("game/engine_enums")

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
--   llg( snd )  [sound_beam]            = load_sample( "beam.ogg"             )
--   llg( snd )  [sound_bigchest]        = load_sample( "bigchest.ogg"         )
--   llg( snd )  [sound_boss_hit]        = load_sample( "boss_hit.ogg"         )
--   llg( snd )  [sound_cashget]         = load_sample( "cashget.ogg"          )
--   llg( snd )  [sound_doorfkey]        = load_sample( "doorfkey.ogg"         )
--   llg( snd )  [sound_doorsmall]       = load_sample( "doorsmall.ogg"        )
--   llg( snd )  [sound_enemyhit]        = load_sample( "enemyhit.ogg"         )
  ll_global.snd[sound_enemyhit] = love.audio.newSource("data/sounds/enemyhit.ogg", "static")
--   llg( snd )  [sound_enemykill]       = load_sample( "enemykill.ogg"        )
  ll_global.snd[sound_enemykill] = love.audio.newSource("data/sounds/enemykill.ogg", "static")
--   llg( snd )  [sound_explosion]       = load_sample( "explosion.ogg"        )
--   llg( snd )  [sound_flare]           = load_sample( "flare.ogg"            )
--   llg( snd )  [sound_healthgrab]      = load_sample( "healthgrab.ogg"       )
  ll_global.snd[sound_healthgrab] = love.audio.newSource("data/sounds/healthgrab.ogg", "static")
--   llg( snd )  [sound_heart]           = load_sample( "heart.ogg"            )
--   llg( snd )  [sound_ice]             = load_sample( "ice.ogg"              )
--   llg( snd )  [sound_portal]          = load_sample( "portal.ogg"           )
--   llg( snd )  [sound_smallchest]      = load_sample( "smallchest.ogg"       )
--   llg( snd )  [sound_switch]          = load_sample( "switch.ogg"           )
--   llg( snd )  [sound_treepull]        = load_sample( "treepull.ogg"         )
--   llg( snd )  [sound_lowhealth]       = load_sample( "lowhealth.ogg"        )
--   llg( snd )  [sound_bush]            = load_sample( "bush.ogg"             )
--   llg( snd )  [sound_crateting]       = load_sample( "crateting.ogg"        )
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
--   llg( snd )  [sound_mace_1]          = load_sample( "mace1.ogg"            )
--   llg( snd )  [sound_mace_2]          = load_sample( "mace2.ogg"            )
--   llg( snd )  [sound_texttemp]        = load_sample( "texttemp.ogg"         )
--   llg( snd )  [sound_torchlight]      = load_sample( "torchlight.ogg"       )
--   llg( snd )  [sound_gulls2]          = load_sample( "gulls2.ogg"           )
--   llg( snd )  [sound_rayflap2]        = load_sample( "rayflap2.ogg"         )
--   llg( snd )  [sound_flap]            = load_sample( "flap.ogg"             )
--   llg( snd )  [sound_sploosh]         = load_sample( "sploosh.ogg"          )
--   llg( snd )  [sound_lynn_die]        = load_sample( "lynn_die3.ogg"        )
--   llg( snd )  [sound_camera]          = load_sample( "ferus_camera.ogg"     )
--   llg( snd )  [sound_ferusstep]       = load_sample( "ferus_step.ogg"       )
--   llg( snd )  [sound_ferusbeep]       = load_sample( "ferus_beepsound.ogg"  )
--   llg( snd )  [sound_ferusgarbled]    = load_sample( "garbled.ogg"          )
--   llg( snd )  [sound_gunfire]         = load_sample( "gunfire.ogg"          )
--   llg( snd )  [sound_coreclunk]       = load_sample( "coreclunk.ogg"        )
--   llg( snd )  [sound_corealarm2]      = load_sample( "single_alarm.ogg"     )
--   llg( snd )  [sound_podopen]         = load_sample( "pod_open.ogg"         )
--   llg( snd )  [sound_turret]          = load_sample( "turret.ogg"           )
--   llg( snd )  [sound_heal]            = load_sample( "heal.ogg"             )
--   llg( snd )  [sound_build]           = load_sample( "build.ogg"            )
--   llg( snd )  [sound_mothdie]           = load_sample( "mothdie.ogg"            )
--
--   llg( snd )  [sound_greystatic]      = load_sample( "greystatic.ogg"  , sound_loop )
--   llg( snd )  [sound_crickets]        = load_sample( "crickets.ogg"    , sound_loop )
--   llg( snd )  [sound_sea]             = load_sample( "sea.ogg"         , sound_loop )
--   llg( snd )  [sound_beamcharge]      = load_sample( "beam_charge.ogg" , sound_loop )
--   llg( snd )  [sound_corealarm]       = load_sample( "alarm_loop.ogg"  , sound_loop )
--   llg( snd )  [sound_rumble]          = load_sample( "rumble.ogg"      , sound_loop )
--   llg( snd )  [sound_limboloop]       = load_sample( "limboloop.ogg"   , sound_loop )
--
--   Dim As Integer vol_tweak
--
--
--   #Define lazy_macro(x) BASS_ChannelSetAttributes( llg( snd )[x], 0, vol_tweak, 0 )
--
--     vol_tweak = 45
--     lazy_macro( sound_lynn_attack_1 )
--     lazy_macro( sound_lynn_attack_2 )
--     lazy_macro( sound_lynn_attack_3 )
--     lazy_macro( sound_lynn_attack_4 )
--
--     vol_tweak = 75
--     lazy_macro( sound_mace_0 )
--     lazy_macro( sound_mace_1 )
--     lazy_macro( sound_mace_2 )
--
--     vol_tweak = 75
--     lazy_macro( sound_lynn_hurt_1 )
--     lazy_macro( sound_lynn_hurt_2 )
--     lazy_macro( sound_lynn_hurt_3 )
--
--     lazy_macro( sound_rayflap2 )
-- '
-- '
--     vol_tweak = 35
--     lazy_macro( sound_flare )
--     lazy_macro( sound_ice )
--
-- '
--     vol_tweak = 45
--     lazy_macro( sound_explosion )
-- '
--     vol_tweak = 75
--     lazy_macro( sound_sea )
-- '
-- '
--     vol_tweak = 45
--     lazy_macro( sound_texttemp )
-- '
-- '
-- '    lazy_macro( sound_bush )
-- '
-- '
--     vol_tweak = 45
--     lazy_macro( sound_crickets )
-- '
-- '
--     vol_tweak = 55
--     lazy_macro( sound_gulls2 )
-- '
-- '
-- '    lazy_macro( sound_flap )
--
--
-- End Sub
end
