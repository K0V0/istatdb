class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :administrative_mode

  before_action(only: :administration) { 
    params[:q] = Rails.cache.read("q")
  }

  before_action(only: [:index, :show]) { 
    #params[:q] = Rails.cache.read("q")
  }

  after_action(only: :search) {
    Rails.cache.write("q",params[:q])
  }

  after_action(only: :administration) {
    Rails.cache.write("q",params[:q])
  }

  def searcher_for object: nil, autoshow: true, default_order: nil, preload: nil, joins: nil

    object ||= controller_name.classify.constantize
    @search = object.ransack(params[:q]) if joins.nil?
    @search = object.joins(joins).ransack(params[:q]) if !joins.nil?
    @search.sorts = default_order if (@search.sorts.empty?&&!default_order.nil?)
    @result = @search.result if preload.nil?
    @result = @search.result.send(:preload, preload) if !preload.nil?


    if  @result.count == 1 && !request.xhr?.nil? && autoshow
    	# if ransack searching during typing ends up showing one result,
    	# and if request is not first page load (request.xhr?.nil? will return nil first time, then only false)
    	# and if option enabled (default yes)
    	# show it in detailed view
    	# set this single result as instance variable (singular form) 
    	# for controller "show" action, then render templates defined for "show" action
    	instance_variable_set('@'+controller_name.singularize, @result.first)
      params[:id] = @result.first.id
    	action_respond_to "show", :js
    else
    	# when item is manually selected
    	# only for show controller actions
    	if !params[:id].nil? && action_name == 'show' 
    		instance_variable_set('@'+controller_name.singularize, @result.find(params[:id]))
    	end	
    end

  end

  def action_respond_to action, *responses
    respond_to do |format|
      responses.each do |response|
        format.send(response) {
          render action
        }
      end
    end
  end

  # DRY for create action
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

  # some DRY for simmilar controllers
  # sets instance variable named as controler according to RoR conventions 
  def new_action
      instance_variable_set(
        '@'+controller_name.singularize,
        controller_name.classify.constantize.new
      )
  end

  # function for selecting records to controller instance variables
  # dependent on what is stored in params[:controller] attributes
  # - perform search based on attribute 
  # - used on select tables in forms when validation failed to load most accurate
  #   results to select table to choose from
  #
  #   field_name: {
  #   param: :<containing parameter from params>,
  #   search_method: :<starts or contains>
  # } 
  def reload_result_by_params(model, **options)
    model ||= controller_name.classify.constantize

    instvar_string = '@' + model.to_s.underscore.pluralize
    query_string = ''
    query_parameters = []
    iterator = 0
    opts_count = options.length

    options.each do |field|

      query_string += field[0].to_s + ' LIKE ?'
      query_string += ' AND ' if (opts_count > 1 && iterator < (opts_count-1))
    
      par = field[1][:param] || field[0]
      search_method = field[1][:search_method] || :starts

      par_string = ''
      par_string += '%' if search_method == :contains
      par_string += params[controller_name.singularize.to_sym][par] || ""
      par_string += '%'

      query_parameters << par_string
      iterator += 1

    end

    result = model.where(query_string, *query_parameters) || model.all
    instance_variable_set(instvar_string, result)
  end

  # model: {
  #   field: :method
  # }
  def reload_result_by_params_nested(**options)
    options.each do |option|
      settings = {}
      option[1].each do |setting|
        settings[setting[0]] = { 
          param: (option[0].to_s.underscore + '_' + setting[0].to_s).to_sym,
          search_method: setting[1]
        }
      end 
      reload_result_by_params(option[0].to_s.constantize, settings)
    end
  end

  def administrative_mode
    @administrative_mode = (params[:administrative_mode] == "true")||(action_name == "administration")
  end

  def convert_search_filter_to_assign_attr model, field_name
    obj = instance_variable_get('@' + model.to_s.pluralize)
    obj.where(id: params[(controller_name.singularize.to_sym)][(model.to_s + '_filter').to_sym])
      .first.try(field_name)
  end

end
