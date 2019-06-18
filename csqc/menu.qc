void (vector vid_size) ShowLobbyMenu;
void (vector vid_size) ShowLobbyChampMenu

vector MENU_BG = '0.2 0.3 0.4';
vector MENU_BG_DARK = '0.1 0.15 0.2';
vector MENU_BORDER = '0.3 0.4 0.5';
vector MENU_BUTTON = '0.3 0.4 0.5';
vector MENU_BUTTON_BORDER = '0.35 0.45 0.55';
vector MENU_TEXT_1 = '1 1 1';
vector MENU_TEXT_2 = '0.7 0.75 0.75';
vector MENU_HIGHLIGHT = '1 1 1';
vector MENU_DARKEN = '1 1 1';

vector MENU_TEXT_SMALL = '8 8 0';
vector MENU_TEXT_MEDIUM = '16 16 0';
vector MENU_TEXT_LARGE = '24 24 0';
float MENU_START_CONTENT = 32;

void (vector boxpos, vector boxsize, string boxpic, string boxtext, vector boxrgb, float boxalpha) spawnbox =
{
	drawpic(boxpos, boxpic, boxsize, boxrgb, boxalpha);


    float msgwidth = stringwidth(boxtext, 0, '8 8 0');
    boxpos_x = boxpos_x + boxsize_x;
    boxpos_x = boxpos_x - (msgwidth * .5);
    boxpos_y = boxpos_y + boxsize_y - 4;

	drawstring(boxpos, boxtext, '8 8 0', boxrgb, 1, 0);
};

void () ClearMenu = {
    setcursormode(FALSE);
    entity button;
	
	// Remove all buttons
	button = find(world, classname, "gui_button");
	while (button)
	{
		remove(button);
		button = find(button, classname, "gui_button");
	}
}

void Menu_Show(vector vid_size, float menuitem) 
{
    if (vid_size_x != 0)
    {
        ClearMenu();
        setcursormode(TRUE);
        mnu_active = menuitem;
        switch (menuitem)
        {
            case MNU_LOBBYTEAM:
                ShowLobbyMenu(vid_size);
                break;
            case MNU_LOBBYCHAMP:
                ShowLobbyChampMenu(vid_size);
                break;
            case MNU_INACTIVE:
                setcursormode(FALSE);
                break;
        }
    }
}

entity (float btnID) GetButton = {
    entity button;
    button = find(world, classname, "gui_button");
    while (button)
    {
        if (button.btn_no == btnID) {
            return button;
        }
        
        button = find(button, classname, "gui_button");
    }
    return world;
}

entity (string button_text, void () btnMethod, vector button_spawnpos, string button_image, vector button_size, float button_flags, float btnID) CreateButton =
{
    entity newbutton;

    newbutton = spawn();
    newbutton.classname = "gui_button";
    newbutton.origin = button_spawnpos;
    newbutton.size = button_size;
    newbutton.btn_img = button_image;
    newbutton.btn_text = button_text;
    newbutton.btn_flags = button_flags;
    newbutton.btn_no = btnID;
    newbutton.think = btnMethod;

    return newbutton;
}

float () MouseOnButton = {
    float boxval;
    entity button;
    boxval = 0;

    button = find(world, classname, "gui_button");
    while (button)
    {
        if (Mouse.y >= button.origin_y && Mouse.y <= button.origin_y+button.size_y) {
            if (Mouse.x >= button.origin_x && Mouse.x <= button.origin_x+button.size_x) {
                boxval = button.btn_no;
                break;
            }
        }
            
        button = find(button, classname, "gui_button");
    }

    return boxval;
}

void () MouseClick = {
    float btnid;
    entity btn;
    btnid = MouseOnButton();
    
        if (btnid > 0)
        {
            btn = GetButton(btnid);
            if (btn.btn_flags & BTNFLAGS_ACTIVE)
            {
                btn.nextthink = 1;
            }
        }
    
}

void Menu_Draw()
{
    float menu = getstatf(STAT_MENU);
    Menu_Show(glob_vid_size, menu);

    entity button;
    float btnID;

    float highlight;
    highlight = MouseOnButton();

    button = find(world, classname, "gui_button");
	while (button)
	{
		btnID = button.btn_no;

        if (btnID == highlight)
        {
            if (button.btn_flags & BTNFLAGS_ACTIVE)
            {
                spawnbox(button.origin, button.size, button.btn_img, button.btn_text, '1 1 1', .4);
            }
            else
            {
                spawnbox(button.origin, button.size, button.btn_img, button.btn_text, '1 1 1', .2);
            }
        }
        else
        {
            spawnbox(button.origin, button.size, button.btn_img, button.btn_text, '1 1 1', .2);
        }
			
		button = find(button, classname, "gui_button");
	}
}

void () Messages_Draw = {
    if (mnu_active == MNU_INACTIVE)
    {
        string msg = "";
        
        entity p;
        p = findfloat(world, entnum, player_localentnum); 
        if (p)
        {
            if (p.champ_id && !p.ready)
            {
                string key1 = argv(0);
                string key2 = argv(1);
                tokenize(findkeysforcommand("ready"));
                if (key1 != "") key1 = (key1=="-1") ? "" : keynumtostring(stof(key1));
                if (key2 != "") key2 = (key2=="-1") ? "" : keynumtostring(stof(key2));

                if (key1 == "" && key2 == "")
                {
                    msg = "Type ^3/ready^7 to start the game";
                }
                else
                {
                    msg = "Press ";
                    if (key1 != "" && key2 != "") 
                        msg = strcat(msg, "^3", key1, "^7 or ^3", key2);
                    else if (key1 != "")
                        msg = strcat(msg, "^3", key1);
                    else
                        msg = strcat(msg, "^3", key2);

                    msg = strcat(msg, "^7 to start the game");           
                }
            }
            else if (p.champ_id && p.ready)
            {
                string champs, readys;
                champs = "";
                readys = "";
                entity player;
                player = find(world, classname, "player");
                while (player)
                {
                    if (!player.champ_id)
                    {
                        if (champs == "")
                            champs = player.netname;
                        else
                            champs = strcat(champs, ", ", player.netname);
                    }
                    else if (!player.ready)
                    {
                        if (readys == "")
                            readys = player.netname;
                        else
                            readys = strcat(readys, ", ", player.netname);
                    }
                    player = find(player, classname, "player");
                }

                if (champs != "")
                {
                    msg = strcat("Waiting on ", champs, " to select a champ");
                }
                else if (readys != "")
                {
                    msg = strcat("Waiting on ", readys, " to ready up");
                }
            }

            if (msg != "")
            {
                // middle 200 vertical of screen
                vector min = (getviewprop(VF_SCREENVSIZE) - '0 200')*0.5;
                // draw msg
                float msgwidth = stringwidth(msg, 0, '20 20');
                min_x = min_x - (msgwidth*.5);
                drawstring(min+'0 0', msg, '20 20', '1 1 1', 1, 0);
            }
        }   
    }
}