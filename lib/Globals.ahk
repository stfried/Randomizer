global TOONUP := 1
global TRAP := 2
global LURE := 3
global SOUND := 4
global THROW := 5
global SQUIRT := 6
global DROP := 7
global EXTRA := 8
global TGETS := 9
global SOS := 10
global MIN_LEVEL := 1
global MAX_LEVEL := 6
global ALLOWED_TRACKS := []
global BLACKLISTED_GAGS := ""
global FIRE_CHANCE := 0
global SOS_CHANCE := 0
global PASS_CHANCE := 0
global DOODLE_CHANCE := 0
global RUNNING := 0
global MOUSE_SPEED := 2
global WINDOW_LEN = 394
global CHAR_WIDTHS := []
global NUM_LINES := 53242


global BLUE := 0x0088e3
global GREEN := 0x448888
global RED := 0xe35b5b
global BACK := 0x228dfa
global TARGET := 0x4f6ee9

global Gags := []
global SosCards := []
global whitelist := []

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

attemptReload()
{
    Reload
    Sleep 1000 ; If successful, the reload will close this instance during the Sleep, so the line below will never be reached.
    MsgBox, 2, Reload Error!, The script could not be reloaded. Would you like to retry?
    IfMsgBox Retry
        attemptReload()
    IfMsgBox Abort
        ExitApp
}