class ManufacturersController < ApplicationController

  	private

  	def _searcher_settings
  		{
  			object: Manufacturer.preload_items,
        	autoshow: false,
        	paginate: true
        }
  	end

    def _allowed_params
        [
            :id,
            :name,
            impexpcompanies_attributes: [:id, :company_name],
            impexpcompany_ids: []
        ]
    end

    def _loads_for_search_panel
		@impexpcompanies = Impexpcompany.all.default_order
	end

	def _load_vars
		@impexpcompanies = Impexpcompany.all
		@incoterms = Incoterm.all
		@local_tarics = LocalTaric.all
	end

	def _around_create_after_save_ok
		@record.impexpcompany_manufacturers.each do |r|
            logger r.id, "man create impexps"
			r.added_or_modded_by_user = true
			r.save
		end
		redirect_to(edit_details_manufacturer_path(@record.id))
		return false
	end

    def _around_update_after_save_ok
        @record.impexpcompany_manufacturers.each do |r|
            logger "man update impexps"
            r.added_or_modded_by_user = true
            r.save
        end
    end

    ### OVERRIDES

    def index_action
        super
        @collection = Manufacturer.preload_items.default_order
    end

    def show_action
        super
        @for_impexpcompaniestable = @record.impexpcompany_manufacturers.preload(:impexpcompany, :incoterm, :trade_type)
        @for_goodstable = @record.goods.preload(:local_taric)
        @for_tarictable = @for_goodstable.select('distinct "goods"."local_taric_id"')
    end

    def update_action_2
        # override to decide which submit button was clicked
        # save or make additional changes and proceed to next form
        saved = @record.update(permitted_params)
        if params.has_key?(:edit_other_details) && saved
            if @record.impexpcompanies.length > 0
                redirect_to edit_details_manufacturer_path(@record.id)
            else
                # dont go to next form if no clients selected for this manufacturer
                render "new"
            end
        elsif !params.has_key?(:edit_other_details) && saved
            redirect_to action: :index
        else
            render "new"
        end
        _around_update_after_save_ok if saved
    end

end
