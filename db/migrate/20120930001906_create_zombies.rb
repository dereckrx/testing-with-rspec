class CreateZombies < ActiveRecord::Migration
  def up
    create_table :zombies do |t|
      t.string :name
      t.integer :brains
      t.boolean :alive
      t.boolean :rotting
      t.float :height
    end
  end

  def down
    drop_table :zombies
  end
end
