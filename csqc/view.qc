void View_Draw()
{
    //  find all players, draw a health bar above them
    GetSelf();
    entity e;
    e = find(world, classname, "player");
    while (e)
    {
        if (e.entnum != self.entnum)
        {
            float h = e.health;
            float mh = e.max_health;
            vector org = e.origin;
            GetChamp(e.champ_id);
            vector mmax = selfchamp.model_max;
            org_z = org_z + mmax_z;

            vector pos = project(org);
            if(pos_z > 0) {
                Hud_DrawBar(pos, h, mh, [255, 0, 0]);
            }
        }
        e = find(e, classname, "player");
    }


}