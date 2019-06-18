//============================================================================
//			VARS NOT REFERENCED BY C CODE
//============================================================================

#ifndef VER
#define VER "unknown"
#endif

#ifndef REV
#define REV "unk"
#endif

//
// constants
//

#define FALSE		0
#define TRUE		1

// edict.flags
#define FL_FLY		1
#define FL_SWIM		2
#define FL_CLIENT	8 	// set for all client edicts
#define FL_INWATER	16 	// for enter / leave water splash
#define FL_MONSTER	32
#define FL_GODMODE	64 	// player cheat
#define FL_NOTARGET	128 	// player cheat
#define FL_ITEM		256 	// extra wide size for bonus items
#define FL_ONGROUND	512 	// standing on something
#define FL_PARTIALGROUND	1024 	// not all corners are valid
#define FL_WATERJUMP	2048 	// player jumping out of water
#define FL_JUMPRELEASED	4096 	// for jump debouncing

// edict.movetype values
#define MOVETYPE_NONE			0 	// never moves
//#define MOVETYPE_ANGLENOCLIP	1
//#define MOVETYPE_ANGLECLIP	2
#define MOVETYPE_WALK			3 	// players only
#define MOVETYPE_STEP			4 	// discrete, not real time unless fall
#define MOVETYPE_FLY			5
#define MOVETYPE_TOSS			6 	// gravity
#define MOVETYPE_PUSH			7 	// no clip to world, push and crush
#define MOVETYPE_NOCLIP			8
#define MOVETYPE_FLYMISSILE		9 	// fly with extra size against monsters
#define MOVETYPE_BOUNCE			10
#define MOVETYPE_BOUNCEMISSILE		11 	// bounce with extra size

// edict.solid values
#define SOLID_NOT	0 	// no interaction with other objects
#define SOLID_TRIGGER	1 	// touch on edge, but not blocking
#define SOLID_BBOX	2 	// touch on edge, block
#define SOLID_SLIDEBOX	3 	// touch on edge, but not an onground
#define SOLID_BSP	4 	// bsp clip, touch on edge, block

// range values
#define RANGE_MELEE	0
#define RANGE_NEAR	1
#define RANGE_MID	2
#define RANGE_FAR	3

// deadflag values
#define DEAD_NO			0
#define DEAD_DYING		1
#define DEAD_DEAD		2
#define DEAD_RESPAWNABLE	3

// takedamage values
#define DAMAGE_NO	0
#define DAMAGE_YES	1
#define DAMAGE_AIM	2

// items
#define IT_AXE			4096
#define IT_SHOTGUN		1
#define IT_SUPER_SHOTGUN	2
#define IT_NAILGUN		4
#define IT_SUPER_NAILGUN	8
#define IT_GRENADE_LAUNCHER	16
#define IT_ROCKET_LAUNCHER	32
#define IT_LIGHTNING		64
#define IT_EXTRA_WEAPON		128

#define IT_SHELLS	256
#define IT_NAILS	512
#define IT_ROCKETS	1024
#define IT_CELLS	2048

#define IT_ARMOR1	8192
#define IT_ARMOR2	16384
#define IT_ARMOR3	32768
#define IT_SUPERHEALTH	65536

#define IT_KEY1	131072
#define IT_KEY2	262144

#define IT_INVISIBILITY		524288
#define IT_INVULNERABILITY	1048576
#define IT_SUIT			2097152
#define IT_QUAD			4194304
#define IT_HOOK			8388608

// point content values
#define CONTENT_EMPTY	-1
#define CONTENT_SOLID	-2
#define CONTENT_WATER	-3
#define CONTENT_SLIME	-4
#define CONTENT_LAVA	-5
#define CONTENT_SKY	-6

#define STATE_TOP	0
#define STATE_BOTTOM	1
#define STATE_UP	2
#define STATE_DOWN	3

#define VEC_ORIGIN	'0 0 0'
#define VEC_HULL_MIN	'-16 -16 -24'
#define VEC_HULL_MAX	'16 16 32'

#define VEC_HULL2_MIN	'-32 -32 -24'
#define VEC_HULL2_MAX	'32 32 64'

// protocol bytes
#define SVC_TEMPENTITY		23
#define SVC_KILLEDMONSTER	27
#define SVC_FOUNDSECRET		28
#define SVC_INTERMISSION	30
#define SVC_FINALE		31
#define SVC_CDTRACK		32
#define SVC_SELLSCREEN		33

