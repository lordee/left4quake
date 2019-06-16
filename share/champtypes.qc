typedef struct {
    float champ_id;
    string model;
    vector model_min;
    vector model_max;
    vector model_viewoffset;
    string model_head;
    string sound_death;
    string sound_aashoot;
    string sound_aahit;
    string sound_aahitwall;
    string sound_skillone_cast;
    string sound_skilltwo_cast;
    string sound_skillthree_cast;
    string sound_skillfour_cast;
    float basead;
    float basehealth;
    float basehealth_regen;
    float basemana;
    float basemana_regen;
    float basespeed;
    float baseattackspeed;
    float skill_one;
    float skill_one_manacost;
    float skill_one_cooldown;
    float skill_one_damage;
    float skill_one_range;
    float skill_one_value;
    float skill_two;
    float skill_two_manacost;
    float skill_two_cooldown;
    float skill_two_damage;
    float skill_two_range;
    float skill_two_value;
    float skill_three;
    float skill_three_manacost;
    float skill_three_cooldown;
    float skill_three_damage;
    float skill_three_range;
    float skill_three_value;
    float skill_four;
    float skill_four_manacost;
    float skill_four_cooldown;
    float skill_four_damage;
    float skill_four_range;
    float skill_four_value;
} Champion_t;

Champion_t Champions[3] = {
    {
        CHAMP_UNDEFINED,
        MODEL_UNDEFINED,
        MODEL_MIN_UNDEFINED,
        MODEL_MAX_UNDEFINED,
        MODEL_VIEWOFFSET_UNDEFINED,
        MODEL_HEAD_UNDEFINED,
        SOUND_DEATH_UNDEFINED,
        SOUND_AASHOOT_UNDEFINED,
        SOUND_AAHIT_UNDEFINED,
        SOUND_AAHITWALL_UNDEFINED,
        "",
        "",
        "",
        "",
        BASEAD_UNDEFINED,
        BASEHEALTH_UNDEFINED,
        BASEHEALTH_REGEN_UNDEFINED,
        BASEMANA_UNDEFINED,
        BASEMANA_REGEN_UNDEFINED,
        BASESPEED_UNDEFINED,
        BASEATTACKSPEED_UNDEFINED,
        SKILLONE_UNDEFINED,
        SKILLONE_MANACOST_UNDEFINED,
        SKILLONE_COOLDOWN_UNDEFINED,
        SKILLONE_DAMAGE_UNDEFINED,
        SKILLONE_RANGE_UNDEFINED,
        0,
        SKILLTWO_UNDEFINED,
        SKILLTWO_MANACOST_UNDEFINED,
        SKILLTWO_COOLDOWN_UNDEFINED,
        SKILLTWO_DAMAGE_UNDEFINED,
        SKILLTWO_RANGE_UNDEFINED,
        0,
        SKILLTHREE_UNDEFINED,
        SKILLTHREE_MANACOST_UNDEFINED,
        SKILLTHREE_COOLDOWN_UNDEFINED,
        SKILLTHREE_DAMAGE_UNDEFINED,
        SKILLTHREE_RANGE_UNDEFINED,
        0,
        SKILLFOUR_UNDEFINED,
        SKILLFOUR_MANACOST_UNDEFINED,
        SKILLFOUR_COOLDOWN_UNDEFINED,
        SKILLFOUR_DAMAGE_UNDEFINED,
        SKILLFOUR_RANGE_UNDEFINED,
        0
    },
    {
        CHAMP_FROSTARCHER,
        MODEL_FROSTARCHER,
        MODEL_MIN_FROSTARCHER,
        MODEL_MAX_FROSTARCHER,
        MODEL_VIEWOFFSET_FROSTARCHER,
        MODEL_HEAD_FROSTARCHER,
        SOUND_DEATH_FROSTARCHER,
        SOUND_AASHOOT_FROSTARCHER,
        SOUND_AAHIT_FROSTARCHER,
        SOUND_AAHITWALL_FROSTARCHER,
        SOUND_SKILLONE_CAST_FROSTARCHER,
        SOUND_SKILLTWO_CAST_FROSTARCHER,
        SOUND_SKILLTHREE_CAST_FROSTARCHER,
        SOUND_SKILLFOUR_CAST_FROSTARCHER,
        BASEAD_FROSTARCHER,
        
        BASEHEALTH_FROSTARCHER,
        
        BASEHEALTH_REGEN_FROSTARCHER,
        BASEMANA_FROSTARCHER,
        
        BASEMANA_REGEN_FROSTARCHER,
        BASESPEED_FROSTARCHER,
        BASEATTACKSPEED_FROSTARCHER,
        
        SKILLONE_FROSTARCHER,
        SKILLONE_MANACOST_FROSTARCHER,
        SKILLONE_COOLDOWN_FROSTARCHER,
        SKILLONE_DAMAGE_FROSTARCHER,
        SKILLONE_RANGE_FROSTARCHER,
        0,
        SKILLTWO_FROSTARCHER,
        SKILLTWO_MANACOST_FROSTARCHER,
        SKILLTWO_COOLDOWN_FROSTARCHER,
        SKILLTWO_DAMAGE_FROSTARCHER,
        SKILLTWO_RANGE_FROSTARCHER,
        0,
        SKILLTHREE_FROSTARCHER,
        SKILLTHREE_MANACOST_FROSTARCHER,
        SKILLTHREE_COOLDOWN_FROSTARCHER,
        SKILLTHREE_DAMAGE_FROSTARCHER,
        SKILLTHREE_RANGE_FROSTARCHER,
        0,
        SKILLFOUR_FROSTARCHER,
        SKILLFOUR_MANACOST_FROSTARCHER,
        SKILLFOUR_COOLDOWN_FROSTARCHER,
        SKILLFOUR_DAMAGE_FROSTARCHER,
        SKILLFOUR_RANGE_FROSTARCHER,
        0
    },
    {
        CHAMP_SHAMBLER,
        MODEL_SHAMBLER,
        MODEL_MIN_SHAMBLER,
        MODEL_MAX_SHAMBLER,
        MODEL_VIEWOFFSET_SHAMBLER,
        MODEL_HEAD_SHAMBLER,
        SOUND_DEATH_SHAMBLER,
        SOUND_AASHOOT_SHAMBLER,
        SOUND_AAHIT_SHAMBLER,
        SOUND_AAHITWALL_SHAMBLER,
        SOUND_SKILLONE_CAST_SHAMBLER,
        SOUND_SKILLTWO_CAST_SHAMBLER,
        SOUND_SKILLTHREE_CAST_SHAMBLER,
        SOUND_SKILLFOUR_CAST_SHAMBLER,
        BASEAD_SHAMBLER,
        
        BASEHEALTH_SHAMBLER,
        
        BASEHEALTH_REGEN_SHAMBLER,
        BASEMANA_SHAMBLER,
        
        BASEMANA_REGEN_SHAMBLER,
        BASESPEED_SHAMBLER,
        BASEATTACKSPEED_SHAMBLER,
        
        SKILLONE_SHAMBLER,
        SKILLONE_MANACOST_SHAMBLER,
        SKILLONE_COOLDOWN_SHAMBLER,
        SKILLONE_DAMAGE_SHAMBLER,
        SKILLONE_RANGE_SHAMBLER,
        0,
        SKILLTWO_SHAMBLER,
        SKILLTWO_MANACOST_SHAMBLER,
        SKILLTWO_COOLDOWN_SHAMBLER,
        SKILLTWO_DAMAGE_SHAMBLER,
        SKILLTWO_RANGE_SHAMBLER,
        0,
        SKILLTHREE_SHAMBLER,
        SKILLTHREE_MANACOST_SHAMBLER,
        SKILLTHREE_COOLDOWN_SHAMBLER,
        SKILLTHREE_DAMAGE_SHAMBLER,
        SKILLTHREE_RANGE_SHAMBLER,
        0,
        SKILLFOUR_SHAMBLER,
        SKILLFOUR_MANACOST_SHAMBLER,
        SKILLFOUR_COOLDOWN_SHAMBLER,
        SKILLFOUR_DAMAGE_SHAMBLER,
        SKILLFOUR_RANGE_SHAMBLER,
        SKILLFOUR_VALUE_SHAMBLER
    }
};

Champion_t selfchamp;
void GetChamp(float id)
{
    for (float i = 0; i < Champions.length; i++)
    {
        if (Champions[i].champ_id == id)
        {
            selfchamp = Champions[i];
            return;
        }
    }
    selfchamp = Champions[0];
}