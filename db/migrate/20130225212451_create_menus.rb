class CreateMenus < ActiveRecord::Migration
  def change
    create_table :menus do |t|
      t.float       :posicion, :null => false
      t.string      :nombre, :null => false
      t.integer     :menu_id, :null => true
      t.string      :accion, :null => false
      t.timestamps
    end
  end
end