#define SVC_SMALLKICK		34
#define SVC_BIGKICK		35
#define SVC_UPDATEPING		36
#define SVC_UPDATETIME		37
#define SVC_MUZZLEFLASH		39
#define SVC_UPDATEUSERINFO	40
#define SVC_PLAYERINFO		42
#define SVC_PACKETENTITIES	47
#define SVC_DELTAPACKETENTITIES	48
#define SVC_SETINFO		51
#define SVC_UPDATEPL		53

#define TE_SPIKE		0
#define TE_SUPERSPIKE		1
#define TE_GUNSHOT		2
#define TE_EXPLOSION		3
#define TE_TAREXPLOSION		4
#define TE_LIGHTNING1		5
#define TE_LIGHTNING2		6
#define TE_WIZSPIKE		7
#define TE_KNIGHTSPIKE		8
#define TE_LIGHTNING3		9
#define TE_LAVASPLASH		10
#define TE_TELEPORT		11
#define TE_BLOOD        	12
#define TE_LIGHTNINGBLOOD	13

// sound channels
// channel 0 never willingly overrides
// other channels (1-7) allways override a playing sound on that channel
#define CHAN_AUTO	0
#define CHAN_WEAPON	1
#define CHAN_VOICE	2
#define CHAN_ITEM	3
#define CHAN_BODY	4
#define CHAN_NO_PHS_ADD	8

#define ATTN_NONE	0
#define ATTN_NORM	1
#define ATTN_IDLE	2
#define ATTN_STATIC	3

// update types

#define UPDATE_GENERAL	0
#define UPDATE_STATIC	1
#define UPDATE_BINARY	2
#define UPDATE_TEMP	3

// entity effects

#define EF_BRIGHTFIELD	1
#define EF_MUZZLEFLASH	2
#define EF_BRIGHTLIGHT	4
#define EF_DIMLIGHT	8
#define EF_FLAG1	16
#define EF_FLAG2	32
// GLQuakeWorld Stuff
#define EF_BLUE		64	// Blue Globe effect for Quad
#define EF_RED		128	// Red Globe effect for Pentagram

// messages
#define MSG_BROADCAST	0		// unreliable to all
#define MSG_ONE		1 		// reliable to one (msg_entity)
#define MSG_ALL		2 		// reliable to all
#define MSG_INIT	3 		// write to the init string
#define MSG_MULTICAST   4

// message levels
#define	PRINT_LOW	0		// pickup messages
#define	PRINT_MEDIUM	1		// death messages
#define	PRINT_HIGH	2		// critical messages
#define PRINT_CHAT	3		// also goes to chat console

// multicast sets
#define MULTICAST_ALL	0    	// every client
#define MULTICAST_PHS	1    	// within hearing
#define MULTICAST_PVS	2    	// within sight
#define MULTICAST_ALL_R	3    	// every client, reliable
#define MULTICAST_PHS_R	4    	// within hearing, reliable
#define MULTICAST_PVS_R	5  	// within sight, reliable

// attack_state
#define AS_STRAIGHT	1
#define AS_SLIDING	2
#define AS_MELEE	3
#define AS_MISSILE	4

// overquake commands
#define SE_MNU_OPEN    1
#define SE_READY    2
#define SE_CHAMP    3
#define SE_NETNAME       4
#define SE_PLAYER       5

#define OPT_NEITHER 0
#define OPT_BOTH    1
#define OPT_BLUE    2
#define OPT_RED     3

#define TEAM_NONE 0
#define TEAM_BLUE 1
#define TEAM_RED 2

// cp
#define SCORESTYLE_HOLD 0
#define SCORESTYLE_TIME 1

// quadmode
#define QUAD_ROUNDS "2"
#define QUAD_DELAY_TIME "30"
#define QUAD_ROUND_TIME "10"

// menus
#define MNU_INACTIVE 0
#define MNU_LOBBYTEAM 1
#define MNU_LOBBYCHAMP 2

#define MENU_NONE = 0
#define MENU_MAIN = 1
#define MENU_JOIN = 2
#define MENU_SETTINGS = 4
#define MENU_BUY = 8
#define MENU_HOST = 16
#define MENU_PREGAME = 32
#define MENU_POSTGAME = 64

