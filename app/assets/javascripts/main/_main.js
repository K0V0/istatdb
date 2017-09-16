function call_controller_specific(on_document_event) {
	if (typeof (fx = window[(CONTROLLER_NAME.toUpperCase() + "_" + on_document_event)]) === "function") {
		fx();
	}
}

function call_on_all_controllers(when, where) {
	if (typeof (fx = window[("ALL_CONTROLLERS_" + when + "_" + where)]) === "function") {
		fx();
	}
}