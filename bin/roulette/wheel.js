function sleep(ms) {
  return new Promise(resolve => setTimeout(resolve, ms));
}

async function spin() {
	return
    var randomNumber = Math.floor(Math.random() * 4) + 2;
    var speed = 20;
    var elem = document.getElementById("WHEEL_CONTAINER");
    var rotation = 0;
    while(rotation < (randomNumber * 360)){
        rotation += speed;
        elem.setAttribute("transform", "rotate(" + rotation + ",306,396)");
        await sleep(50);
    }
	while(speed > 0){
		rotation += speed;
		speed--
		elem.setAttribute("transform", "rotate(" + rotation + ",306,396)");
		await sleep(50);
	}
}

async function increase_volume(audio, cap) {
    while (audio.volume < 0.75) {
        audio.volume += 0.01;
        await sleep(50);
    }
}

async function decrease_volume(audio, floor) {
    while (audio.volume > floor) {
        try {
            audio.volume -= 0.04;
        }
        catch(err) {
            audio.volume = 0;
        }
        await sleep(50);
    }
    audio.pause()
}

async function intro() {
    var intros = ['brawlBrewing.wav', 'greatSlam.wav', 'highClassBout.wav', 'redHot.wav', 'swellBattle.wav']
    var num = Math.floor(Math.random() * intros.length);
    var intro = new Audio('../music/' + intros[num]);
    intro.volume = 0.5;
    intro.play();
    await sleep(2500);
}

async function pick(track,level,deg, first_use) {
	if (first_use)
	{
        await intro();
	}
    var songs = ['bigApple.wav', 'marioSlide.wav', 'MeatBall Parade.mp3']
	var num = Math.floor(Math.random() * songs.length);
    var audio = new Audio('../music/' + songs[num]);
	audio.volume = 0.3;
	audio.play();
    increase_volume(audio, 0.75)
	var id = track + "," + level;
	var wheel = document.getElementById("WHEEL_CONTAINER");
	var gag = document.getElementById(id)
	var gag_rotation = parseFloat(gag.getAttribute("transform").split("(")[1].split(",")[0])
	var fullRevs = 6;
	var max_rotation = (fullRevs * 360) + (360 - gag_rotation)
	var rotation = 0;
	var topSpeed = Math.floor(Math.random() * 5) + 25;
	var speed = 1;
	while(speed < topSpeed){
		rotation += speed;
		speed++;
		wheel.setAttribute("transform", "rotate(" + rotation + ",306,396)");
		await sleep(50);
	}
	while(rotation < max_rotation - ((speed * (speed + 1))/2) - deg){
		rotation += speed;
		wheel.setAttribute("transform", "rotate(" + rotation + ",306,396)");
		await sleep(50);
	}
	while(speed >= 3){
		rotation += speed;
		speed--;
		wheel.setAttribute("transform", "rotate(" + rotation + ",306,396)");
		await sleep(50);
	}
	while(rotation < max_rotation + deg/2 - 2){
		rotation += 2;
		wheel.setAttribute("transform", "rotate(" + rotation + ",306,396)");
		await sleep(50);
	}
	rotation += 1;
	wheel.setAttribute("transform", "rotate(" + rotation + ",306,396)");
	await sleep(50);
    decrease_volume(audio, 0)
    var result = '../music/earthboundWin.wav';
    if (track <= 7 && level == 1) {
        var failures = ['golfMiss.wav', 'goSad.ogg', 'oof.wav']
        var num = Math.floor(Math.random() * failures.length)
        result = '../music/' + failures[num];
    }
    console.log(result)
	var done = new Audio(result);
	done.volume = 0.4;
	done.play();
    show_result(track, level)
    hide_element(document.getElementById("WHEEL_CONTAINER"))
    hide_element(document.getElementById("XMLID_1_"))
    hide_element(document.getElementById("COACH_Z"))
    hide_element(document.getElementById("ARROW"))


    await sleep(4000)
    decrease_volume(done, 0)
}

async function show_result(track,level) {
    var elem;
    if (track == 8) {
        elem = document.getElementById(track + "," + level).getElementsByTagName("text")[0];
    }
    else {
        elem = document.getElementById(track + "," + level).getElementsByTagName("image")[0];
    }
    var cln = elem.cloneNode(true);
    document.getElementById("Layer_1").appendChild(cln)
    var rotation = 0
    var scale = 1
    var attributes = elem.getAttribute("transform")
    while (rotation < 720) {
        scale += 0.1
        rotation += 24
        cln.setAttribute("transform", attributes + "scale(" + scale + ") rotate(" + rotation + ")")
        await sleep(50)
    }
    await sleep(1000)
    hide_element(cln, 0.1)
}

async function hide_element(elem, speed=0.05) {
    var opacity = 1.0
    while (opacity > 0) {
        opacity -= speed
        elem.setAttribute("style", "opacity:" + opacity + ";")
        await sleep(50)
    }
}

async function show_element(elem) {
    elem.setAttribute("style", "opacity:100;")
}

function reset() {
	document.getElementById("WHEEL_CONTAINER").setAttribute("transform", "rotate(0,306,396)");
    show_element(document.getElementById("WHEEL_CONTAINER"))
    show_element(document.getElementById("XMLID_1_"))
    show_element(document.getElementById("COACH_Z"))
    show_element(document.getElementById("ARROW"))
}