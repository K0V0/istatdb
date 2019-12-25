module ApplicationHelper

	include Log
	include MemHelper

	### cbt - controller based translation
	### trying to keep transtations organized, imagine you have t(:foo) somewhere in views
	### associated to GoodsController, in YML file you write:
	### <your lang>:
	###   goods:
	###     foo: BAR
	def cbt translation_key
		I18n.t("#{params[:controller].to_s}.#{translation_key.to_s}")#.gsub(/\n/, "<br>").html_safe
	end

	def current_translations
  		@translations ||= I18n.backend.send(:translations)
  		@translations[I18n.locale].with_indifferent_access
	end

	def is_in_administrative?
		!@MEM.send("is_in_administrative_#{controller_name.singularize.underscore}").blank?
	end

	def get_path_back
    	if !session[:path_back].nil?
    		if !session[:path_back][:controller].nil?
    			return session[:path_back]
            else
                return { controller: params[:controller], action: 'index' }
    		end
    	end
    	return { controller: params[:controller], action: 'index' }
    end

    def kaminari_url_patch(url)
        if url.include?('&search_performed=true')
            return url.gsub('&search_performed=true', '&no_search=true')
        else
            return "#{url}&no_search=true"
        end
    end

end
