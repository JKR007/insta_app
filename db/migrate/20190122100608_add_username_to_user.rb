# alter user table by adding username
class AddUsernameToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :user_name, :string, limit: 40
  end
end
