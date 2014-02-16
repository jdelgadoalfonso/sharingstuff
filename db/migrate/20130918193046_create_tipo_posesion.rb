class CreateTipoPosesion < ActiveRecord::Migration
  def up
    create_table :tipo_posesion do |t|
      t.string      :nombre, :null => false
      t.timestamps
    end
  end

  def down
    drop_table :tipo_posesion
  end
end
