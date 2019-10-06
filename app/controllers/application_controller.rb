class ApplicationController < ActionController::Base

  #include Devise::Controllers::Helpers
  include ApplicationConcern
  include ApplicationAbstract
  include BeforeRender
  include RansackSearchWrapper
  include Log
  include MemHelper

  #protect_from_forgery with: :exception

  def initialize
    super
    @model = model_exist?
  end

  before_action :authenticate_user!

  before_action :user_logged_and_model_exist?

  before_action :task_banned_for_user?

  before_action :inits

  before_action :convert_params_to_date

  before_render :last_visited_set, only: [:show]

  before_render :last_visited_get, only: [:index, :search, :show, :administrative, :export]

  before_action(
    only: [:index, :search, :show, :administrative, :change_status],
    if: -> { @user_logged_and_model_exist }) {
    _before_db_load
  }

  before_action(
  	only: [:index, :search, :show, :administrative, :change_status, :export],
  	if: -> { @user_logged_and_model_exist }) {
    searcher_for(
    	_searcher_settings
    )
  }

  before_action(
    :set_path_back,
    except: [:new, :edit, :create, :update, :show, :check_existence, :new_select_search, :edit_details, :new_select_load_items]
  )

  before_action(
    :generate_form_url,
    only: [:new, :edit, :create, :update],
    if: -> { !@task_banned_for_user }
  )

  before_action(
  	:remember_allow_search_as_new,
  	only: [:new, :edit, :update, :create, :update_multiple, :edit_multiple],
  	if: -> { @user_logged_and_model_exist }
  )

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
      watch_if_allowed do
          new_action if @user_logged_and_model_exist
          render("#{@render_command_prepend}new")
      end
  end

  def create
    watch_if_allowed do
      create_action
      create_action_2
    end
  end

  def edit
    watch_if_allowed do
      edit_action if @user_logged_and_model_exist
      render("#{@render_command_prepend}new")
    end
  end

  def update
    watch_if_allowed do
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

  def new_select_load_items
    apicall_search_action if @user_logged_and_model_exist && !@task_banned_for_user
  end

  def new_select_add_items
    apicall_add_next_action if @user_logged_and_model_exist && !@task_banned_for_user
  end

  def check_existence
    apicall_exist_action if @user_logged_and_model_exist
  end

  def administrative
    watch_if_allowed do
      administrative_action if @user_logged_and_model_exist
      render "#{@render_command_prepend}index"
    end
  end

  def end_administrative
  	redirect_to action: "index"
    end_administrative_action if @user_logged_and_model_exist && !@task_banned_for_user
  end

  private

  def inits
    User.current = current_user
  	init_mem
    _before_inits
    @body_class = "#{action_name} #{controller_name}"
    @body_class += " noscroll" if (action_name == 'index')||(action_name == 'search')
    @body_class += " tride" if setting_is_set?(:gui_enable_3d)
    @items_table_class = ""
    @items_table_class += "searchbar_pinned" if setting_is_set?(:gui_pin_searchbar)
    params[:per] = setting(:gui_per_page)
    remember_param :page    ## page number
    remember_param :q       ## search
    remember_sortlink       ## sort link direction
    is_subsection_of(parent_controller: _parent_controller)
  end

  def index_action
    _loads_for_search_panel
  end

  def search_action
    _loads_for_search_panel
  end

  def administrative_action
    _loads_for_search_panel
  	controller_mem_set("is_in_administrative", true)
  end

  def end_administrative_action
  	controller_mem_set("is_in_administrative", false)
  end

  def show_action
    @record = @model.find(params[:id])
    _loads_for_search_panel
  end

  def new_action
    @record = @model.new
    _load_vars
    _around_new
  end

  def create_action
    @record = @model.new(permitted_params)
    _load_vars
    _around_create
  end

  def create_action_2
    saved = @record.save
    _around_create_after_save
    if saved
      continue = _around_create_after_save_ok
      if continue != false
        if params.has_key? :add_next
          if params[:add_next] == '1'
            @record = @record.dup
            flash.now[:item_added] = t('actions.added_successfully')
            _around_do_add_another
            render "#{@render_command_prepend}new"
            continue = false
          end
        end
      end
      #redirect_to public_send("#{controller_name.pluralize}_path") if continue != false
      redirect_to get_path_back if continue != false
    else
      _around_create_after_save_failed
      render "#{@render_command_prepend}new"
    end
  end

  def edit_action
    show_action
    _load_vars
    _around_edit
  end

  def update_action
    @record = @model.find(params[:id])
    _load_vars
  end

  def update_action_2
    _around_update
    saved = @record.update(permitted_params)
    _around_update_after_save
    if saved
      _around_update_after_save_ok
      #redirect_to controller: controller_name, action: 'index'
      redirect_to get_path_back
    else
      _around_update_after_save_failed
      render "#{@render_command_prepend}new"
    end
  end

  def destroy_action
    sucess = @model.find(params[:id]).destroy
    searcher_for(_searcher_settings)
    index_action
    respond_to do |format|
      format.js {
        flash.now[:cannot_destroy] = t('notices.cannot_destroy') if !sucess
        #flash[:destroy_ok] = t('notices.destroy_ok') if sucess
        render "#{@render_command_prepend}index"
      }
      #format.html { redirect_to(controller: controller_name, action: 'index'), notice: "Order was successfully deleted" }
    end
    #flash.now[:alert] = t("uploading_error")
    ### len 1 request, bez now 2 requesty vydrzi
  end

  def apicall_search_action

    rndr = true
    if action_name == "new_select_search"
      # akcia vyhladavania - input do text pola
      if params[:per_page].blank?
        # widget natahujuci vsetko
        searcher_for(autoshow: false)
      else
        # widget bude strankovany
        params[:page] = 1
        searcher_for(autoshow: false, paginate: true)
      end
    elsif action_name == "new_select_load_items"
      # akcia len natahovania dalsieho obsahu
      params[:page] = params[:loaded_page].to_i + 1
      params[:per] = params[:per_page]
      searcher_for(autoshow: false, paginate: true, not_load_ids: params[:checked])
      rndr = false if @result.blank?
    end

    if ((params.has_key? :association_type) && rndr)
  		parent_rec_id = (params[:window_id].match(/([0-9]+)$/))[1].to_i
      ## pouzit parent rec id
  		parent_obj = params[:source_controller].classify.constantize.new
      ### zleeeeeeee (dobre len pri update)
      parent_obj.id = parent_rec_id

  		if params[:association_type] == "belongs_to"
	  		parent_obj.send("build_#{params[:model]}")
	  	else
        #assocs = params[:model].classify.constantize.send(:find, params[:checked])
        #logger(assocs.size)
        #parent_obj.send("#{params[:model].to_s.pluralize}").send("build")
	  	end
	  	instance_variable_set(
  			"@#{params[:source_controller]}",
  			parent_obj
  		)

      ## nepridava asociacie
      #logger(instance_variable_get("@#{params[:source_controller]}").send("#{params[:model].to_s.pluralize}").size)
      #logger(params[:checked])

  		apicall_render(params[:association_type])
  	else
  		head :ok
  	end
  end

  def apicall_exist_action
  	@results = controller_name.classify.constantize
  		.where("#{params[:field].to_s} LIKE ?", "#{params[:text]}")
  	@results_count = @results.size
    @result = @results.first
  	respond_to do |format|
  		format.js { render('layouts/shared/new_edit_form/record_exist') }
  	end
  end

end
