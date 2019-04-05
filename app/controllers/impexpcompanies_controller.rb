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
		
		@for_manufacturerstable_2 = ImpexpcompanyManufacturer
			.where(impexpcompany_id: @record.id)
			.includes(:manufacturer, :incoterm, local_taric: :translations)
			.order('manufacturers.name asc')

		@for_tarictable = @record.goods
			.preload(local_taric: :translations)
			.select('distinct "goods"."local_taric_id"')
			.default_order
	end

end
