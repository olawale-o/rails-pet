class CreateUserAccounts < ActiveRecord::Migration[7.0]
  def change
    create_table :user_accounts do |t|

      t.timestamps
    end
  end
end
