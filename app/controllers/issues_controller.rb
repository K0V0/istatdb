class IssuesController < ApplicationController

    def export
        @for_export = Issue.find(params[:id]).goods
        @export_options = {
            only_uncomplete: params[:only_uncomplete],
            impexpcompany_filter: controller_mem_get(:q).try(:[], :impexpcompany_filter)
        }
        render 'others/issues/export'
    end

    ### OVERRIDE
    def do_export
        @for_export = select_goods(
            Issue.find(params[:id]),
            controller_mem_get(:q).try(:[], :impexpcompany_filter)
        )
        if (p = params[:only_uncomplete].true?)
            @for_export = @for_export.where(uncomplete: p)
        end
        super
    end

    private

    def _searcher_settings
        {
            paginate: true,
            autoshow: false,
            preload: [
                :impexpcompanies,
                :goods
            ]
        }
    end

    def _parent_controller
        :others
    end

    def _allowed_params
        [
            :id,
            :name,
            :note,
            :season,
            good_issue_files_attributes: [:id, :_destroy, :file, :file_cache, :note]
        ]
    end

    def _loads_for_search_panel
        @impexpcompanies = Impexpcompany.all.default_order
    end

    def _around_new
        build_if_empty :good_issue_files
    end

    def _around_create_after_save_failed
        build_if_empty :good_issue_files
    end

    def _around_edit
        build_if_empty :good_issue_files
    end

    def _around_update_after_save_failed
        build_if_empty :good_issue_files
    end

    ### override
    def show_action
        super
        @impexpcompany_filter = controller_mem_get(:q).try(:[], :impexpcompany_filter)
        @for_goodstable = select_goods(@record, @impexpcompany_filter)
    end

    def select_goods(obj, impexp_filter)
        if !impexp_filter.blank?
            return obj.goods
                .joins(:impexpcompanies)
                .where(impexpcompanies: { id: impexp_filter })
                .order(ident: :asc)
                .distinct
        else
            return obj.goods
        end
    end

end
