void LobbyJoinTeam(float teamnum)
{
    sendevent("JoinTeam", "f", teamnum);
}

float(string id, vector pos, vector size, string text) my_button =
{
	sui_push_frame(pos, size);
	vector basecolor = sui_is_hovered(id) ? MENU_BUTTON + MENU_HIGHLIGHT * 0.1 : MENU_BUTTON; 
	basecolor = sui_is_held(id) ? MENU_BUTTON - MENU_DARKEN * 0.1 : basecolor;
	sui_fill([0, 0], size, basecolor, 0.6, 0);
	sui_border_box([0, 0], size, 1, MENU_BUTTON_BORDER, 0.4, 0);
	
	sui_set_align([SUI_ALIGN_CENTER, SUI_ALIGN_CENTER]);
	sui_text([0, 0], MENU_TEXT_SMALL, text, MENU_TEXT_1, 1, 0);	
	sui_action_element([0, 0], size, id, sui_noop);
	sui_pop_frame();
	
	return sui_is_clicked(id);
};

void(string id, vector pos, vector size, vector minmaxsteps, __inout float value) my_slider =
{
	sui_push_frame(pos, size);
	
	value = sui_slidercontrol(id, [0, 0], size, minmaxsteps, value, sui_slider_noop);
	float maxval = minmaxsteps[1];
	float sliderx = (value / maxval) * size_x;
	sui_fill([0, size_y * 0.25], [size_x, size_y * 0.5], MENU_BG_DARK, 1.0, 0);
	
	float is_active = sui_is_held(id) || (sui_is_hovered(id) && !sui_click_held());
	vector slider_ctrl_color = is_active ? MENU_BUTTON + MENU_HIGHLIGHT * 0.1 : MENU_BUTTON;
	sui_fill([sliderx - 2, 0], [4, size_y], slider_ctrl_color, 1.0, 0);
	
	sui_pop_frame();
};

void(vector pos, vector size, vector minmaxsteps, string cvar_s, string name, string format) cvar_slider =
{
	float current = cvar(cvar_s);
	float old = current;
	sui_push_frame(pos, [size_x, size_y * 0.5 - 4]);
	sui_text([0, 0], MENU_TEXT_SMALL, name, MENU_TEXT_1, 1, 0);
	sui_set_align([SUI_ALIGN_END, SUI_ALIGN_START]);
	sui_text([0, 0], MENU_TEXT_SMALL, sprintf(format, current), MENU_TEXT_1, 1, 0);
	sui_pop_frame();
	my_slider(strcat(cvar_s, "sldr"), [pos_x, pos_y + size_y * 0.5], [size_x, size_y * 0.5], minmaxsteps, current);
	if (current != old) cvar_set(cvar_s, ftos(current));
};

void (vector vid_size) ShowLobbyMenu = {
    vector pos = [0, 0];
	sui_push_frame(pos, glob_vid_size);

	sui_set_align([SUI_ALIGN_CENTER, SUI_ALIGN_CENTER]);
	//vector size = [200, 100];
	// TODO - scale text, btn height etc too
	vector size = [glob_vid_size_x*.2, glob_vid_size_y*.2];

	sui_push_frame(pos, size);

	sui_fill(pos, size, MENU_BG, 0.75, 0);
	sui_border_box(pos, size, 2, MENU_BORDER, 0.3, 0);
	
	sui_set_align([SUI_ALIGN_CENTER, SUI_ALIGN_START]);
	sui_text([0, 4], MENU_TEXT_MEDIUM, "Select Team", MENU_TEXT_1, 1, 0);
	
	float pad = 8;
	float xpos = pad;
	float ypos = MENU_START_CONTENT;
	float width = size_x - (pad * 2);
	float btnheight = 20;

	if (my_button("btn_team1", [0, ypos], [width, btnheight], "Survivors"))
	{
		LobbyJoinTeam(1);
	}

	ypos += btnheight + pad;
	if (my_button("btn_team2", [0, ypos], [width, btnheight], "Monsters"))
	{
		LobbyJoinTeam(2);
	}

	sui_pop_frame();
	sui_pop_frame();
}

void ChooseChamp (float champid)
{
    sendevent("ChooseChamp", "f", champid);
}

vector ChampButton_Draw(vector panelsize, float champnum, string champname, vector btnpos, vector btnsize, float pad)
{
	if (btnpos_y >= (panelsize_y - pad))
	{
		btnpos_y = MENU_START_CONTENT;
		btnpos_x = btnpos_x + btnsize_x + pad;

		// TODO scroll for x/y
	}

	if (my_button(strcat("btn_", ftos(champnum)), btnpos, btnsize, champname))
	{
		ChooseChamp(champnum);
	}

	btnpos_y += btnsize_y + pad;
	
	return btnpos;
}

void (vector vid_size) ShowLobbyChampMenu = {

	vector pos = [0, 0];
	sui_push_frame(pos, glob_vid_size);
	sui_set_align([SUI_ALIGN_CENTER, SUI_ALIGN_CENTER]);

	vector size = [glob_vid_size_x*.7, glob_vid_size_y*.7];

	sui_push_frame(pos, size);

	sui_fill(pos, size, MENU_BG, 0.75, 0);
	sui_border_box(pos, size, 2, MENU_BORDER, 0.3, 0);

	sui_set_align([SUI_ALIGN_CENTER, SUI_ALIGN_START]);
	sui_text([0, 4], MENU_TEXT_MEDIUM, "Select Champion", MENU_TEXT_1, 1, 0);

	sui_set_align([SUI_ALIGN_START, SUI_ALIGN_START]);

	float pad = 8;
	vector btnpos = [pad, MENU_START_CONTENT];
	vector btnsize = [(size_x *.2) - (pad * 2), 20];
	
	btnpos = ChampButton_Draw(size, CHAMP_FROSTARCHER, "Frost Archer", btnpos, btnsize, pad);
	btnpos = ChampButton_Draw(size, CHAMP_TRISTANA, "Tristana", btnpos, btnsize, pad);
	btnpos = ChampButton_Draw(size, CHAMP_SHAMBLER, "Shambler", btnpos, btnsize, pad);
	btnpos = ChampButton_Draw(size, CHAMP_TARIC, "Taric", btnpos, btnsize, pad);
	btnpos = ChampButton_Draw(size, CHAMP_MASTERYI, "Master Yi", btnpos, btnsize, pad);
	btnpos = ChampButton_Draw(size, CHAMP_WARWICK, "Warwick", btnpos, btnsize, pad);
	btnpos = ChampButton_Draw(size, CHAMP_GAREN, "Garen", btnpos, btnsize, pad);
	btnpos = ChampButton_Draw(size, CHAMP_KAYLE, "Kayle", btnpos, btnsize, pad);
	btnpos = ChampButton_Draw(size, CHAMP_AHRI, "Ahri", btnpos, btnsize, pad);
	btnpos = ChampButton_Draw(size, CHAMP_VEIGAR, "Veigar", btnpos, btnsize, pad);
	btnpos = ChampButton_Draw(size, CHAMP_VEIGAR, "Test", btnpos, btnsize, pad);
	btnpos = ChampButton_Draw(size, CHAMP_VEIGAR, "Test 2", btnpos, btnsize, pad);

	sui_pop_frame();
	sui_pop_frame();
}