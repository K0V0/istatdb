module RansackSearchWrapper

	def searcher_for object: nil, autoshow: true, preload: nil, joins: nil, paginate: nil, generate_single_result_var: false, disabled: false

		params[:q] = [] if disabled

	    object ||= controller_name.classify.constantize.try(:default_order)
	    if !object.nil?
		    @search = object.ransack(params[:q]) if joins.nil?
		    @search = object.joins(joins).ransack(params[:q]) if !joins.nil?
		    @result = @search.result if preload.nil?
		    @result = @search.result.send(:preload, preload) if !preload.nil?
		    @result = @result.page(params[:page]) if !paginate.nil?
		    @result = @result.per(params[:per]) if !paginate.nil?&&params.has_key?(:per)

		    if @result.count == 1 && !request.xhr?.nil? && autoshow && action_name == "search"
		    	redirect_to controller: controller_name, action: :show, id: @result.first.id
		    end

		    if @result.count == 1 && generate_single_result_var
		    	@result1 = @result.first
		    end
		end
    end

end