
class SettingsController < ApplicationController

	skip_filter *_process_action_callbacks.map(&:filter)

	def index

	end

	
	
end
