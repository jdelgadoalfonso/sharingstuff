class CreateStuff < ActiveRecord::Migration
  def up
    create_table :stuff do |t|
      t.string      :nombre, :null => false
      t.text        :descripcion, :null => false
      t.binary      :imagen, :null => true, :limit => 1.megabyte
      t.string      :imagen_format, :null => true
      t.string      :latitud, :null => false
      t.string      :longitud, :null => false
      t.timestamps
    end
  end

  def down
    drop_table :stuff
  end
end
