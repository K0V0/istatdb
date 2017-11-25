
function Main() {
	this.H = new H();
	logger("", true);
}

Main.prototype = {
	constructor: Main,

	init: function() {
		var H = this.H;

		$(window).on('load', function() {
			H.run('on_load');
		});
		
		$(document).ready(function(){
			H.run('on_ready');
		});

		$(document).on("turbolinks:load", function() { 
			H.run('on_reload');
		});

		$(window).frequentFireLimit('resize', 500, this, function(e) {
			H.run('on_resize');
		});
	}
}

var JS;

JS = new Main();

JS.init();

/*
var CONTROLLER_NAME;
var ACTION_NAME;

console.log("js router loaded");

function generateHandlers(handler_names) {
	for (var i=0; i<handler_names.length; i++) {
		console.log(handler_names[i]+"Handler()");
	}
}
*/

//generateHandlers(['both', 'onload', 'onready', 'reload']);	
/*
var bothHandler = function() {
	console.log("page changed OR reloaded (bothHandler())");

	CONTROLLER_NAME = $('body').data("controller_name");
	ACTION_NAME = $('body').data("action_name");

	call_controller_specific("onboth");
}

var loadHandler = function() {
	console.log("window loaded (loadHandler())");

	call_on_all_controllers("before", "onload");
	call_controller_specific("onload");
	call_on_all_controllers("after", "onload");
};

var readyHandler = function() {
	console.log("page full reload (readyHandler())");

	call_on_all_controllers("before", "onready");
	call_controller_specific("onready");
	call_on_all_controllers("after", "onready");
};

var reloadHandler = function() {
	console.log("page changed - turbolinks reload (reloadHandler())");

	call_on_all_controllers("before", "reload");
	call_controller_specific("reload");
	call_on_all_controllers("after", "reload");
}

$(window).on('load', function() {
	loadHandler();
});
*/
/*
$(document).ready(function(){
  //Paloma.start();
  bothHandler();
  readyHandler();
});

$(document).on("turbolinks:load", function() { 
	bothHandler();
	reloadHandler();
	//prepareControllerPrototype();
});
*/

