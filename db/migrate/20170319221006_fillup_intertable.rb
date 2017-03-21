class FillupIntertable < ActiveRecord::Migration
  
	def up
		Good.all.each do |good|
			good.manufacturers.each do |man|
				rem = man.impexpcompanies - good.impexpcompanies
				res = man.impexpcompanies - rem

				res.each do |r|
					Intertable.create(
						good_id: good.id,
						manufacturer_id: man.id,
						impexpcompany_id: r.id
					)
				end
			end
		end


	end


end
