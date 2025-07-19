//all kiwis code 
::fl_PotatoFuckingTime <- 0
    
function StartFuckingHotPotatoMode() {
    if (Time() <= fl_PotatoFuckingTime) { // already active
        printl("[Hot Potato] Already active!"); // maybe make this extend time?
        return;
    }
    ::PASSTIME <- Entities.FindByClassname(null, "passtime_logic")
    local time = RandomInt(5,30) // from a donator perspective maybe this would be better off not having a minimum of 5 seconds? (or not even being random @ all)
    fl_PotatoFuckingTime = Time() + time
    EntFireByHandle(GLOBALTHINKENT, "callscriptfunction", "StopFuckingHotPotatoMode", time, null, null)
    EntityOutputs.AddOutput(PASSTIME, "onballgetany", "!activator", "CallScriptFunction", "IHateFuckingEverything", -1, -1)
}

function StopFuckingHotPotatoMode() {
    printl("[Hot Potato] Mode ended.");
}

function IHateFuckingEverything() { 
    if (Time() <= fl_PotatoFuckingTime) // hot potato mode is active
    {
        local trigger = SpawnEntityFromTable("trigger_ignite",{
            burn_duration = 10,
            spawnflags = 1
          

        })
        trigger.AcceptInput("StartTouch", "", self, self)
        EntFireByHandle(trigger, "Kill", "", 0, null, null)
    }
}
