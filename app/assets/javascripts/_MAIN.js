var CONTROLLER_NAME;
var EXCLUSIVE_HANDLER_RUNS;

var bothHandler = function() {
	console.log("page changed or reloaded");

	CONTROLLER_NAME = $('body').data("controller_name");

	call_controller_specific("onboth");
}

var mainHandler = function() {
	console.log("page full reload");

	call_on_all_controllers("before", "onready");
	call_controller_specific("onready");
	call_on_all_controllers("after", "onready");
};

var reloadHandler = function() {
	console.log("page changed (turbolinks reload)");

	call_on_all_controllers("before", "onload");
	call_controller_specific("onload");
	call_on_all_controllers("after", "onload");
}

var onExclusiveHandler = function() {
	if (EXCLUSIVE_HANDLER_RUNS === undefined) {
		EXCLUSIVE_HANDLER_RUNS = true;
		console.log("onExclusiveHandler() runs");

		call_controller_specific("onexclusive");
	}
}


$(document).ready(function() { bothHandler(); mainHandler(); onExclusiveHandler(); });

$(document).on("turbolinks:load", function() { bothHandler(); reloadHandler(); onExclusiveHandler(); } );