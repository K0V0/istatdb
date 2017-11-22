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

function prepareControllerPrototype() {
	
}