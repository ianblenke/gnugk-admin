class CreateUsers < ActiveRecord::Migration
  def up
    create_table :users do |t|
      t.string :firstname
      t.string :lastname
      t.string :password
      t.string :username

      t.timestamps
    end
  end
end
