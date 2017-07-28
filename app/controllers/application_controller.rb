class ApplicationController < ActionController::Base

  include ApplicationConcern
  #include BeforeRender
  include RansackSearchWrapper

  protect_from_forgery with: :exception

  def initialize
    super
    @model = model_exist?
  end

  before_action() {
    @MEM = Mem.new(session) if !defined? @MEM

    @body_class = "noscroll" if action_name == 'index'
    remember_param :page    ## page number
    remember_param :q       ## search
    remember_sortlink       ## sort link direction
  }

  before_action :index_action, only: :index

  before_action :administrative_action, only: :administrative

  before_action :end_administrative_action, only: :end_administrative

  before_action :show_action, only: :show

  before_action :new_action, only: :new

  before_action :create_action, only: :create

  before_action :edit_action, only: [:edit, :update]

  before_action :destroy_action, only: :destroy

  before_action :load_vars, only: [:new, :edit, :update, :create]

  before_action :apicall_search_action, only: :new_select_search

  def index
  end

  def search
    render "index"
  end

  def show
  end

  def new 
  end

  def create
    create_action_2
  end

  def edit
    render "new"
  end

  def update
    update_action_2
  end

  def delete
  end

  def destroy
  end

  def new_select_search
  end

  def administrative
  	render "index"
  end

  def end_administrative
  	redirect_to action: "index"
  end

  private

  def index_action
    @collection = @model.all if @model
  end

  def administrative_action
  	@MEM.is_in_administrative = true
  	@collection = @model.all if @model
  end

  def end_administrative_action
  	@MEM.is_in_administrative = false
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
      redirect_to public_send("#{controller_name.pluralize}_path")
    else
      around_create_after_save_failed
      render "new"
    end
  end

  def edit_action
    show_action
    around_edit
  end

  def update_action_2
    around_update
    saved = @record.update(permitted_params)
    around_update_after_save
    if saved
      redirect_to controller: controller_name, action: 'index'
    else
      around_update_after_save_failed
      render "new"
    end
  end

  def destroy_action
    @model.find(params[:id]).destroy
    redirect_to controller: controller_name, action: 'index'
  end

  def apicall_search_action
    searcher_for(autoshow: false)
  end

  def around_new
  end

  def around_edit
  end

  def around_create
  end

  def around_create_after_save
  end

  def around_create_after_save_failed
  end

  def around_update
  end

  def around_update_after_save
  end

  def around_update_after_save_failed
  end

  def load_vars
  end

  def load_new_edit_vars
  end

  def load_create_update_vars
  end

  def remember_param param
    controller_mem_set(param, params[param]) if params.has_key? param
    params[param] = controller_mem_get(param)
  end

  def remember_sortlink
    if params.deep_has_key? :q, :s
      controller_mem_set :s, params[:q][:s]
    elsif params.has_key? :q && !params[:q].blank?
      params[:q].merge!({ s: controller_mem_get(:s) })
    end
  end

  def controller_mem_set prefix, val
    @MEM.send(
      "#{prefix.to_s}_#{controller_name.singularize.underscore}=",
      val
    )
  end

  def controller_mem_get prefix
    @MEM.send("#{prefix.to_s}_#{controller_name.singularize.underscore}")
  end

end
