global polyID := 4
global origin := [306,396]

buildSVG(useable, choice){
	polyID := 4
    total_deg := 360.0
    deg_offset := 0
    start := [627,396]
    polys := ""
    extra_deg := [-1,-1,-1]
    original_length := useable.length()
    gag_choices := []
    n := useable.length()
    Loop % n
        gag_choices[A_Index] := useable[A_Index]
    if (FIRE_CHANCE > 0)
    {
        extra_deg[1] := (FIRE_CHANCE / 100) * 360.0
        total_deg -= extra_deg[1]
        gag_choices.Insert(Gags[EXTRA,1])
    }
    if (PASS_CHANCE > 0)
    {
        extra_deg[2] := (PASS_CHANCE / 100) * 360.0
        total_deg -= extra_deg[2]
        gag_choices.Insert(Gags[EXTRA,2])
    }
    if (SOS_CHANCE > 0)
    {
        extra_deg[3] := (SOS_CHANCE / 100) * 360.0
        total_deg -= extra_deg[3]
        gag_choices.Insert(Gags[EXTRA,3])
    }
	n := gag_choices.length()
	;Shuffle gags
	Loop % n
	{
		Random, i, 1, n
		tmp := gag_choices[i]
		gag_choices[i] := gag_choices[A_Index]
		gag_choices[A_Index] := tmp
	}
	deg := total_deg/original_length
	rotated := rotate_about_origin(start, deg)
	scale := 1
	if (deg < 10)
	{
		diff := 10 - deg
		diff := 1 - 0.1 * diff
		scale := scale * diff
		
	}
	center := rotate_about_origin([500,396], deg/2)
	center[1] -= scale * 15
	center[2] -= scale * 15
    rotation := 0
	Loop % n
	{
        g := gag_choices[A_Index]
        d := 0
		if (g.getTrack() = EXTRA and extra_deg[g.getLevel()] != -1)
        {
            d := extra_deg[g.getLevel()]
            rotation += d
            poly := points_to_poly(origin, start, rotate_about_origin(start,d), rotation, g, rotate_about_origin([485,380], d/2), 0)
        }
        else
        {
            d := deg
            rotation += d
            poly := points_to_poly(origin, start, rotated, rotation, g, center, scale)
        }
        polys := polys . poly "`n"
	}
	;Read header and closer
	FileRead, header, bin\roulette\header.html
	FileRead, closer, bin\roulette\closer.html
	FileDelete, bin\roulette\wheel.html
	
	preHeader := "<html>`n"
	if (first_use)
	{
		preHeader := preHeader "`t<body onLoad=""pick(" choice.getTrack() "," choice.getLevel() "," deg "," 1 ")"">`n"
	}
	preHeader := preHeader "`t<body onLoad=""pick(" choice.getTrack() "," choice.getLevel() "," deg "," 0 ")"" style=""background-color:#FF0000;"">`n"
	FileAppend, % preHeader, bin\roulette\wheel.html
	
	FileAppend, % header, bin\roulette\wheel.html
	FileAppend, % polys, bin\roulette\wheel.html
	FileAppend, % closer, bin\roulette\wheel.html
    return
}

rotate_about_origin(p, deg)
{
	rad := deg * (3.141592653589793/180)
	x_off := p[1] - origin[1]
	y_off := -1*(p[2]-origin[2])
	x := x_off * cos(rad) - y_off * sin(rad)
	y := y_off * cos(rad) + x_off * sin(rad)
	y *= -1
	x += origin[1]
	y += origin[2]
	return [Round(x),Round(y)]
}

points_to_poly(p1, p2, p3, rotation, gag, center, scale)
{
	polyID += 1
	poly := "`t`t`t<g id=""" gag.getTrack() "," gag.getLevel() """transform=""rotate(" rotation "," origin[1] "," origin[2] ")"">`n"
	poly := poly "`t`t`t`t<polygon id=""XMLID_" polyID "_"" class=""track" gag.getTrack() """ points=""" p1[1] "," p1[2] "," p2[1] "," p2[2] "," p3[1] "," p3[2] """/>`n"
    if (gag.getTrack() = EXTRA)
    {
        if (gag.getLevel() = 1)
            poly := poly "`t`t`t`t<text transform=""matrix(1 0 0 1 " center[1] " " center[2] + 20 ")"" class=""st0 st4 st5"">FIRE</text>"
        else if (gag.getLevel() = 2)
            poly := poly "`t`t`t`t<text transform=""matrix(1 0 0 1 " center[1] " " center[2] + 20 ")"" class=""st0 st4 st5"">PASS</text>"
        else
            poly := poly "`t`t`t`t<text transform=""matrix(1 0 0 1 " center[1] " " center[2] + 20 ")"" class=""st0 st4 st5"">SOS</text>"
    }
    else
        poly := poly "`t`t`t`t<image style=""overflow:visible;"" width=""30"" height=""30"" xlink:href=""../img/gags/" gag.getTrack() "," gag.getLevel() ".png"" transform=""matrix(" scale " 0 0 " scale " " center[1] " " center[2] ")"">`n"
	poly := poly "`t`t`t`t</image>`n"
	poly := poly "`t`t`t</g>`n"
	return poly
}


;gags := [1,2,3,4,5]
;buildSVG(gags)
;a := rotate_about_origin([627,396],17.14285714)
;MsgBox % a[1] "," a[2]