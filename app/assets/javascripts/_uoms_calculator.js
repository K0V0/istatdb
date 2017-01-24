
function UomsCalculator(val=null, multiplier=null, uom_type=null) {
	this.val = val;
	this.multiplier = multiplier;
	this.uom_type = uom_type;
	this.count = 0;
	this.result = 0;
	this.last_calculated_was_quantity = null;
	this.init();
}

UomsCalculator.prototype = {
	constructor: UomsCalculator,

	init: function() {
		var totok = this
		$(document).on('input', 'input[name=uom_count]', function() {
			totok.calculateResult();
		});
		$(document).on('input', 'input[name=uom_result]', function() {
			totok.calculateQuantity();
		});
		$(document).on('click', 'button#add_to_calculator_memory', function() {
			totok.sendToMem();
		});
	},

	calculateResult: function() {
		this.last_calculated_was_quantity = false;
		this.getValsFromFields();
		this.count = parseFloat($('input[name=uom_count]').val());
		this.result = (this.val * this.count) / this.multiplier;
		$('input[name=uom_result]').val(this.result.toFixed(2));
	},

	calculateQuantity: function() {
		this.last_calculated_was_quantity = true;
		this.getValsFromFields();
		this.result = parseFloat($('input[name=uom_result]').val());
		this.count = this.result / (this.val / this.multiplier);
		$('input[name=uom_count]').val(Math.ceil(this.count));
	},

	getValsFromFields: function() {
		this.val = parseFloat($('input[name=uom_value]').val());
		this.multiplier = parseInt($('input[name=uom_multiplier]').val());
		this.uom_type = $.trim($('span.uoms_calculator_uom_type').text());
	},

	setVals(val=null, multiplier=null, uom_type=null) {
		this.val = val;
		this.multiplier = multiplier;
		this.uom_type = uom_type;
		$('input[name=uom_value]').val(val);
		$('input[name=uom_multiplier]').val(multiplier);
		$('span.uoms_calculator_uom_type').text(uom_type);
		if (this.last_calculated_was_quantity === false) {
			this.calculateResult();
		} else if (this.last_calculated_was_quantity === true) {
			this.calculateQuantity();
		} 
	},

	sendToMem: function() {
		var totok = this;
		$.ajax({
		  	method: "POST",
		 	url: 'api/add_to_uoms_calculator',
		  	data: { 
		  		good_name: $(document).find('h1').text(),
		  		uom: totok.val,
		  		multiplier: totok.multiplier,
		  		uom_type: totok.uom_type,
		  		count: totok.count,
		  		result: totok.result 
		  	}
		});
	}

}
