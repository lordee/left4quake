
void (entity player) UpdateStats;

void () ChampUpdateThink = {
    UpdateStats(self.owner);
    remove(self);
}

void SkillThreeThink_Shambler();
void () BuffThink = {
    float h;
    h = self.health - 1;

    if (h > 0)
    {
        self.health = h;
        self.nextthink = time + self.nextthinkinterval;

        // apply ticks (health damage etc)
		switch (self.bufftype)
		{
			case AOEBURN_SKILLTHREE_SHAMBLER:
				SkillThreeThink_Shambler();
				break;
		}

		switch (self.buffcategory)
		{
			case BUFF_AA_EMPOWERED:
				UpdateStats(self.owner);
				break;
		}

        return;
    }

    switch (self.buffcategory)
    {
		case DEBUFF_STUN_MOVEALLOWED:
			self.owner.stunned = FALSE;
			break;
        case DEBUFF_STUN:
            self.owner.stunned = FALSE;
            self.owner.movetype = MOVETYPE_WALK;
			break;
        default:
    }

	switch (self.bufftype)
	{
		case AOEBURN_SKILLTHREE_SHAMBLER:
			self.owner.stacks = 0;
			break;
	}

	// redo stats after self is removed
    entity upd;
    upd = spawn();
    upd.owner = self.owner;
    upd.classname = "champupdater";
    upd.think = ChampUpdateThink;
    upd.nextthink = time + .1;

    remove(self);
}

float BuffExists(entity player, float type)
{
	entity buff;
	buff = find(world, classname, "buff");
	while (buff)
	{
		if (buff.owner == player)
		{
			if (buff.bufftype == type)
			{
				return TRUE;
			}
		}
		buff = find(buff, classname, "buff");
	}
	return FALSE;
}

void (entity targ, float cat, float type, float value, float lifetime, float tickrate) T_ApplyBuff = {
	entity newbuff;
	newbuff = spawn();
    newbuff.owner = targ;
    newbuff.classname = "buff";
    newbuff.buffcategory = cat;
	newbuff.bufftype = type;
    
    newbuff.buffvalue = value;
    newbuff.think = BuffThink;
	newbuff.max_health = lifetime;
	newbuff.health = lifetime;
	newbuff.nextthinkinterval = tickrate;
	newbuff.nextthink = time + tickrate;

    // instant debuff
    switch (cat)
    {
        case DEBUFF_STUN:
            targ.stunned = TRUE;
            targ.movetype = MOVETYPE_NONE;
			break;
		case DEBUFF_STUN_MOVEALLOWED:
			targ.stunned = TRUE;
			break;
        default:
    }

	switch (type)
	{
		case DMGRD_SKILLFOUR_SHAMBLER:
			targ.stunned = FALSE;
			targ.movetype = MOVETYPE_WALK;
			break;
	}

    UpdateStats(newbuff.owner);
}