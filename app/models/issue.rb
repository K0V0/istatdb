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
=begin
    has_many :impexpcompany_issues, inverse_of: :issue #, dependent: :destroy
    accepts_nested_attributes_for(
        :impexpcompany_issues#,
        #reject_if: lambda { |c|
            #c[:good_id].blank?&&c[:íssue_id].blank?
        #}
    )
=end
    has_many :impexpcompanies, -> { distinct }, through: :good_issues
    accepts_nested_attributes_for(
        :impexpcompanies#,
        #reject_if: lambda { |c|
            #c[:name].blank?
        #}
    )

    has_many :good_issue_files, inverse_of: :issue, dependent: :destroy
    accepts_nested_attributes_for(
        :good_issue_files,
        allow_destroy: true,
        reject_if: proc { |c| c[:file].blank? and c[:file_cache].blank? }
    )

    validates :name, presence: true
    validates_uniqueness_of :name, scope: :season
    # uniquenes prerobit na meno a zaroven datum

    scope :default_order, -> {
        order(season: :desc, name: :desc)
    }

    def name_for_search_dropdown
        "#{self.name} - #{self.season.strftime('%m/%Y')}"
    end

    def season_human
        self.season.strftime("%m/%Y")
    end

    def name_field
        self.name
    end

end
