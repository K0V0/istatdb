class AddInvoicesCorrectToImpexpcompanyManufacturers < ActiveRecord::Migration
  def change
    add_column :impexpcompany_manufacturers, :invoices_correct, :boolean
  end
end
