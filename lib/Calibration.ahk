Config(ByRef Coords)
{
    AssignCoordinates(Coords)  
}

ParseFile(ByRef Coords, ByRef Contents)
{
    ;Read the config.ini
    Lines := Object()
    Loop, parse, Contents, `n
    {
        Lines[A_Index] := A_LoopField
    }
    ReadCoordinates(Coords, Lines, TU, 0, 2)
    ReadCoordinates(Coords, Lines, TRAP, 0, 4)
    ReadCoordinates(Coords, Lines, LURE, 0, 6)
    ReadCoordinates(Coords, Lines, SOUND, 0, 8)
    ReadCoordinates(Coords, Lines, THROW, 0, 10)
    ReadCoordinates(Coords, Lines, SQUIRT, 0, 12)
    ReadCoordinates(Coords, Lines, DROP, 0, 14)
    ReadCoordinates(Coords, Lines, THROW, 1, 16)
    ReadCoordinates(Coords, Lines, THROW, 2, 18)
    ReadCoordinates(Coords, Lines, THROW, 3, 20)
    ReadCoordinates(Coords, Lines, THROW, 4, 22)
    ReadCoordinates(Coords, Lines, THROW, 5, 24)
    ReadCoordinates(Coords, Lines, EXTRA, 0, 26)
    ReadCoordinates(Coords, Lines, EXTRA, 1, 28)
    ReadCoordinates(Coords, Lines, EXTRA, 2, 30)
    ReadCoordinates(Coords, Lines, TARGETS, 0, 32)
    ReadCoordinates(Coords, Lines, TARGETS, 1, 34)
    ReadCoordinates(Coords, Lines, TARGETS, 2, 36)
}

ReadCoordinates(ByRef Coords, ByRef Lines, track, level, line)
{
    ;Given the line number with the x coord, assigns the x and y coords of a gag from file
    Coords[track, level, 0] := Lines[line]
    Coords[track, level, 1] := Lines[line + 1]
    
}

AssignCoordinates(ByRef Coords)
{
    ;Get user to calibrate positions
    ToolTip, Press control over the right side of the feather button.,0,0
    InputCoordinates(Coords, TU, 0)
    ToolTip, Press control over the right side of the banana peel button.,0,0
    InputCoordinates(Coords, TRAP, 0)
    ToolTip, Press control over the right side of the dollar bill button.,0,0
    InputCoordinates(Coords, LURE, 0)
    ToolTip, Press control over the right side of the bike horn button.,0,0
    InputCoordinates(Coords, SOUND, 0)
    ToolTip, Press control over the right side of the cupcake button.,0,0
    InputCoordinates(Coords, THROW, 0)
    ToolTip, Press control over the right side of the squirting flower button.,0,0
    InputCoordinates(Coords, SQUIRT, 0)
    ToolTip, Press control over the right side of the flower pot button.,0,0
    InputCoordinates(Coords, DROP, 0)
    ToolTip, Press control over the right side of the fruit pie slice button.,0,0
    InputCoordinates(Coords, THROW, 1)
    ToolTip, Press control over the right side of the cream pie slice button.,0,0
    InputCoordinates(Coords, THROW, 2)
    ToolTip, Press control over the right side of the whole fruit pie button.,0,0
    InputCoordinates(Coords, THROW, 3)
    ToolTip, Press control over the right side of the whole cream pie button.,0,0
    InputCoordinates(Coords, THROW, 4)
    ToolTip, Press control over the right side of the birthday cake button.,0,0
    InputCoordinates(Coords, THROW, 5)
    ToolTip, Press control over the fire button.,0,0
    InputCoordinates(Coords, EXTRA, 0)
    ToolTip, Press control over the pass button.,0,0
    InputCoordinates(Coords, EXTRA, 1)
    ToolTip, Press control over the SOS button.,0,0
    InputCoordinates(Coords, EXTRA, 2)
    ToolTip, Press control over the top left corner of the red targeting menu.,0,0
    InputCoordinates(Coords, TARGETS, 0)
    ToolTip, Press control over the bottom right corner of the red targeting menu.,0,0
    InputCoordinates(Coords, TARGETS, 1)
    ToolTip, Press control over the back arrow.,0,0
    InputCoordinates(Coords, TARGETS, 2)
    CoordToFile(Coords)
}

CoordToFile(ByRef Coords)
{
    ;Write to file
    FileDelete, config.ini
    FileAppend, #Base Coordinate`n, config.ini
    FileAppend, % Coords[TU,0,0]"`n"Coords[TU,0,1]"`n", config.ini
    FileAppend, % Coords[TRAP,0,0]"`n"Coords[TRAP,0,1]"`n", config.ini
    FileAppend, % Coords[LURE,0,0]"`n"Coords[LURE,0,1]"`n", config.ini
    FileAppend, % Coords[SOUND,0,0]"`n"Coords[SOUND,0,1]"`n", config.ini
    FileAppend, % Coords[THROW,0,0]"`n"Coords[THROW,0,1]"`n", config.ini
    FileAppend, % Coords[SQUIRT,0,0]"`n"Coords[SQUIRT,0,1]"`n", config.ini
    FileAppend, % Coords[DROP,0,0]"`n"Coords[DROP,0,1]"`n", config.ini
    FileAppend, % Coords[THROW,1,0]"`n"Coords[THROW,1,1]"`n", config.ini
    FileAppend, % Coords[THROW,2,0]"`n"Coords[THROW,2,1]"`n", config.ini
    FileAppend, % Coords[THROW,3,0]"`n"Coords[THROW,3,1]"`n", config.ini
    FileAppend, % Coords[THROW,4,0]"`n"Coords[THROW,4,1]"`n", config.ini
    FileAppend, % Coords[THROW,5,0]"`n"Coords[THROW,5,1]"`n", config.ini
    FileAppend, % Coords[EXTRA,0,0]"`n"Coords[EXTRA,0,1]"`n", config.ini
    FileAppend, % Coords[EXTRA,1,0]"`n"Coords[EXTRA,1,1]"`n", config.ini
    FileAppend, % Coords[EXTRA,2,0]"`n"Coords[EXTRA,2,1]"`n", config.ini
    FileAppend, % Coords[TARGETS,0,0]"`n"Coords[TARGETS,0,1]"`n", config.ini
    FileAppend, % Coords[TARGETS,1,0]"`n"Coords[TARGETS,1,1]"`n", config.ini
    FileAppend, % Coords[TARGETS,2,0]"`n"Coords[TARGETS,2,1]"`n", config.ini
}

InputCoordinates(ByRef Coords, track, level)
{
    ;Record user input positions
    KeyWait, Control
    KeyWait, Control, D
    MouseGetPos, xpos, ypos
    Coords[track, level, 0] := xpos
    Coords[track, level, 1] := ypos
    ToolTip
}