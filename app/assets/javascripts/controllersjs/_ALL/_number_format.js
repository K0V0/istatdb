function NumberFormat(num) {
	if (num == undefined) {
		this.init();
	} else {
		return NumberFormat.prototype.format(num);
	}
}

NumberFormat.prototype = {
    constructor: NumberFormat,

    init: function() {
    	var tamto = this;
        $("input[data-isnum='true']").on("keyup", function() {
		    this.value = tamto.format(this.value);
		});
    },

    format: function(num) {
        var tmp = num.toString().replace(/ /g,'').split(/\.|\,/);
        var decadic = tmp[0].replace(/\B(?=(\d{3})+(?!\d))/g, " ");
        var decimal = tmp[1] === undefined ? "" : ("."+tmp[1]); 
    	return decadic + decimal
    }
}
