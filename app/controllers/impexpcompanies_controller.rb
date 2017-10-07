class ImpexpcompaniesController < ApplicationController

	private

	def permitted_params
   		params[:impexpcompany].permit(:company_name)
 	end

end
