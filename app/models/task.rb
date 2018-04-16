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

    scope :done_filter, -> (*pars) {
        where(done: false)
        #.order(created_at: :asc)
    }

    scope :type_filter, -> (*pars) {
        Rails.logger.info "-------------------"
        Rails.logger.info *pars
        where(task_type_id: pars)
        #.order(created_at: :asc)
    }

    scope :date_filter, -> (*pars) {
        where("created_at > ?", Date.parse(*pars))
    }

    def self.ransackable_scopes(*pars)
        %i(done_filter date_filter type_filter)
    end

    validates :task, presence: true

end
