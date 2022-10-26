class AddIndexToPostsTable < ActiveRecord::Migration[6.1]
    def change
        add_index(:posts, :post_id, unique: true) 
        add_index(:posts, :author_id, unique: false)
    end
end
