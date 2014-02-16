class CreateTipoPrestamo < ActiveRecord::Migration
  def up
    create_table :tipo_prestamo do |t|
      t.string      :nombre, :null => false
      t.timestamps
    end
  end

  def down
    drop_table :tipo_prestamo
  end
end
