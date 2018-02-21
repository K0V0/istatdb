class GoodsController < ApplicationController

	include UomsCalcMem

	def show
		@uom_alone = @record.uoms.first if (@record.uoms.size == 1)
		#super
	end

	private

	def searcher_settings
		{ preload: :local_taric, paginate: true, autoshow: true }
	end

	def loads_for_search_panel
		@impexpcompanies = Impexpcompany.all.default_order
		if (params.deep_has_key?(:q, :impexpcompany_filter))&&(!params[:q][:impexpcompany_filter].blank?)
			@manufacturers = @impexpcompanies.find(params[:q][:impexpcompany_filter]).manufacturers.default_order
		else
			@manufacturers = Manufacturer.all.default_order
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

	def around_edit
		@record.impexpcompanies.build
		@record.manufacturers.build
		@uom = Uom.new if !@record.uoms.any?
	end

	def around_update_after_save_failed
		build_if_empty :impexpcompanies, :manufacturers
	end

	def permitted_params
		params.require(:good).permit(
			:id,
			:ident,
			:description,
			:local_taric_id,
			local_taric_attributes: [:kncode, :description, :id, :allow_search_as_new],
			impexpcompanies_attributes: [:id, :company_name, :allow_search_as_new],
			impexpcompany_ids: [],
			manufacturers_attributes: [:id, :name, :allow_search_as_new],
			manufacturer_ids: [],
			uoms_attributes: [:id, :uom, :uom_type_id, :uom_multiplier, :manufacturer_id, :impexpcompany_id, :_destroy]
		)
	end
end
