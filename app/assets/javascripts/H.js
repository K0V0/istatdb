
function H() {
	this.CONTROLLER_NAME;
	this.ACTION_NAME;
	this.CONTROLLER;
	this.ALL_CONTROLLER;

	this.init();
}

H.prototype = {
	constructor: H,

	init: function() {

	},

	get_controller: function() {
		this.CONTROLLER_NAME = $('body').data('controller_name');
		this.ACTION_NAME = $('body').data('action_name');
		var fx = window[this.CONTROLLER_NAME.toUpperCase()];
		if (typeof fx != 'undefined') {
			this.CONTROLLER = new fx();
		} else {
			logger("no JS class for this controller");
		}
	},

	get_all_controller: function() {
		this.ALL_CONTROLLER = new ALL();
	},

	run_controller_action: function(controller) {
		if (typeof controller == 'undefined') {
			controller = this.CONTROLLER;
		}
		if (typeof controller != 'undefined') {
			var a;
			if (typeof (a=controller.all()) == 'function') { a(); }
			if (typeof (a=controller[this.ACTION_NAME]) == 'function') { a(); }
		}
	},

	on_reload: function() {
		console.log("running on_reload()");
		this.get_all_controller();
		this.get_controller();
		this.run_controller_action(this.ALL_CONTROLLER);
		this.run_controller_action();
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