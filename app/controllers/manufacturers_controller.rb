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
		@impexpcompanies = Impexpcompany.all.default_order
		@incoterms = Incoterm.includes(:translations).all.default_order
		@local_tarics = LocalTaric.includes(:translations).all.default_order
	end

	def _around_create_after_save_ok
		@record.impexpcompany_manufacturers.each do |r|
			r.added_or_modded_by_user = true
			r.save
		end
        if params.has_key?(:edit_other_details)
            redirect_to(edit_details_manufacturer_path(@record.id))
            return false
        end
	end

    def _around_update_after_save_ok
        @record.impexpcompany_manufacturers.each do |r|
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
        @for_impexpcompaniestable =
            @record
            .impexpcompany_manufacturers
            .includes(:impexpcompany, :incoterm, :trade_type, :local_taric)
            .order('impexpcompanies.company_name ASC')
        @for_goodstable = @record
            .goods
            .includes(:local_taric)
            .order('goods.ident ASC')
        @for_tarictable = @record
            .goods
            .includes(local_taric: [:translations])
            .select('distinct "goods"."local_taric_id"')
            #.order('local_tarics.kncode ASC')
            #.sort { |value1, value2| value2.kncode <=> value1.kncode }
            #.includes(local_taric: [:translations])
            #.select('distinct "goods"."local_taric_id"')
            #.order('local_tarics.kncode ASC')
    end

    def update_action_2
        # override to decide which submit button was clicked
        # save or make additional changes and proceed to next form
        saved = @record.update(permitted_params)
        logger params.has_key?(:edit_other_details), "phk"
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
