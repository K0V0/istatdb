module RansackSearchWrapper

	def searcher_for object: nil, autoshow: true, default_order: nil, preload: nil, joins: nil, paginate: nil

	    object ||= controller_name.classify.constantize
	    @search = object.ransack(params[:q]) if joins.nil?
	    @search = object.joins(joins).ransack(params[:q]) if !joins.nil?
	    @search.sorts = default_order if (@search.sorts.empty?&&!default_order.nil?)
	    @result = @search.result if preload.nil?
	    @result = @search.result.send(:preload, preload) if !preload.nil?
	    @result = @result.page(params[:page]) if !paginate.nil?


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

end