IncludeScript("passtime/defines.nut")
IncludeScript("passtime/gameevents.nut")
IncludeScript("passtime/rtd.nut")

//rtd and horseman code appeneded from mvm code, thanks to kiwi and mega for their contributions to both 
function twitchHandler(username, amount, message) {
    ClientPrint(null, 3, "\x07ffffff[\x07ff00ffTwitch Integration\x07ffffff] \x07FF3F3F" + username + " \x01donated: \x03$" + amount/100 + " \x01with message: " + message)
    switch (amount) {
        case 100:
            ClientPrint(null, 3, "\x07FF3F3F" + username + "\x01 donated \x03$" + amount/100 + "\x01, triggering rtd on a random player!!")
            ApplyRTD(getRandomPlayer())
            break;
        case 1500: 
            ClientPrint(null, 3, "\x07FF3F3F" + username + "\x01 donated \x03$" + amount/100 + "\x01, spawning the horseman!")
            SpawnHorseman(username, Constants.ETFTeam.TF_TEAM_PVE_INVADERS)
            break;
      case 2000:
            Convars.SetValue("sv_gravity", RandomInt(0, 500))
            ClientPrint(null, 3, "\x07FF3F3F" + username + "\x01 donated \x03$" + amount/100 + "\x01, randomising gravity!")
            printl("case for 20 dollars")
            break;
    }
}


      

