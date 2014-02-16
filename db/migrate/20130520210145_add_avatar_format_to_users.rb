class AddAvatarFormatToUsers < ActiveRecord::Migration
  def change
    add_column :users, :avatar_format, :string
  end
end
