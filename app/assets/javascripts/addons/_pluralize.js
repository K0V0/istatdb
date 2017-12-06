
String.prototype.pluralize = function () {

	var last_char = this.substr(this.length-1);
	if (last_char == 'y') {
		return this.substr(0, this.length-1) + 'ies';
	} else {
		return this + 's';
	}
    
};
