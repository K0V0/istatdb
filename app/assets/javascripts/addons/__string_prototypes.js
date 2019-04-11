
// "ko ko ti na" => "ko ko ti nas"
// "ko ko ti ny" => "ko ko ti nies"
String.prototype.pluralize = function () {

	var last_char = this.substr(this.length-1);
	if (last_char == 'y') {
		return this.substr(0, this.length-1) + 'ies';
	} else {
		return this + 's';
	}
};

// backward
String.prototype.singularize = function () {

	var suffix = this.substr(this.length-3);
	if (suffix == 'ies') {
		return this.substr(0, this.length-3) + 'y';
	} else {
		return this.substr(0, this.length-1);
	}
};

// "ko ko ti na" => "Ko Ko Ti Na"
String.prototype.capitalize = function () {

    return this.replace(/\w\S*/g, function(txt){return txt.charAt(0).toUpperCase() + txt.substr(1).toLowerCase();});
};

// "ko ko ti na" => "Ko ko ti na"
String.prototype.titleize = function() {

	return this.replace(/^\w/, function(ch) { return ch.toUpperCase(); });
}

// "ko ko ti na" => "ko ko ti na"
// "ko_ko_ti_na" => "koKoTiNa"
String.prototype.camelize = function() {

	return this.replace(/_([a-z])/g, function (g) { return g[1].toUpperCase(); });
}

// "ko_ko_ti_na" => "KoKoTiNa"
String.prototype.classycase = function() {

	return this.capitalize().camelize();
}

String.prototype.toHsCode = function () {
    var ret = [];
    var spc = 0;
    var str = this.replace(/\s/g, "");

    for(var i=0; i<str.length; i++) {
        ret.push(str[i]);
        if (i >= 2) { spc++; }
        if ((spc == 2)) {
            ret.push(" ");
            spc = 0;
        }
    }

    return ret.join("").trim();
};