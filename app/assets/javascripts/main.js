$(document).on('turbolinks:load', function() {
	ACTIONS = new ActionsHandler($('section.items_table').find('table').attr('id'));
});