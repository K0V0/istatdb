module SelectOnSearched

  # function for selecting records to controller instance variables
  # dependent on what is stored in params[:controller] attributes
  # - perform search based on attribute 
  # - used on select tables in forms when validation failed to load most accurate
  #   results to options table to choose from
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

end