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
        if (A_Index = 15)
        {
            return "NO TARGET"
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

isTargetValid(target)
{
    GetCoords(X, Y, target)
    PixelSearch Px, Py, X-5, Y-5, X+5, Y+5, TARGET, 50, FAST|RGB
    if ErrorLevel
        return 0
    return 1
}

pickTarget(ByRef targets)
{
    Random, choice, 1, targets.Length()
    GetCoords(X, Y, targets[choice])
    MouseClick, , X,Y,,MOUSE_SPEED
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

singleTargetCycle(ByRef targs, ByRef doneBefore)
{
    if (not doneBefore)
    {
        debugPrint("First time using this type!", debug)
        targs := findTargets()
        if (targs = "NO TARGET")
        {
            return targs
        }
        doneBefore := 1
    }
    ;testTargets(targs, debug)
    ;while (not isTargetValid(targs[targs.Length()]))
    ;{
    ;    Sleep 50
    ;    if (A_Index = 15)
    ;    {
    ;        MsgBox TARGET NOT FOUND
    ;        return
    ;    }
    ;    if (isBackAvailable())
    ;    {
    ;        MouseClick, , Gags[TGETS,3].coord.getX(), Gags[TGETS,3].coord.getY(),,MOUSE_SPEED
    ;        return
    ;    }
    ;}
    pickTarget(targs)
}

chooseTargetCycle(gag, ByRef attackTargets, ByRef tuTargets, ByRef lureTargets, ByRef trapTargets, ByRef fireTargets, ByRef attacked, ByRef tued, ByRef lured, ByRef trapped, ByRef fired, debug=0)
{
    ;Optimized version of targeting that stores the targets from previous
    ;gag selections for both attack gags and tu gags
    ;also skips the process for gags that don't need a target selection
    if (gag.getTrack() = EXTRA)
    {
        if (gag.getLevel() = 1)
        {
            ;Fire
            singleTargetCycle(fireTargets, fired)
        }
        else
        {
            ;SOS
            pickSOS()
        }
    }
    else if (gag.isSingleTarget())
    {
        if (gag.getTrack() = TOONUP)
            targ := singleTargetCycle(tuTargets, tued)
        else if (gag.getTrack() = TRAP)
            targ :=singleTargetCycle(trapTargets, trapped)
        else if (gag.getTrack() = LURE)
            targ := singleTargetCycle(lureTargets, lured)
        else
            targ := singleTargetCycle(attackTargets, attacked)
    }
    return targ
}