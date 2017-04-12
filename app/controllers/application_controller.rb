class ApplicationController < ActionController::Base

  include ApplicationConcern
  #include BeforeRender
  include RansackSearchWrapper

  protect_from_forgery with: :exception

  def initialize
    super
    @model = model_exist?
  end

  before_action :index_action, only: :index

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

  private

  def index_action
    @collection = @model.all if @model
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

  def around_update
  end

  def around_update_after_save
  end

  def load_vars
  end

  def load_new_edit_vars
  end

  def load_create_update_vars
  end

end
