class ManufacturersController < ApplicationController

    before_action(only: [:index, :search, :show, :administration]) {
      searcher_for(
        autoshow:false,
        paginate: true#,
        #preload: [:impexpcompanies, :impexpcompany_manufacturers]
      ); 
    }

    #before_action :form_searchfields_vars, only: [:new, :edit, :update, :update_details]

   #before_action(only: :create) { 
      #createeeee(
       # nullize: [:name], 
      #  nullize_ransack: [:name_cont]
      #)
    #}

    def show
      #if 
      @manufacturer_goods = @manufacturer.goods
        .joins(:impexpcompanies)
        .preload(:impexpcompanies)
        #.where("impexpcompanies.id = ?", 4)
      @manufacturer_local_tarics = @manufacturer.goods
        .joins(:impexpcompanies, :local_taric)
        .includes(:local_taric)
        .order('local_tarics.kncode ASC')
        .collect(&:local_taric)
        .uniq
    end

  	def new
      if !@MEM.q_manufacturer.blank?
        @manufacturer.assign_attributes(
          name: 
            @MEM.q_manufacturer[:name_cont],
          impexpcompany_company_name:
            @impexpcompanies.where(id: @MEM.q_manufacturer[:impexpcompany_filter]).first.try(:company_name),
        )
      end
  	end

    def edit
      @impexpcompanies_associated = @manufacturer.impexpcompanies.order(:company_name)
    end

    def update
      @manufacturer = Manufacturer.find(params[:id])
      @manufacturer.update(permitted_pars)
      if params[:edit_attrs]
        @impexpcompany_manufacturer = @manufacturer.impexpcompany_manufacturers
            .where(impexpcompany_id: params[:edit_impexpcompany_manufacturer][:impexpcompany_id])
            .first
        render "manufacturers/edit/edit_details"
      else
        redirect_to manufacturers_path
      end
    end

    def update_details
      @impexpcompany_manufacturer = ImpexpcompanyManufacturer.find(params[:id])
      if @impexpcompany_manufacturer.update(permitted_pars_props)
        if params[:go_to_index]
          redirect_to manufacturers_path
        else
          redirect_to edit_manufacturer_path(@impexpcompany_manufacturer.manufacturer_id)
        end
      else
         render "manufacturers/edit/edit_details"
      end
    end

    def csv_export
    
    end

    def new_select_search
      apicall_render(:has_many)
    end

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

    def permitted_pars_props
      params[:impexpcompany_manufacturer].permit(
        :local_taric_kncode,
        :local_taric_description,
        :incoterm
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
