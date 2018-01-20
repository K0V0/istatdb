class ImpexpcompaniesController < ApplicationController

	before_action do 
		is_subsection_of(parent_controller: :settings)
	end

	private

	def permitted_params
   		params[:impexpcompany].permit(:company_name)
 	end

 	def show_action
		super
		# this include only taric code, incoterm and correct invoices mark
		# only for impexpcompany shown
		@for_manufacturerstable = @record.manufacturers
			.joins(impexpcompany_manufacturers: [:incoterm, :local_taric])
			.includes(impexpcompany_manufacturers: [:incoterm, :local_taric])

		@for_tarictable = @record.goods
			.preload(:local_taric)
			.select('distinct "goods"."local_taric_id"')
	end

end
