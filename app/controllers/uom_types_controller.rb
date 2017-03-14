class UomTypesController < ApplicationController

	before_action(only: :create) { create_action permitted_pars }

    before_action(only: :update) { update_action permitted_pars }

	def index
		redirect_to settings_path
	end

	private

	def permitted_pars
		 params[:uom_type].permit(:uom_type, :full_name, :description)
	end

end