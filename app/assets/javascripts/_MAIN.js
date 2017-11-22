var CONTROLLER_NAME;
var ACTION_NAME;
var EXCLUSIVE_HANDLER_RUNS;

console.log("js router loaded");

var bothHandler = function() {
	console.log("page changed OR reloaded (bothHandler)");

	CONTROLLER_NAME = $('body').data("controller_name");
	ACTION_NAME = $('body').data("action_name");

	call_controller_specific("onboth");
}

var mainHandler = function() {
	console.log("page full reload (mainHandler)");

	call_on_all_controllers("before", "onready");
	call_controller_specific("onready");
	call_on_all_controllers("after", "onready");
};

var reloadHandler = function() {
	console.log("page changed - turbolinks reload (reloadHandler)");

	call_on_all_controllers("before", "onload");
	call_controller_specific("onload");
	call_on_all_controllers("after", "onload");
}


var onExclusiveHandler = function() {
	//console.log(EXCLUSIVE_HANDLER_RUNS);
	if (EXCLUSIVE_HANDLER_RUNS === undefined) {
		EXCLUSIVE_HANDLER_RUNS = true;
		console.log("page changed - turbolinks reload XOR page full reload (onExclusiveHandler)");

		call_controller_specific("onexclusive");
	}
}


$(document).ready(function() { bothHandler(); mainHandler(); onExclusiveHandler(); });

$(document).on("turbolinks:load", function() { bothHandler(); reloadHandler(); onExclusiveHandler(); } );

$(window).on('load', function() {
	console.log("window loaded");
});

$(document).ready(function(){
  Paloma.start();
});