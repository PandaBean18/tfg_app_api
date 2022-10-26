class Post < ApplicationRecord
    validates :post_id, :author_id, :heading, :description, :reference_number, :longitude, :latitude, presence: true 
    validates :post_id, uniqueness: true 
    validate :ensure_valid_latitude, :ensure_valid_longitude, :ensure_valid_phone_number
    before_validation :ensure_post_id

    belongs_to(
        :author, 
        class_name: 'User', 
        foreign_key: 'author_id', 
        primary_key: 'user_id', 
    )

    private 

    def ensure_post_id
        if self.post_id
            return nil 
        end 

        post_id = SecureRandom::urlsafe_base64(8)
        post = Post.find_by(post_id: post_id)

        while post 
            post_id = SecureRandom::urlsafe_base64(8)
            post = Post.find_by(post_id: post_id)
        end 

        self.post_id = post_id
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
        if self.phone.class == String && ((self.phone.to_i / 1000000000) == 0 || (self.phone.to_i / 1000000000) > 9)
            errors.add(:phone_number, "is not valid.")
        end
    end 
end
