module RansackSearchWrapper

	#require 'order_as_specified'

	def searcher_for object: nil, autoshow: true, preload: nil, joins: nil, paginate: nil, generate_single_result_var: false, disabled: false, group_by: nil, not_load_ids: [], intelligent_mode: false

		params[:q] = [] if disabled

		mdl = controller_name.classify.constantize
		if mdl.respond_to? :default_order
	    	object ||= mdl.try(:default_order)
	    else
	    	object ||= mdl
	    end

	    if !object.try(:translated_locales).blank?
	    	object = object.with_translations(I18n.locale)
	    end

	    if !object.nil?

	    	if !not_load_ids.blank?
	    		object = object.where.not(id: not_load_ids)
	    	end

	    	logger object.to_sql

	    	object = object.unscope(:order).order_as_specified(id: [229, 1524, 498, 497, 724, 210, 577, 551, 675, 1715, 2300, 1390, 1532, 625, 626, 479, 1412, 1556, 2129, 2068, 2073, 796, 1714, 1719, 1699, 1708, 1713, 1519]).default_order

	    	logger object.to_sql

		    @search = object.ransack(params[:q]) if joins.nil?
		    @search = object.joins(joins).ransack(params[:q]) if !joins.nil?

		    @result = @search.result
		    @result = @result.send(:preload, preload) if !preload.nil?
		    @result = @result.page(params[:page]) if !paginate.nil?
		    @result = @result.per(params[:per]) if !paginate.nil?&&params.has_key?(:per)

		    total_pages = @result.total_pages
		    if total_pages < params[:page].to_i
		    	@result = @result.page(total_pages)
		    end

		    if 	(
		    	params[:per] != "1" &&
		    	@result.length == 1 &&
		    	!request.xhr?.nil? &&
		    	autoshow &&
		    	!params.has_key?(:no_search) &&
		    	action_name == "search"
		    	)
		    		redirect_to controller: controller_name, action: :show, id: @result.first.id
		    elsif (
	    		params[:per] != "1" &&
	    		@result.length == 1
		    	)
		    		@result.first.only_one = true
		    end

		    if params.has_key? :last_visits
		    	if !(id = params[:last_visits]).blank?
		    		redirect_to controller: controller_name, action: :show, id: id
		    	end
		    end

		    if @result.length == 1 && generate_single_result_var
		    	@result1 = @result.first
		    end
		end
    end

end