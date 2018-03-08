class SettingsController < ApplicationController

	skip_filter *_process_action_callbacks.map(&:filter)

	before_action :inits

	def index
		@settings = current_user.settings.l
	end

	def update_settings
		current_user.settings.u(params[:settings])
		@MEM.settings = current_user.settings.l
		redirect_to :back
	end

end
