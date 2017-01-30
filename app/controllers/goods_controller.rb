class GoodsController < ApplicationController

	before_action(only: [:index, :search, :show, :administration]) {
		searcher_load_manufacturers_by_impexpcompany
		searcher_for(
			object: Good, 
			preload: :local_taric,
			default_order: "ident asc",
			paginate: true
		);
		#searcher_load_manufacturers_by_impexpcompany
	}

	before_action :form_searchfields_vars, only: [:new, :edit, :update]

	def show
		@makers = @good.manufacturers
		if @makers.size == 1
			uoms = @good.goods_manufacturers.first.uoms 
			@autoset_uom = (uoms.size == 1)&&(!uoms.first.uom.blank?) ? uoms.first : nil
		end
	end

	def new
		if !@MEM.search.blank?
			@good.assign_attributes(
				ident: 
					@MEM.search[:ident_cont] || @MEM.search[:ident_or_description_cont],
				description: 
					@MEM.search[:description_cont],
				impexpcompany_company_name: 
					@impexpcompanies.where(id: @MEM.search[:impexpcompany_filter]).first.try(:company_name),
				manufacturer_name: 
					@manufacturers.where(id: @MEM.search[:manufacturer_filter]).first.try(:name)
			)
		end
	end

	def edit
		@good.fillup_virtual_params
	end

	def create
		if Good.exists? ident: params[:good][:ident]
			@good = Good.new(permitted_pars)
			add_next = !params[:create_and_next].blank?
			if @good.valid?
				redirect_to(controller: :goods, action: :index, q: @MEM.search) if !add_next
				if add_next
					@good.ident, @good.description = "", ""
					reload_tables_for_select
					render "new"
				end
			else
				reload_tables_for_select
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

	def form_searchfields_vars 
		@local_tarics = LocalTaric.all
		@impexpcompanies = Impexpcompany.all
		@manufacturers = Manufacturer.all
		@uom_types = UomType.all
	end

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
		client_id = nil
		if params.has_key?(:q)
			if !params[:q].blank?
				client_id = params[:q][:impexpcompany_filter]
			end
		end
		if !client_id.blank?
			@searcher_load_manufacturers_by_impexpcompany = Impexpcompany.find(client_id).manufacturers.order(:name)
		else
			@searcher_load_manufacturers_by_impexpcompany = Manufacturer.all.order(:name)
		end
	end

end
