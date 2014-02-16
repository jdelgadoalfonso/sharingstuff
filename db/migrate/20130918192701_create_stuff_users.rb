class CreateStuffUsers < ActiveRecord::Migration
  def up
    create_table :stuffusers do |t|
      t.timestamps
    end
  end

  def down
    drop_table :stuffusers
  end
end
