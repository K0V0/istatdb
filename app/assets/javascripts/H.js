
function C(run_list) {
	var __run_list__ = run_list;

	this.getRunList = function() {
		return __run_list__;
	};

	this.getActions = function() {
		return Object.getOwnPropertyNames(__run_list__);
	};

	this.getActionMethods = function(action_name) {
		return __run_list__[action_name];
	};

	this.setRunList = function(rl) {
		__run_list__ = rl;
	}
}

function H() {
	this.CONTROLLER_NAME;
	this.ACTION_NAME;
	this.CONTROLLER;
	this.FIRED_ONCE_ACTIONS;

	this.init();
}

H.prototype = {
	constructor: H,

	init: function() {
		this.FIRED_ONCE_ACTIONS = [];
		this.CONTROLLER = {};
	},

	run: function(handler_name) {
		if (typeof handler_name == 'undefined') {
			handler_name = 'on_reload';
		}
		this.CONTROLLER_NAME = $('body').data('controller_name').toUpperCase();
		this.ACTION_NAME = $('body').data('action_name');
		this.get_controller('ALL');
		this.get_controller(this.CONTROLLER_NAME);
		this.run_controller_actions(this.CONTROLLER['ALL'], handler_name);
		this.run_controller_actions(this.CONTROLLER[this.CONTROLLER_NAME], handler_name);
	},

	initiate_cache: function(controller_name, run_list) {
		this.CONTROLLER[controller_name] = new C(run_list);
	},

	get_controller: function(controller_name) {
		var run_list = window[controller_name];

		if (run_list !== undefined) {

			if (this.CONTROLLER === undefined) {
				this.initiate_cache(controller_name, run_list);
			}
			// do not load same controller twice
			// after F5 refresh of app or first run botn "on_ready()" and "on_reload()" runs
			if (!(Object.keys(this.CONTROLLER)).includes(controller_name)) {
				this.initiate_cache(controller_name, run_list);
			}

		} else {
			logger("no JS class for this controller ("+controller_name+")");
		}
	},

	run_controller_actions: function(controller, action_type) {
		// if given page has JS controller
		if (controller !== undefined) {
			var actions = controller.getActions();

			for (var i=0; i<actions.length; i++) {
				var action = actions[i];

				// run only actions suited to current page action
				// includes for string because of js action can cover multiple rails
				// page actions
				if (action.includes(this.ACTION_NAME) || action == '_ALL') {
					var methods = controller.getActionMethods(action);
					var methods_names = Object.keys(methods);

					for (var j=0; j<methods_names.length; j++) {
						var method_name = methods_names[j];
						var method_allowed_events = methods[ methods_names[j] ];

						// run only methods that are suited to particular event
						if (method_allowed_events.contains(action_type)) {

							// and run method that is not on 'run once per instantiation' list
							if (this.FIRED_ONCE_ACTIONS.indexOf(method_name) == -1) {

								// instantiate method (object) only if needed, otherwise just run
								// refresh/events reattach .init() code
								if (controller[ method_name ] === undefined) {
									controller[ method_name ] = new window[ method_name.classycase() ]();
									//this.logging(action, method_name, action_type, 'new()');
									//logger(action_type);
								} else {
									controller[ method_name ].init();
									//this.logging(action, method_name, action_type, 'init()');
									//logger(action_type);
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
	},

	logging: function(action, method_name, action_type, state) {
		logger(
			'controller: 	' + this.CONTROLLER_NAME + '\n' +
			'page_action: 	' + this.ACTION_NAME + '\n' +
			'cntrlr_action:	' + action + '\n' +
			'method: 		' + method_name + '\n' +
			'event:			' + action_type + '\n' +
			'object_state:	' + state + '\n \n'
		);
	}
}
