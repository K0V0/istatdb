module NewFormsHelper

	def select_blank_message(collection, msg_if_blank=nil, msg_if_any=nil)
		msg_if_blank ||= t('actions.nothing_to_select')
		msg_if_any ||= "#{t('actions.select')}..."
		collection.collect(&:id).any? ? msg_if_any : msg_if_blank
	end

end