class GoodsController < ApplicationController

	before_action :searcher_for, only: [:index, :search, :show]

	before_action(only: :create) { 
		reload_tables_for_select
		create_action permitted_pars
	}

	def index

	end

	def search
		
	end

	def show
		
	end

	def new
		@good = Good.new
		@local_tarics = LocalTaric.all
		@impexpcompanies = Impexpcompany.all
		@manufacturers = Manufacturer.all
	end

	def create

	end

	private 

	def permitted_pars
		params[:good].permit(
			:ident, 
			:description,
			:local_taric_kncode,
			:local_taric_description,
			:impexpcompany_company_name,
			:manufacturer_name
		)
	end

	def reload_tables_for_select
		reload_result_by_params_nested(
			LocalTaric: {
				kncode: :starts,
				description: :contains
			},
			Impexpcompany: { company_name: :contains },
			Manufacturer: { name: :contains }
		)
	end

	# model: {
	# 	field: :method
	# }
	def reload_result_by_params_nested(**options)
		Rails.logger.info "------------"
		Rails.logger.info options
		options.each do |option|
			
		end
	end

	#   field_name: {
	#		param: :<containing parameter from params>,
	#		search_method: :<starts or contains>
	#	} 
	def reload_result_by_params(model, **options)
		model ||= controller_name.classify.constantize

		instvar_string = '@' + model.to_s.underscore.pluralize
		query_string = ''
		query_parameters = []
		iterator = 0
		opts_count = options.length

		options.each do |field|

			query_string += field[0].to_s + ' LIKE ?'
			query_string += ' AND ' if (opts_count > 1 && iterator < (opts_count-1))
		
			par = field[1][:param] || field[0]
			search_method = field[1][:search_method] || :starts

			par_string = ''
			par_string += '%' if search_method == :contains
			par_string += params[controller_name.singularize.to_sym][par]
			par_string += '%'

			query_parameters << par_string
			iterator += 1

		end

		result = model.where(query_string, *query_parameters) || model.all
		instance_variable_set(instvar_string, result)
	end

	### TODO
	def reload_vars
		
		@taric = LocalTaric.where(
			"kncode LIKE ? AND description LIKE ?", 
			"#{params[:good][:local_taric_kncode]}%",
			"%#{params[:good][:local_taric_description]}%"
		) 
		@clients = Impexpcompany.where(
			"company_name LIKE ?", "%#{params[:good][:impexpcompany_company_name]}%"
		)
		@manufacturers = Manufacturer.where(
			"name LIKE ?", "%#{params[:good][:manufacturer_name]}%"
		)
	end

end
