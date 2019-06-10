class ApplicationController < ActionController::API
    include ::ActionController::Cookies

    def issue_token payload
        puts "in token"
        JWT.encode(payload, Rails.application.secrets.secret_key_base, "HS256")
    end

    def decoded_token
        if request.headers['Authorization']
          begin
            JWT.decode(request.headers['Authorization'],
            Rails.application.secrets.secret_key_base, true, 
            {algorithm: "HS256"})
          rescue JWT::DecodeError
             return [{}]
          end
         else
           [{}]
         end
    end

    def find_current_user
        @current_user ||= User.find( decoded_token.first['id'])
    end

    def authorize_user!
        if !find_current_user.present?
          render json: {error: 'No user id present'}
        end
    end

    def test_password(password, hash)
        BCrypt::Password.new(hash) == password
    end

end
