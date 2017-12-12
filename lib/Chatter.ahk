charWidthInit()
{
    lowercase := [22, 24, 23, 24, 22, 18, 22, 24, 12, 12, 22, 10, 36, 22, 26, 24, 26, 16, 20, 18, 22, 24, 24, 22, 24, 22] ; abcdefghijklmnopqrstuvwxyz
    uppercase := [26, 28, 30, 28, 26, 24, 30, 30, 12, 18, 30, 20, 38, 28, 32, 28, 32, 28, 28, 24, 28, 26, 42, 26, 30, 24] ; ABCDEFGHIJKLMNOPQRSTUVWXYZ
    nums := [26, 14, 30, 28, 30, 28, 28, 24, 30, 30] ;  0123456789
    symbols1 := [20, 14, 14, 36, 20, 40, 34, 10, 14, 14, 26, 38, 12, 20, 12, 22] ;    {SPACE}!"#$%&'()*+,-./
    symbols2 := [16, 18, 34, 44, 34, 30, 44] ;    :{SEMICOLON}<=>?@
    symbols3 := [12, 20, 12, 32, 26, 14] ;    [\]^_`
    symbols4 := [20, 14, 20, 34] ;    {|}~
    
    ;In order, symbols1, nums, symbols2, uppercase, symbols3, lowercase, symbols4
    Loop, % symbols1.length()
    {
        CHAR_WIDTHS[Asc(" ") + A_Index - 1] := symbols1[A_Index]
    }
    Loop, % nums.length()
    {
        CHAR_WIDTHS[Asc("0") + A_Index - 1] := nums[A_Index]
    }
    Loop, % symbols2.length()
    {
        CHAR_WIDTHS[Asc(":") + A_Index - 1] := symbols2[A_Index]
    }
    Loop, % uppercase.length()
    {
        CHAR_WIDTHS[Asc("A") + A_Index - 1] := uppercase[A_Index]
    }
    Loop, % symbols3.length()
    {
        CHAR_WIDTHS[Asc("[") + A_Index - 1] := symbols3[A_Index]
    }
    Loop, % lowercase.length()
    {
        CHAR_WIDTHS[Asc("a") + A_Index - 1] := lowercase[A_Index]
    }
    Loop, % symbols4.length()
    {
        CHAR_WIDTHS[Asc("{") + A_Index - 1] := symbols4[A_Index]
    }
}

stringWidth(string)
{
    length := 0
    Loop, Parse, string
    {
        length += CHAR_WIDTHS[Asc(A_LoopField)]
    }
    return length
}

canAppend(ByRef length, ByRef lines, new_string)
{
    new_length := stringWidth(new_string) - CHAR_WIDTHS[Asc(" ")]
    if (new_length > WINDOW_LEN)
        return -1
    else if (length + new_length > WINDOW_LEN)
    {
        lines++
        length := new_length + CHAR_WIDTHS[Asc(" ")]
        if (lines > 3)
            return 0
    }
    else if (length + new_length + CHAR_WIDTHS[Asc(" ")] > WINDOW_LEN)
    {
        lines++
        length := 0
        if (lines > 3)
            return 0
    }
    else
        length += new_length + CHAR_WIDTHS[Asc(" ")]
    return 1
}

buildString()
{
    string := ""
    length := 0
    lines := 1
    Random, num_words, 1, 25
    Loop, % num_words
    {
        Random, line, 1, NUM_LINES
		output := whitelist[line] " "
        
        res := canAppend(length, lines, output)
        if (res = -1)
            continue
        else if (res = 0)
            break
        string := string . output
    }
    ; Try to append some punctuation
    string := RTrim(string)
    punct := " "
    Random, punct_chance, 1, 100
    if (punct_chance > 25 and punct_chance <= 50)
        punct := "."
    else if (punct_chance > 50 and punct_chance <= 75)
        punct := "!"
    else if (punct_chance > 75)
        punct := "?"
    string := string . punct
    return string
}

madlib(category)
{
    if (category = "random")
    {
        Random, num, 1, whitelist.length()
        return whitelist[num]
    }
    Random, num, 1, wordlists[category].length()
    word := wordlists[category, num]
    ;StringReplace,word,word,`n,,A
    ;StringReplace,word,word,`r,,A
    return word
}

buildTemplate(template)
{
    output_string := ""
    Loop, parse, template, %A_Space%
    {
        word := A_LoopField
        IfInString, A_LoopField, <
        {
            IfInString, A_LoopField, >
            {
                ;Category
                split := StrSplit(A_LoopField, ["<",">"])
                word := ""
                Loop, % split.length()
                {
                    if (split[A_Index] != "")
                    {
                        fragment := split[A_Index]
                        if (split[A_Index] = "random" or wordlists[split[A_Index], 1] != "") 
                        {
                            fragment := madlib(split[A_Index])
                        }
                        word := word . fragment
                    }
                }
                
            }
        }
        output_string := output_string . word . " "
    }
    return RTrim(output_string)
}

phrase_fits(phrase)
{
    length := 0
    lines := 1
    Loop, parse, phrase, %A_Space%
    {
        ;MsgBox % A_LoopField
        word := A_LoopField . " "
        res := canAppend(length, lines, word)
        if (res = -1)
            return -1 ;Something fucked up with this template
        else if (res = 0)
        {
            ;MsgBox % "Too long: " . phrase
            return 0 ;Try with new words
        }
        ;MsgBox % "lines: " . lines ", length: " . length
    }
    ;MsgBox % phrase
    return 1
}

makeTemplate()
{
    ret := -1
    phrase := ""
    While (ret = -1)
    {
        ret := 0
        Random, num, 1, templates.length()
        template := templates[num]
        While (ret = 0)
        {
            phrase := buildTemplate(template)
            StringReplace,phrase,phrase,`n,,A
            StringReplace,phrase,phrase,`r,,A
            ret := phrase_fits(phrase)
        }
    }
    return phrase
}