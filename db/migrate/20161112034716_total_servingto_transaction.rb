class TotalServingtoTransaction < ActiveRecord::Migration[5.0]
  def change
    add_column :transactions, :totalserving, :integer
  end
end
