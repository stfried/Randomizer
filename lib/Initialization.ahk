init(forceR=0, forceC=0)
{
    log(A_ThisFunc)
    FileRead, Contents, bin\coordinates.ini
    if (ErrorLevel or forceR)
    {
        MsgBox Setup required. Please have a battle menu ready.
        setup()
        FileRead, Contents, bin\coordinates.ini
    }
    parseCoords(Contents)
    FileRead, Contents, config.ini
    if (ErrorLevel or forceC)
    {
        MsgBox User settings not found. Importing defaults.
        config()
        FileRead, Contents, config.ini
    }
    parseConfig(Contents)
    calculateCoords()
    fillSOS()
    log(A_ThisFunc, "VOID")
}

reInit()
{
    log(A_ThisFunc)
    global MIN_LEVEL := 1
    global MAX_LEVEL := 6
    global ALLOWED_TRACKS := []
    global BLACKLISTED_GAGS := ""
    global FIRE_CHANCE := 0
    global SOS_CHANCE := 0
    global PASS_CHANCE := 0
    global DOODLE_CHANCE := 0
    global RUNNING := 0
    log(A_ThisFunc, "VOID")
}

recalibrate()
{
    log(A_ThisFunc)
    reInit()
    init(1)
    log(A_ThisFunc, "VOID")
}

reconfig()
{
    log(A_ThisFunc)
    reInit()
    init(0, 1)
    log(A_ThisFunc, "VOID")
}

calculateCoords()
{
    log(A_ThisFunc)
    ;Calculate x and y coords of each given row and column
    xCoords := []
    yCoords := []
    level := 1
    while level <= 7
    {
        ;GetCoords(Xc, Yc, Gags[THROW, level])
        xCoords[level] := Gags[THROW, level].coord.getX()
        level++
    }
    track := 1
    while track <= DROP
    {
        ;GetCoords(Xc, Yc, Coords[track, 0])
        yCoords[track] := Gags[track, 1].coord.getY()
        track++
    }
    fillCoords(xCoords, yCoords)
    log(A_ThisFunc, "VOID")
}

fillCoords(ByRef xCoords, ByRef yCoords)
{
    log(A_ThisFunc)
    ;Fill entire table of gag coords
    track := TOONUP
    while track <= DROP
    {
        level := 1
        while level <= 7
        {
            temp := new Gag
            temp.setAll(track, level, xCoords[level], yCoords[track])
            Gags[track, level] := temp
            ;MouseMove, Gags[track,level].coord.getX(), Gags[track,level].coord.getY()
            ;MsgBox % Gags[track,level].pprint()
            ;KeyWait, Control
            ;KeyWait, Control, D
            level += 1
        }
        track += 1
    }
    log(A_ThisFunc, "VOID")
}

testCoords()
{
    log(A_ThisFunc)
    track := TOONUP
    while track <= DROP
    {
        level := 1
        while level <= 7
        {
            MouseMove, Gags[track,level].coord.getX(), Gags[track,level].coord.getY()
            MsgBox % Gags[track,level].pprint()
            level += 1
        }
        track += 1
    }
    log(A_ThisFunc, "VOID")
}

whitelistAll()
{
    log(A_ThisFunc)
    BLACKLISTED_GAGS := ""
    track := TOONUP
    while track <= DROP
    {
        level := 1
        while level <= 7
        {
            Gags[track,level].whitelist()
            level += 1
        }
        track += 1
    }
    log(A_ThisFunc, "VOID")
}

blacklistAll()
{
    log(A_ThisFunc)
    BLACKLISTED_GAGS := ""
    track := TOONUP
    while track <= DROP
    {
        level := 1
        while level <= 7
        {
            Gags[track,level].blacklist()
            BLACKLISTED_GAGS := BLACKLISTED_GAGS " " track "," level
            level += 1
        }
        track += 1
    }
    log(A_ThisFunc, "VOID")
}

blacklistGags()
{
    log(A_ThisFunc)
    Loop, Parse, BLACKLISTED_GAGS, %A_Space% 
    {
        C := []
        Loop, Parse, A_LoopField, `,
        {
            val := A_LoopField
            val += 0
            C.Insert(val)
        }
        if (C.Length() = 2)
        {
            Gags[C[1],C[2]].blacklist()
        }
    }
    log(A_ThisFunc, "VOID")
}