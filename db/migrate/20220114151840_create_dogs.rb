class CreateDogs < ActiveRecord::Migration[7.0]
  def change
    create_table :dogs do |t|
      t.string :name, null: false
      t.string :color, null: false
      t.string :weight, null: false
      t.text :description, null: false
      t.references :breed, null: false, foreign_key: true
      t.references :owner, references: :users, foreign_key: { to_table: :users }, null: false
      t.timestamps
    end
  end
end
