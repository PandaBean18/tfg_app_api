class RescueRequest < ApplicationRecord
    validates :rescue_request_id, :author_id, :heading, :description, :reference_number, :longitude, :latitude, presence: true 
    validates :rescue_request_id, uniqueness: true 
    validates :closed, inclusion: { in: [true, false] }
    validate :ensure_valid_latitude, :ensure_valid_longitude, :ensure_valid_phone_number
    before_validation :ensure_rescue_request_id

    belongs_to(
        :author, 
        class_name: 'User', 
        foreign_key: 'author_id', 
        primary_key: 'user_id', 
    )

    private 

    def ensure_rescue_request_id
        if self.rescue_request_id
            return nil 
        end 

        rescue_request_id = SecureRandom::urlsafe_base64(8)
        rescue_request = RescueRequest.find_by(rescue_request_id: rescue_request_id)

        while rescue_request 
            rescue_request_id = SecureRandom::urlsafe_base64(8)
            rescue_request = RescueRequest.find_by(rescue_request_id: rescue_request_id)
        end 

        self.rescue_request_id = rescue_request_id
    end

    def ensure_valid_latitude
        lat = self.latitude.to_f
        
        if lat < -90.0 || lat > 90.0
            errors.add(:latitude, 'is not valid.')
        end 
    end

    def ensure_valid_longitude
        long = self.longitude.to_f 

        if long < -180 || long > 180 
            errors.add(:longitude, 'is not valid.')
        end
    end

    def ensure_valid_phone_number
        if self.reference_number.class == String && ((self.reference_number.to_i / 1000000000) == 0 || (self.reference_number.to_i / 1000000000) > 9)
            errors.add(:reference_number, "is not valid.")
        end
    end 
end
