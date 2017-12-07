
String.prototype.pluralize = function () {

	var last_char = this.substr(this.length-1);
	if (last_char == 'y') {
		return this.substr(0, this.length-1) + 'ies';
	} else {
		return this + 's';
	}
};

String.prototype.singularize = function () {

	var suffix = this.substr(this.length-3);
	if (suffix == 'ies') {
		return this.substr(0, this.length-3) + 'y';
	} else {
		return this.substr(0, this.length-1);
	}
};
