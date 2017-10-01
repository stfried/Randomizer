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
        #Persistent
        ToolTip, DEBUG MODE
        SetTimer, RemoveToolTip, 5000
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

chooseTargetCycle(gag, ByRef attackTargets, ByRef tuTargets, ByRef lureTargets, ByRef trapTargets, ByRef attacked, ByRef tued, ByRef lured, ByRef trapped, debug=0)
{
    ;Optimized version of targeting that stores the targets from previous
    ;gag selections for both attack gags and tu gags
    ;also skips the process for gags that don't need a target selection
    if (gag.getTrack() = EXTRA)
    {
        debugPrint("Pass!", debug)
        ;Pass
        ;TODO: Implement SOS selection
        return
    }
    if (gagIsSingleTarget(gag))
    {
        MsgBox Single Target!
        if (gag.getTrack() = TOONUP)
        {
            if (not tued)
            {
                debugPrint("First time TU!", debug)
                pause(1)
                tuTargets := findTargets()
                tued := 1
            }
            debugPrint("TU!", debug)
            pause(1)
            testTargets(tuTargets, debug)
            pickTarget(tuTargets)
        }
        else if (gag.getTrack() = TRAP)
        {
            if (not trapped)
            {
                debugPrint("First time trap!", debug)
                pause(1)
                trapTargets := findTargets()
                trapped := 1
            }
            debugPrint("TRAPPED!", debug)
            pause(1)
            testTargets(trapTargets, debug)
            pickTarget(trapTargets)
        }
        else if (gag.getTrack() = LURE)
        {
            if (not lured)
            {
               debugPrint("First time lure!", debug)
                pause(1)
                lureTargets := findTargets()
                lured := 1
            }
            debugPrint("LURED!", debug)
            pause(1)
            testTargets(lureTargets, debug)
            pickTarget(lureTargets)
        }
        else
        {
            if (not attacked)
            {
                debugPrint("First time attack!", debug)
                pause(1)
                attackTargets := findTargets()
                attacked := 1
            }
            debugPrint("ATTACKED!", debug)
            pause(1)
            testTargets(attackTargets, debug)
            pickTarget(attackTargets)
        }
    }
    else
    {
        debugPrint("Group target, skipping targeting.", debug)
    }
}