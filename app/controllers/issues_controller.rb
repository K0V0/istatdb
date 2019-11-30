class IssuesController < ApplicationController

    private

    def _searcher_settings
        { paginate: true, autoshow: false }
    end

    def _parent_controller
        :others
    end

    def _allowed_params
        [
            :id,
            :name,
            :note
        ]
    end

end
