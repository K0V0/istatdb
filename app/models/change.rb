class Change < ActiveRecord::Base

    include Defaults

    scope :default_order, -> {
        order(version_num: :desc)
    }

    after_save :write_changelog_file #, on: :create

    def write_changelog_file
        File.open("db/changelog/changelog.json", "w") { |f| f.write Change.all.default_order.to_json }
    end

    def change_desc
        return ChangeType.find(change_typ).name
    end

    def change_class
        return ChangeType.find(change_typ).type
    end

    validates :version_num, presence: true
    validates :change, presence: true

end
