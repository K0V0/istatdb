module Defaults
	extend ActiveSupport::Concern

	include Log

	def self.included(base)
	  base.instance_eval do

	  	attr_accessor :allow_search_as_new

	  	scope :order_this_id_first, -> (pars) {
	  		if !pars.blank?
				order_as_specified(id: [pars])
				.default_order
			else
				default_order
			end
		}

		scope :persisted, -> {
			where "#{model_name.plural}.id IS NOT NULL"
		}

		#def translations_validations *validations
		#	accepts_nested_attributes_for :translations, :allow_destroy => true
		#	validates_associated :translations
		#	validations.each do |field|
		#		field.each do |f_name, v_opts|
		#			translations_validation f_name, v_opts
		#		end
		#	end
		#end

		#def translations_validation field, *options
		#	translation_class.validates(field, *options)
		#end

	  end
	end

end


