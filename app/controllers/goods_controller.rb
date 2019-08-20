class GoodsController < ApplicationController

	include UomsCalcMem

	#def apply_last_select
		#url = Rails.application.routes.recognize_path(request.referrer)
		#redirect_to({ action: url[:action], controller: url[:controller], apply_last_select: true })
	#end

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
			:uncomplete,
			:uncomplete_reason,
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

	# new, create, edit, update
	def _load_vars
		will_paginate :manufacturers, :local_taric 
		@impexpcompanies = Impexpcompany.all.default_order
		@uom_types = UomType.includes(:translations).all.default_order
		@impexpcompanies_for_uoms = Impexpcompany.where(id: @record.impexpcompany_ids)
		@manufacturers_for_uoms = Manufacturer.where(id: @record.manufacturer_ids)
	end

	def load_uoms
		@uom = Uom.new if !@record.uoms.any?
		@impexpcompanies_for_uoms = @record.impexpcompanies
		@manufacturers_for_uoms = @record.manufacturers
	end

	def _around_new
		build_if_empty :local_taric, :impexpcompanies, :manufacturers, :uoms
		get_last_selects
	end

	def _around_create_after_save_failed
		build_if_empty :local_taric, :impexpcompanies, :manufacturers, :uoms
	end

	def _around_edit
		build_if_empty :impexpcompanies, :manufacturers, :local_taric
		get_last_selects
		load_uoms
	end

	def _around_update_after_save
		build_if_empty :impexpcompanies, :manufacturers, :local_taric
	end

	def _around_update_after_save_failed
		build_if_empty :impexpcompanies, :manufacturers, :local_taric
		load_uoms
	end

	def _around_do_add_another
		@record.ident = ""
		@record.description = ""
		build_if_empty :impexpcompanies, :manufacturers, :local_taric, :uoms
	end

	def _around_create_after_save_ok
		remember_last_select
	end

	def _around_update_after_save_ok
		remember_last_select
	end

	def remember_last_select
		controller_mem_set(:last_taric, @record.local_taric.id)
		controller_mem_set(:last_manufacturers, @record.manufacturers.ids)
		controller_mem_set(:last_impexpcompanies, @record.impexpcompanies.ids)
	end

	def get_last_selects
		if params.has_key?(:apply_last_select)
			taric = controller_mem_get(:last_taric)
			manufacturers = controller_mem_get(:last_manufacturers)
			impexpcompanies = controller_mem_get(:last_impexpcompanies)
			@record.ident = params[:item]
			@record.description = params[:description]
			@record.local_taric = LocalTaric.find(taric) if !taric.blank?
			@record.manufacturers = Manufacturer.find(manufacturers) if !manufacturers.blank?
			#logger "v kontrolleri"
			#logger @record.manufacturers.length
			@record.impexpcompanies = Impexpcompany.find(impexpcompanies) if !impexpcompanies.blank?
			## ok, funguje
		end
	end

	### OVERRIDES

	def show_action
		super
		@uom_alone = @record.uoms.first if (@record.uoms.size == 1)
	end



end
