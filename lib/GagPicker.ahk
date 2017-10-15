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
    PixelSearch Px, Py, gag.coord.getX(), gag.coord.getY(), gag.coord.getX(), gag.coord.getY(), BLUE, 50, FAST|RGB
    if ErrorLevel
    {
        PixelSearch Px, Py, gag.coord.getX(), gag.coord.getY(), gag.coord.getX(), gag.coord.getY(), GREEN, 30, FAST|RGB
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

chooseOneGag(debug=0, roulette=0)
{
    ;Count gags and then choose one
    ;useable := countUseableGags()
    ;if (debug)
    ;{
    ;    testGags(useable)
    ;}
    ;pickGag(useable, roulette)
    cycleGags(0,1)
}

pickGag(ByRef useable, roulette=0)
{
    if (roulette)
    {
        Random, num, 10, 20
        Loop %Num%
        {
            Random, choice, 1, useable.Length()
            MouseMove, useable[choice].coord.getX(), useable[choice].coord.getY()
        }
    }

    ;Click on a gag and return its object
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
            MouseClick, , Gags[EXTRA, 1].coord.getX(), Gags[EXTRA, 1].coord.getY(),,MOUSE_SPEED
            return Gags[EXTRA, 1]
        }
        else if (chance <= p_c)
        {
            MouseClick, , Gags[EXTRA, 2].coord.getX(), Gags[EXTRA, 2].coord.getY(),,MOUSE_SPEED
            return Gags[EXTRA, 2]
        }
        else if (chance <= s_c)
        {
            MouseClick, , Gags[EXTRA, 3].coord.getX(), Gags[EXTRA, 3].coord.getY(),,MOUSE_SPEED
            return Gags[EXTRA, 3]
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
            MouseClick, , Gags[TGETS,3].coord.getX(), Gags[TGETS,3].coord.getY(),,MOUSE_SPEED
            break
        }
    }
    MouseClick, , useable[choice].coord.getX(), useable[choice].coord.getY(),,MOUSE_SPEED
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