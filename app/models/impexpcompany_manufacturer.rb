class ImpexpcompanyManufacturer < ActiveRecord::Base

    include Defaults

	belongs_to :impexpcompany, inverse_of: :impexpcompany_manufacturers

	belongs_to :manufacturer, inverse_of: :impexpcompany_manufacturers

	belongs_to :local_taric, inverse_of: :impexpcompany_manufacturers

	belongs_to :incoterm, inverse_of: :impexpcompany_manufacturers

    belongs_to :trade_type, inverse_of: :impexpcompany_manufacturers

    belongs_to :person, inverse_of: :impexpcompany_manufacturers

    accepts_nested_attributes_for :local_taric, update_only: true

    after_initialize :def_export_methods

    attr_accessor :detach_local_taric

    private

    def export_methods
        {
            local_taric: [:kncode, :description],
            impexpcompany: [:company_name],
            incoterm: [:shortland],
            trade_type: [:type]
        }
    end

    def def_export_methods
        @s = self
        export_methods.each do |assoc, fields|
            fields.each do |field|
                create_instance_method "export_#{assoc.to_s}_#{field.to_s}" do
                    sanitize_empty(self.try(assoc).try(field))
                end
            end
        end
    end

    def create_instance_method(method_name, &block)
        if block_given?
            self.class.send(:define_method, method_name, block)
        else

        end
    end

    def sanitize_empty(obj)
        if obj.blank?
            return "---"
        else
            return obj
        end
    end

    def invoices_correct_human
        if invoices_correct == true
            I18n.t('is_true')
        elsif invoices_correct == false
            I18n.t('is_false')
        else
            "---"
        end
    end

end
