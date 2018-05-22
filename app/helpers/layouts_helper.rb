module LayoutsHelper

	def new_edit(type: nil, obj: nil, assoc: nil, fields: {}, multiedit: false, searcher_settings: nil, add_next: false, &block)
		type = :main if type.nil? && assoc.nil?
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
