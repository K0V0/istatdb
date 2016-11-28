//$(document).on('turbolinks:load', function() {
$(document).ready(function() {
	ACTIONS = new ActionsHandler($('section.items_table').find('table').attr('id'));
});