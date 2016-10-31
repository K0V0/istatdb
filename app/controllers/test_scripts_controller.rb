class TestScriptsController < ApplicationController

	def index
	end

	def add_fake_data
		i = 1
		5.times do
			#l = LocalTaric.new
			#l.kncode = (1000000 + i).to_s
			#l.description = "popis " + i.to_s
			#l.save

			g = Good.new
			g.ident = "tovar " + i.to_s
			g.save

			c = Impexpcompany.new
			c.company_name = "client " + i.to_s
			c.save

			m = Manufacturer.new
			m.name = "Vyrobva " + i.to_s
			m.save

			i = i + 1

		end
	end

end
