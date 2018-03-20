class Task < ActiveRecord::Base

    belongs_to :user, inverse_of: :tasks

end
