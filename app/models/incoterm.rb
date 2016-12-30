class Incoterm

	@@incoterms = RecursiveOpenStruct.new(
		{ terms: [
			{ id: 0, shortland: "XXX" },
			{ id: 1, shortland: "EXW" },
			{ id: 2, shortland: "FCA" },
			{ id: 3, shortland: "FAS" },
			{ id: 4, shortland: "FOB" },
			{ id: 5, shortland: "CFR" },
			{ id: 6, shortland: "CIF" },
			{ id: 7, shortland: "CPT" },
			{ id: 8, shortland: "CIP" },
			{ id: 9, shortland: "DAF" },
			{ id: 10, shortland: "DES" },
			{ id: 11, shortland: "DEQ" },
			{ id: 12, shortland: "DDU" },
			{ id: 13, shortland: "DDP" },
			{ id: 14, shortland: "DAP" },
			{ id: 15, shortland: "DAT" }
		] },
		recurse_over_arrays: true
	)

	def self.all 
		@@incoterms.terms
	end

	def self.find incoterm_id
		@@incoterms.terms[incoterm_id] if !incoterm_id.blank?
	end

end