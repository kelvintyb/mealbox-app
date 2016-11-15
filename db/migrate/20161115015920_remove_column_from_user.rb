class RemoveColumnFromUser < ActiveRecord::Migration[5.0]
  def change
    remove_column :users, :address1, :text
    remove_column :users, :address2, :text
    remove_column :users, :cardtype, :string
    remove_column :users, :creditcard, :integer
  end
end
