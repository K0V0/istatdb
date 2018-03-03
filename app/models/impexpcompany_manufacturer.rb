class ImpexpcompanyManufacturer < ActiveRecord::Base

    include Defaults

	belongs_to :impexpcompany, inverse_of: :impexpcompany_manufacturers

	belongs_to :manufacturer, inverse_of: :impexpcompany_manufacturers

	belongs_to :local_taric, inverse_of: :impexpcompany_manufacturers

	belongs_to :incoterm, inverse_of: :impexpcompany_manufacturers

    belongs_to :trade_type, inverse_of: :impexpcompany_manufacturers

    accepts_nested_attributes_for :local_taric, update_only: true

end
