class GoodsController < ApplicationController

	before_action(only: [:index, :search, :show, :administration]) {

		searcher_for(
			preload: :local_taric,
			paginate: true
		);
	}

	before_action :load_vars, only: [:new, :create]
	before_action :loads_for_search_panel, only: [:index, :search, :show]

	private 

	def loads_for_search_panel
		@impexpcompanies = Impexpcompany.all.default_order
		if params[:impexpcompany_filter].blank?
			@manufacturers = Manufacturer.all.default_order
		else
			@manufacturers = @impexpcompanies.find(params[:impexpcompany_filter]).manufacturers.default_order
		end
	end

	def load_vars
		@local_tarics = LocalTaric.all
		@impexpcompanies = Impexpcompany.all
		@manufacturers = Manufacturer.all
		@uom_types = UomType.all
		@impexpcompanies_for_uoms = @record.impexpcompanies
		@manufacturers_for_uoms = @record.manufacturers
	end

	def around_new
		build_if_empty :local_taric, :impexpcompanies, :manufacturers, :uoms
	end

	def around_create_after_save_failed
		build_if_empty :local_taric, :impexpcompanies, :manufacturers, :uoms
	end

	def permitted_params
		params.require(:good).permit(
			:ident, 
			:description,
			:local_taric_id,
			local_taric_attributes: [:kncode, :description],
			impexpcompanies_attributes: [:id, :company_name],
			impexpcompany_ids: [],
			manufacturers_attributes: [:id, :name],
			manufacturer_ids: [],
			uoms_attributes: [:id, :uom, :uom_type_id, :uom_multiplier, :manufacturer_id, :impexpcompany_id]
		)
	end
end
