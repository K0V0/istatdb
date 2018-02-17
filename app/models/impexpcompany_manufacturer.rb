class ImpexpcompanyManufacturer < ActiveRecord::Base

    include Defaults

	belongs_to :impexpcompany, inverse_of: :impexpcompany_manufacturers

	belongs_to :manufacturer, inverse_of: :impexpcompany_manufacturers

	belongs_to :local_taric, inverse_of: :impexpcompany_manufacturers

	belongs_to :incoterm, inverse_of: :impexpcompany_manufacturers

    accepts_nested_attributes_for :local_taric, update_only: true

    #validates_associated :local_taric

    #accepts_nested_attributes_for :local_taric
    #
    #validates_presence_of :local_taric

end
