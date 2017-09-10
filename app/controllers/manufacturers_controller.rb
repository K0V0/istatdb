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

    def new_select_search
      apicall_render(:has_many)
    end

  	private

  	def index_action
	  @collection = Manufacturer.preload_items.default_order
	end

    def permitted_pars
      params[:manufacturer].permit(
        :name,
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

end
