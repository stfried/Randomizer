log(action, ret="NOTRET", no_stack=0)
{
    if (DEBUG_MODE)
    {
        FormatTime, formatted, %A_Now%, HH:mm:ss|
        if (ret != "NOTRET")
        {
            ;Function returned a value
            action := fetch_stack() " returned "
            if (ret != "VOID")
            {
                ;Function returned nothing
                action := action . return
            }
            ;Dequeue
            CALLSTACK.dequeue()
            LOG.enqueue(action)
            enforce_log_size()
            formatted := formatted . action
            FileAppend, % formatted "`n", %LOGFILE%
            return
        }
        if (CALLSTACK.length > 0)
            LOG.enqueue(fetch_stack() ":" action)
        else
            LOG.enqueue(action)
        enforce_log_size()
        if (no_stack)
        {
            ;Do not push to stack
            formatted := formatted . action
        }
        else
        {
            ;New function call
            CALLSTACK.enqueue(action)
            formatted := formatted . fetch_stack()
        }
        FileAppend, % formatted "`n", %LOGFILE%
    }
}

enforce_log_size()
{
    if LOG.length > LOG_LENGTH
        LOG.dequeue()
    updateLog()
}

fetch_stack()
{
    result := ""
    arr := CALLSTACK.toArray()
    for idx, val in arr
    {
        if (idx = 1)
            result := val
        else
            result := val ":" result
    }
    return result
}

clearOldLogs()
{
    num_logs := ComObjCreate("Scripting.FileSystemObject").GetFolder("logs").Files.Count
    if (num_logs > MAX_LOGS)
    {
        Loop, Files, %A_WorkingDir%\logs\*log.txt
        {
            FileDelete %A_WorkingDir%\logs\%A_LoopFileName%
            if (A_Index = num_logs - MAX_LOGS)
                return
        }
    }
}