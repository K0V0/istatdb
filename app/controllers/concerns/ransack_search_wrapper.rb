module RansackSearchWrapper

	### require 'order_as_specified' musi byt na modeli ktory bude pouzivat
	### intelignetny rezim

	def searcher_for object: nil, autoshow: true, preload: nil, joins: nil, paginate: nil, generate_single_result_var: false, disabled: false, group_by: nil, not_load_ids: [], intelligent_mode: false

		params[:q] = [] if disabled
		mdl = controller_name.classify.constantize
	    object ||= mdl

	    if !object.nil?

	    	if !joins.nil?
	    		object = object.joins(joins)
	    	end

	    	if !preload.nil?
	    		object = object.preload(preload)
	    	end

	    	if !object.try(:translated_locales).blank?
		    	object = object.with_translations(I18n.locale)
		    end

	    	if !not_load_ids.blank?
	    		object = object.where.not(id: not_load_ids)
	    	end

	    	if intelligent_mode
	    		if (params.try(:[], :q).try(:first)).try(:[], 0).to_s.match(/_cont$/)
		    		replaced_params = Hash[params[:q].map { |a, v| [a.to_s.sub(/_cont$/, '_start').to_sym, v] }]
		    		### limit 1600 kvoli gemu - limit na SQL QUERY
		    		begins_with_results_ids = object.ransack(replaced_params).result.limit(1600).ids
		    		object = object.order_as_specified(id: begins_with_results_ids)
		    	end
	    	end

	    	### pre cosi ma prve triedenie prednost
	    	#object = object.order(ident: :desc)

	    	if !(o = order_by_ransack_params(object)).nil?

	    		object = o
	    	else
		    	if mdl.respond_to? :default_order
		    		object = object.try(:default_order)
		    	end
		    end

	    	#object = object.order(ident: :desc)

	    	#p = params[:q].except(:s)
		    @search = object.ransack(params[:q].except(:s)) #if joins.nil?
		    #@search = object.joins(joins).ransack(p) if !joins.nil?
		    #@search.sorts = params[:q][:s]

		    #logger params[:q][:s]
		    #
		    #
		     @search.sorts = params[:q][:s]

		    @result = @search.result
		    #logger @result.ids
		    #@result = @result.send(:preload, preload) if !preload.nil?
		    @result = @result.page(params[:page]) if !paginate.nil?
		    @result = @result.per(params[:per]) if !paginate.nil?&&params.has_key?(:per)

		    logger @result.to_sql
		    ## priradit parametre az po funuse, treba aby sa zobrazovali sortlinky
		    @search.sorts = params[:q][:s]

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

    def generate_search_rules_hash()
    	## na triedenie
    	## urobit tunak funkciu ktora vygeneruhe z parametrov sql query poslanu na result namiesto
    	# posielania na ransack object lebo ten vymaze custom poradie prvych poloziek

    end

    def order_by_ransack_params(obj)
    	rule = generate_search_rules_hash()
    	#logger obj.order("ident desc").order('local_taric.kncode desc').to_sql
    	#obj.preload(:local_taric).order('local_tarics.kncode desc')
    	nil
    end

end