class ManufacturersController < ApplicationController

  	private

  	def searcher_settings
  		{ 
  			object: Manufacturer.preload_items,
        	autoshow: false,
        	paginate: true
        }
  	end

  	def index_action
	  @collection = Manufacturer.preload_items.default_order
	end

	def show_action
		super
		@for_goodstable = @record.goods.preload(:local_taric)
		@for_tarictable = @for_goodstable.select('distinct "goods"."local_taric_id"')
	end

    def permitted_params
      params[:manufacturer].permit(
      	:id,
        :name,
        impexpcompanies_attributes: [:id, :company_name],
        impexpcompany_ids: []
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

	# spravit aroud update tiez oznacit riadky v tabulke ako spraveny zasah pouzivatelom

end
