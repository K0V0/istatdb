class ApplicationController < ActionController::Base

  require 'mem'

  include HashExtras
  include RansackSearchWrapper
  include SelectOnSearched
  include ClassOnInputWithError
  include Log

  protect_from_forgery with: :exception

  before_action() {

    @ivp_name = "@#{controller_name.pluralize.underscore}"
    @ivs_name = "@#{controller_name.singularize.underscore}"
    @model = controller_name.classify.constantize

    @MEM = Mem.new(session) if !defined? @MEM

    @administrative_mode = controller_mem_get :administrative

    remember_param :page    ## page number
    remember_param :q       ## search
    remember_sortlink       ## sort link direction

  }

  before_action(only: [:index, :search, :administration]) {
     @body_class = "noscroll"
  }

  before_action :index_action, only: :index

  before_action :search_action, only: :search

  before_action :new_action, only: :new

  before_action :show_action, only: :show

  before_action :edit_action, only: :edit

  
  def index_action
    instance_variable_set(
      @ivp_name,
      @model.all
    )
  end

  def search_action
    
  end

  def new_action
      instance_variable_set(
        @ivs_name,
        @model.new
      )
  end

  def show_action
    instance_variable_set(
      @ivs_name, 
      @model.find(params[:id])
    )
  end

  def create_action permitted_params_obj
    instance_variable_set(
      @ivs_name,
      @model.new(permitted_params_obj)
    )
    if instance_variable_get(@ivs_name).save
      redirect_to public_send("#{controller_name.pluralize}_path")
    else
       render "new"
    end
  end

  def edit_action
      instance_variable_set(
          @ivs_name,
          @model.find(params[:id])
      )
  end

  def update_action permitted_pars
    tmp = edit_action
    if tmp.update(permitted_pars)
       redirect_to controller: controller_name, action: 'index'
    else
        render "new"
    end
  end

  def delete_action
    tmp = edit_action
    tmp.destroy
  end

  def createeeee nullize: [], nullize_ransack: []
    instance_variable_set(
      @ivs_name,
      @model.new(permitted_pars)
    )
    if instance_variable_get(@ivs_name).save
      if !params[:create_and_next].blank?
        tmp = @model.new
        tmp.attributes = instance_variable_get(@ivs_name).attributes.except('id')
        nullize.each do |var|
          tmp.send(var.to_s+"=", nil)
        end
        instance_variable_set(
          @ivs_name,
          tmp
        )
        reload_tables_for_select
        render "new"
      else
        nullize_ransack.each do |var|
          @MEM.search[var] = nil if @MEM.search
        end
        redirect_to controller: controller_name, action: 'index' #, q: @MEM.search
      end
    else
      reload_tables_for_select
      render "new"
    end
  end


  def index

  end

  def search
    render 'index'
  end

  def show
    
  end

  def edit
    render "new"
  end

  def create
    
  end

  def update

  end

  def delete
    delete_action
    respond_to do |format|
      format.js { render "index" }
      format.html { redirect_to controller_name.underscore.downcase.to_sym }
    end
  end

  def administration
    administrative_set true
    render 'index'
  end

  def leave_administration
    administrative_set false
    redirect_to controller_name.underscore.downcase.to_sym
  end

  private

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

  def administrative_set bool
    controller_mem_set :administrative, bool
    @administrative_mode = bool
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
