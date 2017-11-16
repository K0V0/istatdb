class SettingsController < ApplicationController

	skip_filter *_process_action_callbacks.map(&:filter)

	before_action :inits

	def index
		@settings = Setting.load
	end	

	def update_settings
		render :index
	end

end
