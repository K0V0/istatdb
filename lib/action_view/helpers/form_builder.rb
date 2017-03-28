class ActionView::Helpers::FormBuilder

  	def errors(field, continue: false)

	    if !@object.errors[field].blank? 
	    	err = ""
	    	if continue
		    	@object.errors[field].each do |e|
		    		err += @template.content_tag(:span, @object.errors.full_message(field, e))
		    	end
		    else
		    	e = @object.errors[field].first
		    	err += @template.content_tag(:span, @object.errors.full_message(field, e))
		    end
	    	return err.html_safe
	    end
  	end

end
