module ApplicationConcern
	extend ActiveSupport::Concern

	### log to console with better visibility
	def logger(input, description="", **options)
		Rails.logger.info "-- #{description} ----------------------------------"
		Rails.logger.info input
		if options[:iterate]
			if input.respond_to?(:length)
				Rails.logger.info "-- count: #{input.try(:length)} --"
				input.each do |inp|
					Rails.logger.info inp
				end
				Rails.logger.info "-- end --"
			end
		end
		Rails.logger.info " "
	end

	### retruns model instance based on controller name if exists
	### else nil
	def model_exist?
		Module.const_get(controller_name.classify)
	rescue NameError
		return nil
	end

	def build_if_empty(*assocs)
		assocs.each do |a|
			tmp = instance_variable_get(@singular_varname)
			if (iv = tmp.send(a)).length == 0
				instance_variable_set("@#{a.to_s}", iv.build)
			elsif (iv.length != iv.persisted)
				instance_variable_set("@#{a.to_s}", iv.build)
			else
				instance_variable_set("@#{a.to_s}", iv)
			end
		end
	end

	module ClassMethods

	end

end