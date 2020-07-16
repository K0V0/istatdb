class IssuesController < ApplicationController

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
        if !@impexpcompany_filter.blank?
            @for_goodstable = @record.goods
                .joins(:impexpcompanies)
                .where(impexpcompanies: { id: @impexpcompany_filter })
                .order(ident: :asc)
                .distinct
        else
            @for_goodstable = @record.goods
        end
    end

end
