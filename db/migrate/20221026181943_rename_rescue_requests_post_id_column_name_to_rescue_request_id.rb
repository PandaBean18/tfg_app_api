class RenameRescueRequestsPostIdColumnNameToRescueRequestId < ActiveRecord::Migration[6.1]
    def change
        rename_column(:rescue_requests, :post_id, :rescue_request_id)
    end
end
