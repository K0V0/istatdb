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

        @goods = Good
            .includes([{local_taric: [:translations]}, :manufacturers, :issues, :good_images])
            .ransack(ident_or_description_cont: par)
            .result
            .order('ident ASC')
            .page(params[:goods_page])

        @manufacturers = Manufacturer
            .preload_items
            .ransack(name_cont: par)
            .result
            .page(params[:manufacturers_page])

        @local_tarics = LocalTaric
            .with_translations(I18n.locale)
            .ransack(kncode_start_or_translations_description_cont: par)
            .result
            .order('kncode ASC')
            .page(params[:local_taric_page])

        load_counts
        render "index"
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
