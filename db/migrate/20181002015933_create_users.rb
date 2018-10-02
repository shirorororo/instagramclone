class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.text :image
      t.string :password_digest
      t.datetime :created_at, null: false
      t.datetime :updated_at, null: false
      t.index ["email"], name: "index_users_on_email", unique: true
  
      t.timestamps
    end
  end
end
