class GoodsController < ApplicationController

	include UomsCalcMem

	private

	def _searcher_settings
		{ preload: {local_taric: [:translations]}, paginate: true, autoshow: true }
	end

	def _allowed_params
		[
			:id,
			:ident,
			:description,
			:local_taric_id,
			local_taric_attributes: [:kncode, :description, :allow_search_as_new],
			impexpcompanies_attributes: [:id, :company_name, :allow_search_as_new],
			impexpcompany_ids: [],
			manufacturers_attributes: [:id, :name, :allow_search_as_new],
			manufacturer_ids: [],
			uoms_attributes: [:id, :uom, :uom_type_id, :uom_multiplier, :manufacturer_id, :impexpcompany_id, :_destroy]
		]
	end

	def _loads_for_search_panel
		@impexpcompanies = Impexpcompany.all.default_order
		if (params.deep_has_key?(:q, :impexpcompany_filter))&&(!params[:q][:impexpcompany_filter].blank?)
			@manufacturers = @impexpcompanies.find(params[:q][:impexpcompany_filter]).manufacturers.default_order
		else
			@manufacturers = Manufacturer.all.default_order
		end
	end

	# new.create, edit, update
	def _load_vars
		@local_tarics = LocalTaric.includes(:translations).all.default_order.page(1).per(20)
		@impexpcompanies = Impexpcompany.all.default_order
		@manufacturers = Manufacturer.all.default_order.page(1).per(20)
		@uom_types = UomType.includes(:translations).all.default_order
		@impexpcompanies_for_uoms = @record.impexpcompanies.default_order
		@manufacturers_for_uoms = @record.manufacturers.default_order
	end

	def _around_new
		build_if_empty :local_taric, :impexpcompanies, :manufacturers, :uoms
	end

	def _around_create_after_save_failed
		build_if_empty :local_taric, :impexpcompanies, :manufacturers, :uoms
	end

	def _around_edit
		build_if_empty :impexpcompanies, :manufacturers
		@uom = Uom.new if !@record.uoms.any?
	end

	def _around_update_after_save
		build_if_empty :impexpcompanies, :manufacturers
	end

	def _around_update_after_save_failed
		@uom = Uom.new if !@record.uoms.any?
	end

	def _around_do_add_another
		@record.ident = ""
		@record.description = ""
		build_if_empty :impexpcompanies, :manufacturers, :local_taric, :uoms
	end

	### OVERRIDES

	def show_action
		super
		@uom_alone = @record.uoms.first if (@record.uoms.size == 1)
	end

end
