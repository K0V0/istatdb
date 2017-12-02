
function H() {
	this.CONTROLLER_NAME;
	this.ACTION_NAME;

	this.CONTROLLER;
	//this.CONTROLLER_METHODS;
	this.ALL_CONTROLLER;
	//this.ALL_CONTROLLER_METHODS;

	this.FIRED_ONCE_ACTIONS;
	this.ONCE_REGEX; 

	this.init();
}

H.prototype = {
	constructor: H,

	init: function() {
		this.FIRED_ONCE_ACTIONS = [];
		this.ONCE_REGEX = /_once$/;
	},

	run: function(handler_name) {
		if (typeof handler_name == 'undefined') {
			handler_name = 'on_reload';
		}
		this.get_all_controller();
		this.get_controller();
		this.run_controller_actions(this.ALL_CONTROLLER, handler_name);
		this.run_controller_actions(this.CONTROLLER, handler_name);
	},

	get_controller: function() {
		this.CONTROLLER_NAME = $('body').data('controller_name').toUpperCase();
		this.ACTION_NAME = $('body').data('action_name');
		var fx = window[this.CONTROLLER_NAME];
		
		if (typeof fx != 'undefined') {

			if (typeof this.CONTROLLER == 'undefined') {
				this.CONTROLLER = new fx();
			} 
			// do not load same controller twice 
			// after F5 refresh of app or first run botn "on_ready()" and "on_reload()" runs 
			if (this.CONTROLLER.constructor.name != this.CONTROLLER_NAME) {
				this.CONTROLLER = new fx();
			}

		} else {
			logger("no JS class for this controller ("+this.CONTROLLER_NAME+")");
		}
	},

	get_all_controller: function() {
		if (typeof this.ALL_CONTROLLER == 'undefined') {
			this.ALL_CONTROLLER = new ALL();
		}
	},

	get_methods: function(obj) {
		var meth = Object.getOwnPropertyNames(window[obj.constructor.name].prototype);
		meth.shift();
    	return meth;
	},

	run_controller_actions: function(controller, action_type) {
		if (typeof controller != 'undefined') {
			var rgx = "(" + this.ACTION_NAME + ").*(_" + action_type + ")$|(_all_" + action_type + ")$";
			var meths = this.get_methods(controller);

			for (var i=0; i<meths.length; i++) {
				if (meths[i].match(rgx) != null) {
					if (this.FIRED_ONCE_ACTIONS.indexOf(meths[i]) == -1) {
						controller[meths[i]]();
						if (this.ONCE_REGEX.test(meths[i])) { 
							this.FIRED_ONCE_ACTIONS.push(meths[i]);
						}
						logger(controller.constructor.name);
						logger(meths[i]);
					}
				}
			}
		}
	}
}