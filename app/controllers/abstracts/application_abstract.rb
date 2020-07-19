module ApplicationAbstract
	extend ActiveSupport::Concern

	def _parent_controller
		nil
	end

	def _allowed_params
		[]
	end

	def _max_last_visited
		20
	end

	def _searcher_settings
   		{ paginate: true, disabled: true }
 	end

 	def _ban_admin_tasks!
  		false
  	end

	def _around_new
	end

	def _around_edit
	end

	def _around_create
	end

	def _around_create_after_save
	end

	def _around_create_after_save_ok
	end

	def _around_create_after_save_failed
	end

	def _around_update
	end

	def _around_update_after_save
	end

	def _around_update_after_save_ok
	end

	def _around_update_after_save_failed
	end

	def _load_vars
	end

	def _loads_for_search_panel
	end

	def _load_new_edit_vars
	end

	def _load_create_update_vars
	end

	def _around_do_add_another
	end

	def _before_inits
	end

	def _after_inits
	end

	def _before_db_load
	end

	def _before_apicall_render
	end

	def _before_apicall_load
	end

end
