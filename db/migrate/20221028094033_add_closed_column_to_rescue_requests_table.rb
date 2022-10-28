class AddClosedColumnToRescueRequestsTable < ActiveRecord::Migration[6.1]
    def change
        add_column(:rescue_requests, :closed, :boolean, null: false)
    end
end
