
function H() {
	this.CONTROLLER_NAME;
	this.ACTION_NAME;
	this.CONTROLLER;
	this.init();
}

H.prototype = {
	constructor: H,

	init: function() {

	},

	get_controller: function() {
		this.CONTROLLER_NAME = $('body').data("controller_name");
		this.ACTION_NAME = $('body').data("action_name");
		var fx = window[this.CONTROLLER_NAME.toUpperCase()];
		this.CONTROLLER = new fx();
	},

	run_controller_action: function() {

	},

	on_reload: function() {
		console.log("running on_reload()");
		this.get_controller();

	}
}

/*
function call_controller_specific(on_document_event) {
	var fx_name = CONTROLLER_NAME.toUpperCase() + "_" + on_document_event;
	if (typeof (fx = window[fx_name]) === "function") {
		console.log(fx_name + "() called");
		fx(ACTION_NAME);
	}
}

function call_on_all_controllers(when, where) {
	if (typeof (fx = window[("ALL_CONTROLLERS_" + when + "_" + where)]) === "function") {
		fx(ACTION_NAME);
	}
}

function generateHandlers(handler_names) {
	for (var i=0; i<handler_names.length; i++) {
		console.log(handler_names[i]+"Handler()");
	}
}
*/
/*
function prepareControllerPrototype() {
	var controller_name = capitalize(CONTROLLER_NAME);
	window[controller_name+"Controller"] = Paloma.controller(controller_name);


}
*/