// champs
#define CHAMP_UNDEFINED      0
#define CHAMP_FROSTARCHER      1
#define CHAMP_TRISTANA   2  // TODO
#define CHAMP_SHAMBLER   3   // TODO
#define CHAMP_TARIC     4   // TODO
#define CHAMP_MASTERYI  5   // TODO
#define CHAMP_WARWICK   6   // TODO
#define CHAMP_GAREN     7   // TODO
#define CHAMP_KAYLE     8   // TODO
#define CHAMP_AHRI      9   // TODO
#define CHAMP_VEIGAR    10  // TODO

// kill types
#define KT_CHAMPKILL    1
#define KT_CHAMPASSIST    2
#define KT_MINIONKILL    3
#define KT_SELFDEATH    4

// impulse defines
#define SKILLONE    1
#define SKILLTWO    2
#define SKILLTHREE    3
#define SKILLFOUR    4
#define SKILL_USEACTIVE 5
#define SKILL_USEONE    6
#define SKILL_USETWO    7
#define SKILL_USETHREE   8
#define SKILL_USEFOUR    9
#define READY   11

// global rules
#define REGEN_TICKTIME  1

// first 32 are reserved
#define STAT_MENU    32

#define BTN_BG  "progs/csqc/csqcguiback.tga"
#define BTN_BG_DISABLED  "progs/csqc/csqcguiback_disabled.tga"

#define BTNFLAGS_INACTIVE   0
#define BTNFLAGS_ACTIVE   1

// icons
#define SKILLONEICON_FROSTARCHER    "progs/gfx/hud/champions/frostarcher/focus.png"
#define SKILLTWOICON_FROSTARCHER    "progs/gfx/hud/champions/frostarcher/volley.tga"
#define SKILLTHREEICON_FROSTARCHER    "progs/gfx/hud/champions/frostarcher/bird.png"
#define SKILLFOURICON_FROSTARCHER    "progs/gfx/hud/champions/frostarcher/largearrow.png"

// champ skills
#define SKILLONE_UNDEFINED   1
#define SKILLTWO_UNDEFINED   2
#define SKILLTHREE_UNDEFINED  3
#define SKILLFOUR_UNDEFINED   4
#define SKILLONE_FROSTARCHER   5
#define SKILLTWO_FROSTARCHER   6
#define SKILLTHREE_FROSTARCHER  7
#define SKILLFOUR_FROSTARCHER   8
#define SKILLONE_SHAMBLER   9
#define SKILLTWO_SHAMBLER   10
#define SKILLTHREE_SHAMBLER  11
#define SKILLFOUR_SHAMBLER   12

// no selection
#define MODEL_UNDEFINED   "progs/player.mdl"
#define MODEL_MIN_UNDEFINED   '-16 -16 -24'
#define MODEL_MAX_UNDEFINED   '16 16 32'
#define MODEL_VIEWOFFSET_UNDEFINED    '0 0 22'
#define MODEL_HEAD_UNDEFINED "progs/h_player.mdl"
#define SOUND_DEATH_UNDEFINED    "player/death1.wav"
#define SOUND_AASHOOT_UNDEFINED    "weapons/grenade.wav"
#define SOUND_AAHIT_UNDEFINED    ""
#define SOUND_AAHITWALL_UNDEFINED    "weapons/tink1.wav"
#define BASEAD_UNDEFINED     50
#define BASEHEALTH_UNDEFINED 500
#define BASEHEALTH_REGEN_UNDEFINED 5
#define BASESPEED_UNDEFINED  330
#define BASEATTACKSPEED_UNDEFINED    1
#define AASLOW_VALUE_UNDEFINED       30 // slow percent
#define AASLOW_LIFETIME_UNDEFINED   1
#define AASLOW_TICKRATE_UNDEFINED   1

#define SKILLONE_VALUE_UNDEFINED      0
#define SKILLONE_LIFETIME_UNDEFINED   1
#define SKILLONE_TICKRATE_UNDEFINED   5
#define SKILLONE_COOLDOWN_UNDEFINED  20
#define SKILLONE_DAMAGE_UNDEFINED  0
#define SKILLONE_RANGE_UNDEFINED    0

