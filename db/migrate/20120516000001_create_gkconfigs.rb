class CreateGkconfigs < ActiveRecord::Migration
  def change
    create_table :gkconfigs do |t|
      t.integer :gksection_id, null: false
      t.string :key, null: false
      t.text :value

      t.timestamps
    end
  end
end
