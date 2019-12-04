
GOODS = {
	_index_search_show_administrative_end_administrative_export: {
		search_item_actions: ["once"],
		search_mode_change: ["once"],
		time_mode_activation: ["once"],
		search_manufacturers_select: ['once'],
		trigger_focus_on_searchfield: ['on_reload', 'on_resize'],
		image_gallery: ["once"]
	},

	show: {
		uoms_calculator: ["once"],
		//image_gallery: ["on_change", "on_reload"]
	},

	_new_edit_update_create: {
		uom: ["on_reload"],
		search_on_google: ["on_reload"],
		uncomplete_handler: ["on_reload"],
		goods_validations: ["on_reload"],
		image_preview: ["on_reload"]
	},

	_new_create: {
		repeater_handler: ["on_reload"]
	}
}

