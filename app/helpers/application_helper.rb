module ApplicationHelper

	include Log

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

end
