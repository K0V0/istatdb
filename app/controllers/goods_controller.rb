class GoodsController < ApplicationController

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
		@result = @result.page(params[:page])
	}

	before_action :searcher_load_manufacturers_by_impexpcompany, only: [
		:index, 
		:search, 
		:administration, 
		:show
	]

	before_action :form_searchfields_vars, only: [
		:new, 
		:edit, 
		:update
	]

	before_action(only: [
		:create
	]) { 
		reload_tables_for_select
		#create_action permitted_pars
	}

	def index
		
	end

	def search
		render 'index'
	end

	def show
		
	end

	def new
		@good = Good.new
		if params.has_key? :good 
			@good.assign_attributes(
				ident: params[:good][:ident],
				description: params[:good][:description],
				impexpcompany_company_name: convert_search_filter_to_assign_attr(:impexpcompany, :company_name),
				manufacturer_name: convert_search_filter_to_assign_attr(:manufacturer, :name)
			)
		end
	end

	def create
		@good = Good.new(permitted_pars)
	    if @good.save
	    	if params[:create_and_next]
	    		@good = Good.new(permitted_pars)
	    		@good.ident, @good.description = "", ""
	    		render "new"
	    	else
	     		redirect_to goods_path
	     	end
	    else
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
			@searcher_load_manufacturers_by_impexpcompany = Impexpcompany.find(client_id).manufacturers
		else
			@searcher_load_manufacturers_by_impexpcompany = Manufacturer.all
		end
	end

end
