CoordMode, ToolTip, Screen
#Include lib\Calibration.ahk
#Include lib\FindClick.ahk

global TOONUP := 0
global TRAP := 1
global LURE := 2
global SOUND := 3
global THROW := 4
global SQUIRT := 5
global DROP := 6
global EXTRA := 7
global TGETS := 8
global MIN_LEVEL := 0
global MAX_LEVEL := 6
global ALLOWED_TRACKS := []
global BLACKLISTED_GAGS := ""
global PASS_CHANCE := 0
global RUNNING := 0


global BLUE := 0x0088e3
global GREEN := 0x448888

global Coords := Object()

MsgBox RUNNING
FileRead, Contents, coordinates.ini
if ErrorLevel
{
    MsgBox Setup!
    Setup()
}
ParseCoords(Coords, Contents)
FileRead, Contents, config.ini
if ErrorLevel
{
    MsgBox Config!
    Config()
}
ParseConfig(Contents)
CalculateCoords(Coords)
;TestCoords(Coords)

^R::
    ;Force recalibrate
    Coords := Object()
    Setup()
    ParseCoords(Coords, Contents)
    CalculateCoords(Coords)
    return

^Q::
    CycleGags()
    return
    
^W::
    ChooseGag(Coords, "True")
    return
    
;Stop repeating    
^E::
    RUNNING := 0
    return
    
TestPixelSearch()
{
    KeyWait, Control
    KeyWait, Control, D
    MouseGetPos, xVal, yVal
    PixelSearch Px, Py, xVal, yVal, xVal, yVal, BLUE, 15, FAST|RGB
    MsgBox % ErrorLevel
}

CalculateCoords(ByRef Coords)
{
    ;Calculate x and y coords of each given row and column
    xCoords := Object()
    yCoords := Object()
    level := 0
    while level < 7
    {
        GetCoords(Xc, Yc, Coords[THROW, level])
        xCoords[level] := Xc
        level++
    }
    track := 0
    while track <= DROP
    {
        GetCoords(Xc, Yc, Coords[track, 0])
        yCoords[track] := Yc
        track++
    }
    FillCoords(Coords, xCoords, yCoords)
}

FillCoords(ByRef Coords, ByRef xCoords, ByRef yCoords)
{
    ;Fill entire table of gag coords
    track := TOONUP
    while track <= DROP
    {
        level := 0
        while level < 7
        {
            Coords[track, level] := xCoords[level] "," yCoords[track]
            ;MsgBox % Coords[track, level, 0] "," Coords[track, level, 1]
            ;MouseMove, xCoords[level], yCoords[track]
            ;KeyWait, Control
            ;KeyWait, Control, D
            level += 1
        }
        track += 1
    }
}

TestCoords(ByRef Coords)
{
    track := TOONUP
    while track <= DROP
    {
        level := 0
        while level < 7
        {
            GetCoords(Xc, Yc, Coords[track, level])
            MouseMove, Xc, Yc
            MsgBox % Coords[track, level]
            level += 1
        }
        track += 1
    }
}

CountGags(ByRef Coords, ByRef Gags)
{
    ;Loop through Coords of allowed tracks and levels and add them to Gags if they can be used
    Gags := []
    if (PASS_CHANCE < 0)
    {
        Gags.Insert(Coords[EXTRA, 1])
    }
    for idx, track in ALLOWED_TRACKS
    {
        level := MIN_LEVEL
        while level <= MAX_LEVEL
        {
            if GagIsValid(Coords, track, level) {
                Gags.Insert(Coords[track, level])
            }
            level += 1
        }
    }
}

