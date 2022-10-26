class JsonWebToken
    SECRET_KEY = Rails.application.secrets.secret_key_base.to_s

    def self.encode(payload, exp = 24.hours.from_now)
        payload[:exp] = exp.to_i
        JWT.encode(payload, SECRET_KEY)
    end

    def self.valid_token?(token)
        begin   
            decoded = self.decode(token)
            if !decoded[:refresh_token]
                return decoded  
            else 
                return false 
            end 
        rescue JWT::DecodeError 
            return false 
        end
    end

    def self.valid_refresh_token?(token)
        begin   
            decoded = self.decode(token)
            if decoded[:refresh_token]
                return decoded 
            else 
                return false 
            end 
        rescue JWT::DecodeError 
            return false 
        end
    end

    private 

    def self.decode(token)
        decoded = JWT.decode(token, SECRET_KEY)[0]
        return HashWithIndifferentAccess.new(decoded)
    end
end