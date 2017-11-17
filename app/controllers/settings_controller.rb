class SettingsController < ApplicationController

	skip_filter *_process_action_callbacks.map(&:filter)

	before_action :inits

	def index
		@settings = Setting.load
	end	

	def update_settings
		settings = Setting.where(k: params[:settings].keys)
		settings.each do |setting|
			setting.v = params[:settings][setting.k]
			setting.save
		end
		@MEM.settings = Setting.load
		render :index
	end

end
