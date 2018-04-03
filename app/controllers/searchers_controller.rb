class SearchersController < ApplicationController

    skip_filter *_process_action_callbacks.map(&:filter)

    before_action :inits

    def index

        @goods = Good.all
            .includes(:local_taric)
            .default_order
            .page(params[:goods_page])

        @manufacturers = Manufacturer
            .preload_items
            .page(params[:manufacturers_page])

        @local_tarics = LocalTaric.all
            .includes(:translations)
            .page(params[:local_taric_page])
    end

    def search

        q = params[:q]

        @goods = Good
            .ransack(ident_or_description_cont: q[:search_cont])
            .result
            .page(params[:goods_page])

        @manufacturers = Manufacturer
            .ransack(name_cont: q[:search_cont])
            .result
            .page(params[:manufacturers_page])

        @local_tarics = LocalTaric
            .with_translations(I18n.locale)
            .ransack(kncode_start_or_translations_description_cont: q[:search_cont])
            .result
            .page(params[:local_taric_page])

        render "index"
    end

end
