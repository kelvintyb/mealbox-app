class ChangeCostName < ActiveRecord::Migration[5.0]
  def change
    remove_column :transactions, :cost, :float
    add_column :transactions, :totalcost, :integer
  end
end
