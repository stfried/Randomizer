Config()
{
    Input := Object()
    AssignCoordinates(Input)  
}

ParseFile(ByRef Coords, ByRef Contents)
{
    ;Read the config.ini
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
    ReadCoordinates(Coords, Lines, EXTRA, 0, line)
    ReadCoordinates(Coords, Lines, EXTRA, 1, line)
    ReadCoordinates(Coords, Lines, EXTRA, 2, line)
    ReadCoordinates(Coords, Lines, TARGETS, 0, line)
    ReadCoordinates(Coords, Lines, TARGETS, 1, line)
    ReadCoordinates(Coords, Lines, TARGETS, 2, line)
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
    ToolTip, Press control over the fire button.,0,0
    InputCoordinates(Input, EXTRA, 0)
    ToolTip, Press control over the pass button.,0,0
    InputCoordinates(Input, EXTRA, 1)
    ToolTip, Press control over the SOS button.,0,0
    InputCoordinates(Input, EXTRA, 2)
    ToolTip, Press control over the top left corner of the red targeting menu.,0,0
    InputCoordinates(Input, TARGETS, 0)
    ToolTip, Press control over the bottom right corner of the red targeting menu.,0,0
    InputCoordinates(Input, TARGETS, 1)
    ToolTip, Press control over the back arrow.,0,0
    InputCoordinates(Input, TARGETS, 2)
    CoordToFile(Input)
}

CoordToFile(ByRef Input)
{
    ;Write to file
    FileDelete, config.ini
    FileAppend, #Base Coordinate`n, config.ini
    FileAppend, % Input[TU,0,0]","Input[TU,0,1]"`n", config.ini
    FileAppend, % Input[TRAP,0,0]","Input[TRAP,0,1]"`n", config.ini
    FileAppend, % Input[LURE,0,0]","Input[LURE,0,1]"`n", config.ini
    FileAppend, % Input[SOUND,0,0]","Input[SOUND,0,1]"`n", config.ini
    FileAppend, % Input[THROW,0,0]","Input[THROW,0,1]"`n", config.ini
    FileAppend, % Input[SQUIRT,0,0]","Input[SQUIRT,0,1]"`n", config.ini
    FileAppend, % Input[DROP,0,0]","Input[DROP,0,1]"`n", config.ini
    FileAppend, % Input[THROW,1,0]","Input[THROW,1,1]"`n", config.ini
    FileAppend, % Input[THROW,2,0]","Input[THROW,2,1]"`n", config.ini
    FileAppend, % Input[THROW,3,0]","Input[THROW,3,1]"`n", config.ini
    FileAppend, % Input[THROW,4,0]","Input[THROW,4,1]"`n", config.ini
    FileAppend, % Input[THROW,5,0]","Input[THROW,5,1]"`n", config.ini
    FileAppend, % Input[EXTRA,0,0]","Input[EXTRA,0,1]"`n", config.ini
    FileAppend, % Input[EXTRA,1,0]","Input[EXTRA,1,1]"`n", config.ini
    FileAppend, % Input[EXTRA,2,0]","Input[EXTRA,2,1]"`n", config.ini
    FileAppend, % Input[TARGETS,0,0]","Input[TARGETS,0,1]"`n", config.ini
    FileAppend, % Input[TARGETS,1,0]","Input[TARGETS,1,1]"`n", config.ini
    FileAppend, % Input[TARGETS,2,0]","Input[TARGETS,2,1]"`n", config.ini
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