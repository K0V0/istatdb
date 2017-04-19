var CONTROLLER_NAME;

var mainHandler = function() {
	console.log("page full reload");

	call_controller_specific("onready");
};

var reloadHandler = function() {
	console.log("page changed (turbolinks reload)");

	call_controller_specific("onload");
}

var bothHandler = function() {
	console.log("page changed or reloaded");

	CONTROLLER_NAME = $('body').data("controller_name");
}


$(document).ready(function() { bothHandler(); mainHandler(); });

$(document).on("turbolinks:load", function() { bothHandler(); reloadHandler(); } );