class ApplicationController < ActionController::Base

  require 'mem'

  include HashExtras
  include RansackSearchWrapper
  include SelectOnSearched
  include ClassOnInputWithError
  include Log

  protect_from_forgery with: :exception

  before_action :mem

  before_action :administrative_mode

  before_action :body_noscroll, only: [:index, :search, :administration]

  before_action :new_action, only: :new

  before_action :edit_action, only: :edit

  before_action :load_q_from_mem, only: [:index, :administration]

  before_action :load_q_to_mem, only: [:search, :show]

  before_action :load_page_to_mem, only: [:index, :search]

  def mem
    @MEM = Mem.new(session) if !defined? @MEM 
  end

  def body_noscroll
    @body_class = "noscroll"
  end

  def administrative_mode
    @MEM.administrative_mode = true if params[:enter_administrative]
    if params[:leave_administrative] || (@MEM.kontroler != controller_name)
      @MEM.administrative_mode = nil 
    end
    @administrative_mode = @MEM.administrative_mode
    @MEM.kontroler = controller_name
  end

  def load_q_from_mem
    params[:q] = @MEM.search
  end

  def load_q_to_mem
    @MEM.search = (params[:q] if params.has_key?(:q))
  end

  def load_page_to_mem
    @MEM.page = (params.has_key?(:page) ? params[:page] : nil)
  end

  #def load_page_from_mem
  #  params.merge(page: @MEM.page)
  #end

  def new_action
      instance_variable_set(
        '@'+controller_name.singularize,
        controller_name.classify.constantize.new
      )
  end

  def create_action permitted_params_obj
    instance_variable_set(
      '@'+controller_name.singularize.underscore,
      controller_name.classify.constantize.send(:new, permitted_params_obj)
    )
    if instance_variable_get('@'+controller_name.singularize).send(:save)
      redirect_to public_send("#{controller_name.pluralize}_path")
    else
       render "new"
    end
  end

  def edit_action
      instance_variable_set(
          '@'+controller_name.singularize.underscore,
          controller_name.classify.constantize.send(:find, params[:id])
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
    var_name = '@'+controller_name.singularize.underscore
    instance_variable_set(
      var_name,
      controller_name.classify.constantize.send(:new, permitted_pars)
    )
    if instance_variable_get(var_name).send(:save)
      if !params[:create_and_next].blank?
        tmp = controller_name.classify.constantize.send(:new)
        tmp.attributes = instance_variable_get(var_name).attributes.except('id')
        nullize.each do |var|
          tmp.send(var.to_s+"=", nil)
        end
        instance_variable_set(
          var_name,
          tmp
        )
        reload_tables_for_select
        render "new"
      else
        nullize_ransack.each do |var|
          @MEM.search[var] = nil if @MEM.search
        end
        redirect_to controller: controller_name, action: 'index', q: @MEM.search
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
    render 'index'
  end

end
