class SettingsController < ApplicationController

	skip_filter *_process_action_callbacks.map(&:filter)

	before_action :inits

	def index
		@settings = Setting.load
	end	

	def update_settings
		Rails.logger.info "======================"
		Rails.logger.info params[:settings].keys
		a = Setting.where(k: params[:settings].keys)
		Rails.logger.info a
		render :index
	end

end
