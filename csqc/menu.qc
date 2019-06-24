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

void Menu_Show(vector vid_size, float menuitem) 
{
    if (vid_size_x != 0)
    {
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

void Menu_Draw()
{
    float menu = getstatf(STAT_MENU);
    Menu_Show(glob_vid_size, menu);
}

string GetReadyMessage(entity p, string msg)
{
    if (p.team_no && !p.ready)
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
    else if (p.team_no && p.ready)
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

    return msg;
}

void () Messages_Draw = {
    if (mnu_active == MNU_INACTIVE)
    {
        string msg = "";
        
        entity p;
        p = findfloat(world, entnum, player_localentnum); 
        if (p)
        {
            if (p.team_no == TEAM_MONSTERS && !p.spawned)
            {
                msg = "Press attack to spawn!";
            }

            msg = GetReadyMessage(p, msg);
        }

        // centerprint from message global
        if (centerPrintMessageTime >= time)
        {
            msg = centerPrintMessage;
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