class CreateUsers < ActiveRecord::Migration[6.1]
    def change
        create_table :users do |t|
            t.string :user_id, null: false, unique: true
            t.string :first_name, null: false 
            t.string :last_name
            t.string :username, null: false, unique: true
            t.string :password_digest, null: false 
            t.string :mail, null: false, unique: true 
            t.integer :phone, null: false, unique: true
            t.string :session_token, null: false, unique: true
            t.boolean :admin, null: false, default: false 
            t.timestamps
        end
    end
end
