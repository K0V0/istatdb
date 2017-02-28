class GoodsController < ApplicationController

	before_action(only: [:index, :search, :show, :administration]) {

		searcher_load_manufacturers_by_impexpcompany

		searcher_for(
			preload: :local_taric,
			paginate: true
		);
	}

	before_action(only: [:new, :edit, :update]) {

		load_associated_all(
			local_tarics: {},
			## give a id of record
			impexpcompanies: {
				place_first: @MEM.q_good[:impexpcompany_filter]
			}, 
			manufacturers: {
				place_first: @MEM.q_good[:manufacturer_filter]
			}, 
			uom_types: {}
		)
	}

	def show
		@makers = @good.manufacturers
		if @makers.size == 1
			uoms = @good.goods_manufacturers.first.uoms 
			@autoset_uom = (uoms.size == 1)&&(!uoms.first.uom.blank?) ? uoms.first : nil
		end
	end

	def new
		# speed up adding new good(s) - preload fields in form with values from search window, for example adding searched item that was not found (not in database yet)
		if !@MEM.q_good.blank?
			@good.assign_attributes(
				ident: 
					@MEM.q_good[:ident_cont] || @MEM.q_good[:ident_or_description_cont],
				description: 
					@MEM.q_good[:description_cont],
				impexpcompany_company_name: 
					@impexpcompanies.where(id: @MEM.q_good[:impexpcompany_filter]).first.try(:company_name),
				manufacturer_name: 
					@manufacturers.where(id: @MEM.q_good[:manufacturer_filter]).first.try(:name)
			)
		end
	end

	def edit
		@good.fillup_virtual_params
	end

	def create
		if Good.exists? ident: params[:good][:ident]
			# if good(s) exists, offer option to assign them to another intrastat client or importer/exporter
			@good = Good.new(permitted_pars)
			add_next = !params[:create_and_next].blank?

			if @good.valid?
				redirect_to(controller: :goods, action: :index, q: @MEM.search) if !add_next
				if add_next
					@good.ident, @good.description = "", ""
					#reload_tables_for_select
					render "new"
				end
			else
				#reload_tables_for_select
				render "new"
			end
		else
			createeeee(
				nullize: [:ident, :description], 
				nullize_ransack: [:ident_cont, :description_cont, :ident_or_description_cont]
			)
		end
	end

	def update
		tmp = edit_action
	    if tmp.update(permitted_pars)
	       redirect_to controller: controller_name, action: 'index'
	    else
	        render "edit"
	    end
	end

	def delete

	end

	def csv_export
		
	end

	private 

	def permitted_pars
		params.require(:good).permit(
			:ident, 
			:description,
			:local_taric_kncode,
			:local_taric_description,
			:impexpcompany_company_name,
			:manufacturer_name,
			uoms: [:uom, :uom_multiplier, :uom_type_id],
			impexpcompany_ids: []
		)
	end

	def reload_tables_for_select
		# runs on page reload eg submit and validation fail
		# reloads select tables giving more accurate results to select from after failed validation or when adding another record with simmilar or same associations
		reload_result_by_params_nested(
			LocalTaric: {
				kncode: :starts,
				description: :contains
			},
			Impexpcompany: { company_name: :contains },
			Manufacturer: { name: :contains }
		)
	end

	def searcher_load_manufacturers_by_impexpcompany
		# select good(s) importers/exporters to choose from in importer/exporter dropdown menu of search window based on previously selected intrastat client 
		if params.deep_has_key?(:q, :impexpcompany_filter)
			if !(client_id = params[:q][:impexpcompany_filter]).blank?
				@searcher_load_manufacturers_by_impexpcompany = (
					Impexpcompany.find(client_id).manufacturers.order(:name)
				)
			end
		end
		# in case of no intrastat client selected, load all
		@searcher_load_manufacturers_by_impexpcompany ||= Manufacturer.all.order(:name)
	end

end
