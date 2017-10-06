log(action, ret="NOTRET", no_stack=0)
{
    FormatTime, formatted, %A_Now%, HH:mm:ss:
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
    ;Log action in queue
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

enforce_log_size()
{
    if log_size.length > LOG_LENGTH
        log.dequeue()
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
            result := result ":" val
    }
    return result
}