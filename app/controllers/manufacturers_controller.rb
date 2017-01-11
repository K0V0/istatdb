class ManufacturersController < ApplicationController

    before_action :load_q_from_mem, only: [:index]

    before_action :load_q_to_mem, only: [:show, :search]

    before_action :load_page_to_mem, only: [:index, :search]

    before_action(only: [:index, :search, :show, :administration]) {
      searcher_for(
        autoshow:false,
        default_order: "name asc",
        paginate: true,
        preload: [:impexpcompanies, :impexpcompany_manufacturers]
      ); 
    }

    before_action :form_searchfields_vars, only: [:new, :edit, :update]

    before_action(only: :create) { 
      createeeee(
        nullize: [:name], 
        nullize_ransack: [:name_cont]
      )
    }

  	def new
      @manufacturer = Manufacturer.new
      if !@MEM.search.blank?
        @manufacturer.assign_attributes(
          name: 
            @MEM.search[:name_cont],
          impexpcompany_company_name:
            @impexpcompanies.where(id: @MEM.search[:impexpcompany_filter]).first.try(:company_name),
        )
      end
  	end

    def edit
      @manufacturer = Manufacturer.find(params[:id])
    end

    def update
      @manufacturer = Manufacturer.find(params[:id])
      log params
      @manufacturer.update(permitted_pars)
    end

=begin   
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
=end

  	private

    def permitted_pars
      params[:manufacturer].permit(
        :name,
        :impexpcompany_company_name,
        :local_taric_kncode,
        :local_taric_description,
        :incoterm,
        impexpcompany_ids: []
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
