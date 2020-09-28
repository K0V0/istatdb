class SearchersController < ApplicationController

    skip_filter *_process_action_callbacks.map(&:filter)

    before_action :inits
    before_action :set_path_back

    def index
        search
    end

    def search
        q = params[:q]
        par = q.nil? ? "" : q[:search_cont]

        if !par.blank?
            goods_first1_ids = Good
                .ransack(ident_start: par)
                .result
                .order('ident ASC')
                .limit(800)
                .ids
            goods_first2_ids = Good
                .ransack(description_start: par)
                .result
                .order('ident ASC')
                .limit(800)
                .ids
            goods_first_ids = goods_first1_ids | goods_first2_ids

            manufacturers_first_ids = Manufacturer
                .ransack(name_start: par)
                .result
                .order('name ASC')
                .limit(1600)
                .ids
        else
           goods_first_ids, manufacturers_first_ids = [], []
        end

        @goods = Good
            .includes([{local_taric: [:translations]}, {uoms: [:uom_type]}, :manufacturers, :issues, :good_images])
            .ransack(ident_or_description_cont: par)
            .result
            .order_as_specified(id: goods_first_ids)
            .order('ident ASC')
            .page(params[:goods_page])

        @manufacturers = Manufacturer
            .preload_items
            .ransack(name_cont: par)
            .result
            .unscope(:order)
            .order_as_specified(id: manufacturers_first_ids)
            .order('name ASC')
            .page(params[:manufacturers_page])

        @local_tarics = LocalTaric
            .with_translations(I18n.locale)
            .ransack(kncode_start_or_translations_description_cont: par)
            .result
            .order('kncode ASC')
            .page(params[:local_tarics_page])

        load_counts
        render "index"
    end

    def add
        
    end

    private

    def load_counts
        @counts = {
            goods: @goods.total_count,
            manufacturers: @manufacturers.total_count,
            local_tarics: @local_tarics.total_count
        }
    end

end
