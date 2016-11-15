class ChangeCreditCardDataType < ActiveRecord::Migration[5.0]
  def change
    change_column :transactions, :creditcard, :string
  end
end
