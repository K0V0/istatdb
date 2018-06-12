class SettingsController < ApplicationController

	skip_filter *_process_action_callbacks.map(&:filter)

	before_action :inits

	def index
		@settings = current_user.settings.l
		@global_settings = GlobalSettings.get_all
	end

	def update_settings
		update_user_settings
		update_global_settings
		redirect_to :back
	end

	private

	def update_user_settings
		current_user.settings.u(params[:settings])
		@MEM.settings = current_user.settings.l
	end

	def update_global_settings
		if params.has_key? :global_settings
			if current_user.is_admin
				params[:global_settings].each do |key, val|
					GlobalSettings[key] = val
				end
			end
		end
	end

end
