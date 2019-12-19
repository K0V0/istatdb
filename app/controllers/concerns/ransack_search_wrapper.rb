module RansackSearchWrapper

	### require 'order_as_specified' musi byt na modeli ktory bude pouzivat
	### intelignetny rezim
	### controller nastavenie searchera musi joinovat asociacie ak sa podla nich
	### bude sortovat tabulka

	def searcher_for object: nil, autoshow: true, preload: nil, joins: nil, paginate: nil, generate_single_result_var: false, disabled: false, group_by: nil, not_load_ids: [], intelligent_mode: false

		params[:q] = [] if disabled
		mdl = controller_name.classify.constantize
	    object ||= mdl
	    params_no_search = []
	    params_no_search = params.try(:[], :q).try(:except, :s) if !params[:q].nil?
	    disable_ransack_sort = false

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

	    	if mdl.respond_to? :default_order
		    	object = object.try(:default_order)
		    end

	    	if intelligent_mode
	    		if !params_no_search.values.all? { |p| p.blank? }
	    			### nic nieje v hladani, speed improvement
		    		if (params.try(:[], :q).try(:first)).try(:[], 0).to_s.match(/_cont$/)
			    		replaced_params = Hash[params[:q].map { |a, v| [a.to_s.sub(/_cont$/, '_start').to_sym, v] }]
			    		### limit 1600 kvoli gemu - limit na SQL QUERY
			    		begins_with_results_ids = object.ransack(replaced_params).result.limit(1600).ids
			    		object = object.unscope(:order).order_as_specified(id: begins_with_results_ids)
			    		object = order_by_ransack_params(object)
			    	end
			    	disable_ransack_sort = true
			    end
	    	end

	    	intelligent2_mode = true

	    	if intelligent2_mode
	    		if !params_no_search.values.all? { |p| p.blank? }
	    			p = params[:q]
	    			replacable_params = []
	    			p.each do |k, v|
	    				if k.to_s =~ /_cont$/
	    					replacable_params.push({k => v})
	    				end
	    			end
	    			#logger replacable_params
	    		end
	    	end

		    @search = object.ransack(params[:q].try(:except, :s)) if disable_ransack_sort
		    @search = object.ransack(params[:q]) if !disable_ransack_sort

		    @result = @search.result
		    @result = @result.page(params[:page]) if !paginate.nil?
		    @result = @result.per(params[:per]) if !paginate.nil?&&params.has_key?(:per)

		    ## priradit parametre az po funuse, treba aby sa zobrazovali sortlinky
		    if params.deep_has_key?(:q, :s)
		    	@search.sorts = params[:q][:s] if !params[:q][:s].blank?
		    end

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

    def generate_search_query(obj)
    	mdls = ActiveRecord::Base.send(:subclasses)
    		.select { |c| c.name =~ /^[A-Za-z]+$/ }
    		.map { |c| c.name.underscore }
    	queries = []

    	if !(po = params.try(:[], :q)).blank?
    		p = po.try(:[], :s)
	    	if !p.nil?
	    		if !p.blank?
	    			p.each do |par|
	    				k, v = par.split(' ')
	    				mdls.each do |mdl|
	    					query = nil
	    					if k.include?(mdl)&&(k != mdl)
	    						# je to asociacia
	    						assoc_t = mdl.pluralize
	    						field = k.sub(mdl, '').sub(/^_/, '')
	    						query = "#{assoc_t}.#{field} #{v}"
	    					elsif (controller_name.classify.constantize.new.attributes.keys.include?(k))
	    						# je to atribut hlavneho modelu
	    						query = "#{k} #{v}"
	    					end
	    					queries.push(query) if !queries.include?(query)&&!query.nil?
	    				end
	    			end
	    		end
	    	end
	    end

    	return queries.join(", ")
    end

    def order_by_ransack_params(obj)
    	rule = generate_search_query(obj)
    	#logger rule
    	return rule.blank? ? nil : obj.order(rule)
    end

end