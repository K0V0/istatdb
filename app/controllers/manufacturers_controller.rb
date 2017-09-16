class ManufacturersController < ApplicationController

    before_action(only: [:index, :search, :show, :administrative]) {
      searcher_for(
      	object: Manufacturer.preload_items,
        autoshow: false,
        paginate: true,
        preload: [:impexpcompanies, :impexpcompany_manufacturers]
      ); 
    }

    before_action :load_vars, only: [:new, :create, :edit, :update, :edit_details]
    before_action :loads_for_search_panel, only: [:index, :search, :show, :administrative]

    def edit_details
    	@record = Manufacturer.find(params[:id])
    	# association needs to be builded before use in form
    	# using nested attributes in model
    	@record.impexpcompany_manufacturers.each do |im|
    		im.build_local_taric if im.local_taric.nil?
    	end
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
        impexpcompany_ids: [],
        #impexpcompany_manufacturers_attributes: [:id, :impexpcompany_id, :manufacturer_id],
        #impexpcompany_manufacturer_ids: []
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
		@incoterms = Incoterm.all
		@local_tarics = LocalTaric.all
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
