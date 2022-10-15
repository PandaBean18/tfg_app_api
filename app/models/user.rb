class User < ApplicationRecord
    attr_reader :password 

    validates :user_id, :username, :mail, :phone, :password_digest, presence: true, uniqueness: true
    validates :first_name, :session_token, presence: true 
    validates :admin, inclusion: { in: [true, false] }
    validates :password, length: { minimum: 6, allow_nil: true }
    before_validation :ensure_session_token, :ensure_user_id
    validate :ensure_valid_mail, :ensure_valid_phone_number

    after_initialize do |user|
        user.session_token ||= User.generate_session_token
    end

    def self.find_by_credentials(username, password)
        user = User.find_by(username: username) 

        return nil if user.nil?

        user.is_password?(password) ? user : nil 
    end

    def self.generate_session_token
        session_token = SecureRandom::urlsafe_base64(16)
        user = User.find_by(session_token: session_token)

        while user 
            session_token = SecureRandom::urlsafe_base64(16)
            user = User.find_by(session_token: session_token)
        end

        return session_token
    end 

    def password=(password)
        @password = password 
        self.password_digest = BCrypt::Password.create(password)
    end

    def is_password?(password)
        BCrypt::Password.new(self.password_digest).is_password?(password)
    end 

    def reset_session_token!
        self.session_token = self.class.generate_session_token
        self.save!
        return self.session_token
    end

    private 

    def ensure_session_token
        self.session_token || self.class.generate_session_token
    end

    def ensure_user_id
        user_id = SecureRandom::urlsafe_base64(8)
        user = User.find_by(user_id: user_id)

        while user 
            user_id = SecureRandom::urlsafe_base64(8)
            user = User.find_by(user_id: user_id)
        end 
        
        self.user_id = user_id
    end 

    def ensure_valid_mail
        if !(self.mail =~ URI::MailTo::EMAIL_REGEXP)
            errors.add(:mail, "is not valid.")
        end
    end

    def ensure_valid_phone_number
        if self.phone.class == String && ((self.phone.to_i / 1000000000) == 0 || (self.phone.to_i / 1000000000) > 9)
            errors.add(:phone_number, "is not valid.")
        end
    end 
end