GagIsValid(ByRef Coords, track, level)
{
    ;Returns true if the gag may be used (DOES NOT CHECK ALLOWED TRACKS OR LEVELS)
    if IsBlackListed(track, level)
    {
        return 0
    }
    GetCoords(xVal, yVal, Coords[track, level])
    ;MouseMove, xVal, yVal
    PixelSearch Px, Py, xVal, yVal, xVal, yVal, BLUE, 50, FAST|RGB
    if ErrorLevel
    {
        PixelSearch Px, Py, xVal, yVal, xVal, yVal, GREEN, 50, FAST|RGB
        if ErrorLevel
        {
            return 0
        }
    }
    return 1
}

IsBlackListed(track, level)
{
    ;Returns true if gag is blacklisted
    formatted = % track + 1 "," level + 1
    IfInString, BLACKLISTED_GAGS, %formatted%
    {
        return 1
    }
    return 0
}

PickObject(ByRef Obj, Roulette="False")
{
    if (roulette = "True")
    {
        Random, Num, 10, 20
        Loop %Num%
        {
            Random, Choice, 1, Obj.Length()
            GetCoords(X, Y, Obj[Choice])
            MouseMove, X, Y
        }
    }
    Random, Choice, 1, Obj.Length()
    GetCoords(X, Y, Obj[Choice])
    if (X = Y) and (X = 0)
        return
    MouseClick, , X,Y
}

TestObjects(ByRef Obj)
{
    index := 1
    while index <= Obj.Length()
    {
        GetCoords(Xc, Yc, Obj[index])
        MouseMove, Xc, Yc
        KeyWait, Control
        KeyWait, Control, D
        ;MsgBox % Obj[index]
        index += 1
    }
}

ChooseGag(ByRef Coords, Debug="False")
{
    CountGags(Coords, Gags)
    if (debug = "True")
    {
        #Persistent
        ToolTip, DEBUG MODE
        SetTimer, RemoveToolTip, 2000
        TestObjects(Gags)
    }
    PickGag(Coords, Gags)
}

PickGag(ByRef Coords, ByRef Gags)
{
    if (PASS_CHANCE > 0)
    {
        Random, Pass, 0, 100
        if (Pass < PASS_CHANCE)
        {
            GetCoords(X, Y, Coords[EXTRA,1])
            MouseClick, , X,Y
            return
        }
    }
    PickObject(Gags)
}

FindTargets(ByRef Coords, ByRef Targets)
{
    Targets := []
    GetCoords(xPos, yPos, Coords[TGETS, 0])
    GetCoords(xDiff, yDiff, Coords[TGETS, 1])
    xDiff -= xPos
    yDiff -= yPos
    temp = % "o30 e0 n fx,y a" xPos "," yPos "," xDiff "," yDiff
    Result := FindClick("lib\blue.png", temp)
    ;Sort, Result, N
    Loop, Parse, Result, `n
    {
        Targets.Insert(A_Loopfield)
        ;GetCoords(Xc, Yc, A_LoopField)
        ;KeyWait, Control
        ;MouseMove, Xc, Yc
        ;KeyWait, Control, D
    }
}

ChooseTarget(ByRef Coords, Debug="False")
{
    FindTargets(Coords, Targets)
    if (debug = "True")
    {
        TestObjects(Targets)
    }
    PickObject(Targets)
}

GetCoords(ByRef OutputX, ByRef OutputY, Input)
{
    C := []
    Loop, Parse, Input, `,
    {
        C.Insert(A_LoopField)
    }
    OutputX := C[1] + 0
    OutputY := C[2]
    OutputY += 0
    return
}

ClickBack()
{
    GetCoords(X, Y, Coords[TGETS,2])
    MouseClick, , X,Y
}

CycleGags()
{
    CountGags(Coords, Gags)
    RUNNING := 1
    SetTimer, StopCycling, 18000
    while (RUNNING = 1)
    {
        PickGag(Coords, Gags)
        Sleep 50
        ChooseTarget(Coords)
        Sleep 50
        ClickBack()
        Sleep 50
    }
}

StopCycling:
    SetTimer, StopCycling, Off
    RUNNING := 0
    return

RemoveToolTip:
    SetTimer, RemoveToolTip, Off
    ToolTip
    return