
class String

	def is_singular?
		self.pluralize != self && self.singularize == self			
	end

end