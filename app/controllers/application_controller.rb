class ApplicationController < ActionController::Base

  require 'mem'

  include HashExtras
  include RansackSearchWrapper
  include SelectOnSearched
  include ClassOnInputWithError

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :administrative_mode

  before_action :mem

  before_action :body_noscroll, only: [:index, :search, :administration]

=begin
  before_action(only: :administration) { 
    #params[:q] = Rails.cache.read("q")
  }

  before_action(only: [:index, :show]) { 
    #params[:q] = Rails.cache.read("q")
  }

  after_action(only: :search) {
    #Rails.cache.write("q",params[:q])
  }

  after_action(only: :administration) {
    #Rails.cache.write("q",params[:q])
  }
=end

  def mem
    @MEM = Mem.new if !defined? @MEM 
  end

  def body_noscroll
    @body_class = "noscroll"
  end

  def administrative_mode
    @administrative_mode = (params[:administrative_mode] == "true")||(action_name == "administration")
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

  # some DRY for simmilar controllers
  # DRY for "create" action
  def create_action permitted_params_obj
    instance_variable_set(
      '@'+controller_name.singularize,
      controller_name.classify.constantize.send(:new, permitted_params_obj)
    )
    if instance_variable_get('@'+controller_name.singularize).send(:save)
      redirect_to public_send("#{controller_name.pluralize}_path")
    else
       render "new"
    end
  end

  def createeeee nullize: [], nullize_ransack: []
    var_name = ('@'+controller_name.singularize).to_sym
    instance_variable_set(
      var_name,
      controller_name.classify.constantize.send(:new, permitted_pars)
    )
    if instance_variable_get(var_name).send(:save)
      if params[:create_and_next]
        nullize.each do |var|
          instance_variable_get(var_name).send(var.to_s+"=", nil)
        end
        reload_tables_for_select
          render "new"
        else
          nullize_ransack.each do |var|
            @MEM.search[var] = nil
          end
          redirect_to controller: controller_name, action: 'index', q: @MEM.search
      end
    else
      reload_tables_for_select
          render "new"
    end
  end

  # DRY for "new" action
  def new_action
      instance_variable_set(
        '@'+controller_name.singularize,
        controller_name.classify.constantize.new
      )
  end


  def index

  end

  def search
    render 'index'
  end

  def show
    
  end

  def create
    
  end

  def administration
    render 'index'
  end

end
