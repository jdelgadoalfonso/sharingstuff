class AddPasswordToAuthorizations < ActiveRecord::Migration
  def change
    add_column :authorizations, :password, :string
  end
end
