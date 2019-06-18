void () Menu_Draw;
void () Messages_Draw;
void () MouseClick;

void() CSQC_Parse_Event = {
    /*float first = readbyte(); 
    float second, third;
    string thirdS;
    switch (first)
    {
        case SE_MNU_OPEN:
            break;
        default:
    }*/
}

float () Player_PreDraw;

void CSQC_Ent_Update(float flIsNew) {
    float entType = readbyte();

    switch (entType)
    {
        case SE_PLAYER:
            self.origin_x = readcoord();
            self.origin_y = readcoord();
            self.origin_z = readcoord();
            self.angles_x = readcoord();
            self.angles_y = readcoord();
            self.angles_z = readcoord();
            self.velocity_x = readshort();
            self.velocity_y = readshort();
            self.velocity_z = readshort();
            self.flags = readfloat();
            self.netname = readstring();
            float cid = readfloat();
            self.ready = readfloat();
            self.health = readfloat();
            self.max_health = readfloat();
            self.skill_selected = readfloat();
            self.skill_one_cooldown_time = readfloat();
            self.skill_two_cooldown_time = readfloat();
            self.skill_three_cooldown_time = readfloat();
            self.skill_four_cooldown_time = readfloat();

            // TODO - ui buff/debuff, animation above player in game
            self.stunned = readfloat();
                
            if ( flIsNew == TRUE ) {
                self.classname = "player";
                self.solid = SOLID_SLIDEBOX;
                self.predraw = Player_PreDraw;
                self.drawmask = MASK_ENGINE;               
            }

            if (cid != self.champ_id)
            {
                self.champ_id = cid;
                GetChamp(self.champ_id);
                setmodel(self, selfchamp.model);
                setsize (self, selfchamp.model_min, selfchamp.model_max);
            }
            
            setorigin(self, self.origin);
            break;
    }
}

void(float apilevel, string enginename, float engineversion) CSQC_Init = {
    mnu_active = 0;
    precache_pic (SKILLONEICON_FROSTARCHER);
    precache_pic (SKILLTWOICON_FROSTARCHER);
    precache_pic (SKILLTHREEICON_FROSTARCHER);
    precache_pic (SKILLFOURICON_FROSTARCHER);
    precache_pic (BTN_BG);
    precache_pic (BTN_BG_DISABLED);
}

void (vector size) Hud_Draw;
void View_Draw();
void(float width, float height, float menushown) CSQC_UpdateView =
{
    clearscene();
	//setviewprop(VF_DRAWENGINESBAR, 1);
	setviewprop(VF_DRAWCROSSHAIR, 1);
    
    glob_vid_size = [width, height];
    
    addentities((intermission?0:MASK_VIEWMODEL)|MASK_ENGINE);

    setproperty(VF_ORIGIN, vPlayerOrigin + [ 0, 0, getstatf( STAT_VIEWHEIGHT ) ]);
    setproperty(VF_ANGLES, view_angles);

    renderscene();

    Hud_Draw(glob_vid_size);
    View_Draw(); // health bars, stuns etc
    sui_begin(glob_vid_size_x, glob_vid_size_y);
    Menu_Draw();
    sui_end();
    Messages_Draw();
}