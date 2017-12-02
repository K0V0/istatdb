
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
		logger(handler_name + "() runs");
		this.get_all_controller();
		this.get_controller();
		this.run_controller_actions(this.ALL_CONTROLLER, handler_name);
		this.run_controller_actions(this.CONTROLLER, handler_name);
		//console.log(this.get_methods(window[this.CONTROLLER_NAME]));
		//this.run_controller_actions(this.ALL_CONTROLLER, handler_name);
		//this.run_controller_actions(this.CONTROLLER, handler_name);
	},

	get_controller: function() {
		this.CONTROLLER_NAME = $('body').data('controller_name').toUpperCase();
		this.ACTION_NAME = $('body').data('action_name');
		var fx = window[this.CONTROLLER_NAME];
		
		if (typeof fx != 'undefined') {

			if (typeof this.CONTROLLER == 'undefined') {
				//this.init_controller(fx);
				this.CONTROLLER = new fx();
			} 
			// do not load same controller twice 
			// after F5 refresh of app or first run botn "on_ready()" and "on_reload()" runs 
			if (this.CONTROLLER.constructor.name != this.CONTROLLER_NAME) {
				//this.init_controller(fx);
				this.CONTROLLER = new fx();
			}

		} else {
			logger("no JS class for this controller ("+this.CONTROLLER_NAME+")");
		}
	},

	get_all_controller: function() {
		if (typeof this.ALL_CONTROLLER == 'undefined') {
			this.ALL_CONTROLLER = new ALL();
			//this.ALL_CONTROLLER_METHODS = this.get_methods(ALL);
		}
	},

	get_methods: function(obj) {
		var meth = Object.getOwnPropertyNames(window[obj.constructor.name].prototype);
		//logger(obj.constructor.name);
		meth.shift();
    	return meth;
    	//this.CONTROLLER_METHODS = meth;
	},

	/*init_controller: function(f) {
		this.CONTROLLER = new f();
		//this.get_methods(window[this.CONTROLLER.constructor.name]);
		//this.CONTROLLER_METHODS = this.get_methods(f);
	},*/
/*	
	run_controller_actions: function(controller, action_type) {
		if (typeof controller != 'undefined') {
			var action_names = ['all_'+action_type, this.ACTION_NAME+'_'+action_type]
			if (action_type == 'on_reload') { action_names.push("all", this.ACTION_NAME); }
			this.run_controller_action(controller, action_names); 
		}
	},

	run_controller_action: function(controller, action_names) {
		var a;
		for (var i=0; i<action_names.length; i++) {
			if (typeof (a = controller[action_names[i]]) == 'function') { 
				var method_id = controller.constructor.name + "_" + action_names[i];
				if (this.FIRED_ONCE_ACTIONS.indexOf(method_id) == -1) {
					a();
					if (this.ONCE_REGEX.test(method_id)) { 
						this.FIRED_ONCE_ACTIONS.push(method_id);
					}
				}
			}
		}
	}
*/

	run_controller_actions: function(controller, action_type) {
		//console.log()
		if (typeof controller != 'undefined') {
			var rgx = "(" + this.ACTION_NAME + ").*(_" + action_type + ")$";
			//logger(rgx);
			var meths = this.get_methods(controller);
			logger(meths);

			for (var i=0; i<meths.length; i++) {
				if (meths[i].match(rgx) != null) {
					logger(meths[i]);
				}
			}

			//console.log(this.ACTION_NAME);;
			//console.log(this.CONTROLLER_METHODS);
		}
	},
}