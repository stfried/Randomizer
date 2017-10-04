findTargets()
{
    targets := []
    xPos := gags[TGETS,1].coord.getX()
    yPos := gags[TGETS,1].coord.getY()
    xDiff := gags[TGETS,2].coord.getX()
    yDiff := gags[TGETS,2].coord.getY()
    xDiff -= xPos
    yDiff -= yPos
    temp = % "o30 e0 n fx,y a" xPos "," yPos "," xDiff "," yDiff
    Result := FindClick("lib\blue.png", temp)
    while (not Result)
    {
        Result := FindClick("lib\blue.png", temp)
        if (A_Index = 5)
        {
            return "NO TARGETS"
        }
        Sleep 50
    }
    ;Sort, Result, N
    Loop, Parse, Result, `n
    {

        targets.Insert(A_Loopfield)
        ;GetCoords(Xc, Yc, A_LoopField)
        ;KeyWait, Control
        ;MouseMove, Xc, Yc
        ;KeyWait, Control, D
    }
    return targets
}

pickTarget(ByRef targets)
{
    Random, choice, 1, targets.Length()
    GetCoords(X, Y, targets[choice])
    MouseClick, , X,Y
}

testTargets(ByRef targets, debug=0)
{
    ;Cycle through all targets to check detection is working properly
    if (debug)
    {
        for idx, target in targets
        {
            GetCoords(Xc, Yc, target)
            MouseMove, Xc, Yc
            ;KeyWait, Control
            ;KeyWait, Control, D
        }
    }
}

chooseOneTarget(debug=0)
{
    targets := findTargets()
    if (debug)
    {
        testTargets(targets, debug)
    }
    pickTarget(targets)
}

gagIsSingleTarget(gag)
{
    if (gag.getTrack() != SOUND)
    {
        if (gag.getLevel() != 7)
        {
            if (gag.getTrack() == TOONUP or gag.getTrack() == LURE)
            {
                ;Is TU or Lure
                if (gag.getLevel() != 2 and gag.getLevel() != 4 and gag.getLevel() != 6)
                {
                    ;Is single target TU or Lure
                    return 1
                }
                ;Is multi-target TU or Lure
                return 0
            }
            else
            {
                return 1
            }
        }
    }
    return 0
}

singleTargetCycle(ByRef targs, ByRef doneBefore)
{
    if (not doneBefore)
    {
        debugPrint("First time using this type!", debug)
        targs := findTargets()
        if (targs = "NO TARGETS")
            return targs
        doneBefore := 1
    }
    testTargets(targs, debug)
    pickTarget(targs)
}

chooseTargetCycle(gag, ByRef attackTargets, ByRef tuTargets, ByRef lureTargets, ByRef trapTargets, ByRef attacked, ByRef tued, ByRef lured, ByRef trapped, debug=0)
{
    ;Optimized version of targeting that stores the targets from previous
    ;gag selections for both attack gags and tu gags
    ;also skips the process for gags that don't need a target selection
    if (gag.getTrack() = EXTRA)
    {
        if (gag.getLevel() = 1)
        {
            ;Fire
            singleTargetCycle(attackTargets, attacked)
        }
        else if (gag.getLevel() = 2)
        {
            ;Pass
            debugPrint("Pass!", debug)
        }
        else
        {
            ;SOS
            ;TODO
        }
    }
    else if (gagIsSingleTarget(gag))
    {
        if (gag.getTrack() = TOONUP)
            singleTargetCycle(tuTargets, tued)
        else if (gag.getTrack() = TRAP)
            singleTargetCycle(trapTargets, trapped)
        else if (gag.getTrack() = LURE)
            singleTargetCycle(lureTargets, lured)
        else
            singleTargetCycle(attackTargets, attacked)
    }
    return
}