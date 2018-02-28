module ApplicationAbstract
	extend ActiveSupport::Concern

	def searcher_settings
   		{ paginate: true, disabled: true }
 	end

	def around_new
	end

	def around_edit
	end

	def around_create
	end

	def around_create_after_save
	end

	def around_create_after_save_ok
	end

	def around_create_after_save_failed
	end

	def around_update
	end

	def around_update_after_save
	end

	def around_update_after_save_ok
	end

	def around_update_after_save_failed
	end

	def load_vars
	end

	def loads_for_search_panel
	end

	def load_new_edit_vars
	end

	def load_create_update_vars
	end

	def around_do_add_another
	end

end
