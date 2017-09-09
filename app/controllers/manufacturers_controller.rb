class ManufacturersController < ApplicationController

    before_action(only: [:index, :search, :show, :administrative]) {
      searcher_for(
        autoshow: false,
        paginate: true,
        preload: [:impexpcompanies, :impexpcompany_manufacturers]
      ); 
    }

    def new_select_search
      apicall_render(:has_many)
    end

  	private

  	#def index_action
	#  @collection = Manufacturer.preload_items.default_order
	#end

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

end
