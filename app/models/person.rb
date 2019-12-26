class Person < ActiveRecord::Base

    include Defaults
    include NestedAttributesGetterConcern
    include NestedSelectedOrCreatedAnyConcern

    belongs_to :impexpcompany, inverse_of: :people
    accepts_nested_attributes_for(
        :impexpcompany,
        reject_if: lambda { |c|
            c[:allow_search_as_new] == "0" || c[:allow_search_as_new].blank?
        }
    )

    has_many :impexpcompany_manufacturers, inverse_of: :person

    nested_attrs_getter_for :impexpcompany

    validate :at_least_one_impexpcompany_selected

    def at_least_one_impexpcompany_selected
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

    scope :impexpcompany_filter, -> (pars) {
        self.where(impexpcompany_id: pars)
    }

    def self.ransackable_scopes(*pars)
        %i(impexpcompany_filter)
    end

end
