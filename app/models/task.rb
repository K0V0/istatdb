class Task < ActiveRecord::Base

    include Defaults

    belongs_to :user, inverse_of: :tasks

    scope :default_order, -> {
        order(created_at: :asc)
    }

end
