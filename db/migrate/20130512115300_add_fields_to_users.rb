class AddFieldsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :comment, :string
    add_column :users, :avatar, :binary, :limit => 1.megabyte
  end
end
