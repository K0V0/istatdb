class TaskType < ActiveRecord::Base

    include Defaults

    has_many :tasks, inverse_of: :task_type

end
