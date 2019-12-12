module RansackSearchWrapper

	def searcher_for object: nil, autoshow: true, preload: nil, joins: nil, paginate: nil, generate_single_result_var: false, disabled: false, group_by: nil, not_load_ids: []

		params[:q] = [] if disabled

		mdl = controller_name.classify.constantize
		if mdl.respond_to? :default_order
	    	object ||= mdl.try(:default_order)
	    	#logger("mdl respond to def order #{controller_name}")
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

	    	@search = object.ransack(params[:q]) if joins.nil?
			@search = object.joins(joins).ransack(params[:q]) if !joins.nil?
			@result = @search.result

	    	if (params.try(:[], :q).try(:first)).try(:[], 0).to_s.match(/_cont$/)
	    		replaced_params = Hash[params[:q].map { |a, v| [a.to_s.sub(/_cont$/, '_start').to_sym, v] }]
	    		begins_with_results_ids = object.ransack(replaced_params).result.pluck(:id)
	    		#@result = @search.result
	    		#logger(begins_with_results_ids)
	    		#conts_results_ids = object.ransack(params[:q]).result.pluck(:id)
	    		#logger(conts_results_ids)
	    		#final_order_ids = begins_with_results_ids | conts_results_ids - begins_with_results_ids
	    		conts_results_ids = @result.ids
		    	final_order_ids = begins_with_results_ids | conts_results_ids - begins_with_results_ids
		    	@result = @result.order_as_specified(id: final_order_ids)
		    	logger "ide"
	    	end

	    	logger @result.to_sql

	    	#conts_results_ids = @result.ids
		    #final_order_ids = begins_with_results_ids | conts_results_ids - begins_with_results_ids


	    	#@search = object.ransack(params[:q]) if joins.nil?
			#@search = object.joins(joins).ransack(params[:q]) if !joins.nil?

			#@result = @search.result if preload.nil?
		    @result = @result.send(:preload, preload) if !preload.nil?

		    #conts_results_ids = @result.select(:id)
		   # final_order_ids = begins_with_results_ids | conts_results_ids - begins_with_results_ids


		    @result = @result.page(params[:page]) if !paginate.nil?
		    @result = @result.per(params[:per]) if !paginate.nil?&&params.has_key?(:per)

		    #logger @result.to_sql

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

			#end

		    #logger @result.methods
		end
    end

end
