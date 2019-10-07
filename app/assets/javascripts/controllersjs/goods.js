
GOODS = {
	_index_search_show_administrative_end_administrative_export: {
		search_item_actions: ["on_ready"],
		search_mode_change: ["on_reload"],
		time_mode_activation: ["on_reload"],
		search_manufacturers_select: ['on_reload'],
		trigger_focus_on_searchfield: ['on_ready', 'on_reload', 'on_change', 'on_resize']
	},

	show: {
		uoms_calculator: ["once"]
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

