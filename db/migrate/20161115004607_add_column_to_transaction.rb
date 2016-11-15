class AddColumnToTransaction < ActiveRecord::Migration[5.0]
  def change
    add_column :transactions, :address1, :text
    add_column :transactions, :address2, :text
    add_column :transactions, :cardtype, :string
    add_column :transactions, :creditcard, :integer
  end
end
