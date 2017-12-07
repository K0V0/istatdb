
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

function capitalize(str)
{
    return str.replace(/\w\S*/g, function(txt){return txt.charAt(0).toUpperCase() + txt.substr(1).toLowerCase();});
}

String.prototype.capitalize = function () {
    return this.replace(/\w\S*/g, function(txt){return txt.charAt(0).toUpperCase() + txt.substr(1).toLowerCase();});
};
