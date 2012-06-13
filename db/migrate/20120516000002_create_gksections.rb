class CreateGksections < ActiveRecord::Migration
  def change
    create_table :gksections do |t|
      t.string :name, null: false

      t.timestamps
    end
  end
end
