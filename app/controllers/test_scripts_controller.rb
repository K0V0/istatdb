class TestScriptsController < ApplicationController

	after_action :return_to_index, except: [:index]

	def index
	end

	def add_fake_data
		i = 1
		5.times do
			l = LocalTaric.new
			l.kncode = (10000000 + i).to_s
			l.description = "popis " + i.to_s
			l.save

			c = Impexpcompany.new
			c.company_name = "client " + i.to_s
			c.save

			m = Manufacturer.new
			m.name = "Vyrobca " + i.to_s
			m.save

			g = Good.new
			g.ident = "tovar " + i.to_s
			g.local_taric = l
			g.impexpcompanies << c
			g.manufacturers << m
			g.save

			i = i + 1

		end
	end

	def remove_all
		Good.delete_all
		LocalTaric.delete_all
		Impexpcompany.delete_all
		Manufacturer.delete_all
	end

	private

	def return_to_index
		redirect_to test_scripts_path
	end

end
