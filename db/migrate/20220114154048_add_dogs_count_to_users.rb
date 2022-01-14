class AddDogsCountToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :dogs_count, :integer, default: 0
  end
end
