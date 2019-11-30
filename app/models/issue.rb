class Issue < ActiveRecord::Base

    extend OrderAsSpecified
    include Defaults

    has_many :good_issues, inverse_of: :issue #, dependent: :destroy
    accepts_nested_attributes_for(
        :good_issues#,
        #reject_if: lambda { |c|
            #c[:good_id].blank?&&c[:íssue_id].blank?
        #}
    )

    has_many :goods, -> { distinct }, through: :good_issues
    accepts_nested_attributes_for(
        :goods#,
        #reject_if: lambda { |c|
            #c[:name].blank?
        #}
    )

    has_many :impexpcompany_issues, inverse_of: :issue #, dependent: :destroy
    accepts_nested_attributes_for(
        :impexpcompany_issues#,
        #reject_if: lambda { |c|
            #c[:good_id].blank?&&c[:íssue_id].blank?
        #}
    )

    has_many :impexpcompanies, -> { distinct }, through: :impexpcompany_issues
    accepts_nested_attributes_for(
        :impexpcompanies#,
        #reject_if: lambda { |c|
            #c[:name].blank?
        #}
    )

    validates :name, presence: true
    validates_uniqueness_of :name

    scope :default_order, -> {
        order(created_at: :asc)
    }

    def name_new_searcher
        "#{self.name} - #{self.note}"
    end

    def name_field
        self.name
    end

end
