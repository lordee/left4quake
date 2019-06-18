void () FrostArcherAttackTouch = {
    if (other == self.owner)
		return;

	if (self.voided) {
		return;
	}
	self.voided = 1;

	if (other.solid == SOLID_TRIGGER)
		return; // trigger field, do nothing

	if (pointcontents(self.origin) == CONTENT_SKY)
	{
		remove(self);
		return;
	}

    if (other.team_no == self.owner.team_no)
    {
        remove(self);
        return;
    }
	
// hit something that bleeds
	if (other.takedamage)
	{
		spawn_touchblood (self.owner.attackdamage);
		other.deathtype = "FrostArcherattack";
		T_Damage (other, self, self.owner, self.owner.attackdamage);

		// if targ is slowed by FrostArcher already, add a stack
        if (other.classname == "player" || other.classname == "creep")
        {
            entity buff;
            float slowed;
            slowed = 0;

            buff = find(world, classname, "buff");
            while (buff)
            {
                if (buff.owner == other && buff.bufftype == MSSLOW_FROSTARCHER)
                {
                    // apply frost stack to FrostArcher
                    self.owner.stacks = self.owner.stacks + 1;
                    slowed = 1;
                    break;
                }
                buff = find(buff, classname, "buff");
            }	

            if (slowed == 0)
            {
                // apply a slow for FrostArcher attacks
                T_ApplyBuff(other, DEBUFF_MSSLOW, MSSLOW_FROSTARCHER, AASLOW_VALUE_FROSTARCHER, AASLOW_LIFETIME_FROSTARCHER, AASLOW_TICKRATE_FROSTARCHER);
            }
        }
	}
	else
	{
		WriteByte (MSG_MULTICAST, SVC_TEMPENTITY);
		WriteByte (MSG_MULTICAST, TE_SPIKE);
		WriteCoord (MSG_MULTICAST, self.origin_x);
		WriteCoord (MSG_MULTICAST, self.origin_y);
		WriteCoord (MSG_MULTICAST, self.origin_z);
		multicast (self.origin, MULTICAST_PHS);
	}

	remove(self);
}

void () FrostArcherAttack = {
	msg_entity = self;
	WriteByte (MSG_ONE, SVC_SMALLKICK);

	newmis = spawn ();
	newmis.voided = 0;
	newmis.owner = self;
	newmis.movetype = MOVETYPE_BOUNCE;
	newmis.solid = SOLID_BBOX;
    newmis.effects = EF_BLUE;
	newmis.classname = "FrostArcherattack";
		
	makevectors (self.v_angle);

	if (self.v_angle_x)
    {
		newmis.velocity = v_forward*1000 + v_up * 200 + crandom()*v_right*10 + crandom()*v_up*10;
    }
	else
	{
		newmis.velocity = aim(self, 10000);
		newmis.velocity = newmis.velocity * 1000;
		newmis.velocity_z = 200;
	}

	newmis.angles = vectoangles(newmis.velocity);
	
	newmis.touch = FrostArcherAttackTouch;
	newmis.nextthink = time + 6;
	newmis.think = SUB_Remove;

    sound (self, CHAN_WEAPON, SOUND_AASHOOT_FROSTARCHER, 1, ATTN_NORM);
	setmodel (newmis, "progs/champions/frostarcher/frostarcherarrow.mdl");

    entity buff;
    buff = find(world, classname, "buff");
    while (buff)
    {
        if (buff.owner == self && buff.buffcategory == AASPEED_SKILLONE_FROSTARCHER)
        {
            sound (self, CHAN_WEAPON, "weapons/spike2.wav", 1, ATTN_NORM);
	        setmodel (newmis, "progs/champions/frostarcher/frostarcherarrowbuff.mdl");
            break;
        }
        buff = find(buff, classname, "buff");
    }
    
	setsize (newmis, VEC_ORIGIN, VEC_ORIGIN);
	setorigin (newmis, self.origin);
}


void () SkillOne_FrostArcher = {
     // do checks for frost stacks
    float s;
    s = self.stacks;

    // if five frost stacks then allow cast
    if (s >= 5)
    {
        if (Cast(1, self.skill_one_cooldown_time))
        {
            // TODO show cast clientside
            // buff attack speed
            T_ApplyBuff(self, BUFF_AASPEED_PERC, AASPEED_SKILLONE_FROSTARCHER, SKILLONE_VALUE_FROSTARCHER, SKILLONE_LIFETIME_FROSTARCHER, SKILLONE_TICKRATE_FROSTARCHER);
        }
    }
    else
    {
        sprint(self, PRINT_HIGH, "You need 5 frost stacks on a target before you can cast this\n");
    }
}


