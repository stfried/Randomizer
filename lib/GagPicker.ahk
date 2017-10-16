isBlackListed(gag)
{
    ;Return whether or not the given gag is blacklisted by user
    return not gag.isWhitelisted()
}

gagIsValid(gag)
{
    ;Check if a gag is usable and not blacklisted
    ;Note: does not check if it's in an allowed level or track
    if isBlackListed(gag)
        return 0
    PixelSearch Px, Py, gag.coord.getX()-5, gag.coord.getY()-5, gag.coord.getX()+5, gag.coord.getY()+5, BLUE, 50, FAST|RGB
    if ErrorLevel
    {
        PixelSearch Px, Py, gag.coord.getX()-5, gag.coord.getY()-5, gag.coord.getX()+5, gag.coord.getY()+5, GREEN, 30, FAST|RGB
        if ErrorLevel
            return 0
    }
    return 1
}

countUseableGags()
{
    ;Create an array of useable gags
    useable := []
    if (FIRE_CHANCE < 0)
        useable.Insert(Gags[EXTRA,1])
    if (PASS_CHANCE < 0)
        useable.Insert(Gags[EXTRA,2])
    if (SOS_CHANCE < 0)
        useable.Insert(Gags[EXTRA,3])
    for idx, track in ALLOWED_TRACKS
    {
        level := MIN_LEVEL
        while level <= MAX_LEVEL
        {
            if gagIsValid(Gags[track, level])
                useable.Insert(Gags[track, level])
            level +=1
        }
    }
    return useable
}

testGags(ByRef useable)
{
    ;Cycle through all useable gags to check detection is working properly
    for idx, gag in useable
    {
        MouseMove, gag.coord.getX(), gag.coord.getY()
        ;KeyWait, Control
        ;KeyWait, Control, D
    }
}

chooseOneGag(roulette=0)
{
	MouseMove, 0, 0, 0
	useable := countUseableGags()
	gag := pickGag(useable,roulette)
    if (roulette)
    {
        buildSVG(useable, gag)
        IfWinExist, wheel.html - Google Chrome
            WinActivate
        Sleep 50
        ControlSend, , {ctrl down}r{ctrl up}, wheel.html - Google Chrome
        ControlSend, , {F5}, wheel.html - Google Chrome
        IfWinExist, Toontown Rewritten
            WinActivate
        if (first_use)
        {
            Sleep 8500
            first_use := 0
        }
        else
            Sleep 6500
        clickGag(gag)
    }
	if (gag.isSingleTarget())
		target := chooseTargetCycle(gag, [], [], [], [], [], 0, 0, 0, 0, 0)
    if (GAG_CHAT)
    {
        chat := ""
        Random, chance, 0, 100
        if (chance <= 50 and gag.getTrack() = SOUND and gag.getLevel() = 6)
        {
            IfWinExist, Toontown Rewritten
                WinActivate
            Random, num, 1, 325
            if (num = 13)
                chat := "out"
            else
                chat := whitelist[num]
        }
        else if (chance <= 100)
        {
            IfWinExist, Toontown Rewritten
                WinActivate
            if (gag.getTrack() <= DROP)
                chat := "org"
            else if (gag.getTrack() = EXTRA and gag.getLevel() = 2)
            {
                if (target = "SOS")
                   Random, num, 1, NUM_SHOPKEEPERS
                   chat := shopkeepers[n]
            }
        }
        if (chat != "")
            Send %chat% {ENTER}
    }
	
}

clickGag(gag, roulette=0)
{
	if (roulette = 0)
	{
		MouseClick, , gag.coord.getX(), gag.coord.getY(),,MOUSE_SPEED
	}
}

