class AddMapsUrlColumnToRescueRequests < ActiveRecord::Migration[6.1]
    def change
        add_column(:rescue_requests, :maps_url, :string, null: false)
    end
end
