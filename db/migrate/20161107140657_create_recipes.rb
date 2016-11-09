class CreateRecipes < ActiveRecord::Migration[5.0]
  def change
    create_table :recipes do |t|
      t.references :user, foreign_key: true, :default => 1
      t.string :name
      t.string :cuisine
      t.float :costperserving
      t.integer :views
      t.text :instructions
      t.text :image

      t.timestamps
    end
  end
end
