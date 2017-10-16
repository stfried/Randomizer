global polyID := 4
global origin := [306,396]

buildSVG(useable, choice){
	polyID := 4
	n := useable.length()
	;n := 20
	;Shuffle gags
	Loop % n
	{
		Random, i, 1, n
		tmp := useable[i]
		useable[i] := useable[A_Index]
		useable[A_Index] := tmp
	}
	deg := 360.0/n
	polys := ""
	start := [627,396]
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
	Loop % n
	{
		rotation := A_Index * deg
		poly := points_to_poly(origin, start, rotated, rotation, useable[A_Index], center, scale)
		polys := polys . poly "`n"
	}
	;Read header and closer
	FileRead, header, bin\roulette\header.html
	FileRead, closer, bin\roulette\closer.html
	FileDelete, bin\roulette\wheel.html
	
	preHeader := "<html>`n"
	preHeader := preHeader "`t<body onLoad=""pick(" choice.getTrack() "," choice.getLevel() "," deg ")"">`n"
	FileAppend, % preHeader, bin\roulette\wheel.html
	
	FileAppend, % header, bin\roulette\wheel.html
	FileAppend, % polys, bin\roulette\wheel.html
	FileAppend, % closer, bin\roulette\wheel.html
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
	poly := "<g id=""" gag.getTrack() "," gag.getLevel() """transform=""rotate(" rotation "," origin[1] "," origin[2] ")"">`n"
	poly := poly "`t<polygon id=""XMLID_" polyID "_"" class=""track" gag.getTrack() """ points=""" p1[1] "," p1[2] "," p2[1] "," p2[2] "," p3[1] "," p3[2] """/>`n"
	poly := poly "`t<image style=""overflow:visible;"" width=""30"" height=""30"" xlink:href=""../img/gags/" gag.getTrack() "," gag.getLevel() ".png"" transform=""matrix(" scale " 0 0 " scale " " center[1] " " center[2] ")"">`n"
	poly := poly "`t</image>`n"
	poly := poly "</g>"
	return poly
}


;gags := [1,2,3,4,5]
;buildSVG(gags)
;a := rotate_about_origin([627,396],17.14285714)
;MsgBox % a[1] "," a[2]