class Referent < ActiveRecord::Base

    extend OrderAsSpecified

    include Defaults
    include NestedAttributesGetterConcern
    include NestedSelectedOrCreatedAnyConcern

    has_many :impexpcompany_manufacturers, inverse_of: :referent

    belongs_to :impexpcompany, inverse_of: :referents

    accepts_nested_attributes_for(
        :impexpcompany,
        reject_if: lambda { |c|
            c[:allow_search_as_new] == "0" || c[:allow_search_as_new].blank?
        }
    )

    nested_attrs_getter_for :impexpcompany

    #validates :first_name, presence: true
    #validates :last_name, presence: true
    #validate :at_least_one_impexpcompany_selected

    def at_least_one_impexpcompany_selected
        ## dava nil error pri multiuploade
        if !nested_selected_or_created_any?(:impexpcompany, :company_name)
            self.errors.add(:impexpcompany_attributes, :not_selected_or_created)
        end
    end

    def full_name
        "#{self.first_name} #{self.last_name}"
    end

    def name_field
        self.full_name
    end

    scope :default_order, -> {
        order(first_name: :asc, last_name: :asc)
    }

    scope :impexpcompany_filter, -> (*pars) {
        self.where(impexpcompany_id: pars)
    }

    scope :fullname_search, -> (pars) {
        meno_ids = self.where('first_name LIKE ?', "#{pars}%").ids
        priezvisko_ids = self.where('last_name LIKE ?', "#{pars}%").ids
        self.where(id: meno_ids|priezvisko_ids)
    }

    def self.ransackable_scopes(*pars)
        %i(impexpcompany_filter fullname_search)
    end

end
