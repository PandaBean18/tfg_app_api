class ChangePostsTableName < ActiveRecord::Migration[6.1]
    def change
        rename_table(:posts, :rescue_requests)
    end
end
