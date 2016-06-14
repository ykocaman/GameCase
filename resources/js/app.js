function send(to){
	document.getElementById("message").innerHTML = "Yükleniyor...";
	ajax("/send", "to=" + to + "&gift=" + selectedGiftId(), in_request, null);
}

function claim(from){
	document.getElementById("message").innerHTML = "Yükleniyor...";
	ajax("/claim", "from=" + from  +"&gift=" + selectedGiftId(), in_request, null);
}

function accept(gift_claimed){
	ajax("/accept", "gift_claimed=" + gift_claimed, out_request, gift_claimed);
}

function reject(gift_claimed){
	ajax("/reject", "gift_claimed=" + gift_claimed, out_request, gift_claimed);
}

function in_request(json,tmp){
	var d = new Date();
	document.getElementById("message").innerHTML = json.result  + "<br />" + d.toUTCString();
}

function out_request(json,parameter){
	if(json.result !== undefined){
		alert(json.result);
	}else{
		document.getElementById("accept" + parameter).innerHTML = "";
		document.getElementById("reject" + parameter).innerHTML = "";
		document.getElementById("status" + parameter).innerHTML = json.status;
	}
}

function ajax(url,parameters,callback, func_parameters){
	var xhttp = new XMLHttpRequest();
	xhttp.onreadystatechange = function() {
		if (xhttp.readyState == 4 && xhttp.status == 200) {
			var json =  JSON.parse(xhttp.responseText);
			callback(json,func_parameters);
		}
	};

	xhttp.open("POST", url, true);
	xhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
	xhttp.send(parameters);
}

function selectedGiftId(){
	var e = document.getElementsByName("gift")[0];
	return e.options[e.selectedIndex].value;
}