#define SKILLTWO_COOLDOWN_UNDEFINED  20
#define SKILLTWO_DAMAGE_UNDEFINED  20
#define SKILLTWO_VALUE_UNDEFINED  30 // slow percent
#define SKILLTWO_LIFETIME_UNDEFINED   1
#define SKILLTWO_TICKRATE_UNDEFINED   5
#define SKILLTWO_RANGE_UNDEFINED    0

#define SKILLTHREE_COOLDOWN_UNDEFINED  20
#define SKILLTHREE_DAMAGE_UNDEFINED  0
#define SKILLTHREE_RANGE_UNDEFINED    0

#define SKILLFOUR_VALUE_UNDEFINED      1 // meaningless
#define SKILLFOUR_LIFETIME_UNDEFINED   1
#define SKILLFOUR_TICKRATE_UNDEFINED   5
#define SKILLFOUR_COOLDOWN_UNDEFINED  120
#define SKILLFOUR_DAMAGE_UNDEFINED  100
#define SKILLFOUR_RANGE_UNDEFINED    0

// FROSTARCHER defs
#define MODEL_FROSTARCHER   "progs/player.mdl"
#define MODEL_MIN_FROSTARCHER   '-16 -16 -24'
#define MODEL_MAX_FROSTARCHER   '16 16 32'
#define MODEL_VIEWOFFSET_FROSTARCHER    '0 0 22'
#define MODEL_HEAD_FROSTARCHER "progs/h_player.mdl"
#define SOUND_DEATH_FROSTARCHER    "player/death1.wav"
#define SOUND_AASHOOT_FROSTARCHER    "weapons/grenade.wav"
#define SOUND_AAHIT_FROSTARCHER    ""
#define SOUND_AAHITWALL_FROSTARCHER    "weapons/tink1.wav"
#define SOUND_SKILLONE_CAST_FROSTARCHER   ""
#define SOUND_SKILLTWO_CAST_FROSTARCHER   "weapons/grenade.wav"
#define SOUND_SKILLTHREE_CAST_FROSTARCHER   "shambler/ssight.wav"
#define SOUND_SKILLFOUR_CAST_FROSTARCHER   "weapons/grenade.wav"
#define BASEAD_FROSTARCHER     50
#define BASEHEALTH_FROSTARCHER 500
#define BASEHEALTH_REGEN_FROSTARCHER 5
#define BASESPEED_FROSTARCHER  330
#define BASEATTACKSPEED_FROSTARCHER    1
#define AASLOW_VALUE_FROSTARCHER       30 // slow percent
#define AASLOW_LIFETIME_FROSTARCHER   1
#define AASLOW_TICKRATE_FROSTARCHER   1

#define SKILLONE_VALUE_FROSTARCHER      30 // slow percent
#define SKILLONE_LIFETIME_FROSTARCHER   1
#define SKILLONE_TICKRATE_FROSTARCHER   5
#define SKILLONE_COOLDOWN_FROSTARCHER  20
#define SKILLONE_DAMAGE_FROSTARCHER  0
#define SKILLONE_RANGE_FROSTARCHER    0

#define SKILLTWO_COOLDOWN_FROSTARCHER  20
#define SKILLTWO_DAMAGE_FROSTARCHER  20
#define SKILLTWO_VALUE_FROSTARCHER  30 // slow percent
#define SKILLTWO_LIFETIME_FROSTARCHER   1
#define SKILLTWO_TICKRATE_FROSTARCHER   5
#define SKILLTWO_RANGE_FROSTARCHER    0

#define SKILLTHREE_COOLDOWN_FROSTARCHER  20
#define SKILLTHREE_DAMAGE_FROSTARCHER  0
#define SKILLTHREE_RANGE_FROSTARCHER    0

#define SKILLFOUR_LIFETIME_FROSTARCHER   1
#define SKILLFOUR_TICKRATE_FROSTARCHER   5
#define SKILLFOUR_COOLDOWN_FROSTARCHER  120
#define SKILLFOUR_DAMAGE_FROSTARCHER  100
#define SKILLFOUR_RANGE_FROSTARCHER 200

