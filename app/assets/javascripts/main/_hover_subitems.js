function hoverSubitems() {

	var rgx = /[\s]+(r[0-9]+)[\s]+|^([r0-9]+)[\s]+|[\s]+(r[0-9]+)$|^(r[0-9])$/g;

	function getKlass(ref) {
		return "." + $.trim($(ref).attr('class').match(rgx)[0]);
	}

	$(document).find("span.itemstable_subitem").on('mouseenter', function() {
		$(document).find("span" + getKlass(this)).addClass('hovered');
	});

	$(document).find("span.itemstable_subitem").on('mouseleave', function() {
		$(document).find("span" + getKlass(this)).removeClass('hovered');
	});
}