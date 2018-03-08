class ImpexpcompaniesController < ApplicationController

	private

	def _parent_controller
        :settings
    end

	def _allowed_params
   		[ :company_name ]
 	end

 	### OVERRIDES

 	def show_action
		super
		# this include only taric code, incoterm and correct invoices mark
		# only for impexpcompany shown
		@for_manufacturerstable = @record.manufacturers
			.joins(impexpcompany_manufacturers: [:local_taric, :incoterm])
			.includes(impexpcompany_manufacturers: [:local_taric, :incoterm])
		@for_tarictable = @record.goods
			.preload(:local_taric)
			.select('distinct "goods"."local_taric_id"')
	end

end
