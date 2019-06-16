void ShamblerAttack()
{
    GetChamp(self.champ_id);
    sound (self, CHAN_VOICE, selfchamp.sound_aashoot, 1, ATTN_NORM);

    // TODO change to shambler claws
    /*if (random() <= 0.5)
        sham_swingr1();
    else 
        sham_swingl1();*/

    vector source;
    source = self.origin + MODEL_VIEWOFFSET_SHAMBLER; // just a guess really...
    traceline (source, source + v_forward*64, FALSE, self);
	if (trace_fraction == 1.0)
		return;
	
	vector org = trace_endpos - v_forward*4;

	if (trace_ent.takedamage)
	{
		trace_ent.axhitme = 1;
		//SpawnBlood (org, '0 0 0', floor(self.attackdamage/10));
        SpawnMeatSpray (org, self.attackdamage * v_right);
		T_Damage (trace_ent, self, self, self.attackdamage);
        sound (self, CHAN_VOICE, selfchamp.sound_aahit, 1, ATTN_NORM);
	}
	else
	{	// hit wall
		sound (self, CHAN_WEAPON, selfchamp.sound_aahitwall, 1, ATTN_NORM);
		WriteByte (MSG_MULTICAST, SVC_TEMPENTITY);
		WriteByte (MSG_MULTICAST, TE_GUNSHOT);
		WriteByte (MSG_MULTICAST, 3);
		WriteCoord (MSG_MULTICAST, org_x);
		WriteCoord (MSG_MULTICAST, org_y);
		WriteCoord (MSG_MULTICAST, org_z);
		multicast (org, MULTICAST_PVS);
	}
}

void () SkillOne_Shambler = {
    if (Cast(1, self.skill_one_cooldown_time, self.skill_one_manacost))
    {
        // pop up all units in radius around champ
        entity affected = findradius(self.origin, self.skill_one_range);

        while (affected)
        {
            if (affected.team_no != self.team_no)
            {
                if (affected.classname == "player" || affected.classname == "creep")
                {
                    // pop up
                    affected.velocity = '0 0 0';
                    affected.velocity_z = 500;

                    // stun 
                    T_ApplyBuff(affected, DEBUFF_STUN_MOVEALLOWED, STUN_SKILLONE_SHAMBLER, SKILLONE_VALUE_UNDEFINED, SKILLONE_LIFETIME_SHAMBLER, SKILLONE_TICKRATE_SHAMBLER);
                    T_Damage(affected, self, self, self.skill_one_damage);
                }
            }
            affected = affected.chain;
        }
    }
}

void Skill_Two_Shambler_Touch()
{
    // push back unit hit, stunning them for duration and .1 secs after hitting ground?
    if (other)
    {
        if (other.team_no != self.team_no)
        {
            if (other.classname == "player" || other.classname == "creep")
            {
                makevectors(self.angles);
                T_Damage(other, self, self, self.skill_two_damage);
                other.velocity = v_forward * SKILLTWO_RANGE_SHAMBLER;
                other.velocity_z = 181;
                T_ApplyBuff(other, DEBUFF_STUN_MOVEALLOWED, STUN_SKILLTWO_SHAMBLER, SKILLONE_VALUE_UNDEFINED, SKILLTWO_LIFETIME_SHAMBLER, SKILLTWO_TICKRATE_SHAMBLER);
            }
        }
    }
    self.touch = SUB_Null;
}

void () SkillTwo_Shambler = {
	if (Cast(2, self.skill_two_cooldown_time, self.skill_two_manacost))
    {
        // move shambler forward a bunch
        makevectors(self.angles);
        self.velocity = v_forward * SKILLTWO_RANGE_SHAMBLER;
        if (self.flags & FL_ONGROUND)
        {
            self.velocity_z = 181;
        }

        // if he hits a unit
        self.touch = Skill_Two_Shambler_Touch;
    }
}

void SkillThreeThink_Shambler()
{
    // TODO - play a sound

    // do damage in radius of owner
    entity affected;
    affected = findradius(self.owner.origin, SKILLTHREE_RANGE_SHAMBLER);

    while (affected)
    {
        switch (affected.classname)
        {
            case "player":
                // if damage done to enemy champ, give owner a stack
                self.owner.stacks = self.owner.stacks + 1;

                // at 5 stacks next basic attack is empowered and stuns
                if (self.owner.stacks >= 5)
                {
                    if (!BuffExists(self, AAEMPOWER_SKILLTHREE_SHAMBLER))
                    {
                        T_ApplyBuff(self, BUFF_AA_EMPOWERED, AAEMPOWER_SKILLTHREE_SHAMBLER, SKILLTHREE_EMPOWERED_DAMAGE_SHAMBLER, SKILLTHREE_EMPOWERED_LIFETIME_SHAMBLER, SKILLTHREE_EMPOWERED_TICKRATE_SHAMBLER);
                    }
                }
            case "creep": // allow fallthrough
                T_Damage(affected, self.owner, self.owner, self.owner.skill_three_damage);
                break;
            default:
        }
        
        affected = affected.chain;
    }
}

void SkillThree_Shambler()
{
    if (Cast(3, self.skill_three_cooldown_time, self.skill_three_manacost))
    {
        self.stacks = 0;
        T_ApplyBuff(self, BUFF_AOE, AOEBURN_SKILLTHREE_SHAMBLER, self.skill_three_damage, SKILLTHREE_LIFETIME_SHAMBLER, SKILLTHREE_TICKRATE_SHAMBLER);
    }
}

/*reduces all incoming physical and magic damage for the next 7 seconds, cleansing himself of all Stun crowd control on cast.*/
void () SkillFour_Shambler = {
	if (Cast(4, self.skill_four_cooldown_time, self.skill_four_manacost))
    {
        T_ApplyBuff(self, BUFF_DMGRD_ALL, DMGRD_SKILLFOUR_SHAMBLER, self.skill_four_value, SKILLFOUR_LIFETIME_SHAMBLER, SKILLFOUR_TICKRATE_SHAMBLER);
    }
}