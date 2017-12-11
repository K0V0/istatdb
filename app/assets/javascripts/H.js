
function H() {
	this.CONTROLLER_NAME;
	this.ACTION_NAME;
	this.RUN_LIST;

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
		this.CONTROLLER_NAME = $('body').data('controller_name').toUpperCase();
		this.ACTION_NAME = $('body').data('action_name');
		this.get_all_controller();
		this.get_controller();
		this.run_controller_actions(this.ALL_CONTROLLER, handler_name);
		this.run_controller_actions(this.CONTROLLER[this.CONTROLLER_NAME], handler_name);
	},

	initiate_cache: function() {
		this.CONTROLLER = {};
		this.CONTROLLER[this.CONTROLLER_NAME] = {};
	},

	get_controller: function() {
		this.RUN_LIST = window[this.CONTROLLER_NAME];
		
		if (this.RUN_LIST !== undefined) {

			if (this.CONTROLLER === undefined) {
				this.initiate_cache();
			} 
			// do not load same controller twice 
			// after F5 refresh of app or first run botn "on_ready()" and "on_reload()" runs 
			//logger(Object.keys(this.CONTROLLER));
			if (!(Object.keys(this.CONTROLLER)).includes(this.CONTROLLER_NAME)) {
				//logger(Object.keys(this.CONTROLLER));
				this.initiate_cache();
				//logger('runds');
			}

		} else {
			logger("no JS class for this controller ("+this.CONTROLLER_NAME+")");
		}
	},

	get_all_controller: function() {
		if (this.ALL_CONTROLLER === undefined) {
			this.ALL_CONTROLLER = {};
		}
	},

	get_actions: function(obj) {
		var meth = Object.getOwnPropertyNames(this.RUN_LIST);
		//meth.shift();
    	return meth;
	},

	run_controller_actions: function(controller, action_type) {
		// if given page has JS controller
		if (controller !== undefined) {
			var actions = this.get_actions(controller);

			//logger('cstions');
			logger(actions);

			for (var i=0; i<actions.length; i++) {
				var action = actions[i];
				logger(action);

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