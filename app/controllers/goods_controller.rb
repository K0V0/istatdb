class GoodsController < ApplicationController

	before_action :load_q_from_mem, only: [:index]

	before_action :load_q_to_mem, only: [:show, :search]

	before_action :load_page_to_mem, only: [:index, :search]

	before_action(only: [
		:index, 
		:search, 
		:show, 
		:administration
	]) {
		searcher_for(
			object: Good, 
			preload: :local_taric,
			default_order: "ident asc"
		);
		searcher_load_manufacturers_by_impexpcompany
		@result = @result.page(params[:page])
	}

	before_action :form_searchfields_vars, only: [:new, :edit, :update]

	def index

	end

	def search
		render 'index'
	end

	def show
		
	end

	def new
		@good = Good.new
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

	def create
		@good = Good.new(permitted_pars)
	    if @good.save
	    	if params[:create_and_next]
	    		@good.ident, @good.description = "", ""
	    		reload_tables_for_select
	    		render "new"
	    	else
	    		[:ident_cont, :description_cont, :ident_or_description_cont].each { |x|
	    			@MEM.search[x] = nil
	    		}
	     		redirect_to controller: 'goods', action: 'index', q: @MEM.search
	     	end
	    else
	    	reload_tables_for_select
	       	render "new"
	    end
	end

	def administration
		render 'index'
	end

	def edit
		@good = Good.find(params[:id])
	end

	def update
		@good = Good.find(params[:id])
	    if @good.update(permitted_pars)
	      redirect_to @good
	    else
	      render :action => 'edit'
	    end
	end

	def delete

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
			uoms: [:uom, :uom_multiplier, :uom_type_id]
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
