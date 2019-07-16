void () SkillOne_FrostArcher;
void () SkillTwo_FrostArcher;
void () SkillThree_FrostArcher;
void () SkillFour_FrostArcher;
void () SkillOne_Shambler;
void () SkillTwo_Shambler;
void () SkillThree_Shambler;
void () SkillFour_Shambler;

void (entity e) DoRegen = {
    if (e.deadflag == DEAD_NO)
    {
        if (time >= e.healthlastregen)
        {
            e.health = e.health + e.healthregen;
            if (self.health > self.max_health)
            {
                self.health = self.max_health;
            }
            self.healthlastregen = time + self.regentick;
        }
    }
}

void (entity player) UpdateStats = {

    float attdamage, attspeed, msspeed, hth;
    
    GetChamp(player.champ_id);

    attdamage = selfchamp.basead;
    attspeed = selfchamp.baseattackspeed;
    msspeed = selfchamp.basespeed;
    hth = selfchamp.basehealth;

    // buffs
    entity buff;
    float val;

    buff = find(world, classname, "buff");
    while (buff)
    {
        if (buff.owner == player)
        {
            val = buff.buffvalue;
            switch (buff.buffcategory)
            {
                case DEBUFF_MSSLOW:
                    msspeed = msspeed * ((100 - val) / 100);
                    break;
                case BUFF_AASPEED_PERC:
                    attspeed = attspeed * ((100 + val) / 100);
                    break;
                case BUFF_AA_EMPOWERED:
                    attdamage = attdamage + val;
                    break;
            }
        }
        buff = find(buff, classname, "buff");
    }

    float h, mh;
    h = player.health;
    mh = player.max_health;

    player.attackspeed = attspeed;
    player.speed = msspeed;
    player.health = h + (hth - mh);
    player.max_health = hth;
}

void () SetupChamp = {
    self.regentick = time + REGEN_TICKTIME;

    GetChamp(self.champ_id);

    self.attackdamage = selfchamp.basead;
    self.health = selfchamp.basehealth;
    self.max_health = selfchamp.basehealth;
    self.healthregen = selfchamp.basehealth_regen; // per second
    self.speed = selfchamp.basespeed;
    self.attackspeed = selfchamp.baseattackspeed;
    self.skill_one = selfchamp.skill_one;
    self.skill_one_cooldown = selfchamp.skill_one_cooldown;
    self.skill_one_cooldown_time = 0;
    self.skill_one_damage = selfchamp.skill_one_damage;
    self.skill_one_range = selfchamp.skill_one_range;
    self.skill_one_value = selfchamp.skill_one_value;
    self.skill_two = selfchamp.skill_two;
    self.skill_two_cooldown = selfchamp.skill_two_cooldown;
    self.skill_two_cooldown_time = 0;
    self.skill_two_damage = selfchamp.skill_two_damage;
    self.skill_two_range = selfchamp.skill_two_range;
    self.skill_two_value = selfchamp.skill_two_value;
    self.skill_three = selfchamp.skill_three;
    self.skill_three_cooldown = selfchamp.skill_three_cooldown;
    self.skill_three_cooldown_time = 0;
    self.skill_three_damage = selfchamp.skill_three_damage;
    self.skill_three_range = selfchamp.skill_three_range;
    self.skill_three_value = selfchamp.skill_three_value;
    self.skill_four = selfchamp.skill_four;
    self.skill_four_cooldown = selfchamp.skill_four_cooldown;
    self.skill_four_cooldown_time = 0;
    self.skill_four_damage = selfchamp.skill_four_damage;
    self.skill_four_range = selfchamp.skill_four_range;
    self.skill_four_value = selfchamp.skill_four_value;

    UpdateStats(self);
}

void () ChangeSkill = {
    float s;
    s = self.skill_selected;
    switch (self.impulse)
    {
        case SKILLONE:
            s = self.skill_one;
            break;
        case SKILLTWO:
            s = self.skill_two;
            break;
        case SKILLTHREE:
            s = self.skill_three;
            break;
        case SKILLFOUR:
            s = self.skill_four;
            break;
    }

    // do checks??

    // switch to skill
    self.skill_selected = s;
}

void (float skillnum) UseSkill = {
    GetChamp(self.champ_id);
    switch (skillnum)
    {
        case SKILLONE_FROSTARCHER:
            SkillOne_FrostArcher();
        break;
        case SKILLTWO_FROSTARCHER:
            SkillTwo_FrostArcher();
        break;
        case SKILLTHREE_FROSTARCHER:
            SkillThree_FrostArcher();
        break;
        case SKILLFOUR_FROSTARCHER:
            SkillFour_FrostArcher();
        break;
        case SKILLONE_SHAMBLER:
            SkillOne_Shambler();
        break;
        case SKILLTWO_SHAMBLER:
            SkillTwo_Shambler();
        break;
        case SKILLTHREE_SHAMBLER:
            SkillThree_Shambler();
        break;
        case SKILLFOUR_SHAMBLER:
            SkillFour_Shambler();
        break;
    }
}

void Use(entity player)
{
    // if pointed at a downed player
    makevectors(player.v_angle);
    vector source;
    source = player.origin + player.view_ofs;

    traceline(source, source + v_forward * 64, MOVE_HITMODEL | MOVE_EVERYTHING, player);

    if (trace_ent)
    {
        if (trace_ent.team_no == player.team_no)
        {
            // start/continue revive process
            RevivePlayer(player, trace_ent);
        }
    }
}

float Cast(float skillnum, float cooldown)
{
    if (cooldown <= time)
    {
        switch (skillnum)
        {
            case 1:
                self.skill_one_cooldown_time = time + self.skill_one_cooldown;
                sound (self, CHAN_WEAPON, selfchamp.sound_skillone_cast, 1, ATTN_NORM);
                break;
            case 2:
                self.skill_two_cooldown_time = time + self.skill_two_cooldown;
                sound (self, CHAN_WEAPON, selfchamp.sound_skilltwo_cast, 1, ATTN_NORM);
                break;
            case 3:
                self.skill_three_cooldown_time = time + self.skill_three_cooldown;
                sound (self, CHAN_WEAPON, selfchamp.sound_skillthree_cast, 1, ATTN_NORM);
                break;
            case 4:
                self.skill_four_cooldown_time = time + self.skill_four_cooldown;
                sound (self, CHAN_WEAPON, selfchamp.sound_skillfour_cast, 1, ATTN_NORM);
                break;
        }
        return TRUE;
    }
    else
    {
        return FALSE;
    }
}

