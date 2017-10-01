Setup()
{
    Input := Object()
    AssignCoordinates(Input)  
}

ParseCoords(ByRef Coords, ByRef Contents)
{
    ;Read the coordinates.ini
    Lines := Object()
    Loop, parse, Contents, `n
    {
        Lines[A_Index] := A_LoopField
    }
    line := 2
    ReadCoordinates(Coords, Lines, TU, 0, line)
    ReadCoordinates(Coords, Lines, TRAP, 0, line)
    ReadCoordinates(Coords, Lines, LURE, 0, line)
    ReadCoordinates(Coords, Lines, SOUND, 0, line)
    ReadCoordinates(Coords, Lines, THROW, 0, line)
    ReadCoordinates(Coords, Lines, SQUIRT, 0, line)
    ReadCoordinates(Coords, Lines, DROP, 0, line)
    ReadCoordinates(Coords, Lines, THROW, 1, line)
    ReadCoordinates(Coords, Lines, THROW, 2, line)
    ReadCoordinates(Coords, Lines, THROW, 3, line)
    ReadCoordinates(Coords, Lines, THROW, 4, line)
    ReadCoordinates(Coords, Lines, THROW, 5, line)
    ReadCoordinates(Coords, Lines, THROW, 6, line)
    ReadCoordinates(Coords, Lines, EXTRA, 0, line)
    ReadCoordinates(Coords, Lines, EXTRA, 1, line)
    ReadCoordinates(Coords, Lines, EXTRA, 2, line)
    ReadCoordinates(Coords, Lines, TGETS, 0, line)
    ReadCoordinates(Coords, Lines, TGETS, 1, line)
    ReadCoordinates(Coords, Lines, TGETS, 2, line)
}

ReadCoordinates(ByRef Coords, ByRef Lines, track, level, ByRef line)
{
    ;Given the line number with the x coord, assigns the x and y coords of a gag from file
    Coords[track, level] := Lines[line]
    line++
}

AssignCoordinates(ByRef Input)
{
    ;Get user to calibrate positions
    ToolTip, Press control over the right side of the feather button.,0,0
    InputCoordinates(Input, TU, 0)
    ToolTip, Press control over the right side of the banana peel button.,0,0
    InputCoordinates(Input, TRAP, 0)
    ToolTip, Press control over the right side of the dollar bill button.,0,0
    InputCoordinates(Input, LURE, 0)
    ToolTip, Press control over the right side of the bike horn button.,0,0
    InputCoordinates(Input, SOUND, 0)
    ToolTip, Press control over the right side of the cupcake button.,0,0
    InputCoordinates(Input, THROW, 0)
    ToolTip, Press control over the right side of the squirting flower button.,0,0
    InputCoordinates(Input, SQUIRT, 0)
    ToolTip, Press control over the right side of the flower pot button.,0,0
    InputCoordinates(Input, DROP, 0)
    ToolTip, Press control over the right side of the fruit pie slice button.,0,0
    InputCoordinates(Input, THROW, 1)
    ToolTip, Press control over the right side of the cream pie slice button.,0,0
    InputCoordinates(Input, THROW, 2)
    ToolTip, Press control over the right side of the whole fruit pie button.,0,0
    InputCoordinates(Input, THROW, 3)
    ToolTip, Press control over the right side of the whole cream pie button.,0,0
    InputCoordinates(Input, THROW, 4)
    ToolTip, Press control over the right side of the birthday cake button.,0,0
    InputCoordinates(Input, THROW, 5)
    ToolTip, Press control over the right side of the wedding cake button.,0,0
    InputCoordinates(Input, THROW, 6)
    ToolTip, Press control over the fire button.,0,0
    InputCoordinates(Input, EXTRA, 0)
    ToolTip, Press control over the pass button.,0,0
    InputCoordinates(Input, EXTRA, 1)
    ToolTip, Press control over the SOS button.,0,0
    InputCoordinates(Input, EXTRA, 2)
    ToolTip, Press control over the top left corner of the red targeting menu.,0,0
    InputCoordinates(Input, TGETS, 0)
    ToolTip, Press control over the bottom right corner of the red targeting menu.,0,0
    InputCoordinates(Input, TGETS, 1)
    ToolTip, Press control over the back arrow.,0,0
    InputCoordinates(Input, TGETS, 2)
    CoordToFile(Input)
}

CoordToFile(ByRef Input)
{
    ;Write to file
    FileDelete, coordinates.ini
    FileAppend, #Base Coordinate`n, coordinates.ini
    FileAppend, % Input[TU,0,0]","Input[TU,0,1]"`n", coordinates.ini
    FileAppend, % Input[TRAP,0,0]","Input[TRAP,0,1]"`n", coordinates.ini
    FileAppend, % Input[LURE,0,0]","Input[LURE,0,1]"`n", coordinates.ini
    FileAppend, % Input[SOUND,0,0]","Input[SOUND,0,1]"`n", coordinates.ini
    FileAppend, % Input[THROW,0,0]","Input[THROW,0,1]"`n", coordinates.ini
    FileAppend, % Input[SQUIRT,0,0]","Input[SQUIRT,0,1]"`n", coordinates.ini
    FileAppend, % Input[DROP,0,0]","Input[DROP,0,1]"`n", coordinates.ini
    FileAppend, % Input[THROW,1,0]","Input[THROW,1,1]"`n", coordinates.ini
    FileAppend, % Input[THROW,2,0]","Input[THROW,2,1]"`n", coordinates.ini
    FileAppend, % Input[THROW,3,0]","Input[THROW,3,1]"`n", coordinates.ini
    FileAppend, % Input[THROW,4,0]","Input[THROW,4,1]"`n", coordinates.ini
    FileAppend, % Input[THROW,5,0]","Input[THROW,5,1]"`n", coordinates.ini
    FileAppend, % Input[THROW,6,0]","Input[THROW,6,1]"`n", coordinates.ini
    FileAppend, % Input[EXTRA,0,0]","Input[EXTRA,0,1]"`n", coordinates.ini
    FileAppend, % Input[EXTRA,1,0]","Input[EXTRA,1,1]"`n", coordinates.ini
    FileAppend, % Input[EXTRA,2,0]","Input[EXTRA,2,1]"`n", coordinates.ini
    FileAppend, % Input[TGETS,0,0]","Input[TGETS,0,1]"`n", coordinates.ini
    FileAppend, % Input[TGETS,1,0]","Input[TGETS,1,1]"`n", coordinates.ini
    FileAppend, % Input[TGETS,2,0]","Input[TGETS,2,1]"`n", coordinates.ini
}

