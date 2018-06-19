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
    	return num.toString().replace(/ /g,'').replace(/\B(?=(\d{3})+(?!\d))/g, " ");
    }
}
