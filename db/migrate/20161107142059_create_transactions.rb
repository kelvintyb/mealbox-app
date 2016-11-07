class CreateTransactions < ActiveRecord::Migration[5.0]
  def change
    create_table :transactions do |t|
      t.references :user, foreign_key: true
      t.references :recipe, foreign_key: true
      t.float :cost

      t.timestamps
    end
  end
end