void () FrostArcherSkillTwoTouch = {
    if (other == self.owner)
		return;

	if (self.voided) {
		return;
	}
	self.voided = 1;

	if (other.solid == SOLID_TRIGGER)
		return; // trigger field, do nothing

	if (pointcontents(self.origin) == CONTENT_SKY)
	{
		remove(self);
		return;
	}

// hit something that bleeds
	if (other.takedamage)
	{
		spawn_touchblood (self.owner.skill_two_damage);
		other.deathtype = "frostarcherskilltwo";
		
		// if this has already hit, don't damage/slow
        if (other.classname == "player" || other.classname == "creep")
        {
            entity buff;
            float slowed;
            slowed = 0;

            buff = find(world, classname, "buff");
            while (buff)
            {
                if (buff.owner == other && buff.bufftype == MSSLOW_SKILLTWO_FROSTARCHER)
                {
                    slowed = 1;
                    break;
                }
                buff = find(buff, classname, "buff");
            }	

            if (slowed == 0)
            {
                T_ApplyBuff(other, DEBUFF_MSSLOW, MSSLOW_SKILLTWO_FROSTARCHER, SKILLTWO_VALUE_FROSTARCHER, SKILLTWO_LIFETIME_FROSTARCHER, SKILLTWO_TICKRATE_FROSTARCHER);
                T_ApplyBuff(other, DEBUFF_MSSLOW, MSSLOW_FROSTARCHER, 0, AASLOW_LIFETIME_FROSTARCHER, AASLOW_TICKRATE_FROSTARCHER);
                T_Damage (other, self, self.owner, self.owner.skill_two_damage);
            }
        }
        else
        {
            T_Damage (other, self, self.owner, self.owner.skill_two_damage);
        }
	}
	else
	{
		WriteByte (MSG_MULTICAST, SVC_TEMPENTITY);
		WriteByte (MSG_MULTICAST, TE_SPIKE);
		WriteCoord (MSG_MULTICAST, self.origin_x);
		WriteCoord (MSG_MULTICAST, self.origin_y);
		WriteCoord (MSG_MULTICAST, self.origin_z);
		multicast (self.origin, MULTICAST_PHS);
	}

	remove(self);
}

void () SkillTwo_FrostArcher = {
	if (Cast(2, self.skill_two_cooldown_time))
    {
        float num, ang;
        num = 11;
        ang = floor(1800 / num);

        while (num > 0)
        {
            entity mis;
            mis = spawn ();
            mis.voided = 0;
            mis.owner = self;
            mis.movetype = MOVETYPE_BOUNCE;
            mis.solid = SOLID_BBOX;
            mis.classname = "frostarcherskilltwo";
            mis.effects = EF_BLUE;
            makevectors (self.v_angle);

            if (self.v_angle_x)
            {
                if (num < 6)
                {
                    mis.velocity = v_forward*1000 + v_up * 200 + (v_right * (num * ang) * -1) + crandom()*v_up*10;
                }
                else if (num > 6)
                {
                    mis.velocity = v_forward*1000 + v_up * 200 + v_right * ((num - 6) * ang) + crandom()*v_up*10;
                }
                else
                {
                    mis.velocity = v_forward*1000 + v_up * 200 + crandom()*v_right*10 + crandom()*v_up*10;
                }
            }
            else
            {
                mis.velocity = aim(self, 10000);
                mis.velocity = newmis.velocity * 1000;
                mis.velocity_z = 200;
            }

            mis.angles = vectoangles(mis.velocity);
            mis.touch = FrostArcherSkillTwoTouch;
            mis.nextthink = time + 6;
            mis.think = SUB_Remove;
            
            setmodel (mis, "progs/champions/frostarcher/frostarcherarrow.mdl");
            setsize (mis, VEC_ORIGIN, VEC_ORIGIN);
            setorigin (mis, self.origin);
            num = num - 1;
        }
    }
}
void () SkillThree_FrostArcher = {
	sprint(self, PRINT_HIGH, "Not implemented\n");
}

void () FrostArcherSkillFourTouch = {
    if (other == self.owner)
		return;

	if (self.voided) {
		return;
	}
	self.voided = 1;

	if (other.solid == SOLID_TRIGGER)
		return; // trigger field, do nothing

	if (pointcontents(self.origin) == CONTENT_SKY)
	{
		remove(self);
		return;
	}

    if (other.classname == "player" && other.takedamage)
    {
        spawn_touchblood (self.owner.skill_four_damage);
		other.deathtype = "frostarcherskillfour";
		
        //apply stun in radius     
        entity affected;
        affected = findradius(self.origin, SKILLFOUR_RANGE_FROSTARCHER);
        while (affected)
        {
            if (affected.team_no != self.owner.team_no)
            {
                if (affected.classname == "player" || affected.classname == "creep")
                    T_ApplyBuff(affected, DEBUFF_STUN, STUN_SKILLFOUR_FROSTARCHER, SKILLONE_VALUE_UNDEFINED, SKILLFOUR_LIFETIME_FROSTARCHER, SKILLFOUR_TICKRATE_FROSTARCHER);
            }
            
            affected = affected.chain;
        }
        
        T_Damage (other, self, self.owner, self.owner.skill_two_damage);
    }
    else
	{
		WriteByte (MSG_MULTICAST, SVC_TEMPENTITY);
		WriteByte (MSG_MULTICAST, TE_SPIKE);
		WriteCoord (MSG_MULTICAST, self.origin_x);
		WriteCoord (MSG_MULTICAST, self.origin_y);
		WriteCoord (MSG_MULTICAST, self.origin_z);
		multicast (self.origin, MULTICAST_PHS);
	}

	remove(self);
}

void () SkillFour_FrostArcher = {
	if (Cast(4, self.skill_four_cooldown_time))
    {           
        newmis = spawn ();
        newmis.voided = 0;
        newmis.owner = self;
        newmis.movetype = MOVETYPE_FLYMISSILE;
        newmis.solid = SOLID_BBOX;
        newmis.effects = EF_BLUE;
        newmis.classname = "frostarcherskillfour";
        makevectors (self.v_angle);

        newmis.velocity = aim(self, 1000);
        newmis.velocity = newmis.velocity * 1000;
        newmis.angles = vectoangles(newmis.velocity);

        newmis.touch = FrostArcherSkillFourTouch;
        newmis.nextthink = time + 60;
        newmis.think = SUB_Remove;
        
        setmodel (newmis, "progs/champions/frostarcher/frostarcherultimate.mdl");
        setsize (newmis, '0 0 0', '0 0 0');             
        setorigin (newmis, self.origin + v_forward*8 + '0 0 16');
    }
}