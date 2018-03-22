class ChangeType < ActiveRecord::Base

    @@change_types = RecursiveOpenStruct.new(
        { changes: [
            { name: "---", type: "", id: 0 },
            { name: I18n.t('changelog.bugfix'), type: "danger", id: 1 },
            { name: I18n.t('changelog.lobugfix'), type: "normal", id: 5 },
            { name: I18n.t('changelog.refactor'), type: "normal", id: 6 },
            { name: I18n.t('changelog.uxfix'), type: "normal", id: 2 },
            { name: I18n.t('changelog.performance'), type: "normal", id: 3 },
            { name: I18n.t('changelog.add'), type: "new", id: 4 }
        ] },
        recurse_over_arrays: true
    )

    def self.all
        return @@change_types.changes
    end

    def self.find change_type_id
         return @@change_types.changes.select { |k| k.id == change_type_id } [0]
    end

end
