class SettingsController < ApplicationController

	skip_filter *_process_action_callbacks.map(&:filter)

	def index
		@settings = Setting.load
	end	

end
