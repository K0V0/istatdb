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
		assocs.each do |a, opts|
			assoc_var_name = "@#{a.to_s.singularize}"
			build_command = a.to_s.is_singular? ? "build_#{a.to_s}" : "build"

			if (a.to_s.is_singular?)
				if @record.has_attribute? "#{a.to_s}_id"
					if @record.send(a).nil?
						instance_variable_set(assoc_var_name, @record.send(build_command))
					else
						instance_variable_set(assoc_var_name, @record.send(a))
					end
				end
			else
				# if associated has not been build yet
				if (iv = @record.send(a)).length == 0
					instance_variable_set(assoc_var_name, iv.send(build_command))
				else
					# if has been built
					# if empty field leave after reload for example after failed association
					# due to reject_if option of accept_nested_attributes_for
					# create and append one to associations (record with empty id)
					if !iv.collect(&:id).any? { |a| a.nil? }
						iv << a.to_s.singularize.classify.constantize.send(:new)
					end
					instance_variable_set(assoc_var_name, iv)
				end
			end
		end
	end

	module ClassMethods

	end

end