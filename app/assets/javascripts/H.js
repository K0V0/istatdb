
function H() {
	this.CONTROLLER_NAME;
	this.ACTION_NAME;
	this.CONTROLLER;
	this.ALL_CONTROLLER;
	this.FIRED_ONCE_ACTIONS;

	this.init();
}

H.prototype = {
	constructor: H,

	init: function() {
		this.FIRED_ONCE_ACTIONS = [];
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

	get_actions: function(obj) {
		var meth = Object.getOwnPropertyNames(window[obj.constructor.name].prototype);
		meth.shift();
    	return meth;
	},

	run_controller_actions: function(controller, action_type) {
		// if given page has JS controller
		if (typeof controller != 'undefined') {
			var actions = this.get_actions(controller);

			for (var i=0; i<actions.length; i++) {
				var action = actions[i];

				// run only actions suited to current page action 
				// includes for string because of js action can cover multiple rails 
				// page actions
				if (action.includes(this.ACTION_NAME) || action == '_ALL') {
					var methods = controller[ action ];
					var methods_keys = Object.keys(methods);

					for (var j=0; j<methods_keys.length; j++) {
						var method_name = methods_keys[j];
						var method_allowed_events = methods[ methods_keys[j] ];
						
						// run only methods that are suited to particular event
						if (method_allowed_events.contains(action_type)) {

							// and run method that is not on 'run once per instantiation' list
							if (this.FIRED_ONCE_ACTIONS.indexOf(method_name) == -1) {

								logger(
									'controller: ' + controller.constructor.name + '\n' +
									'page_action: ' + this.ACTION_NAME + '\n' +
									'cntrlr_action: ' + action + '\n' +
									'method: ' + method_name + '\n' +
									'event: ' + action_type + '\n' + '\n'
								);

								// instantiate method (object) only if needed, otherwise just run
								// refresh/events reattach .init() code
								if (controller[ method_name ] === undefined) {
									controller[ method_name ] = new window[ method_name.classycase() ]();
								} else {
									controller[ method_name ].init();
								}

								// if 'run once' method executed because is not in list, add it to list
								if (method_allowed_events.contains('once')) { 
									this.FIRED_ONCE_ACTIONS.push(method_name);
								}
							}
						}
					}
				}
			}
		}
	}
}