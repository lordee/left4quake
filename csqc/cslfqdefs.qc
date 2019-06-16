#include "../share/defs.h"

vector vPlayerOrigin;
vector vPlayerOriginOld; // We definitely need this later
vector vPlayerVelocity;
vector COLOR_PANEL_BG = [128, 128, 128];
float ALPHA_PANEL_BG = .2;
vector glob_vid_size;

.string netname;
.float health;
.float max_health;

// btn fields
.string btn_text;
.string btn_img;
.float btn_flags;
.float btn_no;
.float team_no;
.float champ_id;

// menu stuff
float mnu_active;

typedef struct
{
    float x;
    float y;
} MouseStruct;

MouseStruct Mouse;

