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
    if (PASS_CHANCE < 0)
        useable.Insert(Gags[EXTRA,2])
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
    useable := countUseableGags()
    if (debug)
    {
        testGags(useable)
    }
    pickGag(useable, roulette)
}

pickGag(ByRef useable, roulette=0)
{
    ;Click on a gag and return its object
    if (PASS_CHANCE > 0)
    {
        Random, pass, 0, 100
        if (pass < PASS_CHANCE)
        {
            MouseClick, , Gags[EXTRA, 2].coord.getX(), Gags[EXTRA, 2].coord.getY()
            return Gags[EXTRA, 2]
        }
    }
    if (roulette)
    {
        Random, num, 10, 20
        Loop %Num%
        {
            Random, choice, 1, useable.Length()
            MouseMove, useable[choice].coord.getX(), useable[choice].coord.getY()
        }
    }
    Random, choice, 1, useable.Length()
    while (not gagIsValid(useable[choice]))
    {
        Sleep 50
        if (A_Index = 10)
            return "NO TARGET"
    }
    MouseClick, , useable[choice].coord.getX(), useable[choice].coord.getY()
    return useable[choice]
}

clickBack()
{
    MouseClick, , Gags[TGETS,3].coord.getX(), Gags[TGETS,3].coord.getY()
}

cycleGags(debug=0)
{
    attackTargets := []
    tuTargets := []
    lureTargets := []
    trapTargets := []
    lured := 0
    trapped := 0
    attacked := 0
    tued := 0
    useable := countUseableGags()
    RUNNING := 1
    ;if (not debug)
        ;SetTimer, StopCycling, 50000
    while (RUNNING)
    {
        if (A_Index > 1)
        {
            clickBack()
            Sleep 300
        }
        gag := pickGag(useable)
        if (gag = "NO TARGET")
        {
            ;MsgBox NO GAGS
            RUNNING := 0
            return
        }
        pause(debug)
        target := chooseTargetCycle(gag, attackTargets, tuTargets, lureTargets, trapTargets, attacked, tued, lured, trapped)
        if (target = "NO TARGET")
        {
            ;MsgBox NO TARGET
            ;RUNNING := 0
            ;return
        }
        Sleep 300
    }
}

pause(debug=0)
{
    if (debug)
    {
        KeyWait, Control
        KeyWait, Control, D
    }
    else
    {
        Sleep 50
    }
}