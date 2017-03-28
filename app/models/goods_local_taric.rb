class GoodsLocalTaric < ActiveRecord::Base
	belongs_to :good, inverse_of: :goods_local_tarics
	belongs_to :local_taric, inverse_of: :goods_local_tarics
end
