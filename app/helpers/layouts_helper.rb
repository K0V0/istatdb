module LayoutsHelper

	def new_edit(type: nil, obj: nil, assoc: nil, fields: {}, multiedit: false)
		type = :main if type.nil? && assoc.nil?
		type = :belongs_to if type.nil? && assoc.to_s.is_singular?
		type = :has_many if type.nil? && !assoc.to_s.is_singular?
		type = :submit if fields.blank?

		render(
			"layouts/shared/new_edit_form/#{type.to_s}",
			obj: obj,
			assoc: assoc,
			fields: fields,
			multiedit: multiedit
		)
	end

	def settings(section: :main, settings: {})
		render(
			"layouts/shared/settings",
			section: section,
			settings: settings
		)
	end

end