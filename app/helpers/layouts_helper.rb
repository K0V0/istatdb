module LayoutsHelper

	def new_edit(type: nil, obj: nil, assoc: nil, fields: {}, multiedit: false, searcher_settings: nil, add_next: false, html_class: nil, assoc_query_where: nil, &block)
		is_secondary_main = type.to_s == 'secondary'
		type = :main if (type.nil? && assoc.nil?)||(is_secondary_main)
		type = :belongs_to if type.nil? && assoc.to_s.is_singular?
		type = :has_many if type.nil? && !assoc.to_s.is_singular?
		type = :submit if fields.blank?

		render(
			partial: "layouts/shared/new_edit_form/#{type.to_s}",
			locals: {
				obj: obj,
				assoc: assoc,
				fields: fields,
				multiedit: multiedit,
				searcher_settings: searcher_settings,
				add_next: add_next,
				main_secondary: is_secondary_main,
				html_class: html_class,
				assoc_query_where: assoc_query_where,
				## opts: pridat nastavenia !!!!!!, su teraz vo fields asi nutna prestavba
				#required: required,
				block: block
			}
		)
	end

	def settings(section: :main, settings: {}, only_admin: false)
		render(
			"layouts/shared/settings",
			section: section,
			settings: settings,
			only_admin: only_admin
		)
	end

end
