global TOONUP := 1
global TRAP := 2
global LURE := 3
global SOUND := 4
global THROW := 5
global SQUIRT := 6
global DROP := 7
global EXTRA := 8
global TGETS := 9
global MIN_LEVEL := 1
global MAX_LEVEL := 6
global ALLOWED_TRACKS := []
global BLACKLISTED_GAGS := ""
global PASS_CHANCE := 0
global RUNNING := 0


global BLUE := 0x0088e3
global GREEN := 0x448888

global Gags := []



getCoords(ByRef OutputX, ByRef OutputY, Input)
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

debugPrint(msg, debug=0)
{
    if (debug)
    {
        MsgBox % msg
    }
}