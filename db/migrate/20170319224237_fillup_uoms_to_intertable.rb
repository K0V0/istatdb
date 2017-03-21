class FillupUomsToIntertable < ActiveRecord::Migration

  def up
=begin
  	Uom.all.each do |uom|
  		if !uom.uom.blank?
  			g = Intertable.where(good_id: uom.good_id)
  				.where(manufacturer_id: uom.manufacturer_id)
  				.where(impexpcompany_id: uom.impexpcompany_id)
			if !g.blank?
				g.uom_id = uom.id
				g.save
			end
  		end
  	end	
=end
  end

end
