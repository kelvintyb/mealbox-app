class AddDateAndTime < ActiveRecord::Migration[5.0]
  def change
    add_column :transactions, :dateandtime, :datetime
  end
end
