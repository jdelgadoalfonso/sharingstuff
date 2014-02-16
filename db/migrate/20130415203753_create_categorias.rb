class CreateCategorias < ActiveRecord::Migration
  def up
    create_table :categorias do |t|
      t.string      :valor, :null => false
      t.string      :nombre, :null => false
      t.timestamps
    end
  end

  def down
    drop_table :categorias
  end
end
