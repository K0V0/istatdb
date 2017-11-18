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

	def new_edit_multiple(title: nil, form_object: nil, ar_object: nil, result_of_collection: nil, key: :id, name: nil)

		render('layouts/new_checkboxes_table', 
			title: title,
			form_object: form_object,
			ar_object: ar_object,
			result_of_collection: result_of_collection,
			key: key,
			name: name 
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