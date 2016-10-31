class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception


  def searcher_for object: nil, autoshow: true, search_condition:nil

    object ||= controller_name.classify.constantize
    @search = object.ransack(params[:q])
    @search.sorts = search_condition if (@search.sorts.empty?&&!search_condition.nil?)
    @result = @search.result

    if  @result.count == 1 && !request.xhr?.nil? && autoshow
    	# if ransack searching during typing ends up showing one result,
    	# and if request is not first page load (request.xhr?.nil? will return nil first time, then only false)
    	# and if option enabled (default yes)
    	# show it in detailed view
    	# set this single result as instance variable (singular form) 
    	# for controller "show" action, then render templates defined for "show" action
    	instance_variable_set('@'+controller_name.singularize, @result.first)
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

end