InputCoordinates(ByRef Input, track, level)
{
    ;Record user input positions
    KeyWait, Control
    KeyWait, Control, D
    MouseGetPos, xpos, ypos
    Input[track, level, 0] := xpos
    Input[track, level, 1] := ypos
    ToolTip
}

ParseConfig(Contents)
{
    Lines := Object()
    Loop, parse, Contents, `n
    {
        Lines[A_Index] := A_LoopField
    }
    ReadVals(MIN_LEVEL, Lines[2])
    ReadVals(MAX_LEVEL, Lines[3])
    MIN_LEVEL -= 1
    MAX_LEVEL -= 1
    ReadVals(tracks, Lines[5], "False")
    GetTracks(tracks)
    ReadVals(BLACKLISTED_GAGS, Lines[9], "False")
    ReadVals(PASS_CHANCE, Lines[16])
}

ReadVals(ByRef val, line, is_num="True")
{
    C := []
    Loop, Parse, line, :,
    {
        C.Insert(A_LoopField)
    }
    val := C[2]
    if (is_num = "True")
        val += 0
}

GetTracks(raw_text)
{
    IfInString, raw_text, TU
        ALLOWED_TRACKS.Insert(TOONUP)
    IfInString, raw_text, TR
        ALLOWED_TRACKS.Insert(TRAP)
    IfInString, raw_text, LU
        ALLOWED_TRACKS.Insert(LURE)
    IfInString, raw_text, SO
        ALLOWED_TRACKS.Insert(SOUND)
    IfInString, raw_text, TH
        ALLOWED_TRACKS.Insert(THROW)
    IfInString, raw_text, SQ
        ALLOWED_TRACKS.Insert(SQUIRT)
    IfInString, raw_text, DR
        ALLOWED_TRACKS.Insert(DROP)
}

Config()
{
    FileDelete, config.ini
    FileAppend,
    (
#Gag levels are inclusive, eg. min and max levels will be used.
MIN_GAG_LEVEL: 1
MAX_GAG_LEVEL: 6
#Keep separated by pipelines. Format like TU|TR|LU|SO|TH|SQ|DR
ALLOWED_TRACKS: TU|TR|LU|SO|TH|SQ|DR
#Blacklisted gags. Provide coordinate pairs separated by commas and spaces, eg.
# 1,1 5,2 3,7
#This effectively blacklists feather, fruit pie slice, and presentation.
BLACKLISTED_GAGS: 
#Likelihood to fire instead of use a gag. Decimal between 1 and 0.
FIRE: 0
#Likelihood to SOS instead of use a gag. Decimal between 1 and 0.
FIRE: 0
#Likelihood to pass instead of use a gag. Decimal between 1 and 0.
PASS: 0
    ), config.ini
}