pickGag(ByRef useable, roulette=0)
{
    ;Click on a gag and return its object

    if (not roulette)
    {
        ;Check alternatives to gags
        f_c := 0
        if (FIRE_CHANCE > 0)
            f_c += FIRE_CHANCE
        p_c := f_c
        if (PASS_CHANCE > 0)
            p_c += PASS_CHANCE
        s_c := p_c
        if (SOS_CHANCE > 0)
            s_c += SOS_CHANCE 
        if (s_c > 100)
        {
            MsgBox ERROR: PASS, FIRE, AND SOS EXCEED 100`%
        }
        else if (s_c > 0)
        {
            Random, chance, 1, 100
            if (chance <= f_c)
            {
                clickGag(Gags[EXTRA, 1], roulette)
                ;MouseClick, , Gags[EXTRA, 1].coord.getX(), Gags[EXTRA, 1].coord.getY(),,MOUSE_SPEED
                return Gags[EXTRA, 1]
            }
            else if (chance <= p_c)
            {
                clickGag(Gags[EXTRA, 2], roulette)
                ;MouseClick, , Gags[EXTRA, 2].coord.getX(), Gags[EXTRA, 2].coord.getY(),,MOUSE_SPEED
                return Gags[EXTRA, 2]
            }
            else if (chance <= s_c)
            {
                clickGag(Gags[EXTRA, 3], roulette)
                ;MouseClick, , Gags[EXTRA, 3].coord.getX(), Gags[EXTRA, 3].coord.getY(),,MOUSE_SPEED
                return Gags[EXTRA, 3]
            }
        }
    }
    Random, choice, 1, useable.Length()
    while (not gagIsValid(useable[useable.Length()]))
    {
        Sleep 50
        if (A_Index = 20)
            return "NO TARGET"
        if (isBackAvailable())
        {
			clickGag(Gags[TGETS, 3], roulette)
            ;MouseClick, , Gags[TGETS,3].coord.getX(), Gags[TGETS,3].coord.getY(),,MOUSE_SPEED
            break
        }
    }
	clickGag(useable[choice], roulette)
    ;MouseClick, , useable[choice].coord.getX(), useable[choice].coord.getY(),,MOUSE_SPEED
    return useable[choice]
}

isBackAvailable()
{
    PixelSearch Px, Py, Gags[TGETS,3].coord.getX()-5, Gags[TGETS,3].coord.getY()-5, Gags[TGETS,3].coord.getX()+5, Gags[TGETS,3].coord.getY()+5, BACK, 50, FAST|RGB
    if ErrorLevel
        return 0
    return 1
}

clickBack(ByRef useable)
{
    while (not isBackAvailable())
    {
        Sleep 50
        if (A_Index = 15)
            return "NO BACK"
        if (gagIsValid(useable[useable.Length()]))
            return 1
    }
    MouseClick, , Gags[TGETS,3].coord.getX(), Gags[TGETS,3].coord.getY(),,MOUSE_SPEED
    return 1
}

cycleGags(debug=0, once=0)
{
    attackTargets := []
    tuTargets := []
    lureTargets := []
    trapTargets := []
    fireTargets := []
    lured := 0
    trapped := 0
    attacked := 0
    tued := 0
    fired := 0
    single_cog := 0
    MouseMove, 0, 0, 0
    useable := countUseableGags()
    RUNNING := 1
    ;if (not debug)
        ;SetTimer, StopCycling, 50000
    while (RUNNING)
    {
        MouseMove, 0, 0, 0
        if (A_Index > 1)
        {
            result := clickBack(useable)
            if (result = "NO BACK")
            {
                ;MsgBox NO BACK
                return
            }
            Sleep 150
        }
        MouseMove, 0, 0, 0
        gag := pickGag(useable)
        if (gag = "NO TARGET")
        {
            ;MsgBox NO GAGS
            RUNNING := 0
            return
        }
        MouseMove, 0, 0, 0
        Sleep 100
        if (gag.isSingleTarget() and not single_cog)
        {
            ;Targeting
            target := chooseTargetCycle(gag, attackTargets, tuTargets, lureTargets, trapTargets, fireTargets, attacked, tued, lured, trapped, fired)
            if (target = "NO TARGET")
            {
                single_cog := 1
                attacked := 0
            }
            Sleep 100
        }
        if (once)
        {
            RUNNING := 0
            return
        }
        Sleep 100
    }
}