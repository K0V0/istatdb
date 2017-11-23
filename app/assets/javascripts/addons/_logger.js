function logger(content, enabled) {

	if (typeof enabled != 'undefined') {
		window.LOGGER_ENABLED = enabled;
	}
	if (window.LOGGER_ENABLED === true) {
		console.log(content);
	} 
}