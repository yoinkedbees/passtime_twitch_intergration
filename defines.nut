::MAX_WEAPONS <- 8
::MAX_PLAYERS <- MaxClients().tointeger()
::TF_GAMERULES <- Entities.FindByClassname(null, "tf_gamerules")
::MONSTER_RESOURCE <- Entities.FindByClassname(null, "monster_resource")
::WORLDSPAWN <- Entities.FindByClassname(null, "worldspawn") 
::PASSTIME_BALL_SPAWN <- Entities.FindByClassname(null, "info_passtime_ball_spawn")

::GLOBALTHINKENT <- Entities.CreateByClassname("info_target");
AddThinkToEnt(GLOBALTHINKENT, "globalThink");

function getRandomPlayer() {
    local players = []
    for (local i = 1; i <= MAX_PLAYERS ; i++)
    {
        local player = PlayerInstanceFromIndex(i)
        if (player == null || player.IsFakeClient() || player.IsBotOfType( 1337 /* Constants.EBotType.TF_BOT_TYPE */)) continue
        players.append(player)
    }
    local randomIndex = RandomInt(0, players.len() - 1)
    return players[randomIndex];
}
function globalThink()
{
    local hhh = Entities.FindByClassname(null, "headless_hatman")
    if (!hhh)
    {
        if (MONSTER_RESOURCE) // Check if the health bar entity exists, just in case to prevent errors
        {
            NetProps.SetPropInt(MONSTER_RESOURCE, "m_iBossHealthPercentageByte", 0)
        }
    }
    return 0.2
}

PrecacheModel("models/weapons/c_models/c_bigaxe/c_bigaxe.mdl")
PrecacheModel("models/weapons/c_models/c_big_mallet/c_big_mallet.mdl")

::clamp <- function(value, min, max)
{
    if (value < min)
        return min;
    if (value > max)
        return max;
    return value;
}

function RandomKeyFromTable(table) {
    // Collect keys into an array
    local keys = [];
    foreach(key, value in table) {
        keys.append(key);
    }

    return keys[RandomInt(0, keys.len()-1)]
}




function SpawnHorseman(donorname, teamnum) {
    local hhh = Entities.FindByClassname(null, "headless_hatman")

    if (hhh != null)
    {
        local hhhpos = hhh.GetOrigin()
        hhh.SetHealth(hhh.GetHealth() + 5000)
        hhh.SetMaxHealth(hhh.GetHealth())
        SendGlobalGameEvent("show_annotation", {
            worldPosX = hhhpos.x
            worldPosY = hhhpos.y
            worldPosZ = hhhpos.z
            id = 0
            text = "" + donorname + " gave the Horseman +5000 HP!"
            lifetime = 3.0
        })
        return hhh
    }

    local hhh_name = DoUniqueString("yoinkedbees_hhh");
    hhh = SpawnEntityFromTable("headless_hatman", {
        targetname = hhh_name,
        team = teamnum,
    })

    EntFireByHandle(hhh, "RunsScriptCode", "self.SetMaxHealth(5000)", 0, hhh, hhh)
    EntFireByHandle(hhh, "RunsScriptCode", "self.SetHealth(5000)", 0, hhh, hhh)

    local glow = SpawnEntityFromTable("tf_glow", {
        target = "bignet",
        GlowColor = "255 0 255 255",
        mode = 0
    })
    NetProps.SetPropEntity(glow, "m_hTarget", hhh)

    for (local entity; entity = Entities.FindByClassname(entity, "prop_dynamic");)
    {
        if (entity.GetModelName() == "models/weapons/c_models/c_bigaxe/c_bigaxe.mdl")
            entity.SetModel("models/weapons/c_models/c_big_mallet/c_big_mallet.mdl")
    }
    
    local startpos = PASSTIME_BALL_SPAWN.GetOrigin() + Vector(0, 0 ,-150)
    hhh.SetOrigin(startpos)
    SendGlobalGameEvent("show_annotation", {
        worldPosX = startpos.x
        worldPosY = startpos.y
        worldPosZ = startpos.z
        id = 0
        text = "" + donorname + " has summoned the Horseless Headless Horseman!"
        lifetime = 10
    })
    AddThinkToEnt(hhh, "hhhHealthBarThink")
    return hhh
}

function hhhHealthBarThink() {
    if (MONSTER_RESOURCE) // Check if the health bar entity exists, just in case to prevent errors
    {
        local healthratio = self.GetHealth().tofloat() / self.GetMaxHealth().tofloat()
        NetProps.SetPropInt(MONSTER_RESOURCE, "m_iBossHealthPercentageByte", healthratio * 255)
    }
}
