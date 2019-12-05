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
            good_issue_files_attributes: [:id, :_destroy, :file, :file_cache]
        ]
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

end
