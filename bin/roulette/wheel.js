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

async function pick(track,level,deg, first_use) {
	if (first_use)
	{
		var intro = new Audio('../music/redHot.wav');
		intro.volume = 0.5;
		intro.play();
		await sleep(2500);
	}
	var audio = new Audio('../music/bigApple.wav');
	audio.volume = 0.75;
	audio.play();
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
		audio.volume -= 0.25/topSpeed
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
	while(audio.volume > 0.01)
	{
		audio.volume /= 1.5
		await sleep(50);
	}
	var done = new Audio('../music/earthboundWin.wav');
	done.volume = 0.5;
	done.play();
	audio.pause()
	console.log("DONE")
}

function reset() {
	document.getElementById("WHEEL_CONTAINER").setAttribute("transform", "rotate(0,306,396)");
}