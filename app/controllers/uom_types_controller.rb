class UomTypesController < ApplicationController

	before_action do 
		is_subsection_of(parent_controller: :settings)
	end

	private

	def permitted_params
		 params[:uom_type].permit(:uom_type, :full_name, :description)
	end

end