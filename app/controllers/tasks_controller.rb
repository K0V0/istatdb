class TasksController < ApplicationController

    def change_status
        done = params.has_key?(:task) ? true : false
        @result.find(params[:id]).update({ done: done })
        #custom_render :index
        redirect_to tasks_path
    end

    private

    def _parent_controller
        :others
    end

    def _allowed_params
        [
            :id,
            :task,
            :user_id,
            :task_type_id,
            task_type_attributes: [:typ, :allow_search_as_new]
        ]
    end

    def _load_vars
        @task_types = TaskType.all
    end

    def _around_new
        build_if_empty :task_type
    end

    def _around_create_after_save_failed
        build_if_empty :task_type
    end

    def _around_do_add_another
        @record.task = ""
        build_if_empty :task_type
    end

end
