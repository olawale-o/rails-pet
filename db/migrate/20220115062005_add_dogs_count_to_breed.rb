class AddDogsCountToBreed < ActiveRecord::Migration[7.0]
  def change
    add_column :breeds, :dogs_count, :integer, default: 0
  end
end
