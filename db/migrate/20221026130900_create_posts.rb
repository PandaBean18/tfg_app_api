class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
        t.string :post_id, null: false, unique: true 
        t.string :author_id, null: false 
        t.string :heading, null: false 
        t.string :description, null: false 
        t.string :reference_number, null: false 
        t.string :longitude, null: false 
        t.string :latitude, null: false 
        t.timestamps
    end
  end
end
