
class String

	def is_singular?
		self.pluralize != self && self.singularize == self	
	end

	def to_kncode
		self.gsub(/.{2}/).with_index {|x, i| i > 0 ? "#{x} " : "#{x}" } .strip
	end

end