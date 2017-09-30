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
if not ErrorLevel
{
    ParseFile(Coords, Contents)
}
else
{
    Config(Coords)
}
CalculateCoords(Coords)

^Q::
    ;Force recalibrate
    Coords := Object()
    Config(Coords)
    CalculateCoords(Coords)
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
    x_index := 0
    while x_index < MAX_LEVEL
    {
        xCoords[x_index] := Coords[THROW, x_index, 0]
        x_index += 1
    }
    y_index := 0
    while y_index <= DROP
    {
        yCoords[y_index] := Coords[y_index, 0, 1]
        y_index += 1
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
            Coords[track, level, 0] := xCoords[level]
            Coords[track, level, 1] := yCoords[track]
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
            MouseMove, Coords[track, level, 0], Coords[track, level, 1]
            KeyWait, Control
            KeyWait, Control, D
            level += 1
        }
        track += 1
    }
}

ScanCoords(ByRef Coords, ByRef Choices, ByRef ChoicesSize)
{
    ;Loop through coords and add them to choices if they can be used
    Choices := Object()
    ChoicesSize := 0
    track := TU
    while track <= DROP
    {
        level := 0
        while level < MAX_LEVEL
        {
            if GagIsValid(Coords, track, level) {
                Choices[ChoicesSize,0] := Coords[track, level,0]
                Choices[ChoicesSize,1] := Coords[track, level,1]
                ChoicesSize += 1
            }
            level += 1
        }
        track += 1
    }
}

FindTargets(ByRef Coords)
{
    xPos := Coords[TARGETS, 0, 0] + 0
    yPos := Coords[TARGETS, 0, 1] + 0
    temp := Coords[TARGETS, 1, 0] + 0
    temp -= xPos
    xDiff := temp
    temp := Coords[TARGETS, 1, 1] + 0
    temp -= yPos
    yDiff := temp
    temp = % "o30 e0 n fx,y a" xPos "," yPos "," xDiff "," yDiff
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
    OutputY := C[2] + 0
    return
}

GagIsValid(ByRef Coords, track, level)
{
    ;Returns true if the pixel matches a valid color for a given gag
    xVal := Coords[track, level, 0]
    yVal := Coords[track, level, 1]
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

TestChoices(ByRef Choices, ChoicesSize)
{
    MsgBox % ChoicesSize
    index := 0
    while index < ChoicesSize
    {
        MouseMove, Choices[index,0], Choices[index,1]
        MsgBox % Choices[index,0] . Choices[index,1]
        index += 1
    }
}

PickGag(ByRef Coords)
{
    ScanCoords(Coords, Choices, ChoicesSize)
    ;TestChoices(Choices, ChoicesSize)
    Random, Choice, 1, ChoicesSize
    MouseClick, , Choices[Choice, 0], Choices[Choice, 1]
}