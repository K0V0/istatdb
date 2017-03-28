class FillupGoodsLocalTaricIntertable < ActiveRecord::Migration

  def up
	Good.all.each do |g|
	  	GoodsLocalTaric.create({
	  		local_taric_id: g.local_taric.id,
	  		good_id: g.id
	  	})
	end
  end

end
