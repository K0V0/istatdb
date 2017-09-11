class ManufacturersController < ApplicationController

    before_action(only: [:index, :search, :show, :administrative]) {
      searcher_for(
      	object: Manufacturer.preload_items,
        autoshow: false,
        paginate: true,
        preload: [:impexpcompanies, :impexpcompany_manufacturers]
      ); 
    }

    before_action :loads_for_search_panel, only: [:index, :search, :show, :administrative]
    before_action :load_vars, only: [:new, :create, :edit, :update]

    def edit_details
    	@record = Manufacturer.find(params[:id])
    	@impexp_mans = @record.impexpcompany_manufacturers
    	#@impexp_mans = @record.impexpcompany_manufacturers.build
    	render 'manufacturers/shared/edit_details'
    end

  	private

  	def index_action
	  @collection = Manufacturer.preload_items.default_order
	end

    def permitted_params
      params[:manufacturer].permit(
      	:id,
        :name,
        impexpcompanies_attributes: [:id, :company_name],
        impexpcompany_ids: []
        #:impexpcompany_company_name,
        #:local_taric_kncode,
        #:local_taric_description,
        #:incoterm,
        #impexpcompany_ids: []
      )
    end

    def loads_for_search_panel
		@impexpcompanies = Impexpcompany.all.default_order
	end

	def load_vars
		@impexpcompanies = Impexpcompany.all
	end

	def around_new
		build_if_empty :impexpcompanies
	end

	def around_create_after_save_ok
		@record.impexpcompany_manufacturers.each do |r|
			r.added_or_modded_by_user = true
			r.save
		end
		redirect_to(edit_details_manufacturer_path(@record.id))
		return false
	end

end
