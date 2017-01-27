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
	    	func = "#{controller_name.singularize.underscore}_path".to_sym
	    	redirect_to public_send(func, @result.first.id)
	    end
    end

end