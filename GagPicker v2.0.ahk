CoordMode, ToolTip, Screen
#Include lib\Calibration.ahk
#Include lib\FindClick.ahk

global TU := 0
global TRAP := 1
global LURE := 2
global SOUND := 3
global THROW := 4
global SQUIRT := 5
global DROP := 6
global EXTRA := 7
global TARGETS := 8
global MAX_LEVEL := 6

global BLUE := 0x0088e3
global GREEN := 0x448888

global Coords := Object()

FileRead, Contents, config.ini
if ErrorLevel
{
    Config()
}
ParseFile(Coords, Contents)
CalculateCoords(Coords)
;TestCoords(Coords)

^Q::
    ;Force recalibrate
    Coords := Object()
    Config()
    ParseFile(Coords, Contents)
    ;CalculateCoords(Coords)
    return

^W::
    ;PickGag(Coords)
    FindTargets(Coords)
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
    while level < MAX_LEVEL
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
    track := TU
    while track <= DROP
    {
        level := 0
        while level < MAX_LEVEL
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
    track := TU
    while track <= DROP
    {
        level := 0
        while level < MAX_LEVEL
        {
            GetCoords(Xc, Yc, Coords[track, level])
            MouseMove, Xc, Yc
            MsgBox % Coords[track, level]
            level += 1
        }
        track += 1
    }
}

ScanCoords(ByRef Coords, ByRef Choices)
{
    ;Loop through coords and add them to choices if they can be used
    Choices := []
    ChoicesSize := 0
    track := TU
    while track <= DROP
    {
        level := 0
        while level < MAX_LEVEL
        {
            if GagIsValid(Coords, track, level) {
                Choices.Insert(Coords[track, level])
            }
            level += 1
        }
        track += 1
    }
}

GagIsValid(ByRef Coords, track, level)
{
    ;Returns true if the pixel matches a valid color for a given gag
    GetCoords(xVal, yVal, Coords[track, level])
    ;MouseMove, xVal, yVal
    PixelSearch Px, Py, xVal, yVal, xVal, yVal, BLUE, 15, FAST|RGB
    if ErrorLevel
    {
        PixelSearch Px, Py, xVal, yVal, xVal, yVal, GREEN, 15, FAST|RGB
        if ErrorLevel
        {
            return 0
        }
    }
    return 1
}

TestChoices(ByRef Choices)
{
    index := 1
    while index <= Choices.Length()
    {
        GetCoords(Xc, Yc, Choices[index])
        MouseMove, Xc, Yc
        MsgBox % Choices[index]
        index += 1
    }
}

PickGag(ByRef Coords)
{
    ScanCoords(Coords, Choices)
    TestChoices(Choices)
    Random, Choice, 1, Choices.Length()
    GetCoords(Xc, Yc, Choices[Choice])
    MouseClick, , Xc, Yc
}

FindTargets(ByRef Coords)
{
    GetCoords(xPos, yPos, Coords[TARGETS, 0])
    GetCoords(xDiff, yDiff, Coords[TARGETS, 1])
    xDiff -= xPos
    yDiff -= yPos
    temp = % "o30 e0 n fx,y a" xPos "," yPos "," xDiff "," yDiff
    MsgBox % temp
    Result := FindClick("lib\blue.png", temp)
    Sort, Result, N
    Loop, Parse, Result, `n
    {
        Targets.Insert(A_Loopfield)
        ;GetCoords(Xc, Yc, A_LoopField)
        ;KeyWait, Control
        ;MouseMove, Xc, Yc
        ;KeyWait, Control, D
    }
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