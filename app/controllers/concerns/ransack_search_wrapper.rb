module RansackSearchWrapper

	def searcher_for object: nil, autoshow: true, preload: nil, joins: nil, paginate: nil, generate_single_result_var: false, disabled: false

		params[:q] = [] if disabled

	    object ||= controller_name.classify.constantize.try(:default_order)

	    #logger object.try(:translated_locales), "trans locales"
	    #with_translations(I18n.locale)
	    #
	    if !object.try(:translated_locales).blank?
	    	object = object.with_translations(I18n.locale)
	    end

	    if !object.nil?
		    @search = object.ransack(params[:q]) if joins.nil?
		    @search = object.joins(joins).ransack(params[:q]) if !joins.nil?
		    #logger @search, "srch"
		    @result = @search.result if preload.nil?
		    @result = @search.result.send(:preload, preload) if !preload.nil?
		    @result = @result.page(params[:page]) if !paginate.nil?
		    @result = @result.per(params[:per]) if !paginate.nil?&&params.has_key?(:per)

		    if (params[:per] != "1" &&
		    	@result.length == 1 &&
		    	!request.xhr?.nil? &&
		    	autoshow &&
		    	action_name == "search")
		    		redirect_to controller: controller_name, action: :show, id: @result.first.id
		    end

		    if @result.length == 1 && generate_single_result_var
		    	@result1 = @result.first
		    end
		end
    end

end
