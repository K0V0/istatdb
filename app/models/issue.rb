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
        reject_if: proc { |c| c[:file].blank? and c[:file_cache].blank? and c[:note].blank? }
    )

    validates :name, presence: true
    validates_uniqueness_of :name, scope: :season
    # uniquenes prerobit na meno a zaroven datum

    scope :default_order, -> {
        order(season: :desc, name: :desc)
    }

    scope :impexpcompany_filter, -> (pars) {
        self
        .joins(:impexpcompanies)
        .where(impexpcompanies: {
            id: pars
        })
        .preload(:impexpcompanies)
        .distinct
    }

    def self.ransackable_scopes(*pars)
        %i(impexpcompany_filter)
    end

    def name_for_search_dropdown
        "#{self.name} - #{self.season.strftime('%m/%Y')}"
    end

    def season_human
        self.season.strftime("%m/%Y")
    end

    def name_field
        #self.name
        self.name_for_search_dropdown
    end

    def resolved_bilance
        total = self.goods.size
        resolved = total - (self.goods.select { |g| g.uncomplete == true } .size)
        "#{resolved} / #{total}"
    end

    def is_resolved
        total = self.goods.size
        resolved = total - (self.goods.select { |g| g.uncomplete == true } .size)
        return (total-resolved == 0)
    end

end
