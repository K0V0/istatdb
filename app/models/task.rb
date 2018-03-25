class Task < ActiveRecord::Base

    include Defaults

    belongs_to :user, inverse_of: :tasks

    belongs_to :task_type, inverse_of: :tasks
    accepts_nested_attributes_for(
        :task_type,
        reject_if: lambda { |c|
            c[:allow_search_as_new] == "0" || c[:allow_search_as_new].blank?
        }
    )

    scope :default_order, -> {
        order(created_at: :asc)
    }

    scope :done_filter, -> (pars) {
        logger pars, "par"
        #self
        #.where(done: true)
    }

    def self.ransackable_scopes(*pars)
        %i(done_filter)
    end


end
