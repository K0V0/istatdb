class ManufacturersController < ApplicationController


    before_action(only: [:index, :search, :show, :new_good_manufacturer_search]) {
      searcher_for autoshow:false 
    }

    before_action :form_searchfields_vars, only: [:new, :edit, :update]

    before_action :new_action, only: :new

    before_action(only: :create) { 
      reload_tables_for_select
      create_action permitted_pars
    }

  	def index

  	end

    def search

    end

  	def new

  	end

    def create

    end

    def show

    end

    def administration

    end

    def new_good_manufacturer_search
      render('manufacturers/api/manufacturer_search')
    end

    def edit_manufacturers_making_search
      searcher_for(
        object: Good.find(params[:other_data][:manufacturer_id]).manufacturers,
        autoshow: false
      )
        render('manufacturers/api/manufactuer_search_making')
    end

    def edit_manufacturers_other_search
      ids = Good.find(params[:other_data][:manufacturer_id]).manufacturers.pluck(:id)
      searcher_for(
        object: Manufacturer.where.not(id: ids),
        autoshow: false
      )
        render('manufacturers/api/manufacturer_search_other')
    end

  	private

    def permitted_pars
      params[:manufacturer].permit(
        :name,
        :impexpcompany_company_name,
        :local_taric_kncode,
        :local_taric_description
      )
    end

    def form_searchfields_vars
      @impexpcompanies = Impexpcompany.all
      @local_tarics = LocalTaric.all
    end

    def reload_tables_for_select
      reload_result_by_params_nested(
        Impexpcompany: { company_name: :contains },
        LocalTaric: {
          kncode: :starts,
          description: :contains
        },
      )
    end

end
