class AddGenderToDogs < ActiveRecord::Migration[7.0]
  def change
    add_column :dogs, :gender, :string, null: false
  end
end
