init(forceR=0, forceC=0)
{
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
}

reInit()
{
    global MIN_LEVEL := 1
    global MAX_LEVEL := 6
    global ALLOWED_TRACKS := []
    global BLACKLISTED_GAGS := ""
    global PASS_CHANCE := 0
    global RUNNING := 0
}

recalibrate()
{
    reInit()
    init(1)
}

reconfig()
{
    reInit()
    init(0, 1)
}

calculateCoords()
{
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
}

fillCoords(ByRef xCoords, ByRef yCoords)
{
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
}

testCoords()
{
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
}