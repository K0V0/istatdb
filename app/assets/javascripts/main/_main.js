function call_controller_specific(on_document_event) {
	if (typeof (fx = window[(CONTROLLER_NAME.toUpperCase() + "_" + on_document_event)]) === "function") {
		fx();
	}
}