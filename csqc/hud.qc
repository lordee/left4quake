void Hud_DrawBar(vector pos, float val, float max_val, vector color)
{
	float barlength = 150;
	float perc = val / max_val * 100;
	float barperc = barlength / 100 * perc;
	float colorchange = barperc / 100;
    vector fontsize = [8, 8, 0];

	drawfill(pos, [barperc, 10, 0], color, 0.6, 0);
	drawfill(pos, [barlength, 10, 0], color, ALPHA_PANEL_BG, 0);

	string msg = strcat(ftos(val), "/", ftos(max_val));

	vector stringpos = pos;
	stringpos_x = stringpos_x + (barlength / 2);
	stringpos_y = stringpos_y + 2;

	float msgwidth = stringwidth(msg, 0, fontsize);
	stringpos_x = stringpos_x - (msgwidth*.5);

	drawstring(stringpos, msg, fontsize, [1, 1, 1], 1, 0);
}

void Hud_DrawSkillAndItemIcon(vector pos, string image, float selected, float cooldown)
{
	vector size = [20, 20, 0];
	drawpic(pos, image, size, [1, 1, 1], 1, 0);

	if (selected)
	{
		drawfill(pos + [0, -2, 0], [22, 2, 0], [0, 255, 0], 0.6, 0);
		drawfill(pos + [0, 20, 0], [20, 2, 0], [0, 255, 0], 0.6, 0);
		drawfill(pos + [-2, -2, 0], [2, 24, 0], [0, 255, 0], 0.6, 0);
		drawfill(pos + [20, 0, 0], [2, 22, 0], [0, 255, 0], 0.6, 0);
	}

	float cd = ceil(cooldown - time);

	if (cd > 0)
	{
		drawfill(pos, size, COLOR_PANEL_BG, 0.6, 0);
        vector fontsize = [6, 8, 0];
		
		float msgwidth = stringwidth(ftos(cd), 0, fontsize);
		vector stringpos = pos;
		stringpos = stringpos + [10, 10, 0];
		stringpos_x = stringpos_x - (msgwidth * .5);
		stringpos_y = stringpos_y - 4;

		drawstring(stringpos, ftos(cd), fontsize, [1, 1, 1], 1, 0);
	}
}

// TODO this should not be tested every frame... fix it later
string GetChampIcon(float champ, float skillnum)
{
	switch (champ)
	{
		case CHAMP_FROSTARCHER:
			switch (skillnum)
			{
				case 1:
					return SKILLONEICON_FROSTARCHER;
					break;
				case 2:
					return SKILLTWOICON_FROSTARCHER;
					break;
				case 3:
					return SKILLTHREEICON_FROSTARCHER;
					break;
				case 4:
					return SKILLFOURICON_FROSTARCHER;
					break;
			}
			break;
		default:
			return "";
	}
}


void Hud_Draw(vector scrsz)
{
	vector pos = [(scrsz_x-320)/2, pos_y = scrsz_y - 24, 0];	//calculate the top-left of the sbar, assuming it is 320 units wide and placed in the bottom-middle of the screen
	
	float stitems = getstatbits(STAT_ITEMS, 0, 23);			//this is the player's self.items value (STAT_ITEMS is generated specially by the server)
	GetSelf();
	if (self.champ_id)
	{
		float hval = self.health;
		float h_max = self.max_health;
		vector color = [255, 0, 0];
		pos = pos + [24, 12, 0];
		Hud_DrawBar(pos, hval, h_max, color);

		pos = pos + [0, -12, 0];
      
		// skills
		// based on champ, show champ skill icons
		string icon = GetChampIcon(self.champ_id, 1);
		pos = pos + [0, -40, 0];
		
		GetChamp(self.champ_id);
		Hud_DrawSkillAndItemIcon(pos, icon, (self.skill_selected == selfchamp.skill_one) ? TRUE : FALSE, self.skill_one_cooldown);

		icon = GetChampIcon(self.champ_id, 2);
		pos = pos + [25, 0, 0];
		Hud_DrawSkillAndItemIcon(pos, icon, (self.skill_selected == selfchamp.skill_two) ? TRUE : FALSE, self.skill_two_cooldown);

		icon = GetChampIcon(self.champ_id, 3);
		pos = pos + [25, 0, 0];
		Hud_DrawSkillAndItemIcon(pos, icon, (self.skill_selected == selfchamp.skill_three) ? TRUE : FALSE, self.skill_three_cooldown);

		icon = GetChampIcon(self.champ_id, 4);
		pos = pos + [25, 0, 0];
		Hud_DrawSkillAndItemIcon(pos, icon, (self.skill_selected == selfchamp.skill_four) ? TRUE : FALSE, self.skill_four_cooldown);
	}
};