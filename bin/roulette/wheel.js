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

async function pick(track,level,deg) {
	var id = track + "," + level;
	var wheel = document.getElementById("WHEEL_CONTAINER");
	var gag = document.getElementById(id)
	var gag_rotation = parseFloat(gag.getAttribute("transform").split("(")[1].split(",")[0])
	var fullRevs = Math.floor(Math.random() * 4) + 2;
	var max_rotation = (fullRevs * 360) + (360 - gag_rotation)
	var rotation = 0;
	var topSpeed = Math.floor(Math.random() * 10) + 15;
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
	while(speed > 3){
		rotation += speed;
		speed--;
		wheel.setAttribute("transform", "rotate(" + rotation + ",306,396)");
		await sleep(50);
	}
	while(rotation < max_rotation + deg/2 - 1){
		rotation += 3;
		wheel.setAttribute("transform", "rotate(" + rotation + ",306,396)");
		await sleep(50);
	}
}

function reset() {
	document.getElementById("WHEEL_CONTAINER").setAttribute("transform", "rotate(0,306,396)");
}