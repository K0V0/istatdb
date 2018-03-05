class ApplicationController < ActionController::Base

  include ApplicationConcern
  include ApplicationAbstract
  #include BeforeRender
  include RansackSearchWrapper
  include Log
  include MemHelper

  protect_from_forgery with: :exception

  def initialize
    super
    @model = model_exist?
  end

  before_action :authenticate_user!

  before_action :user_logged_and_model_exist?

  before_action :task_banned_for_user?

  before_action :inits

  before_action(
  	only: [:index, :search, :show, :administrative],
  	if: -> { @user_logged_and_model_exist }) {
    searcher_for(
    	searcher_settings
    )
  }

  before_action(
    :generate_form_url,
    only: [:new, :edit, :create, :update],
    if: -> { !@task_banned_for_user }
  )

 # before_action(
  #	:index_action,
  #	only: :index,
  #	if: :user_logged_and_model_exist?
  #)

  #before_action(
  #	:search_action,
  #	only: :search,
  #	if: :user_logged_and_model_exist?
  #)

  #before_action(
  #	:administrative_action,
  #	only: :administrative,
  #	if: -> { user_logged_and_model_exist? && !task_banned_for_user? }
  #)

  #before_action(
  #	:end_administrative_action,
  #	only: :end_administrative,
  #	if: -> { user_logged_and_model_exist? && !task_banned_for_user? }
  #)

  #before_action(
  #	:show_action,
  #	only: :show,
  #	if: :user_logged_and_model_exist?
  #)

  #before_action(
  #	:new_action,
  #	only: :new,
  #	if: -> { user_logged_and_model_exist? && !task_banned_for_user? }
  #)

  #before_action(
  #	:create_action,
  #	only: :create,
  #	if: -> { user_logged_and_model_exist? && !task_banned_for_user? }
  #)

  #before_action(
  #	:edit_action,
  #	only: :edit,
  	#if: -> { user_logged_and_model_exist? && !task_banned_for_user? }
  #)

  #before_action(
  #  :update_action,
   # only: :update,
   # if: -> { user_logged_and_model_exist? && !task_banned_for_user? }
  #)

  #before_action(
  #	:destroy_action,
  #	only: [:destroy, :delete],
  #	if: -> { user_logged_and_model_exist? && !task_banned_for_user? }
  #)

  before_action(
  	:load_vars,
  	only: [:new, :edit, :edit_multiple, :update, :update_multiple, :create],
  	if: -> { @user_logged_and_model_exist }
  )

  before_action(
  	:loads_for_search_panel,
  	only: [:index, :search, :show, :administrative],
  	if: -> { @user_logged_and_model_exist }
  )

  #before_action(
  #	:apicall_search_action,
  #	only: :new_select_search,
  #	if: :user_logged_and_model_exist?
  #)

  #before_action(
  	#:apicall_exist_action,
  	#only: :check_existence,
  	#if: :user_logged_and_model_exist?
  #)

  before_action(
  	:remember_allow_search_as_new,
  	only: [:new, :edit, :update, :create, :update_multiple, :edit_multiple],
  	if: -> { @user_logged_and_model_exist }
  )

  #before_action :task_banned_for_user?

  def index
    index_action if @user_logged_and_model_exist
  	render "#{@render_command_prepend}index"
  end

  def search
    search_action if @user_logged_and_model_exist
    render "#{@render_command_prepend}index"
  end

  def show
    show_action if @user_logged_and_model_exist
  	render "#{@render_command_prepend}show"
  end

  def new
    new_action if @user_logged_and_model_exist && !@task_banned_for_user
  	render(@task_banned_for_user ? "" : "#{@render_command_prepend}new")
  end

  def create
    if !@task_banned_for_user
      create_action
      create_action_2
    end
  end

  def edit
    edit_action if @user_logged_and_model_exist && !@task_banned_for_user
    render(@task_banned_for_user ? "" : "#{@render_command_prepend}new")
  end

  def update
    if !@task_banned_for_user
      update_action
      update_action_2
    end
  end

  def delete
    destroy_action if @user_logged_and_model_exist && !@task_banned_for_user
  end

  def destroy
    destroy_action if @user_logged_and_model_exist && !@task_banned_for_user
  end

  def new_select_search
    apicall_search_action if @user_logged_and_model_exist && !@task_banned_for_user
  end

  def check_existence
    apicall_exist_action if @user_logged_and_model_exist
  end

  def administrative
  	render "#{@render_command_prepend}index"
    administrative_action if @user_logged_and_model_exist && !@task_banned_for_user
  end

  def end_administrative
  	redirect_to action: "index"
    end_administrative_action if @user_logged_and_model_exist && !@task_banned_for_user
  end

  private

  def inits
    User.current = current_user
  	init_mem
    @body_class = "#{action_name} #{controller_name}"
    @body_class += " noscroll" if (action_name == 'index')||(action_name == 'search')
    @body_class += " tride" if setting_is_set?(:gui_enable_3d)
    params[:per] = setting(:gui_per_page)
    remember_param :page    ## page number
    remember_param :q       ## search
    remember_sortlink       ## sort link direction
    is_subsection_of
  end

  def index_action
  end

  def search_action
  end

  def administrative_action
  	controller_mem_set("is_in_administrative", true)
  end

  def end_administrative_action
  	controller_mem_set("is_in_administrative", false)
  end

  def show_action
    @record = @model.find(params[:id])
  end

  def new_action
    @record = @model.new
    around_new
  end

  def create_action
    @record = @model.new(permitted_params)
    around_create
  end

  def create_action_2
    saved = @record.save
    around_create_after_save
    if saved
      continue = around_create_after_save_ok
      if continue != false
        if params.has_key? :add_next
          if params[:add_next] == '1'
            @record = @record.dup
            around_do_add_another
            render "#{@render_command_prepend}new"
            continue = false
          end
        end
      end
      redirect_to public_send("#{controller_name.pluralize}_path") if continue != false
    else
      around_create_after_save_failed
      render "#{@render_command_prepend}new"
    end
  end

  def edit_action
    show_action
    around_edit
  end

  def update_action
    @record = @model.find(params[:id])
  end

  def update_action_2
    around_update
    saved = @record.update(permitted_params)
    around_update_after_save
    if saved
      around_update_after_save_ok
      redirect_to controller: controller_name, action: 'index'
    else
      around_update_after_save_failed
      render "#{@render_command_prepend}new"
    end
  end

  def destroy_action
    @model.find(params[:id]).destroy
    redirect_to controller: controller_name, action: 'index'
  end

  def apicall_search_action
    searcher_for(autoshow: false)
    if params.has_key? :association_type
  		parent_rec_id = (params[:window_id].match(/([0-9]+)$/))[1].to_i
  		parent_obj = params[:source_controller].classify.constantize.new
  		if params[:association_type] == "belongs_to"
	  		parent_obj.send("build_#{params[:model]}")
	  	else

	  	end
	  	instance_variable_set(
  			"@#{params[:source_controller]}",
  			parent_obj
  		)
  		apicall_render(params[:association_type])
  	else
  		head :ok
  	end
  end

  def apicall_exist_action
  	@results_count = controller_name.classify.constantize
  		.where("#{params[:field].to_s} LIKE ?", "#{params[:text]}")
  		.size

  	respond_to do |format|
  		format.js { render('layouts/shared/new_edit_form/record_exist') }
  	end
  end

end
