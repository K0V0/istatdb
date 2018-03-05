class Change < ActiveRecord::Base

    include Defaults

    scope :default_order, -> {
        order(version_num: :asc)
    }

end
