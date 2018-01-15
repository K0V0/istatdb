class SettingsController < ApplicationController

	skip_filter *_process_action_callbacks.map(&:filter)

	before_action :inits

	def index
		@settings = current_user.settings.l
		#Rails.logger.info "============="
		#Rails.logger.info current_user.settings.l
	end	

	def update_settings
		#@settings = current_user.settings.l
		#@settings.u(params[:settings])
		current_user.settings.u(params[:settings])
		#params[:settings].keys.each do |key|

			#Rails.logger.info "---------"
			#Rails.logger.info current_user.settings.l
		
		#settings = Setting.where(k: params[:settings].keys)
		#settings.each do |setting|
		#	setting.v = params[:settings][setting.k]
		#	setting.save
		#end
		@MEM.settings = current_user.settings.l

		render :index
	end

end
