class UpdateGoodsCounters < ActiveRecord::Migration
  def change
  	 Manufacturer.all.each { |m| Manufacturer.reset_counters(m.id, :goods) }
   
  end
end
