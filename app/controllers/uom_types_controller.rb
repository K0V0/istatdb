class UomTypesController < ApplicationController

	skip_filter *_process_action_callbacks.map(&:filter)

	def index
		#@uom_types = UomType.all
	end

	def new
		
	end

end