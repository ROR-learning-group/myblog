class AddAvatarPathToUser < ActiveRecord::Migration
  def change
    add_column :users, :avatar_path, :string
    add_column :users, :username, :string
  end
end
