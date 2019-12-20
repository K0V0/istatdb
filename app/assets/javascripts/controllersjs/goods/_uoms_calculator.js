// show action on goods controller only

function UomsCalculator(val, multiplier, uom_type) {
	this.H = new UomsCalculatorHelper();
	this.val = val;
	this.multiplier = multiplier;
	this.uom_type = uom_type;
	this.count = 0;
	this.result = 0;
	this.last_calculated_was_quantity = null;
	this.valid = false;
	this.init();
}

UomsCalculator.prototype = {
	constructor: UomsCalculator,

	init: function() {
		var totok = this
		$(document).on('input', 'input[name=uom_count]', function(e) {
			totok.calculateResult();
			totok.validate(e);
		});
		$(document).on('input', 'input[name=uom_result]', function(e) {
			totok.calculateQuantity();
			totok.validate(e);
		});
		$(document).on('click', 'button#add_to_calculator_memory', function() {
			totok.sendToMem();
		});
		$(document).on('click', 'button#clear_calculator_fields', function() {
			totok.clearFields();
		});
		$(document).on('click', 'button#clear_uomscalc_list', function() {
			totok.clearMem();
		});
		$(document).on('click', '.calc_uom_select tr', function() {
			$(this).siblings().removeClass('selected');
			$(this).addClass('selected');
			totok.setVals(
				parseFloat($(this).children('td.uoms-uom').first().text()),
				parseFloat($(this).children('td.uoms-uom_multiplier').first().text()),
				$(this).children('td.uoms-type').first().text()
			);
		});
	},

	validate: function(evt) {
		// all conditions must fail if is valid
		this.valid = true;
		if (this.count == 0 || this.result == 0) {
			this.H.handleZeroError();
			this.valid = false;
		}
		else if (isNaN(this.count) || isNaN(this.result)) {
			this.H.handleNanError(evt);
			this.valid = false;
		}
		this.H.blockAddButton(!(this.valid));
	},

	clearFields: function() {
		$('input[name=uom_count], input[name=uom_result]').val('');
	},

	calculateResult: function() {
		this.last_calculated_was_quantity = false;
		this.getValsFromFields();
		this.count = parseFloat(this.H.sanitizeComma($('input[name=uom_count]').val().replace(/\s/g, '')));
		this.result = (this.val * this.count) / this.multiplier;
		$('input[name=uom_result]').val(NumberFormat(this.result.toFixed(2)));
		$('input[name=uom_count]').val(NumberFormat(this.count));
	},

	calculateQuantity: function() {
		this.last_calculated_was_quantity = true;
		this.getValsFromFields();
		this.result = parseFloat(this.H.sanitizeComma($('input[name=uom_result]').val().replace(/\s/g, '')));
		this.count = this.result / (this.val / this.multiplier);
		$('input[name=uom_count]').val(NumberFormat(Math.ceil(this.count)));
		$('input[name=uom_result]').val(NumberFormat(this.result));
	},

	getValsFromFields: function() {
		this.val = parseFloat($('input[name=uom_value]').val().replace(/\s/g, ''));
		this.multiplier = parseInt($('input[name=uom_multiplier]').val().replace(/\s/g, ''));
		this.uom_type = $.trim($('b.uoms_calculator_uom_type').text());
	},

	setVals: function(val, multiplier, uom_type) {
		this.val = val;
		this.multiplier = multiplier;
		this.uom_type = uom_type;
		$('input[name=uom_value]').val(val);
		$('input[name=uom_multiplier]').val(multiplier);
		$('b.uoms_calculator_uom_type').text(uom_type);
		if (this.last_calculated_was_quantity === false) {
			this.calculateResult();
		} else if (this.last_calculated_was_quantity === true) {
			this.calculateQuantity();
		}
	},

	sendToMem: function() {
		var totok = this;
		if (totok.valid) {
			$.ajax({
			  	method: "POST",
			 	url: 'http://' + window.location.host + '/goodsdb/add_to_uoms_calculator',
			  	data: {
			  		good_name: $(document).find('h1').first().text(),
			  		uom: totok.val,
			  		multiplier: totok.multiplier,
			  		uom_type: totok.uom_type,
			  		count: totok.count,
			  		result: totok.result,
			  		good_id: $(document).find('input#good_id').val()
			  	}
			});
		}
	},

	clearMem: function() {
		$.ajax({
		  	method: "POST",
		 	url: 'http://' + window.location.host + '/goodsdb/clear_uoms_calculator',
		  	data: {

		  	}
		});
	},

}

function UomsCalculatorHelper() {

}

UomsCalculatorHelper.prototype = {
	constructor: UomsCalculatorHelper,

	sanitizeComma: function(text) {
		return text.replace(/\,/gi,".");
	},

	handleNanError: function(evt) {
		$(evt.target).val("");
	},

	handleZeroError: function() {

	},

	blockAddButton: function(block) {
		if (block === true) {
			$('button#add_to_calculator_memory')
				.addClass('disabled')
				.attr('disabled', 'disabled');
		} else {
			$('button#add_to_calculator_memory')
				.removeClass('disabled')
				.attr('disabled', false);
		}
	}
}
