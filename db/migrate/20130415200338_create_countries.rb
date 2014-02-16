class CreateCountries < ActiveRecord::Migration
  def up
    create_table :countries do |t|
      t.string      :valor, :null => false
      t.string      :nombre, :null => false
      t.timestamps
    end
  end

  def down
    drop_table :countries
  end
end