// SHAMBLER defs
#define MODEL_SHAMBLER     "progs/shambler.mdl"
#define MODEL_MIN_SHAMBLER   '-32 -32 -24'
#define MODEL_MAX_SHAMBLER   '32 32 64'
#define MODEL_VIEWOFFSET_SHAMBLER    '0 0 50'
#define MODEL_HEAD_SHAMBLER "progs/h_shams.mdl"
#define SOUND_DEATH_SHAMBLER    "shambler/sdeath.wav"
#define SOUND_AASHOOT_SHAMBLER    "shambler/melee1.wav"
#define SOUND_AAHIT_SHAMBLER    "shambler/smack.wav"
#define SOUND_AAHITWALL_SHAMBLER    "shambler/melee1.wav"
#define SOUND_SKILLONE_CAST_SHAMBLER   "shambler/ssight.wav"
#define SOUND_SKILLTWO_CAST_SHAMBLER   "shambler/ssight.wav"
#define SOUND_SKILLTHREE_CAST_SHAMBLER   "shambler/ssight.wav"
#define SOUND_SKILLFOUR_CAST_SHAMBLER   "shambler/ssight.wav"
#define BASEAD_SHAMBLER     50
#define BASEHEALTH_SHAMBLER 500
#define BASEHEALTH_REGEN_SHAMBLER 5
#define BASESPEED_SHAMBLER  330
#define BASEATTACKSPEED_SHAMBLER    1
#define AASLOW_VALUE_SHAMBLER       30 // slow percent
#define AASLOW_LIFETIME_SHAMBLER   1
#define AASLOW_TICKRATE_SHAMBLER   1

#define SKILLONE_LIFETIME_SHAMBLER   1
#define SKILLONE_TICKRATE_SHAMBLER   2
#define SKILLONE_COOLDOWN_SHAMBLER  20
#define SKILLONE_DAMAGE_SHAMBLER  100
#define SKILLONE_RANGE_SHAMBLER 200

#define SKILLTWO_COOLDOWN_SHAMBLER  20
#define SKILLTWO_DAMAGE_SHAMBLER  80
#define SKILLTWO_RANGE_SHAMBLER    1000
#define SKILLTWO_LIFETIME_SHAMBLER   1
#define SKILLTWO_TICKRATE_SHAMBLER   1

#define SKILLTHREE_COOLDOWN_SHAMBLER  20
#define SKILLTHREE_DAMAGE_SHAMBLER  20
#define SKILLTHREE_EMPOWERED_DAMAGE_SHAMBLER  80
#define SKILLTHREE_LIFETIME_SHAMBLER   10
#define SKILLTHREE_TICKRATE_SHAMBLER   .5
#define SKILLTHREE_EMPOWERED_LIFETIME_SHAMBLER   1
#define SKILLTHREE_EMPOWERED_TICKRATE_SHAMBLER   5
#define SKILLTHREE_RANGE_SHAMBLER    200

#define SKILLFOUR_VALUE_SHAMBLER      40    // damage reduction base val
#define SKILLFOUR_LIFETIME_SHAMBLER   7
#define SKILLFOUR_TICKRATE_SHAMBLER   1
#define SKILLFOUR_COOLDOWN_SHAMBLER  120
#define SKILLFOUR_DAMAGE_SHAMBLER  0
#define SKILLFOUR_RANGE_SHAMBLER    0

// buff category
#define DEBUFF_MSSLOW       1
#define DEBUFF_STUN         2
#define BUFF_AASPEED_PERC        4
#define BUFF_MS_BASE    8
#define BUFF_RESIST_SLOW    16
#define DEBUFF_STUN_MOVEALLOWED 32  // target will still fly through air etc
#define BUFF_AA_EMPOWERED   64
#define BUFF_AOE    128
#define BUFF_DMGRD_ALL   256
#define BUFF_DMGRD_AD   512
#define BUFF_DMGRD_AP   1024

// buff type
#define MSSLOW_FROSTARCHER     1
#define AASPEED_SKILLONE_FROSTARCHER    2
#define MSSLOW_SKILLTWO_FROSTARCHER     3
#define STUN_SKILLFOUR_FROSTARCHER     4
#define STUN_SKILLONE_SHAMBLER     5
#define STUN_SKILLTWO_SHAMBLER     6
#define STUN_SKILLTHREE_SHAMBLER     7
#define AAEMPOWER_SKILLTHREE_SHAMBLER   8
#define AOEBURN_SKILLTHREE_SHAMBLER 9
#define DMGRD_SKILLFOUR_SHAMBLER    10
