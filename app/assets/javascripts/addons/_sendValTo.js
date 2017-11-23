(function($) {

	$.fn.sendValTo = function (t) {
		if (this.length > 1) {
			console.log("sendValTo advice: It seems that you select more than one object to get val from.\nThe values will be set acording to last element from set");
		}
		if (typeof t == 'string') {
			t = $(t);
		}

		var val = null;
		var obj = $(this[this.length-1]);

		if (obj[0].value !== undefined) {
			val = obj.val();
		} else {
		    val = obj.text();
		}

		t.each(function() {
			if ($(this)[0].value !== undefined) {
				$(this).val($.trim(val));
			} else {
			    $(this).text($.trim(val));
			}
		});
	}
}(jQuery));