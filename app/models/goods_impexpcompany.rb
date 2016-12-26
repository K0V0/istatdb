class GoodsImpexpcompany < ActiveRecord::Base

	belongs_to :good, inverse_of: :goods_impexpcompanies
	belongs_to :impexpcompany, inverse_of: :goods_impexpcompanies

end