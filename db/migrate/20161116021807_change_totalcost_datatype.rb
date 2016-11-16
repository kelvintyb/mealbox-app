class ChangeTotalcostDatatype < ActiveRecord::Migration[5.0]
  def change
    change_column :transactions, :totalcost, :float
  end
end
