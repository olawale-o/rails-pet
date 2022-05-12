class AddProfilePicUrlToDogs < ActiveRecord::Migration[7.0]
  def change
    add_column :dogs, :pic_url, :string
  end
end
